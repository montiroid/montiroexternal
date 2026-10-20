import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:signature/signature.dart';
import '../provider/provider_mou.dart';
import '../shared/shared_color.dart';
import '../widget/widget_custom_dialog.dart';
import '../widget/widget_loading.dart';

class PageMou extends StatefulWidget {
  final int idMitra;

  const PageMou({
    super.key,
    required this.idMitra,
  });

  @override
  State<PageMou> createState() => _PageMouState();
}

class _PageMouState extends State<PageMou>
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
      Provider.of<ProviderMou>(context, listen: false)
          .detail(widget.idMitra);
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  bool _isTowing(int type) => type == 1;

  String _judul(int type) =>
      _isTowing(type) ? 'MITRA TOWING' : 'MITRA MONTIR';

  String _labelMitra(int type) =>
      _isTowing(type) ? 'Nama Towing' : 'Nama Bengkel';

  String _labelAlamat(int type) =>
      _isTowing(type) ? 'Alamat Homebase' : 'Alamat Bengkel';

  Color _typeColor(int type) => _isTowing(type)
      ? Colors.orange.shade600
      : Colors.green.shade600;

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

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<ProviderMou>(context);

    return WillPopScope(
      onWillPop: () async => !prov.isSubmitting,
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        body: SafeArea(
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Column(
                children: [
                  Expanded(
                    child: prov.isLoading
                        ? const Center(child: CustomLoading())
                        : prov.responseMitraDetail?.mitraDetail == null
                            ? _buildErrorWidget(prov)
                            : SingleChildScrollView(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                child: FadeTransition(
                                  opacity: _fadeAnimation,
                                  child: Column(
                                    children: [
                                      _buildMouContentCard(prov),
                                      const SizedBox(height: 20),
                                      _buildSignatureCard(prov),
                                      const SizedBox(height: 24),
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

  Widget _buildErrorWidget(ProviderMou prov) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
              'Gagal memuat data mitra.',
              style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => prov.detail(widget.idMitra),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.mainColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                    horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text('Muat Ulang'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMouContentCard(ProviderMou prov) {
    final detail = prov.responseMitraDetail!.mitraDetail!;
    final type = detail.type;
    final typeColor = _typeColor(type);

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
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'ANTARA PT. BRILIAN INOVASI GEMILANG (MONTIRO.ID) DENGAN ${_judul(type)}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Yang bertandatangan dibawah ini:',
              style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
            ),
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
                  Text(
                    'Pihak Pertama',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildMouRow('Nama', 'Achmad Sofyan'),
                  const SizedBox(height: 8),
                  _buildMouRow('Jabatan', 'Direktur Utama'),
                  const SizedBox(height: 8),
                  _buildMouRow(
                    'Alamat Kantor',
                    'Gedung GKM Green Tower Lt. 20 Jl. Tb Simatupang Kav. 9G Jakarta Selatan, Jakarta 12520',
                  ),
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
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: typeColor.withAlpha(10),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: typeColor.withAlpha(60)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pihak Kedua',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: typeColor,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildMouRow('Nama', detail.namaPIC),
                  const SizedBox(height: 8),
                  _buildMouRow(_labelMitra(type), detail.namaMitra),
                  const SizedBox(height: 8),
                  _buildMouRow(_labelAlamat(type), detail.alamatMitra),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Selanjutnya disebut "Pihak Kedua".',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
                height: 1.5,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 20),
            Divider(color: Colors.grey.shade200),
            const SizedBox(height: 16),
            _buildMouPoin(type),
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
          width: 110,
          child: Text(
            label,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
        ),
        const Text(
          ': ',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        ),
        Expanded(
          child: Text(
            value.isEmpty ? '-' : value,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMouPoin(int type) {
    final poin = _isTowing(type) ? _poinTowing : _poinMontir;
    final now = DateTime.now();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade700,
              height: 1.6,
            ),
            children: [
              const TextSpan(text: 'Pada hari ini, '),
              TextSpan(
                text: _namaHari,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              const TextSpan(text: ' tanggal '),
              TextSpan(
                text: '${now.day}',
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              const TextSpan(text: ' bulan '),
              TextSpan(
                text: _namaBulan,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              const TextSpan(text: ' tahun '),
              TextSpan(
                text: '${now.year}',
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              const TextSpan(
                text:
                    ' kedua belah pihak sepakat untuk melakukan Kerjasama yang isinya sebagai berikut :',
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        ...List.generate(poin.length, (i) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 22,
                  child: Text(
                    '${i + 1}.',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: _typeColor(type),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    poin[i],
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade800,
                      height: 1.6,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
        const SizedBox(height: 8),
        Text(
          'Demikian surat ini telah disepakati kedua belah pihak.',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade700,
            height: 1.6,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }

  List<String> get _poinTowing => [
        'Pihak Pertama dalam hal ini berperan sebagai penghubung antara Pihak Kedua dengan Pengguna Jasa (customer). Pada saat ada order Pihak Pertama akan mengirim informasi data customer kepada Pihak Kedua diawal untuk diproses lebih lanjut.',
        'Pihak Kedua berperan sebagai pelaksana layanan jasa towing terhadap mobil customer. Dalam hal ini Pihak Kedua wajib menjaga kualitas pelayanan yang diberikan ke customer dengan standar layanan yang baik termasuk berpakaian yang baik, memakai sepatu, dan tidak merokok saat memberikan layanan.',
        'Harga jasa layanan yang dilakukan oleh Pihak Kedua terhadap Customer untuk area dalam kota atau layanan dibawah 30 KM (inputan baru) yaitu Rp 600.000 (Enam Ratus Ribu Rupiah).',
        'Biaya pembatalan dapat terjadi apabila layanan towing Pihak Kedua sudah menuju lokasi titik penjemputan namun mobil Customer batal diangkut oleh towing maka Pihak Pertama akan membayar Biaya Pembatalan kepada Pihak Kedua sebesar 50% dari biaya yang tercantum pada SPK (Surat Perintah Kerja).',
        'Biaya atas jasa layanan towing yang dilakukan oleh Pihak Kedua terhadap customer akan dibayarkan oleh Pihak Pertama kepada Pihak Kedua dengan cara via transfer ke nomor rekening Bank milik Pihak Kedua dalam tempo selambat-lambatnya 7 (tujuh) hari atau periode pembayaran disetiap hari Rabu, sejak layanan tersebut selesai. Khusus untuk rekening mitra selain Bank BCA, biaya admin yang timbul pada saat proses transfer pembayaran dari Pihak Pertama kepada Pihak Kedua akan ditanggung oleh Pihak Kedua dengan cara pemotongan langsung dari biaya layanan.',
        'Hal-hal yang terjadi saat layanan diberikan kepada customer (contoh mobil lecet/baret/penyok dan sejenisnya) atau tidak sesuai dengan peruntukan pesanan customer menjadi tanggung jawab Pihak Kedua.',
        'Pihak Kedua tidak menyalahgunakan data Pihak Pertama termasuk data Customernya selain untuk keperluan pada saat pemberian layanan.',
        'Dapat menyediakan asuransi cargo / penderekan bila dibutuhkan.',
      ];

  List<String> get _poinMontir => [
        'Pihak Pertama dalam hal ini berperan sebagai penghubung antara Pihak Kedua dengan Customer (pelanggan Pihak Pertama).',
        'Pihak Kedua berperan sebagai pelaksana layanan jasa servis terhadap mobil customer. Dalam hal ini Pihak Kedua wajib menjaga etika sopan santun dalam melayani sesuai kebutuhan customer dengan standar layanan yang baik dan juga berpakaian yang baik (memakai sepatu dan tidak menggunakan celana pendek) serta tidak merokok saat memberikan layanan terhadap customer.',
        'Pihak Pertama wajib mengirim SPK (Surat Perintah Kerja) setiap kali order layanan kepada Pihak Kedua.',
        'Biaya jasa layanan akan ditanggung oleh Pihak Pertama dan akan dibayarkan kepada Pihak Kedua yaitu:\n- Jasa jumper aki Rp 200.000 (Dua Ratus Ribu Rupiah);\n- Jasa pergantian ban Rp 200.000 (Dua Ratus Ribu Rupiah);\n- Jasa pengiriman bensin Rp 200.000 (Dua Ratus Ribu Rupiah);\n- Jasa locksmith (kunci tertinggal) Rp 250.000 (Dua Ratus Lima Puluh Ribu Rupiah);\n- Jasa perawatan dan perbaikan lainnya menyesuaikan dengan harga bengkel.',
        'Teknis pembayaran akan dilakukan oleh Pihak Pertama melalui transfer ke nomor rekening bank milik Pihak Kedua dalam tempo selambat-lambatnya 7 (Tujuh) hari kalender sejak selesai servis, dengan sistem pencairan diakumulasi pada setiap hari Rabu.',
        'Pihak Kedua tidak menyalahgunakan data Pihak Pertama termasuk data Customernya selain untuk keperluan pada saat pemberian layanan.',
      ];

  Widget _buildSignatureCard(ProviderMou prov) {
    final detail = prov.responseMitraDetail!.mitraDetail!;
    final typeColor = _typeColor(detail.type);

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
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pihak Pertama',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    height: 120,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/images/ttd_pihak_pertama.png',
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Text(
                            'TTD Pihak Pertama',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade500,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Achmad Sofyan',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  Text(
                    'Direktur Utama',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: typeColor.withAlpha(10),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: typeColor.withAlpha(60)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pihak Kedua',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: typeColor,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200),
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
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              detail.namaPIC,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            Text(
                              detail.namaMitra,
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: prov.isSubmitting
                            ? null
                            : () => prov.signatureController.clear(),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.red.shade400,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                        ),
                        child: const Text('Hapus'),
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
    final isFormValid = prov.signatureController.isNotEmpty;

    return ElevatedButton(
      onPressed: (prov.isSubmitting || !isFormValid)
          ? null
          : () async {
              await prov.submitMou(context, widget.idMitra);
              if (prov.submitSuccess && mounted) {
                CustomAlert.showSuccess(
                  context,
                  message: 'Berhasil disubmit',
                  onClose: () {
                    prov.signatureController.clear();
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
          : const Text('Setujui & Lanjutkan'),
    );
  }
}