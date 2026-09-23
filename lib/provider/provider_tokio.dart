import 'dart:convert';
import 'dart:html' as html;
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../model/model_subscribe.dart';

tokioPdf({
  required ResponseSubscribe response,
}) async {

  final pdf = pw.Document();

  final fontAssets = await rootBundle.load("assets/calibri.ttf");
  final font = pw.Font.ttf(fontAssets);
  final fontAssetsBold = await rootBundle.load("assets/calibrib.ttf");
  final fontBold = pw.Font.ttf(fontAssetsBold);

  var level4 = 14.0;
  var level1 = 11.0;
  var levelmin1 = 10.0;
  var levelmin3 = 8.0;

  var icLogoBlue = pw.MemoryImage(
    (await rootBundle.load('assets/ic_logo_blue.png')).buffer.asUint8List(),
  );

  var icTokio = pw.MemoryImage(
    (await rootBundle.load('assets/pt_tokio.png')).buffer.asUint8List(),
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
                      color: PdfColor.fromHex("#272262"),
                      width: 1,
                    ),
                  ),
                  child: pw.Column(
                    children: [
                      pw.SizedBox(height: 10),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        children: [
                          pw.Expanded(
                            flex: 2,
                            child: pw.Column(
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Container(
                                  margin: const pw.EdgeInsets.only(left: 15),
                                  child: pw.Text(
                                    'E-Sertifikat Emergency'.toUpperCase(),
                                    style: pw.TextStyle(
                                      font: fontBold,
                                      fontSize: level4,
                                      color: PdfColor.fromHex("#000000"),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          pw.Container(
                            margin: const pw.EdgeInsets.only(right: 15),
                            child: pw.Column(
                              mainAxisAlignment: pw.MainAxisAlignment.center,
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              children: [
                                pw.Center(
                                  child: pw.Image(
                                    icLogoBlue,
                                    height: 20,
                                  ),
                                ),
                                response.detailPackage!.id_perusahaan == 10
                                    ? pw.Row(
                                        mainAxisAlignment:
                                            pw.MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.center,
                                        children: [
                                          pw.Container(
                                            margin: const pw.EdgeInsets.only(
                                                right: 5),
                                            child: pw.Text(
                                              'Partner With',
                                              style: pw.TextStyle(
                                                font: font,
                                                fontSize: levelmin3,
                                                color:
                                                    PdfColor.fromHex("#000000"),
                                              ),
                                            ),
                                          ),
                                          pw.Center(
                                            child: pw.Image(
                                              icTokio,
                                              height: 20,
                                            ),
                                          ),
                                        ],
                                      )
                                    : pw.SizedBox(),
                              ],
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 10),
                      pw.Container(
                        height: 1,
                        color: PdfColor.fromHex("#000000"),
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
                                margin: const pw.EdgeInsets.only(
                                    left: 30, right: 30),
                                child: pw.Column(
                                  mainAxisAlignment: pw.MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.SizedBox(
                                      height: 15,
                                    ),
                                    pw.Text(
                                      'IKHTISAR PERTANGGUNGAN',
                                      style: pw.TextStyle(
                                        font: fontBold,
                                        fontSize: level4,
                                        color: PdfColor.fromHex("#272262"),
                                      ),
                                    ),
                                    pw.SizedBox(
                                      height: 15,
                                    ),
                                    pw.Text(
                                      'Diterbitkan oleh PT. Brilian Inovasi Gemilang (Montiro.id) selaku Penanggung untuk:',
                                      style: pw.TextStyle(
                                        font: font,
                                        fontSize: level1,
                                        color: PdfColor.fromHex("#000000"),
                                      ),
                                    ),
                                    pw.SizedBox(
                                      height: 5,
                                    ),
                                    pw.Row(
                                      children: [
                                        pw.Expanded(
                                          child: pw.Text(
                                            'Nama Tertanggung',
                                            style: pw.TextStyle(
                                              font: font,
                                              fontSize: level1,
                                              color:
                                                  PdfColor.fromHex("#000000"),
                                            ),
                                          ),
                                        ),
                                        pw.SizedBox(
                                          width: 5,
                                        ),
                                        pw.Expanded(
                                          flex: 2,
                                          child: pw.Text(
                                            ': ${response.detailPackage!.customer_name}',
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
                                    pw.Row(
                                      children: [
                                        pw.Expanded(
                                          child: pw.Text(
                                            'Nama Perusahaan',
                                            style: pw.TextStyle(
                                              font: font,
                                              fontSize: level1,
                                              color:
                                                  PdfColor.fromHex("#000000"),
                                            ),
                                          ),
                                        ),
                                        pw.SizedBox(
                                          width: 5,
                                        ),
                                        pw.Expanded(
                                          flex: 2,
                                          child: pw.Text(
                                            ': ${response.detailPackage!.perusahaan_name}',
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
                                    pw.Row(
                                      children: [
                                        pw.Expanded(
                                          child: pw.Text(
                                            'Nomor Membership',
                                            style: pw.TextStyle(
                                              font: font,
                                              fontSize: level1,
                                              color:
                                                  PdfColor.fromHex("#000000"),
                                            ),
                                          ),
                                        ),
                                        pw.SizedBox(
                                          width: 5,
                                        ),
                                        pw.Expanded(
                                          flex: 2,
                                          child: pw.Text(
                                            ': ${response.detailPackage!.idMembership}',
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
                                    pw.Row(
                                      children: [
                                        pw.Expanded(
                                          child: pw.Text(
                                            'No. Polis',
                                            style: pw.TextStyle(
                                              font: font,
                                              fontSize: level1,
                                              color:
                                                  PdfColor.fromHex("#000000"),
                                            ),
                                          ),
                                        ),
                                        pw.SizedBox(
                                          width: 5,
                                        ),
                                        pw.Expanded(
                                          flex: 2,
                                          child: pw.Text(
                                            ': ${response.detailPackage!.nomor_asuransi}',
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
                                    pw.Row(
                                      children: [
                                        pw.Expanded(
                                          child: pw.Text(
                                            'Merk & Model Kendaraan',
                                            style: pw.TextStyle(
                                              font: font,
                                              fontSize: level1,
                                              color:
                                                  PdfColor.fromHex("#000000"),
                                            ),
                                          ),
                                        ),
                                        pw.SizedBox(
                                          width: 5,
                                        ),
                                        pw.Expanded(
                                          flex: 2,
                                          child: pw.Text(
                                            ': ${response.detailPackage!.mobil}',
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
                                    pw.Row(
                                      children: [
                                        pw.Expanded(
                                          child: pw.Text(
                                            'Tahun Produksi Kendaraan',
                                            style: pw.TextStyle(
                                              font: font,
                                              fontSize: level1,
                                              color:
                                                  PdfColor.fromHex("#000000"),
                                            ),
                                          ),
                                        ),
                                        pw.SizedBox(
                                          width: 5,
                                        ),
                                        pw.Expanded(
                                          flex: 2,
                                          child: pw.Text(
                                            ': ${response.detailPackage!.tahunProduksi}',
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
                                    pw.Row(
                                      children: [
                                        pw.Expanded(
                                          child: pw.Text(
                                            'Plat Nomor',
                                            style: pw.TextStyle(
                                              font: font,
                                              fontSize: level1,
                                              color:
                                                  PdfColor.fromHex("#000000"),
                                            ),
                                          ),
                                        ),
                                        pw.SizedBox(
                                          width: 5,
                                        ),
                                        pw.Expanded(
                                          flex: 2,
                                          child: pw.Text(
                                            ': ${response.detailPackage!.plat}',
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
                                    pw.Row(
                                      children: [
                                        pw.Expanded(
                                          child: pw.Text(
                                            'No. Rangka',
                                            style: pw.TextStyle(
                                              font: font,
                                              fontSize: level1,
                                              color:
                                                  PdfColor.fromHex("#000000"),
                                            ),
                                          ),
                                        ),
                                        pw.SizedBox(
                                          width: 5,
                                        ),
                                        pw.Expanded(
                                          flex: 2,
                                          child: pw.Text(
                                            ': ${response.detailPackage!.nomor_rangka}',
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
                                    pw.Row(
                                      children: [
                                        pw.Expanded(
                                          child: pw.Text(
                                            'Warna Kendaraan',
                                            style: pw.TextStyle(
                                              font: font,
                                              fontSize: level1,
                                              color:
                                                  PdfColor.fromHex("#000000"),
                                            ),
                                          ),
                                        ),
                                        pw.SizedBox(
                                          width: 5,
                                        ),
                                        pw.Expanded(
                                          flex: 2,
                                          child: pw.Text(
                                            ': ${response.detailPackage!.warna}',
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
                                    pw.Row(
                                      children: [
                                        pw.Expanded(
                                          child: pw.Text(
                                            'Tanggal Berlaku',
                                            style: pw.TextStyle(
                                              font: font,
                                              fontSize: level1,
                                              color:
                                                  PdfColor.fromHex("#000000"),
                                            ),
                                          ),
                                        ),
                                        pw.SizedBox(
                                          width: 5,
                                        ),
                                        pw.Expanded(
                                          flex: 2,
                                          child: pw.Text(
                                            ': ${response.detailPackage!.periode}',
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
                                      height: 15,
                                    ),
                                    pw.Text(
                                      'RINGKASAN CAKUPAN & KETENTUAN',
                                      style: pw.TextStyle(
                                        font: fontBold,
                                        fontSize: level4,
                                        color: PdfColor.fromHex("#272262"),
                                      ),
                                    ),
                                    pw.SizedBox(
                                      height: 15,
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
                                                  fontSize: level1,
                                                  color: PdfColor.fromHex(
                                                      "#000000"),
                                                ),
                                              ),
                                              pw.SizedBox(
                                                width: 5,
                                              ),
                                              pw.Expanded(
                                                child: pw.Text(
                                                  'Layanan bantuan darurat di jalan disediakan untuk membantu mobil yang telah didaftarkan apabila mengalami kendala atau situasi darurat hanya di jalan, seperti bantuan towing ketika mobil mogok, kehabisan strum aki atau bantuan jump start aki, serta penggantian atau penambalan ban kempes. Layanan tersedia selama masa berlaku untuk kejadian yang terjadi di area dalam jangkauan layanan.',
                                                  textAlign:
                                                      pw.TextAlign.justify,
                                                  style: pw.TextStyle(
                                                    font: font,
                                                    fontSize: level1,
                                                    color: PdfColor.fromHex(
                                                        "#000000"),
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
                                                  fontSize: level1,
                                                  color: PdfColor.fromHex(
                                                      "#000000"),
                                                ),
                                              ),
                                              pw.SizedBox(
                                                width: 5,
                                              ),
                                              pw.Expanded(
                                                child: pw.Text(
                                                  'Consultation (Konsultasi) dengan montir mengenai masalah mobil customer melalui live chat.',
                                                  textAlign:
                                                      pw.TextAlign.justify,
                                                  style: pw.TextStyle(
                                                    font: font,
                                                    fontSize: level1,
                                                    color: PdfColor.fromHex(
                                                        "#000000"),
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
                                                  fontSize: level1,
                                                  color: PdfColor.fromHex(
                                                      "#000000"),
                                                ),
                                              ),
                                              pw.SizedBox(
                                                width: 5,
                                              ),
                                              pw.Expanded(
                                                child: pw.Text(
                                                  'Towing, akan diberikan untuk customer yang mengalami mogok dan sudah diberikan bantuan sebelumnya oleh montir kami.',
                                                  textAlign:
                                                      pw.TextAlign.justify,
                                                  style: pw.TextStyle(
                                                    font: font,
                                                    fontSize: level1,
                                                    color: PdfColor.fromHex(
                                                        "#000000"),
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
                                                  fontSize: level1,
                                                  color: PdfColor.fromHex(
                                                      "#000000"),
                                                ),
                                              ),
                                              pw.SizedBox(
                                                width: 5,
                                              ),
                                              pw.Expanded(
                                                child: pw.Text(
                                                  'Battery Boost (Aki Drop), akan ditangani oleh Montir kami dengan cara jumper start aki yang mengalami masalah.',
                                                  textAlign:
                                                      pw.TextAlign.justify,
                                                  style: pw.TextStyle(
                                                    font: font,
                                                    fontSize: level1,
                                                    color: PdfColor.fromHex(
                                                        "#000000"),
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
                                                  fontSize: level1,
                                                  color: PdfColor.fromHex(
                                                      "#000000"),
                                                ),
                                              ),
                                              pw.SizedBox(
                                                width: 5,
                                              ),
                                              pw.Expanded(
                                                child: pw.Text(
                                                  "Flat Tire Change (Ban kempes), akan ditangani dengan cara penggantian ban dengan ban serep yang dalam kondisi baik dengan tujuan customer dapat melanjutkan perjalanan.",
                                                  textAlign:
                                                      pw.TextAlign.justify,
                                                  style: pw.TextStyle(
                                                    font: font,
                                                    fontSize: level1,
                                                    color: PdfColor.fromHex(
                                                        "#000000"),
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
                                                  fontSize: level1,
                                                  color: PdfColor.fromHex(
                                                      "#000000"),
                                                ),
                                              ),
                                              pw.SizedBox(
                                                width: 5,
                                              ),
                                              pw.Expanded(
                                                child: pw.Text(
                                                  'Fuel Delivery (Pengantaran Bensin), bantuan pembelian bensin yang dikirimkan jika mobil mogok akibat kehabisan bensin di jalan.',
                                                  textAlign:
                                                      pw.TextAlign.justify,
                                                  style: pw.TextStyle(
                                                    font: font,
                                                    fontSize: level1,
                                                    color: PdfColor.fromHex(
                                                        "#000000"),
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
                                                  fontSize: level1,
                                                  color: PdfColor.fromHex(
                                                      "#000000"),
                                                ),
                                              ),
                                              pw.SizedBox(
                                                width: 5,
                                              ),
                                              pw.Expanded(
                                                child: pw.Text(
                                                  'Lockout Service (Kunci Tertinggal di Dalam Mobil), layanan bantuan membuka pintu mobil yang mengalami masalah kunci tertinggal di dalam.',
                                                  textAlign:
                                                      pw.TextAlign.justify,
                                                  style: pw.TextStyle(
                                                    font: font,
                                                    fontSize: level1,
                                                    color: PdfColor.fromHex(
                                                        "#000000"),
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
                                                  fontSize: level1,
                                                  color: PdfColor.fromHex(
                                                      "#000000"),
                                                ),
                                              ),
                                              pw.SizedBox(
                                                width: 5,
                                              ),
                                              pw.Expanded(
                                                child: pw.Text(
                                                  'Jangkauan layanan untuk bantuan layanan darurat meliputi area pulau Jawa, Bali, Kalimantan, Sulawesi, NTB, atau 50 kota-kota besar di Indonesia.',
                                                  textAlign:
                                                      pw.TextAlign.justify,
                                                  style: pw.TextStyle(
                                                    font: font,
                                                    fontSize: level1,
                                                    color: PdfColor.fromHex(
                                                        "#000000"),
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
                                                '9.',
                                                style: pw.TextStyle(
                                                  font: font,
                                                  fontSize: level1,
                                                  color: PdfColor.fromHex(
                                                      "#000000"),
                                                ),
                                              ),
                                              pw.SizedBox(
                                                width: 5,
                                              ),
                                              pw.Expanded(
                                                child: pw.Text(
                                                  'Benefit yang diberikan:\n- Consultation\n- Towing\n- Battery Boost\n- Fuel Delivery\n- Lockout Service',
                                                  textAlign:
                                                      pw.TextAlign.justify,
                                                  style: pw.TextStyle(
                                                    font: font,
                                                    fontSize: level1,
                                                    color: PdfColor.fromHex(
                                                        "#000000"),
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
                                                '10.',
                                                style: pw.TextStyle(
                                                  font: font,
                                                  fontSize: level1,
                                                  color: PdfColor.fromHex(
                                                      "#000000"),
                                                ),
                                              ),
                                              pw.SizedBox(
                                                width: 5,
                                              ),
                                              pw.Expanded(
                                                child: pw.Text(
                                                  'Layanan siaga selama 24 jam 7 minggun 365 hari dalam 1 tahun.',
                                                  textAlign:
                                                      pw.TextAlign.justify,
                                                  style: pw.TextStyle(
                                                    font: font,
                                                    fontSize: level1,
                                                    color: PdfColor.fromHex(
                                                        "#000000"),
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
                                                '',
                                                style: pw.TextStyle(
                                                  font: font,
                                                  fontSize: level1,
                                                  color: PdfColor.fromHex(
                                                      "#000000"),
                                                ),
                                              ),
                                              pw.SizedBox(
                                                width: 5,
                                              ),
                                              pw.Expanded(
                                                child: pw.Text(
                                                  '',
                                                  textAlign:
                                                      pw.TextAlign.justify,
                                                  style: pw.TextStyle(
                                                    font: font,
                                                    fontSize: level1,
                                                    color: PdfColor.fromHex(
                                                        "#000000"),
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
                  'Versi 1.0.0',
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
                      color: PdfColor.fromHex("#272262"),
                      width: 1,
                    ),
                  ),
                  child: pw.Column(
                    children: [
                      pw.SizedBox(height: 15),
                      pw.Expanded(
                        child: pw.Container(
                          width: double.infinity,
                          child: pw.Column(
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Container(
                                width: double.infinity,
                                margin: const pw.EdgeInsets.only(
                                    left: 30, right: 30),
                                child: pw.Column(
                                  mainAxisAlignment: pw.MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.SizedBox(
                                      height: 15,
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
                                                '11.',
                                                style: pw.TextStyle(
                                                  font: font,
                                                  fontSize: level1,
                                                  color: PdfColor.fromHex(
                                                      "#000000"),
                                                ),
                                              ),
                                              pw.SizedBox(
                                                width: 5,
                                              ),
                                              pw.Expanded(
                                                child: pw.Text(
                                                  'Apabila Customer membutuhkan towing karena disebabkan oleh kecelakaan atau insiden dengan kendaraan lain dan masih dalam penanganan aparat kepolisian, maka semua hal-hal mengenai dan yang berhubungan dengan pihak berwenang atau Polisi harus diselesaikan terlebih dahulu.',
                                                  textAlign:
                                                      pw.TextAlign.justify,
                                                  style: pw.TextStyle(
                                                    font: font,
                                                    fontSize: level1,
                                                    color: PdfColor.fromHex(
                                                        "#000000"),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    pw.SizedBox(
                                      height: 30,
                                    ),
                                    pw.Row(
                                      children: [
                                        pw.Expanded(
                                          child: pw.SizedBox(),
                                        ),
                                        pw.Text(
                                         response.detailPackage!.tanggalSertifikat,
                                          textAlign: pw.TextAlign.justify,
                                          style: pw.TextStyle(
                                            font: font,
                                            fontSize: level1,
                                            color: PdfColor.fromHex("#000000"),
                                          ),
                                        ),
                                        pw.SizedBox(
                                          width: 15,
                                        ),
                                      ],
                                    ),
                                    pw.SizedBox(
                                      height: 5,
                                    ),
                                    pw.Row(
                                      children: [
                                        pw.Expanded(
                                          child: pw.SizedBox(),
                                        ),
                                        pw.Text(
                                          'PT. Brilian Inovasi Gemilang (Montiro.id)',
                                          textAlign: pw.TextAlign.justify,
                                          style: pw.TextStyle(
                                            font: font,
                                            fontSize: level1,
                                            color: PdfColor.fromHex("#000000"),
                                          ),
                                        ),
                                        pw.SizedBox(
                                          width: 15,
                                        ),
                                      ],
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
                  'Versi 1.0.0',
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
                      color: PdfColor.fromHex("#272262"),
                      width: 1,
                    ),
                  ),
                  child: pw.Column(
                    children: [
                      pw.SizedBox(height: 15),
                      pw.Expanded(
                        child: pw.Container(
                          width: double.infinity,
                          child: pw.Row(
                            children: [
                              pw.Expanded(
                                child: pw.Column(
                                  mainAxisAlignment: pw.MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Container(
                                      width: double.infinity,
                                      margin: const pw.EdgeInsets.only(
                                        left: 30,
                                      ),
                                      child: pw.Column(
                                        mainAxisAlignment:
                                            pw.MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.start,
                                        children: [
                                          pw.SizedBox(
                                            height: 15,
                                          ),
                                          pw.Text(
                                            'KETENTUAN LAYANAN',
                                            style: pw.TextStyle(
                                              font: fontBold,
                                              fontSize: level4,
                                              color:
                                                  PdfColor.fromHex("#272262"),
                                            ),
                                          ),
                                          pw.SizedBox(
                                            height: 15,
                                          ),
                                          pw.Container(
                                            decoration: pw.BoxDecoration(
                                              color:
                                                  PdfColor.fromHex("#FFFFFF"),
                                              border: pw.Border.all(
                                                color:
                                                    PdfColor.fromHex("#000000"),
                                                width: 1,
                                              ),
                                            ),
                                            child: pw.Column(
                                              mainAxisAlignment:
                                                  pw.MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  pw.CrossAxisAlignment.start,
                                              children: [
                                                pw.Container(
                                                  margin:
                                                      const pw.EdgeInsets.only(
                                                          left: 15,
                                                          right: 15,
                                                          top: 5,
                                                          bottom: 5),
                                                  child: pw.Column(
                                                    mainAxisAlignment: pw
                                                        .MainAxisAlignment
                                                        .start,
                                                    crossAxisAlignment: pw
                                                        .CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      pw.Text(
                                                        'Konsultasi',
                                                        style: pw.TextStyle(
                                                          font: fontBold,
                                                          fontSize: level4,
                                                          color:
                                                              PdfColor.fromHex(
                                                                  "#272262"),
                                                        ),
                                                      ),
                                                      pw.Text(
                                                        'Live chat dengan montir',
                                                        style: pw.TextStyle(
                                                          font: font,
                                                          fontSize: level1,
                                                          color:
                                                              PdfColor.fromHex(
                                                                  "#272262"),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                pw.Container(
                                                  height: 1,
                                                  color: PdfColor.fromHex(
                                                      "#000000"),
                                                ),
                                                pw.Container(
                                                  margin:
                                                      const pw.EdgeInsets.only(
                                                          left: 15,
                                                          right: 15,
                                                          top: 5,
                                                          bottom: 5),
                                                  child: pw.Column(
                                                    mainAxisAlignment: pw
                                                        .MainAxisAlignment
                                                        .start,
                                                    crossAxisAlignment: pw
                                                        .CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      pw.Text(
                                                        'Derek Towing',
                                                        style: pw.TextStyle(
                                                          font: fontBold,
                                                          fontSize: level4,
                                                          color:
                                                              PdfColor.fromHex(
                                                                  "#272262"),
                                                        ),
                                                      ),
                                                      pw.Text(
                                                        'Derek satu tumpuan, Derek gendong',
                                                        style: pw.TextStyle(
                                                          font: font,
                                                          fontSize: level1,
                                                          color:
                                                              PdfColor.fromHex(
                                                                  "#272262"),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                pw.Container(
                                                  height: 1,
                                                  color: PdfColor.fromHex(
                                                      "#000000"),
                                                ),
                                                pw.Container(
                                                  margin:
                                                      const pw.EdgeInsets.only(
                                                          left: 15,
                                                          right: 15,
                                                          top: 5,
                                                          bottom: 5),
                                                  child: pw.Column(
                                                    mainAxisAlignment: pw
                                                        .MainAxisAlignment
                                                        .start,
                                                    crossAxisAlignment: pw
                                                        .CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      pw.Text(
                                                        'Ban Kempes',
                                                        style: pw.TextStyle(
                                                          font: fontBold,
                                                          fontSize: level4,
                                                          color:
                                                              PdfColor.fromHex(
                                                                  "#272262"),
                                                        ),
                                                      ),
                                                      pw.Text(
                                                        'Ganti ban dengan ban serep',
                                                        style: pw.TextStyle(
                                                          font: font,
                                                          fontSize: level1,
                                                          color:
                                                              PdfColor.fromHex(
                                                                  "#272262"),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                pw.Container(
                                                  height: 1,
                                                  color: PdfColor.fromHex(
                                                      "#000000"),
                                                ),
                                                pw.Container(
                                                  margin:
                                                      const pw.EdgeInsets.only(
                                                          left: 15,
                                                          right: 15,
                                                          top: 5,
                                                          bottom: 5),
                                                  child: pw.Column(
                                                    mainAxisAlignment: pw
                                                        .MainAxisAlignment
                                                        .start,
                                                    crossAxisAlignment: pw
                                                        .CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      pw.Text(
                                                        'Aki Soak',
                                                        style: pw.TextStyle(
                                                          font: fontBold,
                                                          fontSize: level4,
                                                          color:
                                                              PdfColor.fromHex(
                                                                  "#272262"),
                                                        ),
                                                      ),
                                                      pw.Text(
                                                        'Jump start aki',
                                                        style: pw.TextStyle(
                                                          font: font,
                                                          fontSize: level1,
                                                          color:
                                                              PdfColor.fromHex(
                                                                  "#272262"),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                pw.Container(
                                                  height: 1,
                                                  color: PdfColor.fromHex(
                                                      "#000000"),
                                                ),
                                                pw.Container(
                                                  margin:
                                                      const pw.EdgeInsets.only(
                                                          left: 15,
                                                          right: 15,
                                                          top: 5,
                                                          bottom: 5),
                                                  child: pw.Column(
                                                    mainAxisAlignment: pw
                                                        .MainAxisAlignment
                                                        .start,
                                                    crossAxisAlignment: pw
                                                        .CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      pw.Text(
                                                        'Lockout',
                                                        style: pw.TextStyle(
                                                          font: fontBold,
                                                          fontSize: level4,
                                                          color:
                                                              PdfColor.fromHex(
                                                                  "#272262"),
                                                        ),
                                                      ),
                                                      pw.Text(
                                                        'Kunci tertinggal di dalam mobil',
                                                        style: pw.TextStyle(
                                                          font: font,
                                                          fontSize: level1,
                                                          color:
                                                              PdfColor.fromHex(
                                                                  "#272262"),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                pw.Container(
                                                  height: 1,
                                                  color: PdfColor.fromHex(
                                                      "#000000"),
                                                ),
                                                pw.Container(
                                                  margin:
                                                      const pw.EdgeInsets.only(
                                                          left: 15,
                                                          right: 15,
                                                          top: 5,
                                                          bottom: 5),
                                                  child: pw.Column(
                                                    mainAxisAlignment: pw
                                                        .MainAxisAlignment
                                                        .start,
                                                    crossAxisAlignment: pw
                                                        .CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      pw.Text(
                                                        'Fuel Delivery',
                                                        style: pw.TextStyle(
                                                          font: fontBold,
                                                          fontSize: level4,
                                                          color:
                                                              PdfColor.fromHex(
                                                                  "#272262"),
                                                        ),
                                                      ),
                                                      pw.Text(
                                                        'Bantuan pembelian bensin',
                                                        style: pw.TextStyle(
                                                          font: font,
                                                          fontSize: level1,
                                                          color:
                                                              PdfColor.fromHex(
                                                                  "#272262"),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          pw.SizedBox(
                                            height: 15,
                                          ),
                                          pw.Text(
                                            'KETENTUAN UMUM',
                                            style: pw.TextStyle(
                                              font: fontBold,
                                              fontSize: level4,
                                              color:
                                                  PdfColor.fromHex("#272262"),
                                            ),
                                          ),
                                          pw.Container(
                                            margin: const pw.EdgeInsets.only(
                                              top: 15,
                                            ),
                                            child: pw.Column(
                                              mainAxisAlignment:
                                                  pw.MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  pw.CrossAxisAlignment.start,
                                              children: [
                                                pw.Row(
                                                  mainAxisAlignment: pw
                                                      .MainAxisAlignment.start,
                                                  crossAxisAlignment: pw
                                                      .CrossAxisAlignment.start,
                                                  children: [
                                                    pw.Text(
                                                      '1.',
                                                      style: pw.TextStyle(
                                                        font: fontBold,
                                                        fontSize: level1,
                                                        color: PdfColor.fromHex(
                                                            "#272262"),
                                                      ),
                                                    ),
                                                    pw.SizedBox(
                                                      width: 5,
                                                    ),
                                                    pw.Expanded(
                                                      child: pw.Column(
                                                        mainAxisAlignment: pw
                                                            .MainAxisAlignment
                                                            .start,
                                                        crossAxisAlignment: pw
                                                            .CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          pw.Text(
                                                            'ISTILAH UMUM',
                                                            textAlign: pw
                                                                .TextAlign
                                                                .justify,
                                                            style: pw.TextStyle(
                                                              font: fontBold,
                                                              fontSize: level1,
                                                              color: PdfColor
                                                                  .fromHex(
                                                                      "#272262"),
                                                            ),
                                                          ),
                                                          pw.SizedBox(
                                                            height: 5,
                                                          ),
                                                          pw.Row(
                                                            children: [
                                                              pw.Text(
                                                                'Montiro.id',
                                                                textAlign: pw
                                                                    .TextAlign
                                                                    .justify,
                                                                style: pw
                                                                    .TextStyle(
                                                                  font:
                                                                      fontBold,
                                                                  fontSize:
                                                                      levelmin1,
                                                                  color: PdfColor
                                                                      .fromHex(
                                                                          "#000000"),
                                                                ),
                                                              ),
                                                              pw.Expanded(
                                                                child: pw.Text(
                                                                  ' adalah penyedia layanan bantuan darurat ',
                                                                  textAlign: pw
                                                                      .TextAlign
                                                                      .justify,
                                                                  style: pw
                                                                      .TextStyle(
                                                                    font: font,
                                                                    fontSize:
                                                                        levelmin1,
                                                                    color: PdfColor
                                                                        .fromHex(
                                                                            "#000000"),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          pw.Text(
                                                            'dijalan yang diselenggarakan oleh PT. Brilian Inovasi Gemilang, yang disediakan oleh Mitra dengan menggunakan kendaraan towing untuk mengantar kendaraan dari lokasi penjemputan pelanggan ke bengkel rekanan terdekat. Seluruh layanan disediakan secara langsung oleh pihak ketiga independen yang setuju menjadi penyedia layanan dengan skema kemitraan atau skema lainnya.',
                                                            textAlign: pw
                                                                .TextAlign
                                                                .justify,
                                                            style: pw.TextStyle(
                                                              font: font,
                                                              fontSize:
                                                                  levelmin1,
                                                              color: PdfColor
                                                                  .fromHex(
                                                                      "#000000"),
                                                            ),
                                                          ),
                                                          pw.SizedBox(
                                                            height: 10,
                                                          ),
                                                          pw.Row(
                                                            children: [
                                                              pw.Text(
                                                                'Mitra',
                                                                textAlign: pw
                                                                    .TextAlign
                                                                    .justify,
                                                                style: pw
                                                                    .TextStyle(
                                                                  font:
                                                                      fontBold,
                                                                  fontSize:
                                                                      levelmin1,
                                                                  color: PdfColor
                                                                      .fromHex(
                                                                          "#000000"),
                                                                ),
                                                              ),
                                                              pw.Expanded(
                                                                child: pw.Text(
                                                                  ' adalah pihak ketiga independen penyedia layanan ',
                                                                  textAlign: pw
                                                                      .TextAlign
                                                                      .justify,
                                                                  style: pw
                                                                      .TextStyle(
                                                                    font: font,
                                                                    fontSize:
                                                                        levelmin1,
                                                                    color: PdfColor
                                                                        .fromHex(
                                                                            "#000000"),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          pw.Text(
                                                            'pengangkutan yang bekerjasama dengan Montiro.id dengan skema kemitraan, dan bukan karyawan, agen atau perwakilan Montiro.id.',
                                                            textAlign: pw
                                                                .TextAlign
                                                                .justify,
                                                            style: pw.TextStyle(
                                                              font: font,
                                                              fontSize:
                                                                  levelmin1,
                                                              color: PdfColor
                                                                  .fromHex(
                                                                      "#000000"),
                                                            ),
                                                          ),
                                                          pw.SizedBox(
                                                            height: 10,
                                                          ),
                                                          pw.Row(
                                                            children: [
                                                              pw.Text(
                                                                'Customer',
                                                                textAlign: pw
                                                                    .TextAlign
                                                                    .justify,
                                                                style: pw
                                                                    .TextStyle(
                                                                  font:
                                                                      fontBold,
                                                                  fontSize:
                                                                      levelmin1,
                                                                  color: PdfColor
                                                                      .fromHex(
                                                                          "#000000"),
                                                                ),
                                                              ),
                                                              pw.Expanded(
                                                                child: pw.Text(
                                                                  ' dalah setiap orang atau badan yang telah ',
                                                                  textAlign: pw
                                                                      .TextAlign
                                                                      .justify,
                                                                  style: pw
                                                                      .TextStyle(
                                                                    font: font,
                                                                    fontSize:
                                                                        levelmin1,
                                                                    color: PdfColor
                                                                        .fromHex(
                                                                            "#000000"),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          pw.Text(
                                                            'melakukan pembelian layanan kepesertaan.',
                                                            textAlign: pw
                                                                .TextAlign
                                                                .justify,
                                                            style: pw.TextStyle(
                                                              font: font,
                                                              fontSize:
                                                                  levelmin1,
                                                              color: PdfColor
                                                                  .fromHex(
                                                                      "#000000"),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),

                                          //
                                          pw.Container(
                                            margin: const pw.EdgeInsets.only(
                                              top: 15,
                                            ),
                                            child: pw.Column(
                                              mainAxisAlignment:
                                                  pw.MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  pw.CrossAxisAlignment.start,
                                              children: [
                                                pw.Row(
                                                  mainAxisAlignment: pw
                                                      .MainAxisAlignment.start,
                                                  crossAxisAlignment: pw
                                                      .CrossAxisAlignment.start,
                                                  children: [
                                                    pw.Text(
                                                      '2.',
                                                      style: pw.TextStyle(
                                                        font: fontBold,
                                                        fontSize: level1,
                                                        color: PdfColor.fromHex(
                                                            "#272262"),
                                                      ),
                                                    ),
                                                    pw.SizedBox(
                                                      width: 5,
                                                    ),
                                                    pw.Expanded(
                                                      child: pw.Column(
                                                        mainAxisAlignment: pw
                                                            .MainAxisAlignment
                                                            .start,
                                                        crossAxisAlignment: pw
                                                            .CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          pw.Text(
                                                            'JENIS LAYANAN',
                                                            textAlign: pw
                                                                .TextAlign
                                                                .justify,
                                                            style: pw.TextStyle(
                                                              font: fontBold,
                                                              fontSize: level1,
                                                              color: PdfColor
                                                                  .fromHex(
                                                                      "#272262"),
                                                            ),
                                                          ),
                                                          pw.SizedBox(
                                                            height: 5,
                                                          ),
                                                          pw.Text(
                                                            'Layanan Membership Montiro meliputi:\nEmergency Roadside Assistance (ERA) adalah layanan darurat khusus untuk membantu mengangkut dan membantu kendaraan mobil yang mengalami kendala atau situasi darurat di jalan meliputi layanan:\nTowing, Penggantian Ban Kempes dengan ban serep, dan Jump Start Aki untuk Aki Drop.',
                                                            textAlign: pw
                                                                .TextAlign
                                                                .justify,
                                                            style: pw.TextStyle(
                                                              font: font,
                                                              fontSize:
                                                                  levelmin1,
                                                              color: PdfColor
                                                                  .fromHex(
                                                                      "#000000"),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          //
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              pw.Expanded(
                                child: pw.Column(
                                  mainAxisAlignment: pw.MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Container(
                                      margin: const pw.EdgeInsets.only(
                                        top: 15,
                                        left: 15,
                                        right: 30,
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
                                                '',
                                                style: pw.TextStyle(
                                                  font: fontBold,
                                                  fontSize: level1,
                                                  color: PdfColor.fromHex(
                                                      "#272262"),
                                                ),
                                              ),
                                              pw.SizedBox(
                                                width: 5,
                                              ),
                                              pw.Expanded(
                                                child: pw.Column(
                                                  mainAxisAlignment: pw
                                                      .MainAxisAlignment.start,
                                                  crossAxisAlignment: pw
                                                      .CrossAxisAlignment.start,
                                                  children: [
                                                    pw.Row(
                                                      mainAxisAlignment: pw
                                                          .MainAxisAlignment
                                                          .start,
                                                      crossAxisAlignment: pw
                                                          .CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        pw.Expanded(
                                                          child: pw.Column(
                                                            mainAxisAlignment: pw
                                                                .MainAxisAlignment
                                                                .start,
                                                            crossAxisAlignment: pw
                                                                .CrossAxisAlignment
                                                                .start,
                                                            children: [
                                                              pw.Text(
                                                                'EMERGENCY ROADSIDE ASSISTANCE (ERA)\nPENGGUNAAN',
                                                                textAlign: pw
                                                                    .TextAlign
                                                                    .justify,
                                                                style: pw
                                                                    .TextStyle(
                                                                  font:
                                                                      fontBold,
                                                                  fontSize:
                                                                      level1,
                                                                  color: PdfColor
                                                                      .fromHex(
                                                                          "#272262"),
                                                                ),
                                                              ),
                                                              pw.SizedBox(
                                                                height: 2,
                                                              ),
                                                              pw.Row(
                                                                mainAxisAlignment:
                                                                    pw.MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    pw.CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  pw.Expanded(
                                                                    child: pw
                                                                        .Column(
                                                                      mainAxisAlignment: pw
                                                                          .MainAxisAlignment
                                                                          .start,
                                                                      crossAxisAlignment: pw
                                                                          .CrossAxisAlignment
                                                                          .start,
                                                                      children: [
                                                                        pw.Text(
                                                                          'Customer dapat menggunakan layanan ERA saat terjadi kendala atau keadaan darurat pada kendaraan yang dimiliki melalui website atau mobile apps serta hotline Montiro.id',
                                                                          textAlign: pw
                                                                              .TextAlign
                                                                              .justify,
                                                                          style:
                                                                              pw.TextStyle(
                                                                            font:
                                                                                font,
                                                                            fontSize:
                                                                                levelmin1,
                                                                            color:
                                                                                PdfColor.fromHex("#000000"),
                                                                          ),
                                                                        ),
                                                                        pw.SizedBox(
                                                                          height:
                                                                              2,
                                                                        ),
                                                                        pw.Row(
                                                                          mainAxisAlignment: pw
                                                                              .MainAxisAlignment
                                                                              .start,
                                                                          crossAxisAlignment: pw
                                                                              .CrossAxisAlignment
                                                                              .start,
                                                                          children: [
                                                                            pw.Text(
                                                                              '1)',
                                                                              style: pw.TextStyle(
                                                                                font: font,
                                                                                fontSize: levelmin1,
                                                                                color: PdfColor.fromHex("#000000"),
                                                                              ),
                                                                            ),
                                                                            pw.SizedBox(
                                                                              width: 5,
                                                                            ),
                                                                            pw.Expanded(
                                                                              child: pw.Column(
                                                                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                                                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                                                                children: [
                                                                                  pw.Text(
                                                                                    'Customer memahami bahwa ERA hanya melayani kendaraan yang mengalami kendala mogok atau dalam situasi darurat dimana kendaraan tidak dapat berfungsi dalam perjalanan. Kondisi darurat yang dimaksud antara lain:',
                                                                                    textAlign: pw.TextAlign.justify,
                                                                                    style: pw.TextStyle(
                                                                                      font: font,
                                                                                      fontSize: levelmin1,
                                                                                      color: PdfColor.fromHex("#000000"),
                                                                                    ),
                                                                                  ),
                                                                                  pw.SizedBox(
                                                                                    height: 2,
                                                                                  ),
                                                                                  pw.Row(
                                                                                    mainAxisAlignment: pw.MainAxisAlignment.start,
                                                                                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      pw.Text(
                                                                                        'a)',
                                                                                        style: pw.TextStyle(
                                                                                          font: font,
                                                                                          fontSize: level1,
                                                                                          color: PdfColor.fromHex("#000000"),
                                                                                        ),
                                                                                      ),
                                                                                      pw.SizedBox(
                                                                                        width: 5,
                                                                                      ),
                                                                                      pw.Expanded(
                                                                                        child: pw.Column(
                                                                                          mainAxisAlignment: pw.MainAxisAlignment.start,
                                                                                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                                                                                          children: [
                                                                                            pw.Text(
                                                                                              'Gangguan pada mesin kendaraan yang menyebabkan tidak dapat melanjutkan perjalanan ',
                                                                                              textAlign: pw.TextAlign.justify,
                                                                                              style: pw.TextStyle(
                                                                                                font: font,
                                                                                                fontSize: levelmin1,
                                                                                                color: PdfColor.fromHex("#000000"),
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  pw.Row(
                                                                                    mainAxisAlignment: pw.MainAxisAlignment.start,
                                                                                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      pw.Text(
                                                                                        'b)',
                                                                                        style: pw.TextStyle(
                                                                                          font: font,
                                                                                          fontSize: level1,
                                                                                          color: PdfColor.fromHex("#000000"),
                                                                                        ),
                                                                                      ),
                                                                                      pw.SizedBox(
                                                                                        width: 5,
                                                                                      ),
                                                                                      pw.Expanded(
                                                                                        child: pw.Column(
                                                                                          mainAxisAlignment: pw.MainAxisAlignment.start,
                                                                                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                                                                                          children: [
                                                                                            pw.Text(
                                                                                              'Kehabisan daya baterai (Accu)',
                                                                                              textAlign: pw.TextAlign.justify,
                                                                                              style: pw.TextStyle(
                                                                                                font: font,
                                                                                                fontSize: levelmin1,
                                                                                                color: PdfColor.fromHex("#000000"),
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  pw.Row(
                                                                                    mainAxisAlignment: pw.MainAxisAlignment.start,
                                                                                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      pw.Text(
                                                                                        'c)',
                                                                                        style: pw.TextStyle(
                                                                                          font: font,
                                                                                          fontSize: level1,
                                                                                          color: PdfColor.fromHex("#000000"),
                                                                                        ),
                                                                                      ),
                                                                                      pw.SizedBox(
                                                                                        width: 5,
                                                                                      ),
                                                                                      pw.Expanded(
                                                                                        child: pw.Column(
                                                                                          mainAxisAlignment: pw.MainAxisAlignment.start,
                                                                                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                                                                                          children: [
                                                                                            pw.Text(
                                                                                              'Ban bocor (penggantian dengan ban serep atau tambal)',
                                                                                              textAlign: pw.TextAlign.justify,
                                                                                              style: pw.TextStyle(
                                                                                                font: font,
                                                                                                fontSize: levelmin1,
                                                                                                color: PdfColor.fromHex("#000000"),
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  pw.Row(
                                                                                    mainAxisAlignment: pw.MainAxisAlignment.start,
                                                                                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      pw.Text(
                                                                                        'd)',
                                                                                        style: pw.TextStyle(
                                                                                          font: font,
                                                                                          fontSize: level1,
                                                                                          color: PdfColor.fromHex("#000000"),
                                                                                        ),
                                                                                      ),
                                                                                      pw.SizedBox(
                                                                                        width: 5,
                                                                                      ),
                                                                                      pw.Expanded(
                                                                                        child: pw.Column(
                                                                                          mainAxisAlignment: pw.MainAxisAlignment.start,
                                                                                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                                                                                          children: [
                                                                                            pw.Text(
                                                                                              'Kunci mobil tertinggal di dalam mobil sehingga tidak dapat masuk ke mobil',
                                                                                              textAlign: pw.TextAlign.justify,
                                                                                              style: pw.TextStyle(
                                                                                                font: font,
                                                                                                fontSize: levelmin1,
                                                                                                color: PdfColor.fromHex("#000000"),
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  pw.Row(
                                                                                    mainAxisAlignment: pw.MainAxisAlignment.start,
                                                                                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      pw.Text(
                                                                                        'e)',
                                                                                        style: pw.TextStyle(
                                                                                          font: font,
                                                                                          fontSize: level1,
                                                                                          color: PdfColor.fromHex("#000000"),
                                                                                        ),
                                                                                      ),
                                                                                      pw.SizedBox(
                                                                                        width: 5,
                                                                                      ),
                                                                                      pw.Expanded(
                                                                                        child: pw.Column(
                                                                                          mainAxisAlignment: pw.MainAxisAlignment.start,
                                                                                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                                                                                          children: [
                                                                                            pw.Text(
                                                                                              'Kehabisan bensin di jalan (bantuan pembelian bensin dengan pengantaran gratis)',
                                                                                              textAlign: pw.TextAlign.justify,
                                                                                              style: pw.TextStyle(
                                                                                                font: font,
                                                                                                fontSize: levelmin1,
                                                                                                color: PdfColor.fromHex("#000000"),
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        pw.SizedBox(
                                                                          height:
                                                                              5,
                                                                        ),
                                                                        pw.Row(
                                                                          mainAxisAlignment: pw
                                                                              .MainAxisAlignment
                                                                              .start,
                                                                          crossAxisAlignment: pw
                                                                              .CrossAxisAlignment
                                                                              .start,
                                                                          children: [
                                                                            pw.Text(
                                                                              '2)',
                                                                              style: pw.TextStyle(
                                                                                font: font,
                                                                                fontSize: levelmin1,
                                                                                color: PdfColor.fromHex("#000000"),
                                                                              ),
                                                                            ),
                                                                            pw.SizedBox(
                                                                              width: 5,
                                                                            ),
                                                                            pw.Expanded(
                                                                              child: pw.Column(
                                                                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                                                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                                                                children: [
                                                                                  pw.Text(
                                                                                    'Customer mengisi posisi pada mobile apps atau telepon terkait kondisi dan kendala kendaraan yang sedang dialami dan titik lokasi penjemputan.',
                                                                                    textAlign: pw.TextAlign.justify,
                                                                                    style: pw.TextStyle(
                                                                                      font: font,
                                                                                      fontSize: levelmin1,
                                                                                      color: PdfColor.fromHex("#000000"),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        pw.SizedBox(
                                                                          height:
                                                                              5,
                                                                        ),
                                                                        pw.Row(
                                                                          mainAxisAlignment: pw
                                                                              .MainAxisAlignment
                                                                              .start,
                                                                          crossAxisAlignment: pw
                                                                              .CrossAxisAlignment
                                                                              .start,
                                                                          children: [
                                                                            pw.Text(
                                                                              '3)',
                                                                              style: pw.TextStyle(
                                                                                font: font,
                                                                                fontSize: levelmin1,
                                                                                color: PdfColor.fromHex("#000000"),
                                                                              ),
                                                                            ),
                                                                            pw.SizedBox(
                                                                              width: 5,
                                                                            ),
                                                                            pw.Expanded(
                                                                              child: pw.Column(
                                                                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                                                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                                                                children: [
                                                                                  pw.Text(
                                                                                    'Montiro akan menghubungkan customer dengan mitra Montiro.id dan menginformasi kan customer terkait data mitra yang akan datang memberikan bantuan.',
                                                                                    textAlign: pw.TextAlign.justify,
                                                                                    style: pw.TextStyle(
                                                                                      font: font,
                                                                                      fontSize: levelmin1,
                                                                                      color: PdfColor.fromHex("#000000"),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        pw.SizedBox(
                                                                          height:
                                                                              5,
                                                                        ),
                                                                        pw.Row(
                                                                          mainAxisAlignment: pw
                                                                              .MainAxisAlignment
                                                                              .start,
                                                                          crossAxisAlignment: pw
                                                                              .CrossAxisAlignment
                                                                              .start,
                                                                          children: [
                                                                            pw.Text(
                                                                              '4)',
                                                                              style: pw.TextStyle(
                                                                                font: font,
                                                                                fontSize: levelmin1,
                                                                                color: PdfColor.fromHex("#000000"),
                                                                              ),
                                                                            ),
                                                                            pw.SizedBox(
                                                                              width: 5,
                                                                            ),
                                                                            pw.Expanded(
                                                                              child: pw.Column(
                                                                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                                                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                                                                children: [
                                                                                  pw.Text(
                                                                                    'Mitra ERA Montiro menuju lokasi customer dalam waktu 60 menit. Customer memahami bahwa Waktu kedatangan towing dapat melebihi waktu yang sudah ditentukan tergantung dari kondisi lokasi penjemputan. Beberapa kemungkinan kondisi tersebut adalah:',
                                                                                    textAlign: pw.TextAlign.justify,
                                                                                    style: pw.TextStyle(
                                                                                      font: font,
                                                                                      fontSize: levelmin1,
                                                                                      color: PdfColor.fromHex("#000000"),
                                                                                    ),
                                                                                  ),
                                                                                  pw.SizedBox(
                                                                                    height: 2,
                                                                                  ),
                                                                                  pw.Row(
                                                                                    mainAxisAlignment: pw.MainAxisAlignment.start,
                                                                                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      pw.Text(
                                                                                        'i.',
                                                                                        style: pw.TextStyle(
                                                                                          font: fontBold,
                                                                                          fontSize: levelmin1,
                                                                                          color: PdfColor.fromHex("#000000"),
                                                                                        ),
                                                                                      ),
                                                                                      pw.SizedBox(
                                                                                        width: 5,
                                                                                      ),
                                                                                      pw.Expanded(
                                                                                        child: pw.Column(
                                                                                          mainAxisAlignment: pw.MainAxisAlignment.start,
                                                                                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                                                                                          children: [
                                                                                            pw.Text(
                                                                                              'Terdapat bencana alam (contoh: banjir) pada lokasi penjemputan',
                                                                                              textAlign: pw.TextAlign.justify,
                                                                                              style: pw.TextStyle(
                                                                                                font: font,
                                                                                                fontSize: levelmin1,
                                                                                                color: PdfColor.fromHex("#000000"),
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  pw.SizedBox(
                                                                                    height: 2,
                                                                                  ),
                                                                                  pw.Row(
                                                                                    mainAxisAlignment: pw.MainAxisAlignment.start,
                                                                                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      pw.Text(
                                                                                        'ii.',
                                                                                        style: pw.TextStyle(
                                                                                          font: fontBold,
                                                                                          fontSize: levelmin1,
                                                                                          color: PdfColor.fromHex("#000000"),
                                                                                        ),
                                                                                      ),
                                                                                      pw.SizedBox(
                                                                                        width: 5,
                                                                                      ),
                                                                                      pw.Expanded(
                                                                                        child: pw.Column(
                                                                                          mainAxisAlignment: pw.MainAxisAlignment.start,
                                                                                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                                                                                          children: [
                                                                                            pw.Text(
                                                                                              'Jalan macet menuju lokasi penjemputan',
                                                                                              textAlign: pw.TextAlign.justify,
                                                                                              style: pw.TextStyle(
                                                                                                font: font,
                                                                                                fontSize: levelmin1,
                                                                                                color: PdfColor.fromHex("#000000"),
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  pw.SizedBox(
                                                                                    height: 2,
                                                                                  ),
                                                                                  pw.Row(
                                                                                    mainAxisAlignment: pw.MainAxisAlignment.start,
                                                                                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      pw.Text(
                                                                                        'iii.',
                                                                                        style: pw.TextStyle(
                                                                                          font: fontBold,
                                                                                          fontSize: levelmin1,
                                                                                          color: PdfColor.fromHex("#000000"),
                                                                                        ),
                                                                                      ),
                                                                                      pw.SizedBox(
                                                                                        width: 5,
                                                                                      ),
                                                                                      pw.Expanded(
                                                                                        child: pw.Column(
                                                                                          mainAxisAlignment: pw.MainAxisAlignment.start,
                                                                                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                                                                                          children: [
                                                                                            pw.Text(
                                                                                              'Jarak tempuh lokasi penjemputan yang terlalu jauh dari coverage (jangkauan)',
                                                                                              textAlign: pw.TextAlign.justify,
                                                                                              style: pw.TextStyle(
                                                                                                font: font,
                                                                                                fontSize: levelmin1,
                                                                                                color: PdfColor.fromHex("#000000"),
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        pw.SizedBox(
                                                                          height:
                                                                              5,
                                                                        ),
                                                                        pw.Row(
                                                                          mainAxisAlignment: pw
                                                                              .MainAxisAlignment
                                                                              .start,
                                                                          crossAxisAlignment: pw
                                                                              .CrossAxisAlignment
                                                                              .start,
                                                                          children: [
                                                                            pw.Text(
                                                                              '5)',
                                                                              style: pw.TextStyle(
                                                                                font: font,
                                                                                fontSize: levelmin1,
                                                                                color: PdfColor.fromHex("#000000"),
                                                                              ),
                                                                            ),
                                                                            pw.SizedBox(
                                                                              width: 5,
                                                                            ),
                                                                            pw.Expanded(
                                                                              child: pw.Column(
                                                                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                                                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                                                                children: [
                                                                                  pw.Text(
                                                                                    'Customer memahami bahwa ketentuan jarak towing adalah ke bengkel terdekat atau lokasi antar adalah maksimal 50 km dari lokasi jemput atau dalam kota. Jika customer menghendaki pengantaran melebihi jarak tersebut, customer akan dikenakan biaya tambahan sebesar Rp.20.000 per kilometer.',
                                                                                    textAlign: pw.TextAlign.justify,
                                                                                    style: pw.TextStyle(
                                                                                      font: font,
                                                                                      fontSize: levelmin1,
                                                                                      color: PdfColor.fromHex("#000000"),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
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
                  'Versi 1.0.0',
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
                      color: PdfColor.fromHex("#272262"),
                      width: 1,
                    ),
                  ),
                  child: pw.Column(
                    children: [
                      pw.SizedBox(height: 15),
                      pw.Expanded(
                        child: pw.Container(
                          width: double.infinity,
                          child: pw.Row(
                            children: [
                              pw.Expanded(
                                child: pw.Column(
                                  mainAxisAlignment: pw.MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Container(
                                      margin: const pw.EdgeInsets.only(
                                        top: 15,
                                        left: 30,
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
                                                '',
                                                style: pw.TextStyle(
                                                  font: fontBold,
                                                  fontSize: level1,
                                                  color: PdfColor.fromHex(
                                                      "#272262"),
                                                ),
                                              ),
                                              pw.SizedBox(
                                                width: 5,
                                              ),
                                              pw.Expanded(
                                                child: pw.Column(
                                                  mainAxisAlignment: pw
                                                      .MainAxisAlignment.start,
                                                  crossAxisAlignment: pw
                                                      .CrossAxisAlignment.start,
                                                  children: [
                                                    pw.Row(
                                                      mainAxisAlignment: pw
                                                          .MainAxisAlignment
                                                          .start,
                                                      crossAxisAlignment: pw
                                                          .CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        pw.Text(
                                                          '  ',
                                                          style: pw.TextStyle(
                                                            font: fontBold,
                                                            fontSize: level1,
                                                            color: PdfColor
                                                                .fromHex(
                                                                    "#272262"),
                                                          ),
                                                        ),
                                                        pw.SizedBox(
                                                          width: 5,
                                                        ),
                                                        pw.Expanded(
                                                          child: pw.Column(
                                                            mainAxisAlignment: pw
                                                                .MainAxisAlignment
                                                                .start,
                                                            crossAxisAlignment: pw
                                                                .CrossAxisAlignment
                                                                .start,
                                                            children: [
                                                              pw.Row(
                                                                mainAxisAlignment:
                                                                    pw.MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    pw.CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  pw.Text(
                                                                    '  ',
                                                                    style: pw
                                                                        .TextStyle(
                                                                      font:
                                                                          fontBold,
                                                                      fontSize:
                                                                          level1,
                                                                      color: PdfColor
                                                                          .fromHex(
                                                                              "#272262"),
                                                                    ),
                                                                  ),
                                                                  pw.SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                  pw.Expanded(
                                                                    child: pw
                                                                        .Column(
                                                                      mainAxisAlignment: pw
                                                                          .MainAxisAlignment
                                                                          .start,
                                                                      crossAxisAlignment: pw
                                                                          .CrossAxisAlignment
                                                                          .start,
                                                                      children: [
                                                                        pw.Row(
                                                                          mainAxisAlignment: pw
                                                                              .MainAxisAlignment
                                                                              .start,
                                                                          crossAxisAlignment: pw
                                                                              .CrossAxisAlignment
                                                                              .start,
                                                                          children: [
                                                                            pw.Text(
                                                                              '6)',
                                                                              style: pw.TextStyle(
                                                                                font: font,
                                                                                fontSize: levelmin1,
                                                                                color: PdfColor.fromHex("#000000"),
                                                                              ),
                                                                            ),
                                                                            pw.SizedBox(
                                                                              width: 5,
                                                                            ),
                                                                            pw.Expanded(
                                                                              child: pw.Column(
                                                                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                                                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                                                                children: [
                                                                                  pw.Text(
                                                                                    'Customer memahami bahwa kendaraan yang dapat menggunakan layanan Montiro Membership ERA harus sesuai dengan data yang didaftarkan. Dalam hal kendaraan tidak sesuai dengan data yang didaftarkan, customer akan diberlakukan sebagai customer umum.',
                                                                                    textAlign: pw.TextAlign.justify,
                                                                                    style: pw.TextStyle(
                                                                                      font: font,
                                                                                      fontSize: levelmin1,
                                                                                      color: PdfColor.fromHex("#000000"),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        pw.SizedBox(
                                                                            height:
                                                                                5),
                                                                        pw.Row(
                                                                          mainAxisAlignment: pw
                                                                              .MainAxisAlignment
                                                                              .start,
                                                                          crossAxisAlignment: pw
                                                                              .CrossAxisAlignment
                                                                              .start,
                                                                          children: [
                                                                            pw.Text(
                                                                              '7)',
                                                                              style: pw.TextStyle(
                                                                                font: font,
                                                                                fontSize: levelmin1,
                                                                                color: PdfColor.fromHex("#000000"),
                                                                              ),
                                                                            ),
                                                                            pw.SizedBox(
                                                                              width: 5,
                                                                            ),
                                                                            pw.Expanded(
                                                                              child: pw.Column(
                                                                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                                                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                                                                children: [
                                                                                  pw.Text(
                                                                                    'Customer telah memastikan bahwa kendaraan towing Mitra dapat mengakses lokasi penjempu tan dan lokasi pengiriman.',
                                                                                    textAlign: pw.TextAlign.justify,
                                                                                    style: pw.TextStyle(
                                                                                      font: font,
                                                                                      fontSize: levelmin1,
                                                                                      color: PdfColor.fromHex("#000000"),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        pw.SizedBox(
                                                                            height:
                                                                                5),
                                                                        pw.Row(
                                                                          mainAxisAlignment: pw
                                                                              .MainAxisAlignment
                                                                              .start,
                                                                          crossAxisAlignment: pw
                                                                              .CrossAxisAlignment
                                                                              .start,
                                                                          children: [
                                                                            pw.Text(
                                                                              '8)',
                                                                              style: pw.TextStyle(
                                                                                font: font,
                                                                                fontSize: levelmin1,
                                                                                color: PdfColor.fromHex("#000000"),
                                                                              ),
                                                                            ),
                                                                            pw.SizedBox(
                                                                              width: 5,
                                                                            ),
                                                                            pw.Expanded(
                                                                              child: pw.Column(
                                                                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                                                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                                                                children: [
                                                                                  pw.Text(
                                                                                    'Sebelum melakukan pengangkutan, Mitra Towing akan mengambil foto kendaraan dan meminta customer untuk mengisi form serah terima kendaraan.',
                                                                                    textAlign: pw.TextAlign.justify,
                                                                                    style: pw.TextStyle(
                                                                                      font: font,
                                                                                      fontSize: levelmin1,
                                                                                      color: PdfColor.fromHex("#000000"),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        pw.SizedBox(
                                                                            height:
                                                                                5),
                                                                        pw.Row(
                                                                          mainAxisAlignment: pw
                                                                              .MainAxisAlignment
                                                                              .start,
                                                                          crossAxisAlignment: pw
                                                                              .CrossAxisAlignment
                                                                              .start,
                                                                          children: [
                                                                            pw.Text(
                                                                              '9)',
                                                                              style: pw.TextStyle(
                                                                                font: fontBold,
                                                                                fontSize: levelmin1,
                                                                                color: PdfColor.fromHex("#000000"),
                                                                              ),
                                                                            ),
                                                                            pw.SizedBox(
                                                                              width: 5,
                                                                            ),
                                                                            pw.Expanded(
                                                                              child: pw.Column(
                                                                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                                                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                                                                children: [
                                                                                  pw.Text(
                                                                                    'Dalam hal penerima kendaraan bukan customer yang bersangkutan, customer wajib menginformasi kan data penerima secara lengkap dan akurat.',
                                                                                    textAlign: pw.TextAlign.justify,
                                                                                    style: pw.TextStyle(
                                                                                      font: font,
                                                                                      fontSize: levelmin1,
                                                                                      color: PdfColor.fromHex("#000000"),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    pw.Container(
                                      margin: const pw.EdgeInsets.only(
                                        top: 15,
                                        left: 30,
                                      ),
                                      child: pw.Row(
                                        mainAxisAlignment:
                                            pw.MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.start,
                                        children: [
                                          pw.Text(
                                            '3.',
                                            style: pw.TextStyle(
                                              font: fontBold,
                                              fontSize: level1,
                                              color:
                                                  PdfColor.fromHex("#272262"),
                                            ),
                                          ),
                                          pw.SizedBox(
                                            width: 5,
                                          ),
                                          pw.Expanded(
                                            child: pw.Column(
                                              mainAxisAlignment:
                                                  pw.MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  pw.CrossAxisAlignment.start,
                                              children: [
                                                pw.Text(
                                                  'DISCLAIMER',
                                                  textAlign:
                                                      pw.TextAlign.justify,
                                                  style: pw.TextStyle(
                                                    font: fontBold,
                                                    fontSize: level1,
                                                    color: PdfColor.fromHex(
                                                        "#272262"),
                                                  ),
                                                ),
                                                pw.Row(
                                                  mainAxisAlignment: pw
                                                      .MainAxisAlignment.start,
                                                  crossAxisAlignment: pw
                                                      .CrossAxisAlignment.start,
                                                  children: [
                                                    pw.Expanded(
                                                      child: pw.Column(
                                                        mainAxisAlignment: pw
                                                            .MainAxisAlignment
                                                            .start,
                                                        crossAxisAlignment: pw
                                                            .CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          pw.SizedBox(
                                                              height: 5),
                                                          pw.Row(
                                                            mainAxisAlignment: pw
                                                                .MainAxisAlignment
                                                                .start,
                                                            crossAxisAlignment: pw
                                                                .CrossAxisAlignment
                                                                .start,
                                                            children: [
                                                              pw.Text(
                                                                '1)',
                                                                style: pw
                                                                    .TextStyle(
                                                                  font: font,
                                                                  fontSize:
                                                                      levelmin1,
                                                                  color: PdfColor
                                                                      .fromHex(
                                                                          "#000000"),
                                                                ),
                                                              ),
                                                              pw.SizedBox(
                                                                width: 5,
                                                              ),
                                                              pw.Expanded(
                                                                child:
                                                                    pw.Column(
                                                                  mainAxisAlignment: pw
                                                                      .MainAxisAlignment
                                                                      .start,
                                                                  crossAxisAlignment: pw
                                                                      .CrossAxisAlignment
                                                                      .start,
                                                                  children: [
                                                                    pw.Text(
                                                                      'Dalam hal kendaraan towing tidak dapat menjangkau lokasi jemput atau lokasi pengiriman yang disebabkan oleh beberapa faktor (contoh: banjir, gang sempit, basement Gedung), customer dapat mendiskusikan dengan mitra untuk mencari penyelesaian atas masalah tersebut. Mitra dapat menolak maupun mengenakan tambahan biaya atas penyelesaian masalah tersebut.',
                                                                      textAlign: pw
                                                                          .TextAlign
                                                                          .justify,
                                                                      style: pw
                                                                          .TextStyle(
                                                                        font:
                                                                            font,
                                                                        fontSize:
                                                                            levelmin1,
                                                                        color: PdfColor.fromHex(
                                                                            "#000000"),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          pw.SizedBox(
                                                              height: 5),
                                                          pw.Row(
                                                            mainAxisAlignment: pw
                                                                .MainAxisAlignment
                                                                .start,
                                                            crossAxisAlignment: pw
                                                                .CrossAxisAlignment
                                                                .start,
                                                            children: [
                                                              pw.Text(
                                                                '2)',
                                                                style: pw
                                                                    .TextStyle(
                                                                  font: font,
                                                                  fontSize:
                                                                      levelmin1,
                                                                  color: PdfColor
                                                                      .fromHex(
                                                                          "#000000"),
                                                                ),
                                                              ),
                                                              pw.SizedBox(
                                                                width: 5,
                                                              ),
                                                              pw.Expanded(
                                                                child:
                                                                    pw.Column(
                                                                  mainAxisAlignment: pw
                                                                      .MainAxisAlignment
                                                                      .start,
                                                                  crossAxisAlignment: pw
                                                                      .CrossAxisAlignment
                                                                      .start,
                                                                  children: [
                                                                    pw.Text(
                                                                      'Pengguna wajib untuk memastikan bahwa dalam pengangkutan kendaraan tidak ada barang sebagai berikut:',
                                                                      textAlign: pw
                                                                          .TextAlign
                                                                          .justify,
                                                                      style: pw
                                                                          .TextStyle(
                                                                        font:
                                                                            font,
                                                                        fontSize:
                                                                            levelmin1,
                                                                        color: PdfColor.fromHex(
                                                                            "#000000"),
                                                                      ),
                                                                    ),
                                                                    pw.SizedBox(
                                                                        height:
                                                                            5),
                                                                    pw.Row(
                                                                      mainAxisAlignment: pw
                                                                          .MainAxisAlignment
                                                                          .start,
                                                                      crossAxisAlignment: pw
                                                                          .CrossAxisAlignment
                                                                          .start,
                                                                      children: [
                                                                        pw.Text(
                                                                          'a.',
                                                                          style:
                                                                              pw.TextStyle(
                                                                            font:
                                                                                font,
                                                                            fontSize:
                                                                                level1,
                                                                            color:
                                                                                PdfColor.fromHex("#000000"),
                                                                          ),
                                                                        ),
                                                                        pw.SizedBox(
                                                                          width:
                                                                              5,
                                                                        ),
                                                                        pw.Expanded(
                                                                          child:
                                                                              pw.Column(
                                                                            mainAxisAlignment:
                                                                                pw.MainAxisAlignment.start,
                                                                            crossAxisAlignment:
                                                                                pw.CrossAxisAlignment.start,
                                                                            children: [
                                                                              pw.Text(
                                                                                'Barang Terlarang, termasuk namun tidak terbatas pada:',
                                                                                textAlign: pw.TextAlign.justify,
                                                                                style: pw.TextStyle(
                                                                                  font: font,
                                                                                  fontSize: levelmin1,
                                                                                  color: PdfColor.fromHex("#000000"),
                                                                                ),
                                                                              ),
                                                                              pw.Row(
                                                                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                                                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                                                                children: [
                                                                                  pw.Text(
                                                                                    'i.    ',
                                                                                    style: pw.TextStyle(
                                                                                      font: font,
                                                                                      fontSize: level1,
                                                                                      color: PdfColor.fromHex("#000000"),
                                                                                    ),
                                                                                  ),
                                                                                  pw.SizedBox(
                                                                                    width: 5,
                                                                                  ),
                                                                                  pw.Expanded(
                                                                                    child: pw.Column(
                                                                                      mainAxisAlignment: pw.MainAxisAlignment.start,
                                                                                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        pw.Text(
                                                                                          'Uang (tunai, koin, mata uang asing);',
                                                                                          textAlign: pw.TextAlign.justify,
                                                                                          style: pw.TextStyle(
                                                                                            font: font,
                                                                                            fontSize: levelmin1,
                                                                                            color: PdfColor.fromHex("#000000"),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              pw.Row(
                                                                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                                                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                                                                children: [
                                                                                  pw.Text(
                                                                                    'ii.   ',
                                                                                    style: pw.TextStyle(
                                                                                      font: font,
                                                                                      fontSize: level1,
                                                                                      color: PdfColor.fromHex("#000000"),
                                                                                    ),
                                                                                  ),
                                                                                  pw.SizedBox(
                                                                                    width: 5,
                                                                                  ),
                                                                                  pw.Expanded(
                                                                                    child: pw.Column(
                                                                                      mainAxisAlignment: pw.MainAxisAlignment.start,
                                                                                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        pw.Text(
                                                                                          'Narkotika, ganja, morfin, dan produk lainnya yang menyebabkan kecanduan;',
                                                                                          textAlign: pw.TextAlign.justify,
                                                                                          style: pw.TextStyle(
                                                                                            font: font,
                                                                                            fontSize: levelmin1,
                                                                                            color: PdfColor.fromHex("#000000"),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              pw.Row(
                                                                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                                                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                                                                children: [
                                                                                  pw.Text(
                                                                                    'iii.  ',
                                                                                    style: pw.TextStyle(
                                                                                      font: font,
                                                                                      fontSize: level1,
                                                                                      color: PdfColor.fromHex("#000000"),
                                                                                    ),
                                                                                  ),
                                                                                  pw.SizedBox(
                                                                                    width: 5,
                                                                                  ),
                                                                                  pw.Expanded(
                                                                                    child: pw.Column(
                                                                                      mainAxisAlignment: pw.MainAxisAlignment.start,
                                                                                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        pw.Text(
                                                                                          'Pornografi dalam bentuk apapun;',
                                                                                          textAlign: pw.TextAlign.justify,
                                                                                          style: pw.TextStyle(
                                                                                            font: font,
                                                                                            fontSize: levelmin1,
                                                                                            color: PdfColor.fromHex("#000000"),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              pw.Row(
                                                                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                                                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                                                                children: [
                                                                                  pw.Text(
                                                                                    'iv.  ',
                                                                                    style: pw.TextStyle(
                                                                                      font: font,
                                                                                      fontSize: level1,
                                                                                      color: PdfColor.fromHex("#000000"),
                                                                                    ),
                                                                                  ),
                                                                                  pw.SizedBox(
                                                                                    width: 5,
                                                                                  ),
                                                                                  pw.Expanded(
                                                                                    child: pw.Column(
                                                                                      mainAxisAlignment: pw.MainAxisAlignment.start,
                                                                                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        pw.Text(
                                                                                          'Pengiriman yang memiliki durasi lebih lama dari waktu transit yang diperlukan;',
                                                                                          textAlign: pw.TextAlign.justify,
                                                                                          style: pw.TextStyle(
                                                                                            font: font,
                                                                                            fontSize: levelmin1,
                                                                                            color: PdfColor.fromHex("#000000"),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              pw.Row(
                                                                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                                                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                                                                children: [
                                                                                  pw.Text(
                                                                                    'v.   ',
                                                                                    style: pw.TextStyle(
                                                                                      font: font,
                                                                                      fontSize: level1,
                                                                                      color: PdfColor.fromHex("#000000"),
                                                                                    ),
                                                                                  ),
                                                                                  pw.SizedBox(
                                                                                    width: 5,
                                                                                  ),
                                                                                  pw.Expanded(
                                                                                    child: pw.Column(
                                                                                      mainAxisAlignment: pw.MainAxisAlignment.start,
                                                                                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        pw.Text(
                                                                                          'Hewan hidup dan tanaman;',
                                                                                          textAlign: pw.TextAlign.justify,
                                                                                          style: pw.TextStyle(
                                                                                            font: font,
                                                                                            fontSize: levelmin1,
                                                                                            color: PdfColor.fromHex("#000000"),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              pw.Row(
                                                                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                                                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                                                                children: [
                                                                                  pw.Text(
                                                                                    'vi.  ',
                                                                                    style: pw.TextStyle(
                                                                                      font: font,
                                                                                      fontSize: level1,
                                                                                      color: PdfColor.fromHex("#000000"),
                                                                                    ),
                                                                                  ),
                                                                                  pw.SizedBox(
                                                                                    width: 5,
                                                                                  ),
                                                                                  pw.Expanded(
                                                                                    child: pw.Column(
                                                                                      mainAxisAlignment: pw.MainAxisAlignment.start,
                                                                                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        pw.Text(
                                                                                          'Bahan makanan yang mudah rusak dan minuman yang membutuhkan pendingin atau lingkungan yang dikendalikan;',
                                                                                          textAlign: pw.TextAlign.justify,
                                                                                          style: pw.TextStyle(
                                                                                            font: font,
                                                                                            fontSize: levelmin1,
                                                                                            color: PdfColor.fromHex("#000000"),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              pw.Row(
                                                                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                                                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                                                                children: [
                                                                                  pw.Text(
                                                                                    'vii. ',
                                                                                    style: pw.TextStyle(
                                                                                      font: font,
                                                                                      fontSize: level1,
                                                                                      color: PdfColor.fromHex("#000000"),
                                                                                    ),
                                                                                  ),
                                                                                  pw.SizedBox(
                                                                                    width: 5,
                                                                                  ),
                                                                                  pw.Expanded(
                                                                                    child: pw.Column(
                                                                                      mainAxisAlignment: pw.MainAxisAlignment.start,
                                                                                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        pw.Text(
                                                                                          'Bahan peledak, senjata api, persenjataan, dan bagian-bagiannya;',
                                                                                          textAlign: pw.TextAlign.justify,
                                                                                          style: pw.TextStyle(
                                                                                            font: font,
                                                                                            fontSize: levelmin1,
                                                                                            color: PdfColor.fromHex("#000000"),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              pw.Row(
                                                                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                                                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                                                                children: [
                                                                                  pw.Text(
                                                                                    'viii.',
                                                                                    style: pw.TextStyle(
                                                                                      font: font,
                                                                                      fontSize: level1,
                                                                                      color: PdfColor.fromHex("#000000"),
                                                                                    ),
                                                                                  ),
                                                                                  pw.SizedBox(
                                                                                    width: 5,
                                                                                  ),
                                                                                  pw.Expanded(
                                                                                    child: pw.Column(
                                                                                      mainAxisAlignment: pw.MainAxisAlignment.start,
                                                                                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        pw.Text(
                                                                                          'Perangkat judi dan tiket lotere;',
                                                                                          textAlign: pw.TextAlign.justify,
                                                                                          style: pw.TextStyle(
                                                                                            font: font,
                                                                                            fontSize: levelmin1,
                                                                                            color: PdfColor.fromHex("#000000"),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              pw.Row(
                                                                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                                                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                                                                children: [
                                                                                  pw.Text(
                                                                                    'ix.  ',
                                                                                    style: pw.TextStyle(
                                                                                      font: font,
                                                                                      fontSize: level1,
                                                                                      color: PdfColor.fromHex("#000000"),
                                                                                    ),
                                                                                  ),
                                                                                  pw.SizedBox(
                                                                                    width: 5,
                                                                                  ),
                                                                                  pw.Expanded(
                                                                                    child: pw.Column(
                                                                                      mainAxisAlignment: pw.MainAxisAlignment.start,
                                                                                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        pw.Text(
                                                                                          'Barang-barang yang dikendalikan oleh pemerintah;',
                                                                                          textAlign: pw.TextAlign.justify,
                                                                                          style: pw.TextStyle(
                                                                                            font: font,
                                                                                            fontSize: levelmin1,
                                                                                            color: PdfColor.fromHex("#000000"),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              pw.Row(
                                                                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                                                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                                                                children: [
                                                                                  pw.Text(
                                                                                    'x.   ',
                                                                                    style: pw.TextStyle(
                                                                                      font: font,
                                                                                      fontSize: level1,
                                                                                      color: PdfColor.fromHex("#000000"),
                                                                                    ),
                                                                                  ),
                                                                                  pw.SizedBox(
                                                                                    width: 5,
                                                                                  ),
                                                                                  pw.Expanded(
                                                                                    child: pw.Column(
                                                                                      mainAxisAlignment: pw.MainAxisAlignment.start,
                                                                                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        pw.Text(
                                                                                          'Barang hasil tindak kejahatan, misalnya barang curian dan sebagainya; dan/atau',
                                                                                          textAlign: pw.TextAlign.justify,
                                                                                          style: pw.TextStyle(
                                                                                            font: font,
                                                                                            fontSize: levelmin1,
                                                                                            color: PdfColor.fromHex("#000000"),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              pw.Row(
                                                                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                                                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                                                                children: [
                                                                                  pw.Text(
                                                                                    'xi.  ',
                                                                                    style: pw.TextStyle(
                                                                                      font: font,
                                                                                      fontSize: level1,
                                                                                      color: PdfColor.fromHex("#000000"),
                                                                                    ),
                                                                                  ),
                                                                                  pw.SizedBox(
                                                                                    width: 5,
                                                                                  ),
                                                                                  pw.Expanded(
                                                                                    child: pw.Column(
                                                                                      mainAxisAlignment: pw.MainAxisAlignment.start,
                                                                                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        pw.Text(
                                                                                          'Barang lain yang dilarang oleh hukum dan peraturan perundang-undangan yang berlaku;',
                                                                                          textAlign: pw.TextAlign.justify,
                                                                                          style: pw.TextStyle(
                                                                                            font: font,
                                                                                            fontSize: levelmin1,
                                                                                            color: PdfColor.fromHex("#000000"),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    pw.SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    pw.Row(
                                                                      mainAxisAlignment: pw
                                                                          .MainAxisAlignment
                                                                          .start,
                                                                      crossAxisAlignment: pw
                                                                          .CrossAxisAlignment
                                                                          .start,
                                                                      children: [
                                                                        pw.Text(
                                                                          'b.',
                                                                          style:
                                                                              pw.TextStyle(
                                                                            font:
                                                                                font,
                                                                            fontSize:
                                                                                level1,
                                                                            color:
                                                                                PdfColor.fromHex("#000000"),
                                                                          ),
                                                                        ),
                                                                        pw.SizedBox(
                                                                          width:
                                                                              5,
                                                                        ),
                                                                        pw.Expanded(
                                                                          child:
                                                                              pw.Column(
                                                                            mainAxisAlignment:
                                                                                pw.MainAxisAlignment.start,
                                                                            crossAxisAlignment:
                                                                                pw.CrossAxisAlignment.start,
                                                                            children: [
                                                                              pw.Text(
                                                                                'Barang Luar Biasa, termasuk namun tidak terbatas pada:',
                                                                                textAlign: pw.TextAlign.justify,
                                                                                style: pw.TextStyle(
                                                                                  font: font,
                                                                                  fontSize: levelmin1,
                                                                                  color: PdfColor.fromHex("#000000"),
                                                                                ),
                                                                              ),
                                                                              pw.Row(
                                                                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                                                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                                                                children: [
                                                                                  pw.Text(
                                                                                    'i.   ',
                                                                                    style: pw.TextStyle(
                                                                                      font: font,
                                                                                      fontSize: level1,
                                                                                      color: PdfColor.fromHex("#000000"),
                                                                                    ),
                                                                                  ),
                                                                                  pw.SizedBox(
                                                                                    width: 5,
                                                                                  ),
                                                                                  pw.Expanded(
                                                                                    child: pw.Column(
                                                                                      mainAxisAlignment: pw.MainAxisAlignment.start,
                                                                                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        pw.Text(
                                                                                          'Karya seni, termasuk karya yang dibuat atau dikerjakan dengan menggunakan keterampilan, rasa atau bakat kreatif untuk dijual,',
                                                                                          textAlign: pw.TextAlign.justify,
                                                                                          style: pw.TextStyle(
                                                                                            font: font,
                                                                                            fontSize: levelmin1,
                                                                                            color: PdfColor.fromHex("#000000"),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
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
                              pw.Expanded(
                                child: pw.Column(
                                  mainAxisAlignment: pw.MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Row(
                                      mainAxisAlignment:
                                          pw.MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.start,
                                      children: [
                                        pw.SizedBox(width: 43),
                                        pw.Text(
                                          '       ',
                                          style: pw.TextStyle(
                                            font: font,
                                            fontSize: level1,
                                            color: PdfColor.fromHex("#000000"),
                                          ),
                                        ),
                                        pw.SizedBox(
                                          width: 5,
                                        ),
                                        pw.Expanded(
                                          child: pw.Column(
                                            mainAxisAlignment:
                                                pw.MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                pw.CrossAxisAlignment.start,
                                            children: [
                                              pw.Text(
                                                'dipertunjukkan, atau koleksi, termasuk, namun tidak terbatas pada barang-barang (dan bagian-bagiannya) seperti lukisan, gambar, vas, permadani;',
                                                textAlign: pw.TextAlign.justify,
                                                style: pw.TextStyle(
                                                  font: font,
                                                  fontSize: levelmin1,
                                                  color: PdfColor.fromHex(
                                                      "#000000"),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        pw.SizedBox(
                                          width: 30,
                                        ),
                                      ],
                                    ),
                                    pw.Row(
                                      mainAxisAlignment:
                                          pw.MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.start,
                                      children: [
                                        pw.SizedBox(width: 30),
                                        pw.Text(
                                          'ii.  ',
                                          style: pw.TextStyle(
                                            font: font,
                                            fontSize: level1,
                                            color: PdfColor.fromHex("#000000"),
                                          ),
                                        ),
                                        pw.SizedBox(
                                          width: 5,
                                        ),
                                        pw.Expanded(
                                          child: pw.Column(
                                            mainAxisAlignment:
                                                pw.MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                pw.CrossAxisAlignment.start,
                                            children: [
                                              pw.Text(
                                                'Film, gambar hasil foto, termasuk negatif fotografi, chromes fotografi, slide fotografi;',
                                                textAlign: pw.TextAlign.justify,
                                                style: pw.TextStyle(
                                                  font: font,
                                                  fontSize: levelmin1,
                                                  color: PdfColor.fromHex(
                                                      "#000000"),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        pw.SizedBox(
                                          width: 30,
                                        ),
                                      ],
                                    ),
                                    pw.Row(
                                      mainAxisAlignment:
                                          pw.MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.start,
                                      children: [
                                        pw.SizedBox(width: 30),
                                        pw.Text(
                                          'iii. ',
                                          style: pw.TextStyle(
                                            font: font,
                                            fontSize: level1,
                                            color: PdfColor.fromHex("#000000"),
                                          ),
                                        ),
                                        pw.SizedBox(
                                          width: 5,
                                        ),
                                        pw.Expanded(
                                          child: pw.Column(
                                            mainAxisAlignment:
                                                pw.MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                pw.CrossAxisAlignment.start,
                                            children: [
                                              pw.Text(
                                                'Komoditas yang secara alamiah sangat rentan terhadap kerusakan, atau nilai pasar yang sangat variabel, atau sulit untuk dipastikan;',
                                                textAlign: pw.TextAlign.justify,
                                                style: pw.TextStyle(
                                                  font: font,
                                                  fontSize: levelmin1,
                                                  color: PdfColor.fromHex(
                                                      "#000000"),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        pw.SizedBox(
                                          width: 30,
                                        ),
                                      ],
                                    ),
                                    pw.Row(
                                      mainAxisAlignment:
                                          pw.MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.start,
                                      children: [
                                        pw.SizedBox(width: 30),
                                        pw.Text(
                                          'iv.  ',
                                          style: pw.TextStyle(
                                            font: font,
                                            fontSize: level1,
                                            color: PdfColor.fromHex("#000000"),
                                          ),
                                        ),
                                        pw.SizedBox(
                                          width: 5,
                                        ),
                                        pw.Expanded(
                                          child: pw.Column(
                                            mainAxisAlignment:
                                                pw.MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                pw.CrossAxisAlignment.start,
                                            children: [
                                              pw.Text(
                                                'Barang antik, komoditas yang menunjukkan gaya atau mode dari era masa lalu yang sejarahnya, usia atau kelangkaan kontribusi untuk nilainya. Item ini termasuk namun tidak terbatas pada, furnitur, peralatan makan, gelas, dan barang-barang koleksi seperti koin, perangko;',
                                                textAlign: pw.TextAlign.justify,
                                                style: pw.TextStyle(
                                                  font: font,
                                                  fontSize: levelmin1,
                                                  color: PdfColor.fromHex(
                                                      "#000000"),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        pw.SizedBox(
                                          width: 30,
                                        ),
                                      ],
                                    ),
                                    pw.Row(
                                      mainAxisAlignment:
                                          pw.MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.start,
                                      children: [
                                        pw.SizedBox(width: 30),
                                        pw.Text(
                                          'v.   ',
                                          style: pw.TextStyle(
                                            font: font,
                                            fontSize: level1,
                                            color: PdfColor.fromHex("#000000"),
                                          ),
                                        ),
                                        pw.SizedBox(
                                          width: 5,
                                        ),
                                        pw.Expanded(
                                          child: pw.Column(
                                            mainAxisAlignment:
                                                pw.MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                pw.CrossAxisAlignment.start,
                                            children: [
                                              pw.Text(
                                                'Barang pecah belah berupa perhiasan, termasuk kostum perhiasan, jam tangan dan bagian-bagiannya, batu permata atau batu (mulia atau semi mulia) berlian industri dan perhiasan yang terbuat dari logam mulia;',
                                                textAlign: pw.TextAlign.justify,
                                                style: pw.TextStyle(
                                                  font: font,
                                                  fontSize: levelmin1,
                                                  color: PdfColor.fromHex(
                                                      "#000000"),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        pw.SizedBox(
                                          width: 30,
                                        ),
                                      ],
                                    ),
                                    pw.Row(
                                      mainAxisAlignment:
                                          pw.MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.start,
                                      children: [
                                        pw.SizedBox(width: 30),
                                        pw.Text(
                                          'vi.  ',
                                          style: pw.TextStyle(
                                            font: font,
                                            fontSize: level1,
                                            color: PdfColor.fromHex("#000000"),
                                          ),
                                        ),
                                        pw.SizedBox(
                                          width: 5,
                                        ),
                                        pw.Expanded(
                                          child: pw.Column(
                                            mainAxisAlignment:
                                                pw.MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                pw.CrossAxisAlignment.start,
                                            children: [
                                              pw.Text(
                                                'Bulu binatang, termasuk namun tidak terbatas pada pakaian bulu, pakaian dengan trimming dan kulit berbulu;',
                                                textAlign: pw.TextAlign.justify,
                                                style: pw.TextStyle(
                                                  font: font,
                                                  fontSize: levelmin1,
                                                  color: PdfColor.fromHex(
                                                      "#000000"),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        pw.SizedBox(
                                          width: 30,
                                        ),
                                      ],
                                    ),
                                    pw.Row(
                                      mainAxisAlignment:
                                          pw.MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.start,
                                      children: [
                                        pw.SizedBox(width: 30),
                                        pw.Text(
                                          'vii. ',
                                          style: pw.TextStyle(
                                            font: font,
                                            fontSize: level1,
                                            color: PdfColor.fromHex("#000000"),
                                          ),
                                        ),
                                        pw.SizedBox(
                                          width: 5,
                                        ),
                                        pw.Expanded(
                                          child: pw.Column(
                                            mainAxisAlignment:
                                                pw.MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                pw.CrossAxisAlignment.start,
                                            children: [
                                              pw.Text(
                                                'Logam Mulia, termasuk namun tidak terbatas pada, emas dan perak batangan atau bubuk, endapan atau platinum (kecuali sebagai bagian integral dari mesin elektronik);',
                                                textAlign: pw.TextAlign.justify,
                                                style: pw.TextStyle(
                                                  font: font,
                                                  fontSize: levelmin1,
                                                  color: PdfColor.fromHex(
                                                      "#000000"),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        pw.SizedBox(
                                          width: 30,
                                        ),
                                      ],
                                    ),
                                    pw.Row(
                                      mainAxisAlignment:
                                          pw.MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.start,
                                      children: [
                                        pw.SizedBox(width: 30),
                                        pw.Text(
                                          'viii.',
                                          style: pw.TextStyle(
                                            font: font,
                                            fontSize: level1,
                                            color: PdfColor.fromHex("#000000"),
                                          ),
                                        ),
                                        pw.SizedBox(
                                          width: 5,
                                        ),
                                        pw.Expanded(
                                          child: pw.Column(
                                            mainAxisAlignment:
                                                pw.MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                pw.CrossAxisAlignment.start,
                                            children: [
                                              pw.Text(
                                                'Barang digital dan/atau barang tidak berwujud berisi konversi satuan isi ulang yang memiliki nilai ekonomis, seperti voucher pulsa elektrik, voucher game elektrik, token listrik;',
                                                textAlign: pw.TextAlign.justify,
                                                style: pw.TextStyle(
                                                  font: font,
                                                  fontSize: levelmin1,
                                                  color: PdfColor.fromHex(
                                                      "#000000"),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        pw.SizedBox(
                                          width: 30,
                                        ),
                                      ],
                                    ),
                                    pw.Row(
                                      mainAxisAlignment:
                                          pw.MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.start,
                                      children: [
                                        pw.SizedBox(width: 30),
                                        pw.Text(
                                          'ix.  ',
                                          style: pw.TextStyle(
                                            font: font,
                                            fontSize: level1,
                                            color: PdfColor.fromHex("#000000"),
                                          ),
                                        ),
                                        pw.SizedBox(
                                          width: 5,
                                        ),
                                        pw.Expanded(
                                          child: pw.Column(
                                            mainAxisAlignment:
                                                pw.MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                pw.CrossAxisAlignment.start,
                                            children: [
                                              pw.Text(
                                                'Perangko, cukai atas minuman keras, materai;',
                                                textAlign: pw.TextAlign.justify,
                                                style: pw.TextStyle(
                                                  font: font,
                                                  fontSize: levelmin1,
                                                  color: PdfColor.fromHex(
                                                      "#000000"),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        pw.SizedBox(
                                          width: 30,
                                        ),
                                      ],
                                    ),
                                    pw.Row(
                                      mainAxisAlignment:
                                          pw.MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.start,
                                      children: [
                                        pw.SizedBox(width: 30),
                                        pw.Text(
                                          'x.   ',
                                          style: pw.TextStyle(
                                            font: font,
                                            fontSize: level1,
                                            color: PdfColor.fromHex("#000000"),
                                          ),
                                        ),
                                        pw.SizedBox(
                                          width: 5,
                                        ),
                                        pw.Expanded(
                                          child: pw.Column(
                                            mainAxisAlignment:
                                                pw.MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                pw.CrossAxisAlignment.start,
                                            children: [
                                              pw.Text(
                                                'Stok persediaan darah; dan/atau',
                                                textAlign: pw.TextAlign.justify,
                                                style: pw.TextStyle(
                                                  font: font,
                                                  fontSize: levelmin1,
                                                  color: PdfColor.fromHex(
                                                      "#000000"),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        pw.SizedBox(
                                          width: 30,
                                        ),
                                      ],
                                    ),
                                    pw.Row(
                                      mainAxisAlignment:
                                          pw.MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.start,
                                      children: [
                                        pw.SizedBox(width: 30),
                                        pw.Text(
                                          'xi.  ',
                                          style: pw.TextStyle(
                                            font: font,
                                            fontSize: level1,
                                            color: PdfColor.fromHex("#000000"),
                                          ),
                                        ),
                                        pw.SizedBox(
                                          width: 5,
                                        ),
                                        pw.Expanded(
                                          child: pw.Column(
                                            mainAxisAlignment:
                                                pw.MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                pw.CrossAxisAlignment.start,
                                            children: [
                                              pw.Text(
                                                'Koin Emas (harus dikemas dengan coin header atau Safe-T Mailer dan harus dijaga untuk tidak bersentuhan antara satu dan lainnya atau yang dibungkus dalam bahan yang berlapis).',
                                                textAlign: pw.TextAlign.justify,
                                                style: pw.TextStyle(
                                                  font: font,
                                                  fontSize: levelmin1,
                                                  color: PdfColor.fromHex(
                                                      "#000000"),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        pw.SizedBox(
                                          width: 30,
                                        ),
                                      ],
                                    ),
                                    pw.SizedBox(height: 5),
                                    pw.Row(
                                      mainAxisAlignment:
                                          pw.MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.start,
                                      children: [
                                        pw.SizedBox(width: 15),
                                        pw.Text(
                                          'c. ',
                                          style: pw.TextStyle(
                                            font: font,
                                            fontSize: level1,
                                            color: PdfColor.fromHex("#000000"),
                                          ),
                                        ),
                                        pw.SizedBox(
                                          width: 5,
                                        ),
                                        pw.Expanded(
                                          child: pw.Column(
                                            mainAxisAlignment:
                                                pw.MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                pw.CrossAxisAlignment.start,
                                            children: [
                                              pw.Text(
                                                'Dokumen Berharga, termasuk namun tidak terbatas pada:',
                                                textAlign: pw.TextAlign.justify,
                                                style: pw.TextStyle(
                                                  font: font,
                                                  fontSize: levelmin1,
                                                  color: PdfColor.fromHex(
                                                      "#000000"),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        pw.SizedBox(
                                          width: 30,
                                        ),
                                      ],
                                    ),
                                    pw.Row(
                                      mainAxisAlignment:
                                          pw.MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.start,
                                      children: [
                                        pw.SizedBox(width: 30),
                                        pw.Text(
                                          'i.   ',
                                          style: pw.TextStyle(
                                            font: font,
                                            fontSize: level1,
                                            color: PdfColor.fromHex("#000000"),
                                          ),
                                        ),
                                        pw.SizedBox(
                                          width: 5,
                                        ),
                                        pw.Expanded(
                                          child: pw.Column(
                                            mainAxisAlignment:
                                                pw.MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                pw.CrossAxisAlignment.start,
                                            children: [
                                              pw.Text(
                                                'Sertifikat Kepemilikan dan/atau Sertifikat Hak Milik (SHM) dan Guna Bangunan (HGB)',
                                                textAlign: pw.TextAlign.justify,
                                                style: pw.TextStyle(
                                                  font: font,
                                                  fontSize: levelmin1,
                                                  color: PdfColor.fromHex(
                                                      "#000000"),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        pw.SizedBox(
                                          width: 30,
                                        ),
                                      ],
                                    ),
                                    pw.Row(
                                      mainAxisAlignment:
                                          pw.MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.start,
                                      children: [
                                        pw.SizedBox(width: 30),
                                        pw.Text(
                                          'ii.  ',
                                          style: pw.TextStyle(
                                            font: font,
                                            fontSize: level1,
                                            color: PdfColor.fromHex("#000000"),
                                          ),
                                        ),
                                        pw.SizedBox(
                                          width: 5,
                                        ),
                                        pw.Expanded(
                                          child: pw.Column(
                                            mainAxisAlignment:
                                                pw.MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                pw.CrossAxisAlignment.start,
                                            children: [
                                              pw.Text(
                                                'Bukti Kepemilikan Kendaraan Bermotor (BPKB), Sertifikat Tanda Kelulusan, Paspor; dan/atau',
                                                textAlign: pw.TextAlign.justify,
                                                style: pw.TextStyle(
                                                  font: font,
                                                  fontSize: levelmin1,
                                                  color: PdfColor.fromHex(
                                                      "#000000"),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        pw.SizedBox(
                                          width: 30,
                                        ),
                                      ],
                                    ),
                                    pw.Row(
                                      mainAxisAlignment:
                                          pw.MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.start,
                                      children: [
                                        pw.SizedBox(width: 30),
                                        pw.Text(
                                          'iii. ',
                                          style: pw.TextStyle(
                                            font: font,
                                            fontSize: level1,
                                            color: PdfColor.fromHex("#000000"),
                                          ),
                                        ),
                                        pw.SizedBox(
                                          width: 5,
                                        ),
                                        pw.Expanded(
                                          child: pw.Column(
                                            mainAxisAlignment:
                                                pw.MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                pw.CrossAxisAlignment.start,
                                            children: [
                                              pw.Text(
                                                'Sertifikat Bank Deposit Obligasi Barang-barang lainnya yang didefinisikan oleh Kami sebagai Dokumen Berharga.',
                                                textAlign: pw.TextAlign.justify,
                                                style: pw.TextStyle(
                                                  font: font,
                                                  fontSize: levelmin1,
                                                  color: PdfColor.fromHex(
                                                      "#000000"),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        pw.SizedBox(
                                          width: 30,
                                        ),
                                      ],
                                    ),
                                    pw.SizedBox(height: 5),
                                    pw.Row(
                                      mainAxisAlignment:
                                          pw.MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.start,
                                      children: [
                                        pw.SizedBox(width: 15),
                                        pw.Text(
                                          '3)',
                                          style: pw.TextStyle(
                                            font: font,
                                            fontSize: level1,
                                            color: PdfColor.fromHex("#000000"),
                                          ),
                                        ),
                                        pw.SizedBox(
                                          width: 5,
                                        ),
                                        pw.Expanded(
                                          child: pw.Column(
                                            mainAxisAlignment:
                                                pw.MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                pw.CrossAxisAlignment.start,
                                            children: [
                                              pw.Text(
                                                'Montiro.id tidak bertanggung jawab atas kehilangan atau kerusakan yang terjadi atas barang-barang yang ada di dalam kendaraan.',
                                                textAlign: pw.TextAlign.justify,
                                                style: pw.TextStyle(
                                                  font: font,
                                                  fontSize: levelmin1,
                                                  color: PdfColor.fromHex(
                                                      "#000000"),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        pw.SizedBox(
                                          width: 30,
                                        ),
                                      ],
                                    ),
                                    pw.SizedBox(height: 5),
                                    pw.Row(
                                      mainAxisAlignment:
                                          pw.MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.start,
                                      children: [
                                        pw.SizedBox(width: 15),
                                        pw.Text(
                                          '4)',
                                          style: pw.TextStyle(
                                            font: font,
                                            fontSize: level1,
                                            color: PdfColor.fromHex("#000000"),
                                          ),
                                        ),
                                        pw.SizedBox(
                                          width: 5,
                                        ),
                                        pw.Expanded(
                                          child: pw.Column(
                                            mainAxisAlignment:
                                                pw.MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                pw.CrossAxisAlignment.start,
                                            children: [
                                              pw.Text(
                                                'Dalam hal terjadi hal-hal yang tidak diinginkan selama pemberian layanan ERA, Montiro.id akan, dengan upaya terbaik, membantu mempertemukan Customer dengan Mitra yang terkait dalam mencari penyelesaian atas masalah tersebut.',
                                                textAlign: pw.TextAlign.justify,
                                                style: pw.TextStyle(
                                                  font: font,
                                                  fontSize: levelmin1,
                                                  color: PdfColor.fromHex(
                                                      "#000000"),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        pw.SizedBox(
                                          width: 30,
                                        ),
                                      ],
                                    ),
                                    pw.SizedBox(height: 5),
                                    pw.Row(
                                      mainAxisAlignment:
                                          pw.MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.start,
                                      children: [
                                        pw.SizedBox(width: 15),
                                        pw.Text(
                                          '5)',
                                          style: pw.TextStyle(
                                            font: font,
                                            fontSize: level1,
                                            color: PdfColor.fromHex("#000000"),
                                          ),
                                        ),
                                        pw.SizedBox(
                                          width: 5,
                                        ),
                                        pw.Expanded(
                                          child: pw.Column(
                                            mainAxisAlignment:
                                                pw.MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                pw.CrossAxisAlignment.start,
                                            children: [
                                              pw.Text(
                                                'Syarat dan Ketentuan ini dapat berubah sewaktu waktu, yang perubahannya akan dinformasikan oleh Montiro.id ke Customer.',
                                                textAlign: pw.TextAlign.justify,
                                                style: pw.TextStyle(
                                                  font: font,
                                                  fontSize: levelmin1,
                                                  color: PdfColor.fromHex(
                                                      "#000000"),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        pw.SizedBox(
                                          width: 30,
                                        ),
                                      ],
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
                  'Versi 1.0.0',
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

   List<int> bytes = await pdf.save();
    html.AnchorElement(
        href:
            "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}")
      ..setAttribute("download",
          "E-Sertifikat-${response.detailPackage!.idMembership}.pdf")
      ..click();
}
