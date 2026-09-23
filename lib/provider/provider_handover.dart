import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:montiro_external/model/response_emergency_detail.dart';
import 'package:montiro_external/service/service_emergency.dart';
import 'package:montiro_external/shared/shared_config.dart';
import 'package:montiro_external/widget/widget_custom_dialog.dart';
import 'package:signature/signature.dart';
import 'package:image/image.dart' as img;

class ProviderHandover with ChangeNotifier {
  ResponseEmergencyDetail? responseHandoverDetail;

  final SignatureController signatureController = SignatureController(
    penStrokeWidth: 3,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  // 2 images
  Uint8List? image1Bytes;
  Uint8List? image2Bytes;
  String? image1Name;
  String? image2Name;

  bool isLoading = true;
  bool isSubmitting = false;
  bool isConfirmed = false;
  bool submitSuccess = false;
  String? submitErrorMessage;

  static const double maxWidth = 600.0;
  static const double maxHeight = 1000.0;

  ProviderHandover();

  void toggleConfirmation() {
    isConfirmed = !isConfirmed;
    notifyListeners();
  }

  // ========== PICK IMAGE (WEB + MOBILE) ==========
  Future<void> pickImage(BuildContext context, int imageIndex) async {
    if (kIsWeb) {
      await _pickImageWeb(context, imageIndex);
    } else {
      await _pickImageMobile(context, imageIndex);
    }
  }

  // ========== WEB ==========
  Future<void> _pickImageWeb(BuildContext context, int imageIndex) async {
    try {
      FilePickerResult? result = await FilePicker.pickFiles(
        type: FileType.image,
        allowMultiple: false,
        withData: true,
      );

      if (result != null) {
        Uint8List bytes = result.files.first.bytes!;
        String fileName = result.files.first.name;
        
        final compressedBytes = await _compressAndResize(bytes);
        
        if (imageIndex == 1) {
          image1Bytes = compressedBytes;
          image1Name = fileName;
        } else {
          image2Bytes = compressedBytes;
          image2Name = fileName;
        }
        notifyListeners();
      }
    } catch (e) {
      if (context.mounted) {
        CustomAlert.showError(
          context,
          title: 'Gagal',
          message: 'Gagal mengambil gambar: $e',
          onConfirm: () {},
        );
      }
    }
  }

  // ========== MOBILE ==========
  Future<void> _pickImageMobile(BuildContext context, int imageIndex) async {
    final source = await _showImageSourceDialog(context);
    if (source == null) return;

    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(
        source: source,
      );

      if (pickedFile != null) {
        Uint8List bytes = await pickedFile.readAsBytes();
        final compressedBytes = await _compressAndResize(bytes);
        
        if (imageIndex == 1) {
          image1Bytes = compressedBytes;
          image1Name = pickedFile.name;
        } else {
          image2Bytes = compressedBytes;
          image2Name = pickedFile.name;
        }
        notifyListeners();
      }
    } catch (e) {
      if (context.mounted) {
        CustomAlert.showError(
          context,
          title: 'Gagal',
          message: 'Gagal mengambil gambar: $e',
          onConfirm: () {},
        );
      }
    }
  }

  Future<ImageSource?> _showImageSourceDialog(BuildContext context) async {
    return showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pilih Sumber Gambar'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Kamera'),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Galeri'),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
  }

  // ========== COMPRESS & RESIZE ==========
  Future<Uint8List> _compressAndResize(Uint8List bytes) async {
    try {
      img.Image? image = img.decodeImage(bytes);
      if (image == null) return bytes;

      int width = image.width;
      int height = image.height;
      
      if (width > maxWidth || height > maxHeight) {
        final double ratio = width / height;
        if (width > maxWidth) {
          width = maxWidth.toInt();
          height = (width / ratio).round();
        }
        if (height > maxHeight) {
          height = maxHeight.toInt();
          width = (height * ratio).round();
        }
        image = img.copyResize(image, width: width, height: height);
      }

      return Uint8List.fromList(img.encodeJpg(image, quality: 85));
    } catch (e) {
      return bytes;
    }
  }

  void removeImage(int imageIndex) {
    if (imageIndex == 1) {
      image1Bytes = null;
      image1Name = null;
    } else {
      image2Bytes = null;
      image2Name = null;
    }
    notifyListeners();
  }

  // ========== DETAIL ==========
  Future<void> detail(int idEmergency) async {
    isLoading = true;
    responseHandoverDetail = null;
    notifyListeners();

    responseHandoverDetail = await ServiceEmergency().detail(idEmergency);

    isLoading = false;
    notifyListeners();
  }

  // ========== SUBMIT ==========
  Future<void> submitHandover(
    BuildContext context,
    int idEmergency,
    int type,
  ) async {
    if (signatureController.isEmpty) {
      submitErrorMessage = 'Tanda tangan tidak boleh kosong!';
      notifyListeners();
      return;
    }

    if (!isConfirmed) {
      submitErrorMessage = 'Harap centang konfirmasi terlebih dahulu!';
      notifyListeners();
      return;
    }

    Config().showLoading(context);

    isSubmitting = true;
    submitSuccess = false;
    submitErrorMessage = null;
    notifyListeners();

    try {
      final Uint8List? signaturePngBytes = await signatureController.toPngBytes();

      if (signaturePngBytes == null) {
        submitErrorMessage = 'Gagal mengambil gambar tanda tangan';
        isSubmitting = false;
        notifyListeners();
        return;
      }

      String signatureBase64 = base64Encode(signaturePngBytes);
      var signatureEncoded = "data:image/png;base64,$signatureBase64";

      String? image1Base64;
      String? image2Base64;
      
      if (image1Bytes != null) {
        String img1Base64 = base64Encode(image1Bytes!);
        image1Base64 = "data:image/jpeg;base64,$img1Base64";
      }
      
      if (image2Bytes != null) {
        String img2Base64 = base64Encode(image2Bytes!);
        image2Base64 = "data:image/jpeg;base64,$img2Base64";
      }

      final result = await ServiceEmergency().submit(
        id: idEmergency,
        signature: signatureEncoded,
        type: type,
        image1: image1Base64,
        image2: image2Base64,
      );

      if (result) {
        submitSuccess = true;
        signatureController.clear();
        isConfirmed = false;
        image1Bytes = null;
        image1Name = null;
        image2Bytes = null;
        image2Name = null;
      } else {
        submitErrorMessage = 'Gagal mengirim handover. Silakan coba lagi.';
      }
    } catch (e) {
      submitErrorMessage = 'Terjadi kesalahan: $e';
    } finally {
      isSubmitting = false;
      notifyListeners();
    }

    if (context.mounted) {
      Navigator.pop(context);
    }
  }

  void resetForm() {
    signatureController.clear();
    isConfirmed = false;
    image1Bytes = null;
    image1Name = null;
    image2Bytes = null;
    image2Name = null;
    submitSuccess = false;
    submitErrorMessage = null;
    notifyListeners();
  }

  @override
  void dispose() {
    signatureController.dispose();
    super.dispose();
  }
}