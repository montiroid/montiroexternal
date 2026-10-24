import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:signature/signature.dart';
import 'package:url_launcher/url_launcher.dart';
import '../model/response_mitra_detail.dart';
import '../provider/provider_mou.dart';
import '../shared/shared_color.dart';
import '../widget/widget_custom_dialog.dart';
import '../widget/widget_loading.dart';

class PageMouAmbulance extends StatefulWidget {
  final int idMitra;
  const PageMouAmbulance({super.key, required this.idMitra});

  @override
  State<PageMouAmbulance> createState() => _PageMouAmbulanceState();
}

class _PageMouAmbulanceState extends State<PageMouAmbulance> {
  final Color _typeColor = Colors.red.shade600; // Warna Ambulans

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
                    'PT BRILIAN INOVASI GEMILANG (MONTIRO.ID) DENGAN MITRA AMBULANCE',
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
                  _buildMouRow('Nama', 'Murti Soedjarwo'),
                  const SizedBox(height: 8),
                  _buildMouRow('Jabatan', 'Direktur Operasional'),
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
                  _buildMouRow('Nama', detail.namaPIC),
                  const SizedBox(height: 8),
                  _buildMouRow('Jabatan', detail.jabatanPIC),
                  const SizedBox(height: 8),
                  _buildMouRow('Alamat', detail.alamatMitra),
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
            
            // TANGGAL
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
            const SizedBox(height: 20),

            // PASAL 1
            Center(
              child: Column(
                children: const [
                  Text('PASAL 1', style: TextStyle(fontWeight: FontWeight.w700)),
                  Text('Pengertian', style: TextStyle(fontWeight: FontWeight.w700)),
                ],
              ),
            ),
            const SizedBox(height: 12),
            _buildPoin(1, 'Pihak Pertama yang memiliki merek dagang Montiro.id adalah sebuah perusahaan aplikasi layanan otomotif yang menyediakan layanan bantuan darurat bagi customer Montiro.id yang mengalami kecelakaan lalu lintas yang membutuhkan layanan ambulans dan paramedis untuk mengantarnya dengan cepat dari tempat kejadian kecelakaan menuju ke fasilitas medis yang memadai dan terdekat.'),
            _buildPoin(2, 'Pihak Kedua merupakan perusahaan penyedia jasa penyewaan armada ambulans berikut paramedis, yang dapat mendukung Pihak Pertama dalam melaksanakan fungsinya dengan mulos lancar tapi saat dibutuhkan dengan respon yang cepat, tanggap dan bermutu untuk kasus kegawatdaruratan yang dialami customer Montiro.id saat terjadinya kecelakaan.'),
            _buildPoin(3, 'Customer Montiro.id adalah seorang atau lebih korban kecelakaan lalu lintas yang menerlukan layanan transportasi mobil ambulans berikut paramedis untuk mengantarnya menuju fasilitas medis yang memadai dan terdekat guna mendapat penanganan medis yang dibutuhkan.'),
            _buildPoin(4, 'Maksud perjanjian kerja sama ini adalah untuk melaksanakan kegiatan Sistem Penanggulangan Gawat Darurat lalu lintas yang terjadi pada customer Montiro.id.'),
            const SizedBox(height: 20),

            // PASAL 2
            Center(
              child: Column(
                children: const [
                  Text('PASAL 2', style: TextStyle(fontWeight: FontWeight.w700)),
                  Text('Hak dan Kewajiban', style: TextStyle(fontWeight: FontWeight.w700)),
                ],
              ),
            ),
            const SizedBox(height: 12),
            
            _buildPoinPasal(1, 'Pihak Pertama mempunyai hak sebagai berikut:', [
              'Mendapatkan pasien yang diantangi sesuai dengan keadaan pasien;',
              'Dapat menghubungi PIHAK KEDUA 24 jam sehari/7hari seminggu jika terjadi ke gawat darurat medis pada saat kecelakaan lalu lintas yang menimpa satu orang atau lebih Customer Montiro.id, yang mana semua korban memerlukan penggunaan mobil ambulans;',
              'Mendapat dukungan dari PIHAK KEDUA untuk penyediaan 1 (satu) atau lebih mobil ambulans, alat medis advance berikut paramedis.',
            ]),
            
            _buildPoinPasal(2, 'Pihak Pertama mempunyai kewajiban sebagai berikut:', [
              'Memberi informasi awal kondisi pasien/korban kepada PIHAK KEDUA, termasuk lokasi penjemputan dan lokasi pengantaran dan rumah sakit tujuan pengantaran;',
              'Mengirimkan Surat Jaminan kepada PIHAK KEDUA pada saat melakukan pemesanan layanan, sebagai jaminan PIHAK PERTAMA akan melakukan pembayaran maksimal 14 (empat belas) hari setelah diterimanya invoice oleh PIHAK PERTAMA;',
              'Melakukan pembayaran atas pemakaian sewa ambulans dan paramedis sesuai dengan waktu yang telah ditentukan;',
              'Menyediakan aplikasi pendukung untuk PIHAK KEDUA dalam melakukan pekerjaannya.',
            ]),

            _buildPoinPasal(3, 'Pihak Kedua mempunyai hak sebagai berikut:', [
              'Mendapatkan upah jasa sewa pemakaian ambulans berikut paramedis pasien customer Montiro.id yang ditangani dan diantar;',
              'Mendapat Surat Jaminan sebagai bukti jaminan pembayaran dari PIHAK PERTAMA atas biaya sewa pemakaian ambulans berikut paramedis;',
              'Mengirim foto (soft copy) nota tagihan/invoice) kepada PIHAK PERTAMA. Kemudian pembayaran kepada PIHAK KEDUA akan dilakukan maksimal 14 (empat belas) hari kerja dari sejak foto invoice diterima.',
            ]),

            _buildPoinPasal(4, 'Pihak Kedua mempunyai kewajiban sebagai berikut:', [
              'Sebagai mitra penyedia layanan ambulans maka mitra wajib menyediakan mobil ambulans dalam kondisi penampilan yang baik, layak jalan serta lengkap dokumen kendarannya. Wajib juga menyediakan peralatan medis gawat darurat yang lengkap (Oxygen, ventilator dll bila dibutuhkan). Juga wajib menyediakan paramedis pendamping yang ahli dan bersertifikat;',
              'Pihak Kedua memberikan layanan ambulans, paramedis berikut akses komunikasi selama 24jam sehari/7hari seminggu;',
              'Pihak Kedua membantu Pihak Pertama untuk melaporkan kejadian kecelakaan lalu lintas yang dialami oleh customer Pihak Pertama ke Kepolisian terdekat bila diperlukan.',
            ]),

            const SizedBox(height: 20),
            Text('Demikian Surat Perjanjian ini di buat atas persetujuan kedua pihak secara musyawarah dan mufakat serta dalam keadaan sehat jasmani dan rohani.',
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

  Widget _buildPoinPasal(int num, String title, List<String> subPoin) {
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey.shade800,
                        height: 1.6)),
                const SizedBox(height: 4),
                ...subPoin.asMap().entries.map((entry) {
                  int idx = entry.key;
                  String text = entry.value;
                  String letter = String.fromCharCode(97 + idx); // a, b, c...
                  return Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: 20,
                            child: Text('$letter.',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade800))),
                        Expanded(
                          child: Text(text,
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade800,
                                  height: 1.6)),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
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
              await prov.submitMou(context, widget.idMitra, 3); // 3 = Ambulance
              if (prov.submitSuccess && mounted) {
                CustomAlert.showSuccess(context,
                    message: 'MoU Ambulance Berhasil Disubmit', onClose: () {});
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
      case 1: return 'Senin';
      case 2: return 'Selasa';
      case 3: return 'Rabu';
      case 4: return 'Kamis';
      case 5: return 'Jumat';
      case 6: return 'Sabtu';
      case 7: return 'Minggu';
      default: return '-';
    }
  }

  String get _namaBulan {
    final bulan = DateTime.now().month;
    switch (bulan) {
      case 1: return 'Januari';
      case 2: return 'Februari';
      case 3: return 'Maret';
      case 4: return 'April';
      case 5: return 'Mei';
      case 6: return 'Juni';
      case 7: return 'Juli';
      case 8: return 'Agustus';
      case 9: return 'September';
      case 10: return 'Oktober';
      case 11: return 'November';
      case 12: return 'Desember';
      default: return '-';
    }
  }
}