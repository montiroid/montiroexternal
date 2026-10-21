import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:signature/signature.dart';
import 'package:url_launcher/url_launcher.dart';
import '../model/response_mitra_detail.dart';
import '../provider/provider_mou.dart';
import '../shared/shared_color.dart';
import '../widget/widget_custom_dialog.dart';
import '../widget/widget_loading.dart';

class PageMouMontir extends StatefulWidget {
  final int idMitra;
  const PageMouMontir({super.key, required this.idMitra});

  @override
  State<PageMouMontir> createState() => _PageMouMontirState();
}

class _PageMouMontirState extends State<PageMouMontir> {
  final Color _typeColor = Colors.green.shade600;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProviderMou>(context, listen: false).detail(widget.idMitra);
    });
  }

  Future<void> _openUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<ProviderMou>(context);
    final detail = prov.responseMitraDetail?.mitraDetail;

    return WillPopScope(
      onWillPop: () async => !prov.isSubmitting,
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        body: SafeArea(
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 600),
              child: prov.isLoading
                  ? const Center(child: CustomLoading())
                  : detail == null
                      ? const Center(child: Text('Data tidak ditemukan'))
                      : SingleChildScrollView(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              if (detail.isSigned) ...[
                                _buildSignedCard(detail),
                              ] else ...[
                                _buildWordingCard(detail),
                                const SizedBox(height: 20),
                                _buildSignatureCard(prov, detail),
                                const SizedBox(height: 24),
                                _buildSubmitButton(prov),
                              ],
                              const SizedBox(height: 30),
                            ],
                          ),
                        ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWordingCard(MitraDetail detail) {
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
            Center(
              child: Column(
                children: [
                  const Text(
                    'MEMORANDUM OF UNDERSTANDING',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'ANTARA PT. BRILIAN INOVASI GEMILANG (MONTIRO.ID) DENGAN MITRA MONTIR',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text('Yang bertandatangan dibawah ini:',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade700)),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Pihak Pertama',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade700)),
                  const SizedBox(height: 12),
                  _buildMouRow('Nama', 'Achmad Sofyan'),
                  const SizedBox(height: 8),
                  _buildMouRow('Jabatan', 'Direktur Utama'),
                  const SizedBox(height: 8),
                  _buildMouRow('Alamat Kantor',
                      'Gedung GKM Green Tower Lt. 7 Jl. TB. Simatupang Kav. 9G, Kebagusan, Ps. Minggu, Jakarta Selatan, DKI Jakarta 12520'),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text(
                'Yang bertindak untuk dan atas nama PT. Brilian Inovasi Gemilang (Montiro.id), selanjutnya disebut "Pihak Pertama".',
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                    height: 1.5,
                    fontStyle: FontStyle.italic)),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: _typeColor.withAlpha(10),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _typeColor.withAlpha(60)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Pihak Kedua',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: _typeColor)),
                  const SizedBox(height: 12),
                  _buildMouRow('Nama Owner', detail.namaPIC),
                  const SizedBox(height: 8),
                  _buildMouRow('Nama Bengkel', detail.namaMitra),
                  const SizedBox(height: 8),
                  _buildMouRow('Alamat Bengkel', detail.alamatMitra),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text('Selanjutnya disebut "Pihak Kedua".',
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                    height: 1.5,
                    fontStyle: FontStyle.italic)),
            const SizedBox(height: 20),
            Divider(color: Colors.grey.shade200),
            const SizedBox(height: 16),
            RichText(
              text: TextSpan(
                style: TextStyle(
                    fontSize: 12, color: Colors.grey.shade700, height: 1.6),
                children: [
                  const TextSpan(text: 'Pada hari ini, '),
                  TextSpan(
                      text: _namaHari,
                      style: const TextStyle(fontWeight: FontWeight.w700)),
                  const TextSpan(text: ' tanggal '),
                  TextSpan(
                      text: '${DateTime.now().day}',
                      style: const TextStyle(fontWeight: FontWeight.w700)),
                  const TextSpan(text: ' bulan '),
                  TextSpan(
                      text: _namaBulan,
                      style: const TextStyle(fontWeight: FontWeight.w700)),
                  const TextSpan(text: ' tahun '),
                  TextSpan(
                      text: '${DateTime.now().year}',
                      style: const TextStyle(fontWeight: FontWeight.w700)),
                  const TextSpan(
                      text:
                          ' kedua belah pihak sepakat untuk melakukan Kerjasama yang isinya sebagai berikut :'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _buildPoin(1,
                'Pihak Pertama dalam hal ini berperan sebagai penghubung antara Pihak Kedua dengan Customer (pelanggan Pihak Pertama).'),
            _buildPoin(2,
                'Pihak Kedua berperan sebagai pelaksana layanan jasa servis terhadap mobil customer. Dalam hal ini Pihak Kedua wajib menjaga etika sopan santun dalam melayani sesuai kebutuhan customer dengan standar layanan yang baik dan juga berpakaian yang baik (memakai sepatu dan tidak menggunakan celana pendek) serta tidak merokok saat memberikan layanan terhadap customer.'),
            _buildPoin(3,
                'Pihak Pertama wajib mengirim SPK (Surat Perintah Kerja) setiap kali order layanan kepada Pihak Kedua.'),
            _buildPoin(4,
                'Biaya jasa layanan akan ditanggung oleh Pihak Pertama dan akan dibayarkan kepada Pihak Kedua yaitu:\n- Jasa jumper aki Rp 200.000 (Dua Ratus Ribu Rupiah);\n- Jasa pergantian ban Rp 200.000 (Dua Ratus Ribu Rupiah);\n- Jasa pengiriman bensin Rp 200.000 (Dua Ratus Ribu Rupiah);\n- Jasa locksmith (kunci tertinggal) Rp 250.000 (Dua Ratus Lima Puluh Ribu Rupiah);\n- Jasa perawatan dan perbaikan lainnya menyesuaikan dengan harga bengkel.'),
            _buildPoin(5,
                'Teknis pembayaran akan dilakukan oleh Pihak Pertama melalui transfer ke nomor rekening bank milik Pihak Kedua dalam tempo selambat-lambatnya 7 (Tujuh) hari kalender sejak selesai servis, dengan sistem pencairan diakumulasi pada setiap hari Rabu.'),
            _buildPoin(6,
                'Pihak Kedua tidak menyalahgunakan data Pihak Pertama termasuk data Customernya selain untuk keperluan pada saat pemberian layanan.'),
            const SizedBox(height: 8),
            Text('Demikian surat ini telah disepakati kedua belah pihak.',
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade700,
                    height: 1.6,
                    fontStyle: FontStyle.italic)),
          ],
        ),
      ),
    );
  }

  Widget _buildMouRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
            width: 130,
            child: Text(label,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600))),
        const Text(': ',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
        Expanded(
            child: Text(value.isEmpty ? '-' : value,
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    height: 1.4))),
      ],
    );
  }

  Widget _buildPoin(int num, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: 22,
              child: Text('$num.',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: _typeColor))),
          const SizedBox(width: 6),
          Expanded(
              child: Text(text,
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade800,
                      height: 1.6))),
        ],
      ),
    );
  }

  Widget _buildSignedCard(MitraDetail detail) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.green.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(8),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.check_circle, color: Colors.green.shade600, size: 64),
          const SizedBox(height: 16),
          Text(
            'MoU Telah Disepakati',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green.shade800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Ditandatangani pada:\n${detail.mouSignedAt}',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.green.shade700),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => _openUrl(detail.urlFile),
              icon: const Icon(Icons.picture_as_pdf),
              label: const Text('Lihat Dokumen PDF'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade700,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignatureCard(ProviderMou prov, MitraDetail detail) {
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
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _typeColor.withAlpha(10),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: _typeColor.withAlpha(60)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Tanda Tangan Pihak Kedua',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: _typeColor)),
                  const SizedBox(height: 12),
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Signature(
                        controller: prov.signatureController,
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(detail.namaPIC,
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w600)),
                      TextButton(
                        onPressed: () => prov.signatureController.clear(),
                        child: const Text('Hapus',
                            style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmitButton(ProviderMou prov) {
    return ElevatedButton(
      onPressed: prov.isSubmitting
          ? null
          : () async {
              await prov.submitMou(context, widget.idMitra, 2); // 2 = Montir
              if (prov.submitSuccess && mounted) {
                CustomAlert.showSuccess(context,
                    message: 'MoU Montir Berhasil Disubmit', onClose: () {});
              } else if (prov.submitErrorMessage != null && mounted) {
                CustomAlert.showError(context,
                    title: 'Gagal',
                    message: prov.submitErrorMessage!,
                    onConfirm: () {});
              }
            },
      style: ElevatedButton.styleFrom(
        elevation: 0,
        disabledBackgroundColor: Colors.grey.shade300,
        backgroundColor: AppColor.mainColor,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 54),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: prov.isSubmitting
          ? const CircularProgressIndicator(color: Colors.white)
          : const Text('Setujui & Lanjutkan'),
    );
  }

  String get _namaHari {
    final hari = DateTime.now().weekday;
    switch (hari) {
      case 1:
        return 'Senin';
      case 2:
        return 'Selasa';
      case 3:
        return 'Rabu';
      case 4:
        return 'Kamis';
      case 5:
        return 'Jumat';
      case 6:
        return 'Sabtu';
      case 7:
        return 'Minggu';
      default:
        return '-';
    }
  }

  String get _namaBulan {
    final bulan = DateTime.now().month;
    switch (bulan) {
      case 1:
        return 'Januari';
      case 2:
        return 'Februari';
      case 3:
        return 'Maret';
      case 4:
        return 'April';
      case 5:
        return 'Mei';
      case 6:
        return 'Juni';
      case 7:
        return 'Juli';
      case 8:
        return 'Agustus';
      case 9:
        return 'September';
      case 10:
        return 'Oktober';
      case 11:
        return 'November';
      case 12:
        return 'Desember';
      default:
        return '-';
    }
  }
}