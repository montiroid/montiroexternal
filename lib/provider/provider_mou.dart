import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:signature/signature.dart';
import '../model/response_mitra_detail.dart';
import '../service/service_mou.dart';
import '../shared/shared_config.dart';

class ProviderMou with ChangeNotifier {
  ResponseMitraDetail? responseMitraDetail;

  final SignatureController signatureController = SignatureController(
    penStrokeWidth: 3,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  bool isLoading = true;
  bool isSubmitting = false;
  bool submitSuccess = false;
  String? submitErrorMessage;

  ProviderMou();

  Future<void> detail(int idMitra) async {
    isLoading = true;
    responseMitraDetail = null;
    notifyListeners();

    responseMitraDetail = await ServiceMou().detail(idMitra);

    isLoading = false;
    notifyListeners();
  }

  Future<void> submitMou(BuildContext context, int idMitra) async {
    if (signatureController.isEmpty) {
      submitErrorMessage = 'Tanda tangan tidak boleh kosong!';
      notifyListeners();
      return;
    }

    Config().showLoading(context);

    isSubmitting = true;
    submitSuccess = false;
    submitErrorMessage = null;
    notifyListeners();

    try {
      final Uint8List? signaturePngBytes =
          await signatureController.toPngBytes();

      if (signaturePngBytes == null) {
        submitErrorMessage = 'Gagal mengambil gambar tanda tangan';
        isSubmitting = false;
        notifyListeners();
        return;
      }

      String signatureBase64 = base64Encode(signaturePngBytes);
      var signatureEncoded = "data:image/png;base64,$signatureBase64";

      final detail = responseMitraDetail?.mitraDetail;

      final result = await ServiceMou().submitMou(
        idMitra: idMitra,
        type: detail?.type ?? 1,
        namaPIC: detail?.namaPIC ?? "",
        namaMitra: detail?.namaMitra ?? "",
        alamatMitra: detail?.alamatMitra ?? "",
        signature: signatureEncoded,
      );

      if (result) {
        submitSuccess = true;
        signatureController.clear();
      } else {
        submitErrorMessage = 'Gagal mengirim MoU. Silakan coba lagi.';
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