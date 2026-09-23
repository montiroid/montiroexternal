import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../service/service_booking.dart';
import 'dart:html' as html;
import 'dart:convert';
class ProviderPdfPolish with ChangeNotifier {
  final String id;

  ProviderPdfPolish(
    this.id,
  );

  var isLoading = true;

  download(BuildContext context) async {
    var response = await ServiceBooking().detailMembership(
      id,
    );
    notifyListeners();

    if (response.detailPackage == null) {
      return;
    }
    final pdf = pw.Document();
    final font = pw.Font.times();
    final fontBold = pw.Font.timesBold();

    var level4 = 14.0;
    var level3 = 13.0;
    var level1 = 11.0;
    var levelmin1 = 10.0;

    var icLogoBlue = pw.MemoryImage(
      (await rootBundle.load('assets/ic_logo_blue.png')).buffer.asUint8List(),
    );

    var footer = pw.MemoryImage(
      (await rootBundle.load('assets/ic_footer.png')).buffer.asUint8List(),
    );

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat(
            PdfPageFormat.a4.portrait.width, PdfPageFormat.a4.portrait.height),
        build: (pw.Context context) {
          return pw.Container(
            color: PdfColor.fromHex("#FFFFFF"),
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Expanded(
                  child: pw.Container(
                    margin: const pw.EdgeInsets.only(
                      left: 15,
                      top: 15,
                      bottom: 5,
                      right: 15,
                    ),
                    decoration: pw.BoxDecoration(
                      color: PdfColor.fromHex("#FFFFFF"),
                      border: pw.Border.all(
                        color: PdfColor.fromHex("#CCCCCC"),
                        width: 1,
                      ),
                    ),
                    child: pw.Column(
                      children: [
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Expanded(
                              flex: 2,
                              child: pw.Column(
                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Container(
                                    padding: const pw.EdgeInsets.all(5),
                                    child: pw.Center(
                                      child: pw.Image(
                                        icLogoBlue,
                                        height: 25,
                                      ),
                                    ),
                                  ),
                                  pw.Container(
                                    height: 1,
                                    color: PdfColor.fromHex("#CCCCCC"),
                                  ),
                                  pw.SizedBox(
                                    height: 12,
                                  ),
                                  pw.Container(
                                    margin: const pw.EdgeInsets.only(left: 15),
                                    child: pw.Text(
                                      'Cakupan Layanan\nMembership Montiro\nEmergency Roadside Assistance ${response.detailPackage!.month} Bulan',
                                      style: pw.TextStyle(
                                        font: fontBold,
                                        fontSize: level3,
                                        color: PdfColor.fromHex("#000000"),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            pw.Container(
                              height: 120,
                              width: 1,
                              color: PdfColor.fromHex("#CCCCCC"),
                            ),
                            pw.Expanded(
                              flex: 3,
                              child: pw.Column(
                                children: [
                                  pw.Column(
                                    children: [
                                      pw.SizedBox(
                                        height: 5,
                                      ),
                                      pw.Row(
                                        mainAxisAlignment:
                                            pw.MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.start,
                                        children: [
                                          pw.Expanded(
                                            child: pw.Text(
                                              '  No Membership',
                                              style: pw.TextStyle(
                                                font: font,
                                                fontSize: level1,
                                                color:
                                                    PdfColor.fromHex("#000000"),
                                              ),
                                            ),
                                          ),
                                          pw.Text(
                                            ': ',
                                            style: pw.TextStyle(
                                              font: font,
                                              fontSize: level1,
                                              color:
                                                  PdfColor.fromHex("#000000"),
                                            ),
                                          ),
                                          pw.Expanded(
                                            flex: 2,
                                            child: pw.Text(
                                              response.detailPackage!.noMember,
                                              style: pw.TextStyle(
                                                font: font,
                                                fontSize: level1,
                                                color:
                                                    PdfColor.fromHex("#000000"),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      pw.SizedBox(
                                        height: 5,
                                      ),
                                      pw.Container(
                                        height: 1,
                                        color: PdfColor.fromHex("#CCCCCC"),
                                      ),
                                    ],
                                  ),
                                  pw.Column(
                                    children: [
                                      pw.SizedBox(
                                        height: 5,
                                      ),
                                      pw.Row(
                                        mainAxisAlignment:
                                            pw.MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.start,
                                        children: [
                                          pw.Expanded(
                                            child: pw.Text(
                                              '  Plat Nomor',
                                              style: pw.TextStyle(
                                                font: font,
                                                fontSize: level1,
                                                color:
                                                    PdfColor.fromHex("#000000"),
                                              ),
                                            ),
                                          ),
                                          pw.Text(
                                            ': ',
                                            style: pw.TextStyle(
                                              font: font,
                                              fontSize: level1,
                                              color:
                                                  PdfColor.fromHex("#000000"),
                                            ),
                                          ),
                                          pw.Expanded(
                                            flex: 2,
                                            child: pw.Text(
                                              response.detailPackage!.plat,
                                              style: pw.TextStyle(
                                                font: font,
                                                fontSize: level1,
                                                color:
                                                    PdfColor.fromHex("#000000"),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      pw.SizedBox(
                                        height: 2,
                                      ),
                                      pw.Container(
                                        height: 1,
                                        color: PdfColor.fromHex("#CCCCCC"),
                                      ),
                                    ],
                                  ),
                                  pw.Column(
                                    children: [
                                      pw.SizedBox(
                                        height: 5,
                                      ),
                                      pw.Row(
                                        mainAxisAlignment:
                                            pw.MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.start,
                                        children: [
                                          pw.Expanded(
                                            child: pw.Text(
                                              '  Tanggal Berlaku',
                                              style: pw.TextStyle(
                                                font: font,
                                                fontSize: level1,
                                                color:
                                                    PdfColor.fromHex("#000000"),
                                              ),
                                            ),
                                          ),
                                          pw.Text(
                                            ': ',
                                            style: pw.TextStyle(
                                              font: font,
                                              fontSize: level1,
                                              color:
                                                  PdfColor.fromHex("#000000"),
                                            ),
                                          ),
                                          pw.Expanded(
                                            flex: 2,
                                            child: pw.Text(
                                             response.detailPackage!.periode,
                                              style: pw.TextStyle(
                                                font: font,
                                                fontSize: level1,
                                                color:
                                                    PdfColor.fromHex("#000000"),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      pw.SizedBox(
                                        height: 5,
                                      ),
                                      pw.Container(
                                        height: 1,
                                        color: PdfColor.fromHex("#CCCCCC"),
                                      ),
                                    ],
                                  ),
                                  pw.Column(
                                    children: [
                                      pw.SizedBox(
                                        height: 5,
                                      ),
                                      pw.Row(
                                        mainAxisAlignment:
                                            pw.MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.start,
                                        children: [
                                          pw.Expanded(
                                            child: pw.Text(
                                              '  Kendaraan',
                                              style: pw.TextStyle(
                                                font: font,
                                                fontSize: level1,
                                                color:
                                                    PdfColor.fromHex("#000000"),
                                              ),
                                            ),
                                          ),
                                          pw.Text(
                                            ': ',
                                            style: pw.TextStyle(
                                              font: font,
                                              fontSize: level1,
                                              color:
                                                  PdfColor.fromHex("#000000"),
                                            ),
                                          ),
                                          pw.Expanded(
                                            flex: 2,
                                            child: pw.Text(
                                              "${response.detailPackage!.brand_name} ${response.detailPackage!.model_name} ${response.detailPackage!.varian_name}. Tahun ${response.detailPackage!.tahunProduksi}",
                                              style: pw.TextStyle(
                                                font: font,
                                                fontSize: level1,
                                                color:
                                                    PdfColor.fromHex("#000000"),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      pw.SizedBox(
                                        height: 5,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        pw.Container(
                          height: 1,
                          color: PdfColor.fromHex("#CCCCCC"),
                        ),
                        pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Container(
                              margin: const pw.EdgeInsets.only(left: 15),
                              child: pw.Column(
                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.SizedBox(
                                    height: 2,
                                  ),
                                  pw.Text(
                                    'Derek Towing',
                                    style: pw.TextStyle(
                                      font: fontBold,
                                      fontSize: level4,
                                      color: PdfColor.fromHex("#272262"),
                                    ),
                                  ),
                                  pw.Text(
                                    'Derek satu tumpuan, Derek gendong',
                                    style: pw.TextStyle(
                                      font: font,
                                      fontSize: levelmin1,
                                      color: PdfColor.fromHex("#272262"),
                                    ),
                                  ),
                                  pw.SizedBox(
                                    height: 2,
                                  ),
                                ],
                              ),
                            ),
                            pw.Container(
                              height: 1,
                              color: PdfColor.fromHex("#CCCCCC"),
                            ),
                          ],
                        ),
                        pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Container(
                              margin: const pw.EdgeInsets.only(left: 15),
                              child: pw.Column(
                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.SizedBox(
                                    height: 2,
                                  ),
                                  pw.Text(
                                    'Ban Bocor',
                                    style: pw.TextStyle(
                                      font: fontBold,
                                      fontSize: level4,
                                      color: PdfColor.fromHex("#272262"),
                                    ),
                                  ),
                                  pw.Text(
                                    'Ganti ban dengan ban serep',
                                    style: pw.TextStyle(
                                      font: font,
                                      fontSize: levelmin1,
                                      color: PdfColor.fromHex("#272262"),
                                    ),
                                  ),
                                  pw.SizedBox(
                                    height: 2,
                                  ),
                                ],
                              ),
                            ),
                            pw.Container(
                              height: 1,
                              color: PdfColor.fromHex("#CCCCCC"),
                            ),
                          ],
                        ),
                        pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Container(
                              margin: const pw.EdgeInsets.only(left: 15),
                              child: pw.Column(
                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.SizedBox(
                                    height: 2,
                                  ),
                                  pw.Text(
                                    'Aki Soak',
                                    style: pw.TextStyle(
                                      font: fontBold,
                                      fontSize: level4,
                                      color: PdfColor.fromHex("#272262"),
                                    ),
                                  ),
                                  pw.Text(
                                    'Jump start aki',
                                    style: pw.TextStyle(
                                      font: font,
                                      fontSize: levelmin1,
                                      color: PdfColor.fromHex("#272262"),
                                    ),
                                  ),
                                  pw.SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                            pw.Container(
                              height: 1,
                              color: PdfColor.fromHex("#CCCCCC"),
                            ),
                          ],
                        ),
                        pw.Expanded(
                          child: pw.Container(
                            width: double.infinity,
                            child: pw.Column(
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Container(
                                  width: double.infinity,
                                  margin: const pw.EdgeInsets.only(left: 10),
                                  child: pw.Column(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.SizedBox(
                                        height: 5,
                                      ),
                                      pw.Text(
                                        'Ringkasan Cakupan & Ketentuan',
                                        style: pw.TextStyle(
                                          font: fontBold,
                                          fontSize: level4,
                                          color: PdfColor.fromHex("#272262"),
                                        ),
                                      ),
                                      pw.SizedBox(
                                        height: 5,
                                      ),
                                      pw.Container(
                                        margin: const pw.EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                        ),
                                        child: pw.Column(
                                          mainAxisAlignment:
                                              pw.MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              pw.CrossAxisAlignment.start,
                                          children: [
                                            pw.Row(
                                              mainAxisAlignment:
                                                  pw.MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  pw.CrossAxisAlignment.start,
                                              children: [
                                                pw.Text(
                                                  '1.',
                                                  style: pw.TextStyle(
                                                    font: font,
                                                    fontSize: levelmin1,
                                                    color: PdfColor.fromHex(
                                                        "#272262"),
                                                  ),
                                                ),
                                                pw.SizedBox(
                                                  width: 5,
                                                ),
                                                pw.Expanded(
                                                  child: pw.Text(
                                                    'Layanan bantuan darurat jalan disediakan untuk membantu mobil yang didaftarkan apabila mengalami kendala atau situasi darurat hanya di jalan, seperti bantuan towing ketika mobil mogok , kehabisan strum aki atau bantuan jump start aki, serta penggantian atau penambalan ban kempes. Layanan tersedia selama masa periode berlangganan untuk kejadian yang terjadi di area dalam jangkauan layanan.',
                                                    style: pw.TextStyle(
                                                      font: font,
                                                      fontSize: levelmin1,
                                                      color: PdfColor.fromHex(
                                                          "#272262"),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      pw.SizedBox(
                                        height: 5,
                                      ),
                                      pw.Container(
                                        margin: const pw.EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                        ),
                                        child: pw.Column(
                                          mainAxisAlignment:
                                              pw.MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              pw.CrossAxisAlignment.start,
                                          children: [
                                            pw.Row(
                                              mainAxisAlignment:
                                                  pw.MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  pw.CrossAxisAlignment.start,
                                              children: [
                                                pw.Text(
                                                  '2.',
                                                  style: pw.TextStyle(
                                                    font: font,
                                                    fontSize: levelmin1,
                                                    color: PdfColor.fromHex(
                                                        "#272262"),
                                                  ),
                                                ),
                                                pw.SizedBox(
                                                  width: 5,
                                                ),
                                                pw.Expanded(
                                                  child: pw.Text(
                                                    'Ban bocor, akan ditangani dengan cara penggantian ban dengan ban serep yang dalam kondisi baik dengan tujuan customer dapat melanjutkan perjalanan',
                                                    style: pw.TextStyle(
                                                      font: font,
                                                      fontSize: levelmin1,
                                                      color: PdfColor.fromHex(
                                                          "#272262"),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      pw.SizedBox(
                                        height: 5,
                                      ),
                                      pw.Container(
                                        margin: const pw.EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                        ),
                                        child: pw.Column(
                                          mainAxisAlignment:
                                              pw.MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              pw.CrossAxisAlignment.start,
                                          children: [
                                            pw.Row(
                                              mainAxisAlignment:
                                                  pw.MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  pw.CrossAxisAlignment.start,
                                              children: [
                                                pw.Text(
                                                  '3.',
                                                  style: pw.TextStyle(
                                                    font: font,
                                                    fontSize: levelmin1,
                                                    color: PdfColor.fromHex(
                                                        "#272262"),
                                                  ),
                                                ),
                                                pw.SizedBox(
                                                  width: 5,
                                                ),
                                                pw.Expanded(
                                                  child: pw.Text(
                                                    'Aki drop, akan ditangani oleh Montir kami dengan cara jumper start Aki yang mengalami masalah.',
                                                    style: pw.TextStyle(
                                                      font: font,
                                                      fontSize: levelmin1,
                                                      color: PdfColor.fromHex(
                                                          "#272262"),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      pw.SizedBox(
                                        height: 5,
                                      ),
                                      pw.Container(
                                        margin: const pw.EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                        ),
                                        child: pw.Column(
                                          mainAxisAlignment:
                                              pw.MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              pw.CrossAxisAlignment.start,
                                          children: [
                                            pw.Row(
                                              mainAxisAlignment:
                                                  pw.MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  pw.CrossAxisAlignment.start,
                                              children: [
                                                pw.Text(
                                                  '4.',
                                                  style: pw.TextStyle(
                                                    font: font,
                                                    fontSize: levelmin1,
                                                    color: PdfColor.fromHex(
                                                        "#272262"),
                                                  ),
                                                ),
                                                pw.SizedBox(
                                                  width: 5,
                                                ),
                                                pw.Expanded(
                                                  child: pw.Text(
                                                    'Towing, proses analisa awal akan dilakukan oleh tim montiro.id untuk menentukan apakah problem dapat ditangani di lokasi kejadian. Bilamana hasil analisa bahwa perbaikan memungkinkan maka akan diberikan layanan montir ke lokasi. Towing akan dikirimkan ke lokasi kejadian jika dibutuhkan.',
                                                    style: pw.TextStyle(
                                                      font: font,
                                                      fontSize: levelmin1,
                                                      color: PdfColor.fromHex(
                                                          "#272262"),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      pw.SizedBox(
                                        height: 5,
                                      ),
                                      pw.Container(
                                        margin: const pw.EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                        ),
                                        child: pw.Column(
                                          mainAxisAlignment:
                                              pw.MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              pw.CrossAxisAlignment.start,
                                          children: [
                                            pw.Row(
                                              mainAxisAlignment:
                                                  pw.MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  pw.CrossAxisAlignment.start,
                                              children: [
                                                pw.Text(
                                                  '5.',
                                                  style: pw.TextStyle(
                                                    font: font,
                                                    fontSize: levelmin1,
                                                    color: PdfColor.fromHex(
                                                        "#272262"),
                                                  ),
                                                ),
                                                pw.SizedBox(
                                                  width: 5,
                                                ),
                                                pw.Expanded(
                                                  child: pw.Text(
                                                    "Area layanan kami meliputi 21 kotamadya yang terdiri dari: Jakarta, Bogor, Depok, Tangerang, Bekasi, Bandung, Cilegon, Cimahi, Sukabumi, Cirebon, Tasikmalaya, Pekalongan, Semarang, Surakarta, Tegal, Yogyakarta, Kediri, Malang, Probolinggo, Surabaya dan Bali.",
                                                    style: pw.TextStyle(
                                                      font: font,
                                                      fontSize: levelmin1,
                                                      color: PdfColor.fromHex(
                                                          "#272262"),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      pw.SizedBox(
                                        height: 5,
                                      ),
                                      pw.Container(
                                        margin: const pw.EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                        ),
                                        child: pw.Column(
                                          mainAxisAlignment:
                                              pw.MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              pw.CrossAxisAlignment.start,
                                          children: [
                                            pw.Row(
                                              mainAxisAlignment:
                                                  pw.MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  pw.CrossAxisAlignment.start,
                                              children: [
                                                pw.Text(
                                                  '6.',
                                                  style: pw.TextStyle(
                                                    font: font,
                                                    fontSize: levelmin1,
                                                    color: PdfColor.fromHex(
                                                        "#272262"),
                                                  ),
                                                ),
                                                pw.SizedBox(
                                                  width: 5,
                                                ),
                                                pw.Expanded(
                                                  child: pw.Text(
                                                    'Kuota bantuan layanan darurat atau emergency roadside assistance paket ${response.detailPackage!.month} adalah sebagai berikut :\nmaksimal sebanyak:\n- Towing maksimal ${response.detailPackage!.quota_towing} kali kejadian\n- Ban Bocor maksimal ${response.detailPackage!.quota_ban_kempes} kali kejadian\n- Aki Drop maksimal ${response.detailPackage!.quota_aki_drop} kali kejadian',
                                                    style: pw.TextStyle(
                                                      font: font,
                                                      fontSize: levelmin1,
                                                      color: PdfColor.fromHex(
                                                          "#272262"),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      pw.SizedBox(
                                        height: 5,
                                      ),
                                      pw.Container(
                                        margin: const pw.EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                        ),
                                        child: pw.Column(
                                          mainAxisAlignment:
                                              pw.MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              pw.CrossAxisAlignment.start,
                                          children: [
                                            pw.Row(
                                              mainAxisAlignment:
                                                  pw.MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  pw.CrossAxisAlignment.start,
                                              children: [
                                                pw.Text(
                                                  '7.',
                                                  style: pw.TextStyle(
                                                    font: font,
                                                    fontSize: levelmin1,
                                                    color: PdfColor.fromHex(
                                                        "#272262"),
                                                  ),
                                                ),
                                                pw.SizedBox(
                                                  width: 5,
                                                ),
                                                pw.Expanded(
                                                  child: pw.Text(
                                                    'Layanan siaga selama 24 jam 7 minggu 365 hari dalam satu tahun.',
                                                    style: pw.TextStyle(
                                                      font: font,
                                                      fontSize: levelmin1,
                                                      color: PdfColor.fromHex(
                                                          "#272262"),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      pw.SizedBox(
                                        height: 5,
                                      ),
                                      pw.Container(
                                        margin: const pw.EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                        ),
                                        child: pw.Column(
                                          mainAxisAlignment:
                                              pw.MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              pw.CrossAxisAlignment.start,
                                          children: [
                                            pw.Row(
                                              mainAxisAlignment:
                                                  pw.MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  pw.CrossAxisAlignment.start,
                                              children: [
                                                pw.Text(
                                                  '8.',
                                                  style: pw.TextStyle(
                                                    font: font,
                                                    fontSize: levelmin1,
                                                    color: PdfColor.fromHex(
                                                        "#272262"),
                                                  ),
                                                ),
                                                pw.SizedBox(
                                                  width: 5,
                                                ),
                                                pw.Expanded(
                                                  child: pw.Text(
                                                    'Apabila Customer membutuhkan towing karena disebabkan kecelakaan atau insiden dengan kendaraan lain dan       masih dalam penangan aparat kepolisian maka semua hal-hal mengenai dan yang berhubungan dengan pihak     berwenang atau Polisi harus diselesaikan terlebih dahulu, dan akan mendapatkan bantuan towing bila hal-hal yang sedang ditangani oleh aparat sudah selesai dan jelas.',
                                                    style: pw.TextStyle(
                                                      font: font,
                                                      fontSize: levelmin1,
                                                      color: PdfColor.fromHex(
                                                          "#272262"),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                pw.Row(children: [
                  pw.Expanded(child: pw.SizedBox()),
                  pw.Text(
                    'Versi 1.0.2',
                    style: pw.TextStyle(
                      font: font,
                      fontSize: levelmin1,
                      color: PdfColor.fromHex("#272262"),
                    ),
                  ),
                  pw.SizedBox(width: 15),
                ]),
                pw.SizedBox(
                  height: 5,
                ),
                pw.Container(
                  child: pw.Center(
                    child: pw.Image(
                      footer,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
    isLoading = false;
    notifyListeners();
    List<int> bytes = await pdf.save();
    html.AnchorElement(
        href:
            "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}")
      ..setAttribute("download",
          "Membership-Ikhtisar-Layanan-${response.detailPackage!.brand_name} ${response.detailPackage!.model_name} ${response.detailPackage!.varian_name}. Tahun ${response.detailPackage!.tahunProduksi}.pdf")
      ..click();
    //
    //window.close();
  }
}
