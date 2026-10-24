import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:signature/signature.dart';
import 'package:url_launcher/url_launcher.dart';
import '../model/response_mitra_detail.dart';
import '../provider/provider_mou.dart';
import '../shared/shared_color.dart';
import '../widget/widget_custom_dialog.dart';
import '../widget/widget_loading.dart';

class PageMouTowing extends StatefulWidget {
  final int idMitra;
  const PageMouTowing({super.key, required this.idMitra});

  @override
  State<PageMouTowing> createState() => _PageMouTowingState();
}

class _PageMouTowingState extends State<PageMouTowing> {
  final Color _typeColor = Colors.orange.shade600;

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
                    'ANTARA PT. BRILIAN INOVASI GEMILANG (MONTIRO.ID) DENGAN MITRA TOWING',
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
                  _buildMouRow('Nama PIC/Admin', detail.namaPIC),
                  const SizedBox(height: 8),
                  _buildMouRow('Jabatan', detail.jabatanPIC),
                  const SizedBox(height: 8),
                  _buildMouRow('Nama Towing', detail.namaMitra),
                  const SizedBox(height: 8),
                  _buildMouRow('Alamat Homebase', detail.alamatMitra),
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
                'Pihak Pertama dalam hal ini berperan sebagai penghubung antara Pihak Kedua dengan Pengguna Jasa (customer). Pada saat ada order Pihak Pertama akan mengirim informasi data customer kepada Pihak Kedua diawal untuk diproses lebih lanjut.'),
            _buildPoin(2,
                'Pihak Kedua berperan sebagai pelaksana layanan jasa towing terhadap mobil customer. Dalam hal ini Pihak Kedua wajib menjaga kualitas pelayanan yang diberikan ke customer sesuai kebutuhan customer dengan standar layanan yang baik termasuk berpakaian yang baik, memakai sepatu, dan tidak merokok saat memberikan layanan.'),
            _buildPoinTowing(detail),
            _buildPoin(4,
                'Biaya pembatalan dapat terjadi apabila layanan towing Pihak Kedua sudah tiba dilokasi titik penjemputan namun mobil Customer batal diangkut oleh towing maka Pihak Pertama akan membayar Biaya Pembatalan kepada Pihak Kedua sebesar 50% dari biaya yang tercantum pada SPK (Surat Perintah Kerja).'),
            _buildPoin(5,
                'Biaya atas jasa layanan towing yang dilakukan oleh Pihak Kedua terhadap customer akan dibayarkan oleh Pihak Pertama kepada Pihak Kedua dengan cara via transfer ke nomor rekening Bank milik Pihak Kedua dalam tempo selambat-lambatnya 7 (tujuh) hari kalender sejak mobil customer tersebut selesai dikirim. Khusus untuk rekening mitra selain Bank BCA, biaya admin yang timbul pada saat proses transfer pembayaran dari Pihak Pertama kepada Pihak Kedua akan ditanggung oleh Pihak Kedua dengan cara pemotongan langsung dari biaya layanan.'),
            _buildPoin(6,
                'Hal-hal yang terjadi saat layanan diberikan kepada customer (contoh mobil lecet/baret/penyok dan sejenisnya) atau tidak sesuai dengan peruntukan pesanan customer menjadi tanggung jawab Pihak Kedua.'),
            _buildPoin(7,
                'Dapat menyediakan asuransi cargo / penderekan bila dibutuhkan.'),
            _buildPoin(8,
                'Pihak Kedua dilarang mengungkapkan, mengeksploitasi, atau menyampaikan kepada pihak yang tidak berwenang, termasuk dalam bentuk komentar, asumsi, atau informasi yang tidak dapat dipastikan kebenarannya.'),
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

  Widget _buildPoinTowing(MitraDetail detail) {
    final hDerek = detail.hargaTowingDerek;
    final hRoller = detail.hargaTowingRoller;
    final hHidrolik = detail.hargaTowingHidrolik;
    final hWheelLift = detail.hargaTowingWheelLift;
    final hEvakuasi = detail.hargaTowingEvakuasi;

    if (hDerek.isEmpty &&
        hRoller.isEmpty &&
        hHidrolik.isEmpty &&
        hWheelLift.isEmpty &&
        hEvakuasi.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 22,
            child: Text('3.',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: _typeColor)),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Harga jasa layanan towing khusus mobil mogok yang dilakukan oleh Pihak Kedua terhadap Customer untuk area dibawah 30 KM dari homebase atau dalam kota yaitu:',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade800, height: 1.6),
                ),
                const SizedBox(height: 4),
                if (hDerek.isNotEmpty)
                  _buildRowListTowing('Towing Derek Gendong', hDerek),
                if (hRoller.isNotEmpty)
                  _buildRowListTowing('Towing Roller', hRoller),
                if (hHidrolik.isNotEmpty)
                  _buildRowListTowing('Towing Hidrolik', hHidrolik),
                if (hWheelLift.isNotEmpty)
                  _buildRowListTowing('Towing Wheel Lift', hWheelLift),
                if (hEvakuasi.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(fontSize: 12, color: Colors.grey.shade800, height: 1.6),
                      children: [
                        const TextSpan(text: 'Adapun untuk jasa towing khusus evakuasi kecelakaan yaitu '),
                        TextSpan(text: hEvakuasi, style: const TextStyle(fontWeight: FontWeight.w700)),
                        const TextSpan(text: ' dari homebase atau dalam kota.'),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRowListTowing(String nama, String harga) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, bottom: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text('- $nama',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade800)),
          ),
          Expanded(
            child: Text(harga,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey.shade800)),
          ),
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
              await prov.submitMou(context, widget.idMitra, 1);
              if (prov.submitSuccess && mounted) {
                CustomAlert.showSuccess(context,
                    message: 'MoU Towing Berhasil Disubmit', onClose: () {});
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