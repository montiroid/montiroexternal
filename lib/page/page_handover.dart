import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:montiro_external/model/response_emergency_detail.dart';
import 'package:montiro_external/widget/widget_custom_dialog.dart';
import 'package:provider/provider.dart';
import 'package:signature/signature.dart';
import 'package:url_launcher/url_launcher.dart';
import '../provider/provider_handover.dart';
import '../shared/shared_color.dart';
import '../widget/widget_loading.dart';

class PageHandover extends StatefulWidget {
  final int idEmergency;
  final int type; // 1 = on_process, 2 = done

  const PageHandover({
    super.key,
    required this.idEmergency,
    required this.type,
  });

  @override
  PageHandoverState createState() => PageHandoverState();
}

class PageHandoverState extends State<PageHandover>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProviderHandover>(context, listen: false)
          .detail(widget.idEmergency);
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _openUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<ProviderHandover>(context);
    return WillPopScope(
      onWillPop: () async {
        if (prov.isSubmitting) {
          return false;
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        body: SafeArea(
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Column(
                children: [
                  _buildHeader(prov),
                  Expanded(
                    child: prov.isLoading
                        ? const Center(child: CustomLoading())
                        : prov.responseHandoverDetail?.emergencyDetail == null
                            ? _buildErrorWidget(prov)
                            : SingleChildScrollView(
                                controller: ScrollController(),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                child: FadeTransition(
                                  opacity: _fadeAnimation,
                                  child: Column(
                                    children: [
                                      _buildInfoCard(prov),
                                      const SizedBox(height: 20),
                                      if (!_isSignatureExist(prov)) ...[
                                        _buildImagePickerSection(prov),
                                        const SizedBox(height: 20),
                                      ],
                                      _buildSignatureCard(prov),
                                      const SizedBox(height: 24),
                                      if (!_isSignatureExist(prov))
                                        _buildSubmitButton(prov),
                                      const SizedBox(height: 30),
                                    ],
                                  ),
                                ),
                              ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(ProviderHandover prov) {
    final detail = prov.responseHandoverDetail?.emergencyDetail;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _getTypeColor().withAlpha(15),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              widget.type == 1 ? Icons.build : Icons.check_circle,
              color: _getTypeColor(),
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getSubtitle(),
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                    letterSpacing: -0.2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'ID: #${detail?.id ?? '-'}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade500,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ),
          if (detail?.code != null && detail!.code.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.blue.shade100),
              ),
              child: Text(
                detail.code,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue.shade700,
                  fontFamily: 'monospace',
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget(ProviderHandover prov) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              'Terjadi Kesalahan',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              prov.responseHandoverDetail == null
                  ? 'Gagal memuat data. Mohon muat ulang.'
                  : 'Data tidak ditemukan',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => prov.detail(widget.idEmergency),
              icon: const Icon(Icons.refresh, size: 18),
              label: const Text('Muat Ulang'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.mainColor,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(ProviderHandover prov) {
    final detail = prov.responseHandoverDetail?.emergencyDetail;
    if (detail == null) return const SizedBox.shrink();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(8),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColor.mainColor.withAlpha(10),
                border: Border(
                  bottom: BorderSide(color: Colors.grey.shade100),
                ),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: AppColor.mainColor.withAlpha(30),
                    child: Icon(
                      Icons.build_circle,
                      color: AppColor.mainColor,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Mitra Partner',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade500,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          detail.mitra_nama,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border:
                          Border.all(color: AppColor.mainColor.withAlpha(50)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.miscellaneous_services,
                          size: 14,
                          color: AppColor.mainColor,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          detail.layananName,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColor.mainColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildInfoRow(
                    icon: Icons.person_outline,
                    iconColor: Colors.blue.shade400,
                    title: 'Nama Customer',
                    content: detail.custName,
                  ),
                  const SizedBox(height: 16),
                  _buildInfoRow(
                    icon: Icons.location_on_outlined,
                    iconColor: Colors.red.shade400,
                    title: 'Alamat',
                    content: detail.custAddress,
                    subtitle: detail.custAddressNote.isNotEmpty &&
                            detail.custAddressNote != "-"
                        ? 'Catatan: ${detail.custAddressNote}'
                        : null,
                  ),
                  const SizedBox(height: 16),
                  _buildInfoRow(
                    icon: Icons.directions_car_outlined,
                    iconColor: Colors.orange.shade600,
                    title: 'Kendaraan',
                    content: detail.car.toUpperCase(),
                    subtitle:
                        detail.noPolisi.isNotEmpty ? detail.noPolisi : null,
                  ),
                  const SizedBox(height: 16),
                  _buildInfoRow(
                    icon: Icons.description_outlined,
                    iconColor: Colors.purple.shade400,
                    title: 'Keluhan',
                    content: detail.keluhan,
                  ),
                  const SizedBox(height: 16),
                  _buildInfoRow(
                    icon: Icons.calendar_today_outlined,
                    iconColor: Colors.teal.shade400,
                    title: 'Tanggal',
                    content: detail.date,
                  ),
                  if (detail.price > 0) ...[
                    const SizedBox(height: 16),
                    _buildInfoRow(
                      icon: Icons.price_change_outlined,
                      iconColor: Colors.green.shade600,
                      title: 'Harga',
                      content: detail.priceText,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String content,
    String? subtitle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 2),
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: iconColor.withAlpha(15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 18, color: iconColor),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade500,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                content.isEmpty ? '-' : content,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 1.3,
                ),
              ),
              if (subtitle != null && subtitle.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  // ==================== IMAGE PICKER SECTION ====================
  Widget _buildImagePickerSection(ProviderHandover prov) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(8),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.purple.shade50,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.purple.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.image,
                    color: Colors.purple.shade700,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Foto Pendukung',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'Ambil dari kamera atau galeri',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          _buildImageItem(
            prov: prov,
            index: 1,
            imageBytes: prov.image1Bytes,
            imageName: prov.image1Name,
            label: 'Foto 1',
          ),
          
          const Divider(height: 1),
          
          _buildImageItem(
            prov: prov,
            index: 2,
            imageBytes: prov.image2Bytes,
            imageName: prov.image2Name,
            label: 'Foto 2',
          ),
          
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildImageItem({
    required ProviderHandover prov,
    required int index,
    required Uint8List? imageBytes,
    required String? imageName,
    required String label,
  }) {
    final bool hasImage = imageBytes != null;
    
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: hasImage ? Colors.green.shade300 : Colors.grey.shade300,
                width: 2,
              ),
            ),
            child: hasImage
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.memory(
                      imageBytes,
                      fit: BoxFit.cover,
                    ),
                  )
                : Icon(
                    Icons.add_photo_alternate,
                    size: 32,
                    color: Colors.grey.shade400,
                  ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                if (hasImage) ...[
                  Text(
                    imageName ?? 'Gambar',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ] else ...[
                  Text(
                    'Belum ada foto',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
                const SizedBox(height: 8),
                Row(
                  children: [
                    if (!hasImage)
                      ElevatedButton.icon(
                        onPressed: prov.isSubmitting
                            ? null
                            : () => prov.pickImage(context, index),
                        icon: const Icon(Icons.add_a_photo, size: 16),
                        label: const Text('Ambil Foto'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.mainColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          textStyle: const TextStyle(fontSize: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    if (hasImage) ...[
                      TextButton.icon(
                        onPressed: prov.isSubmitting
                            ? null
                            : () => prov.removeImage(index),
                        icon: Icon(Icons.close, size: 16, color: Colors.red.shade400),
                        label: Text(
                          'Hapus',
                          style: TextStyle(color: Colors.red.shade400),
                        ),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          textStyle: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getImageSize(Uint8List bytes) {
    final sizeInKB = bytes.length / 1024;
    if (sizeInKB < 1024) {
      return '${sizeInKB.toStringAsFixed(1)} KB';
    }
    return '${(sizeInKB / 1024).toStringAsFixed(1)} MB';
  }
  // ==================== END IMAGE PICKER SECTION ====================

  Widget _buildSignatureCard(ProviderHandover prov) {
    final detail = prov.responseHandoverDetail?.emergencyDetail;
    final isAlreadySigned = _isSignatureExist(prov);

    String signerName = '';
    String signatureDate = '';

    if (widget.type == 1) {
      signerName = detail?.handover_receiver_on_process ?? '';
      signatureDate = detail?.signOnProcessDate ?? '';
    } else {
      signerName = detail?.handover_receiver_on_done ?? '';
      signatureDate = detail?.signOnDoneDate ?? '';
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(8),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _getTypeColor().withAlpha(15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.edit_note,
                    color: _getTypeColor(),
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _getSignatureTitle(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        _getSignatureDescription(),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (isAlreadySigned) ...[
              _buildSignedState(signerName, signatureDate, detail),
            ] else ...[
              _buildSignaturePad(prov),
              const SizedBox(height: 16),
              Divider(color: Colors.grey.shade200),
              const SizedBox(height: 12),
              _buildConfirmationCheckbox(prov),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSignedState(
      String signerName, String signatureDate, EmergencyDetail? detail) {
    const baseUrl = 'https://api-webapps.montiro.id/storage/images/handover';
    
    // Cek dari database
    final hasSignature = detail?.signature_name != null && detail!.signature_name.isNotEmpty;
    final hasFoto1 = detail?.foto1_name != null && detail!.foto1_name.isNotEmpty;
    final hasFoto2 = detail?.foto2_name != null && detail!.foto2_name.isNotEmpty;

    final idEmergency = detail?.id ?? '';
    
    final String signatureUrl = '$baseUrl/signature_${idEmergency}_${widget.type}.png';
    final String foto1Url = '$baseUrl/foto1_$idEmergency.jpeg';
    final String foto2Url = '$baseUrl/foto2_$idEmergency.jpeg';
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.green.shade50,
            Colors.green.shade50.withAlpha(200),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Column(
        children: [
          // Icon sukses
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.green.withAlpha(30),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Icon(
              Icons.check_circle_rounded,
              color: Colors.green.shade600,
              size: 48,
            ),
          ),
          const SizedBox(height: 16),
          
          Text(
            'Telah Ditandatangani',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.green.shade800,
            ),
          ),
          
          // Nama penandatangan
          if (signerName.isNotEmpty) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.person, size: 16, color: Colors.grey.shade600),
                  const SizedBox(width: 8),
                  Text(
                    signerName,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ],
              ),
            ),
          ],
          
          // Tanggal
          if (signatureDate.isNotEmpty) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.schedule, size: 14, color: Colors.grey.shade600),
                  const SizedBox(width: 6),
                  Text(
                    signatureDate,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),
          ],
          
          // ========== TOMBOL BUKA DI TAB BARU ==========
          const SizedBox(height: 20),
          Divider(color: Colors.grey.shade300),
          const SizedBox(height: 16),
          
          // Tombol Lihat TTD (hanya jika ada)
          if (hasSignature)
            _buildViewButton(
              label: 'Lihat Tanda Tangan',
              icon: Icons.edit_note,
              url: signatureUrl,
              color: Colors.purple,
            ),
          
          if (hasSignature) const SizedBox(height: 12),
          
          // Tombol Lihat Foto 1 (hanya jika ada)
          if (hasFoto1)
            _buildViewButton(
              label: 'Lihat Foto 1',
              icon: Icons.image,
              url: foto1Url,
              color: Colors.blue,
            ),
          
          if (hasFoto1) const SizedBox(height: 12),
          
          // Tombol Lihat Foto 2 (hanya jika ada)
          if (hasFoto2)
            _buildViewButton(
              label: 'Lihat Foto 2',
              icon: Icons.image,
              url: foto2Url,
              color: Colors.green,
            ),
          
          // Pesan kalo gak ada file sama sekali
          if (!hasSignature && !hasFoto1 && !hasFoto2)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                'Tidak ada file pendukung',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade500,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildViewButton({
    required String label,
    required IconData icon,
    required String url,
    required Color color,
  }) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () => _openUrl(url),
        icon: Icon(icon, size: 18, color: color),
        label: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: color,
          ),
        ),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          side: BorderSide(color: color),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget _buildSignaturePad(ProviderHandover prov) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300, width: 1.5),
            borderRadius: BorderRadius.circular(16),
            color: Colors.grey.shade50,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Signature(
              controller: prov.signatureController,
              height: 200,
              width: double.infinity,
              backgroundColor: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              widget.type == 1
                  ? (prov.responseHandoverDetail?.emergencyDetail
                          ?.handover_receiver_on_process ??
                      '')
                  : (prov.responseHandoverDetail?.emergencyDetail
                          ?.handover_receiver_on_done ??
                      ''),
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Expanded(
              child: SizedBox(),
            ),
            TextButton.icon(
              onPressed: prov.isSubmitting
                  ? null
                  : () {
                      prov.signatureController.clear();
                    },
              icon: const Icon(Icons.delete_sweep, size: 18),
              label: const Text('Hapus'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.red.shade400,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildConfirmationCheckbox(ProviderHandover prov) {
    return InkWell(
      onTap: prov.isSubmitting ? null : () => prov.toggleConfirmation(),
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Row(
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: Checkbox(
                value: prov.isConfirmed,
                onChanged:
                    prov.isSubmitting ? null : (v) => prov.toggleConfirmation(),
                activeColor: AppColor.mainColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Saya menyatakan bahwa data di atas adalah benar',
                style: TextStyle(
                  fontSize: 13,
                  height: 1.4,
                  color:
                      prov.isConfirmed ? Colors.black87 : Colors.grey.shade500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmitButton(ProviderHandover prov) {
    final isFormValid = prov.isConfirmed && prov.signatureController.isNotEmpty;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      child: ElevatedButton(
        onPressed: (prov.isSubmitting || !isFormValid)
            ? null
            : () async {
                await prov.submitHandover(
                  context,
                  widget.idEmergency,
                  widget.type,
                );
                if (prov.submitSuccess && mounted) {
                  CustomAlert.showSuccess(
                    context,
                    message: 'Berhasil disubmit',
                    onClose: () {
                      Provider.of<ProviderHandover>(context, listen: false)
                          .detail(widget.idEmergency);
                      prov.signatureController.clear();
                      if (prov.isConfirmed) {
                        prov.toggleConfirmation();
                      }
                    },
                  );
                } else if (prov.submitErrorMessage != null && mounted) {
                  CustomAlert.showError(
                    context,
                    title: 'Gagal!',
                    message: prov.submitErrorMessage!,
                    onConfirm: () {},
                  );
                }
              },
        style: ElevatedButton.styleFrom(
          elevation: 0,
          disabledBackgroundColor: Colors.grey.shade300,
          backgroundColor: AppColor.mainColor,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 54),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        child: prov.isSubmitting
            ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : const Text('Lanjutkan'),
      ),
    );
  }

  String _getSubtitle() {
    switch (widget.type) {
      case 1:
        return 'Proses Serah Terima Kendaraan';
      case 2:
        return 'Serah Terima Selesai Pengerjaan';
      default:
        return 'Serah Terima Kendaraan';
    }
  }

  Color _getTypeColor() {
    switch (widget.type) {
      case 1:
        return Colors.orange.shade600;
      case 2:
        return Colors.green.shade600;
      default:
        return AppColor.mainColor;
    }
  }

  bool _isSignatureExist(ProviderHandover prov) {
    final detail = prov.responseHandoverDetail?.emergencyDetail;
    if (detail == null) return false;

    if (widget.type == 1) {
      return detail.handover_receiver_on_process_signed_at.isNotEmpty;
    } else {
      return detail.handover_receiver_on_done_signed_at.isNotEmpty;
    }
  }

  String _getSignatureTitle() {
    switch (widget.type) {
      case 1:
        return 'Tanda Tangan Serah Terima';
      case 2:
        return 'Tanda Tangan Penyelesaian';
      default:
        return 'Tanda Tangan Serah Terima';
    }
  }

  String _getSignatureDescription() {
    switch (widget.type) {
      case 1:
        return 'Tanda tangani sebagai bukti serah terima untuk proses pengerjaan';
      case 2:
        return 'Tanda tangani sebagai bukti serah terima setelah selesai pengerjaan';
      default:
        return 'Silakan tanda tangan di area bawah sebagai bukti serah terima kendaraan';
    }
  }
}