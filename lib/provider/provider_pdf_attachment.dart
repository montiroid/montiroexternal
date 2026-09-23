import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../service/service_booking.dart';
import 'dart:html' as html;
import 'dart:convert';

class ProviderPdfAttachment with ChangeNotifier {
  final String id;

  ProviderPdfAttachment(
    this.id,
  );

  var isLoading = true;

  download(BuildContext context) async {
    var response = await ServiceBooking().detailBooking(
      int.tryParse(id) ?? 0,
      "",
    );
    notifyListeners();
    final pdf = pw.Document();
    final fontAssets = await rootBundle.load("assets/calibri.ttf");
    final font = pw.Font.ttf(fontAssets);
    final fontAssetsBold = await rootBundle.load("assets/calibrib.ttf");
    final fontBold = pw.Font.ttf(fontAssetsBold);
    var level5 = 15.0;
    var level2 = 12.0;
    var level1 = 11.0;
    var level0 = 10.0;
    var levelmin1 = 9.0;
    var levelmin2 = 8.0;
    var assetImage = pw.MemoryImage(
      (await rootBundle.load('assets/ic_logo.png')).buffer.asUint8List(),
    );

    var phone = pw.MemoryImage(
      (await rootBundle.load('assets/ic_phone.png')).buffer.asUint8List(),
    );

    var pin = pw.MemoryImage(
      (await rootBundle.load('assets/ic_pin.png')).buffer.asUint8List(),
    );

    var watch = pw.MemoryImage(
      (await rootBundle.load('assets/ic_watch.png')).buffer.asUint8List(),
    );

    var calender = pw.MemoryImage(
      (await rootBundle.load('assets/ic_calender.png')).buffer.asUint8List(),
    );

    var cash = pw.MemoryImage(
      (await rootBundle.load('assets/ic_cash.png')).buffer.asUint8List(),
    );

    var montir = pw.MemoryImage(
      (await rootBundle.load('assets/ic_montir.png')).buffer.asUint8List(),
    );

    var cs = pw.MemoryImage(
      (await rootBundle.load('assets/ic_cs.png')).buffer.asUint8List(),
    );

    var wa = pw.MemoryImage(
      (await rootBundle.load('assets/ic_wa.png')).buffer.asUint8List(),
    );

    var email = pw.MemoryImage(
      (await rootBundle.load('assets/ic_email.png')).buffer.asUint8List(),
    );

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat(
            PdfPageFormat.a4.portrait.width, PdfPageFormat.a4.portrait.height),
        build: (pw.Context context) {
          return pw.Container(
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                //
                pw.Container(
                  padding: const pw.EdgeInsets.only(left: 15, right: 15),
                  height: 35,
                  color: PdfColor.fromHex("#262262"),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.end,
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      pw.Image(
                        assetImage,
                        height: 20,
                      )
                    ],
                  ),
                ),
                //
                //
                pw.Container(
                  margin: const pw.EdgeInsets.only(
                    left: 15,
                    right: 15,
                    top: 15,
                    bottom: 15,
                  ),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      pw.Container(
                        padding: const pw.EdgeInsets.only(
                            left: 15, right: 15, top: 5, bottom: 5),
                        decoration: pw.BoxDecoration(
                          color: PdfColor.fromHex("#262262"),
                          borderRadius: const pw.BorderRadius.all(
                            pw.Radius.circular(12),
                          ),
                        ),
                        child: pw.Center(
                          child: pw.Text(
                            'Booking Servis',
                            style: pw.TextStyle(
                              font: fontBold,
                              fontSize: level2,
                              color: PdfColor.fromHex("#FFFFFF"),
                            ),
                          ),
                        ),
                      ),
                      pw.Expanded(child: pw.SizedBox()),
                      pw.Center(
                        child: pw.Text(
                          'No. Booking ${response.booking.id}',
                          style: pw.TextStyle(
                            font: fontBold,
                            fontSize: level1,
                            color: PdfColor.fromHex("#000000"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                pw.Container(
                  margin: const pw.EdgeInsets.only(
                    left: 15,
                    right: 15,
                    bottom: 10,
                  ),
                  child: pw.Center(
                    child: pw.Text(
                      'Konfirmasi Booking Servis Bengkel',
                      style: pw.TextStyle(
                        font: fontBold,
                        fontSize: level5,
                        color: PdfColor.fromHex("#000000"),
                      ),
                    ),
                  ),
                ),
                pw.Container(
                  margin: const pw.EdgeInsets.only(
                    left: 15,
                    right: 15,
                    bottom: 15,
                  ),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.SizedBox(
                        width: 300,
                        child: pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              'Bengkel ${response.booking.namaBengkel}',
                              style: pw.TextStyle(
                                font: fontBold,
                                fontSize: level2,
                                color: PdfColor.fromHex("#000000"),
                              ),
                            ),
                            pw.SizedBox(height: 5),
                            pw.Row(
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Image(
                                  pin,
                                  height: 15,
                                ),
                                pw.SizedBox(width: 5),
                                pw.Expanded(
                                  child: pw.Text(
                                    response.booking.alamat,
                                    style: pw.TextStyle(
                                      font: font,
                                      fontSize: levelmin1,
                                      color: PdfColor.fromHex("#1869bb"),
                                    ),
                                  ),
                                ),
                                pw.SizedBox(width: 100),
                              ],
                            ),
                            pw.SizedBox(height: 5),
                            pw.Row(
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              children: [
                                pw.Image(
                                  phone,
                                  height: 15,
                                ),
                                pw.SizedBox(width: 5),
                                pw.Expanded(
                                  child: pw.Text(
                                    response.booking.noHp,
                                    style: pw.TextStyle(
                                      font: font,
                                      fontSize: levelmin1,
                                      color: PdfColor.fromHex("#1869bb"),
                                    ),
                                  ),
                                ),
                                pw.SizedBox(width: 100),
                              ],
                            ),
                          ],
                        ),
                      ),
                      pw.Expanded(child: pw.SizedBox()),
                      pw.Container(
                        height: 50,
                        width: 2,
                        color: PdfColor.fromHex("#F1592A"),
                      ),
                      pw.SizedBox(
                        width: 10,
                      ),
                      pw.SizedBox(
                        width: 150,
                        child: pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              'Datang ke Bengkel',
                              style: pw.TextStyle(
                                font: fontBold,
                                fontSize: level1,
                                color: PdfColor.fromHex("#C3C3C3"),
                              ),
                            ),
                            pw.Row(
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Expanded(
                                  child: pw.Text(
                                    response.booking.tanggalText,
                                    style: pw.TextStyle(
                                      font: font,
                                      fontSize: level1,
                                      color: PdfColor.fromHex("#000000"),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            pw.Row(
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              children: [
                                pw.Image(
                                  watch,
                                  height: 15,
                                ),
                                pw.SizedBox(width: 5),
                                pw.Expanded(
                                  child: pw.Text(
                                    response.booking.timeText,
                                    style: pw.TextStyle(
                                      font: font,
                                      fontSize: level1,
                                      color: PdfColor.fromHex("#000000"),
                                    ),
                                  ),
                                ),
                                pw.SizedBox(width: 100),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                pw.Container(
                  margin: const pw.EdgeInsets.only(
                    left: 15,
                    right: 15,
                    top: 5,
                    bottom: 15,
                  ),
                  padding: const pw.EdgeInsets.all(15),
                  decoration: pw.BoxDecoration(
                    color: PdfColor.fromHex("#F2F8FF"),
                    borderRadius: const pw.BorderRadius.all(
                      pw.Radius.circular(8),
                    ),
                    border: pw.Border.all(
                      color: PdfColor.fromHex("#D4E5F9"),
                      width: 1,
                    ),
                  ),
                  child: pw.Row(
                    children: [
                      pw.Expanded(
                        child: pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Image(
                              calender,
                              height: 15,
                            ),
                            pw.SizedBox(width: 5),
                            pw.Expanded(
                              child: pw.Column(
                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text(
                                    'Atur Jadwal Sendiri',
                                    style: pw.TextStyle(
                                      font: fontBold,
                                      fontSize: level1,
                                      color: PdfColor.fromHex("#5B6282"),
                                    ),
                                  ),
                                  pw.Text(
                                    'Waktu fleksibel menyesuaikan kebutuhan anda',
                                    style: pw.TextStyle(
                                      font: font,
                                      fontSize: levelmin1,
                                      color: PdfColor.fromHex("#5B6282"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      pw.SizedBox(width: 15),
                      pw.Expanded(
                        child: pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Image(
                              cash,
                              height: 15,
                            ),
                            pw.SizedBox(width: 5),
                            pw.Expanded(
                              child: pw.Column(
                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text(
                                    'Estimasi Harga',
                                    style: pw.TextStyle(
                                      font: fontBold,
                                      fontSize: level1,
                                      color: PdfColor.fromHex("#5B6282"),
                                    ),
                                  ),
                                  pw.Text(
                                    'Dapatkan estimasi harga sebelum melakukan servis',
                                    style: pw.TextStyle(
                                      font: font,
                                      fontSize: levelmin1,
                                      color: PdfColor.fromHex("#5B6282"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      pw.SizedBox(width: 15),
                      pw.Expanded(
                        child: pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Image(
                              montir,
                              height: 15,
                            ),
                            pw.SizedBox(width: 5),
                            pw.Expanded(
                              child: pw.Column(
                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text(
                                    'Montir Profesional',
                                    style: pw.TextStyle(
                                      font: fontBold,
                                      fontSize: level1,
                                      color: PdfColor.fromHex("#5B6282"),
                                    ),
                                  ),
                                  pw.Text(
                                    'Dengan tenaga montir profesional, anda tidak perlu khawatir atau ragu',
                                    style: pw.TextStyle(
                                      font: font,
                                      fontSize: levelmin1,
                                      color: PdfColor.fromHex("#5B6282"),
                                    ),
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
                pw.Container(
                  margin: const pw.EdgeInsets.only(
                    left: 15,
                  ),
                  width: double.infinity,
                  child: pw.Text(
                    'Detail Booking',
                    style: pw.TextStyle(
                      font: fontBold,
                      fontSize: level2,
                      color: PdfColor.fromHex("#000000"),
                    ),
                  ),
                ),
                pw.Expanded(
                  child: pw.Container(
                    margin: const pw.EdgeInsets.only(
                      left: 15,
                      right: 15,
                      top: 5,
                      bottom: 0,
                    ),
                    padding: const pw.EdgeInsets.all(15),
                    decoration: pw.BoxDecoration(
                      color: PdfColor.fromHex("#FFFFFF"),
                      borderRadius: const pw.BorderRadius.all(
                        pw.Radius.circular(12),
                      ),
                      border: pw.Border.all(
                        color: PdfColor.fromHex("#C3C3C3"),
                        width: 1,
                      ),
                    ),
                    child: pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        //
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.center,
                          crossAxisAlignment: pw.CrossAxisAlignment.center,
                          children: [
                            pw.Container(
                              width: 100,
                              child: pw.Text(
                                'No. Booking',
                                style: pw.TextStyle(
                                  font: fontBold,
                                  fontSize: level0,
                                  color: PdfColor.fromHex("#35405A"),
                                ),
                              ),
                            ),
                            pw.SizedBox(
                              child: pw.Text(
                                ' : ',
                                style: pw.TextStyle(
                                  font: fontBold,
                                  fontSize: level0,
                                  color: PdfColor.fromHex("#35405A"),
                                ),
                              ),
                            ),
                            pw.Expanded(
                              child: pw.SizedBox(
                                child: pw.Text(
                                  response.booking.id.toString(),
                                  style: pw.TextStyle(
                                    font: fontBold,
                                    fontSize: level0,
                                    color: PdfColor.fromHex("#35405A"),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        //
                        pw.SizedBox(
                          height: 4.1,
                        ),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.center,
                          crossAxisAlignment: pw.CrossAxisAlignment.center,
                          children: [
                            pw.Container(
                              width: 100,
                              child: pw.Text(
                                'Nama Bengkel',
                                style: pw.TextStyle(
                                  font: font,
                                  fontSize: level0,
                                  color: PdfColor.fromHex("#000000"),
                                ),
                              ),
                            ),
                            pw.SizedBox(
                              child: pw.Text(
                                ' : ',
                                style: pw.TextStyle(
                                  font: font,
                                  fontSize: level0,
                                  color: PdfColor.fromHex("#000000"),
                                ),
                              ),
                            ),
                            pw.Expanded(
                              child: pw.SizedBox(
                                child: pw.Text(
                                  response.booking.namaBengkel,
                                  style: pw.TextStyle(
                                    font: font,
                                    fontSize: level0,
                                    color: PdfColor.fromHex("#000000"),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        pw.SizedBox(
                          height: 4.1,
                        ),
                        //
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.center,
                          crossAxisAlignment: pw.CrossAxisAlignment.center,
                          children: [
                            pw.Container(
                              width: 100,
                              child: pw.Text(
                                'Status',
                                style: pw.TextStyle(
                                  font: font,
                                  fontSize: level0,
                                  color: PdfColor.fromHex("#000000"),
                                ),
                              ),
                            ),
                            pw.SizedBox(
                              child: pw.Text(
                                ' : ',
                                style: pw.TextStyle(
                                  font: font,
                                  fontSize: level0,
                                  color: PdfColor.fromHex("#000000"),
                                ),
                              ),
                            ),
                            pw.Expanded(
                              child: pw.SizedBox(
                                child: pw.Text(
                                  'Terkonfirmasi',
                                  style: pw.TextStyle(
                                    font: font,
                                    fontSize: level0,
                                    color: PdfColor.fromHex("#000000"),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        pw.SizedBox(
                          height: 4.1,
                        ),
                        //
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.center,
                          crossAxisAlignment: pw.CrossAxisAlignment.center,
                          children: [
                            pw.Container(
                              width: 100,
                              child: pw.Text(
                                'Hari/Tanggal',
                                style: pw.TextStyle(
                                  font: font,
                                  fontSize: level0,
                                  color: PdfColor.fromHex("#000000"),
                                ),
                              ),
                            ),
                            pw.SizedBox(
                              child: pw.Text(
                                ' : ',
                                style: pw.TextStyle(
                                  font: font,
                                  fontSize: level0,
                                  color: PdfColor.fromHex("#000000"),
                                ),
                              ),
                            ),
                            pw.Expanded(
                              child: pw.SizedBox(
                                child: pw.Text(
                                  response.booking.tanggalText,
                                  style: pw.TextStyle(
                                    font: font,
                                    fontSize: level0,
                                    color: PdfColor.fromHex("#000000"),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        pw.SizedBox(
                          height: 4.1,
                        ),
                        //
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.center,
                          crossAxisAlignment: pw.CrossAxisAlignment.center,
                          children: [
                            pw.Container(
                              width: 100,
                              child: pw.Text(
                                'Metode Pembayaran',
                                style: pw.TextStyle(
                                  font: font,
                                  fontSize: level0,
                                  color: PdfColor.fromHex("#000000"),
                                ),
                              ),
                            ),
                            pw.SizedBox(
                              child: pw.Text(
                                ' : ',
                                style: pw.TextStyle(
                                  font: font,
                                  fontSize: level0,
                                  color: PdfColor.fromHex("#000000"),
                                ),
                              ),
                            ),
                            pw.Expanded(
                              child: pw.SizedBox(
                                child: pw.Text(
                                  response.booking.pt != ""
                                      ? 'Bebas Biaya'
                                      : "Bayar di Tempat",
                                  style: pw.TextStyle(
                                    font: font,
                                    fontSize: level0,
                                    color: PdfColor.fromHex("#000000"),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        pw.SizedBox(
                          height: 4.1,
                        ),
                        //
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.center,
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Container(
                              width: 100,
                              child: pw.Text(
                                'Alamat Bengkel',
                                style: pw.TextStyle(
                                  font: font,
                                  fontSize: level0,
                                  color: PdfColor.fromHex("#000000"),
                                ),
                              ),
                            ),
                            pw.SizedBox(
                              child: pw.Text(
                                ' : ',
                                style: pw.TextStyle(
                                  font: font,
                                  fontSize: level0,
                                  color: PdfColor.fromHex("#000000"),
                                ),
                              ),
                            ),
                            pw.Expanded(
                              child: pw.SizedBox(
                                child: pw.Text(
                                  response.booking.alamat,
                                  style: pw.TextStyle(
                                    font: font,
                                    fontSize: level0,
                                    color: PdfColor.fromHex("#000000"),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        //

                        //
                        pw.SizedBox(
                          height: 4.1,
                        ),
                        //
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.center,
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Container(
                              width: 100,
                              child: pw.Text(
                                'Keluhan',
                                style: pw.TextStyle(
                                  font: font,
                                  fontSize: level0,
                                  color: PdfColor.fromHex("#000000"),
                                ),
                              ),
                            ),
                            pw.SizedBox(
                              child: pw.Text(
                                ' : ',
                                style: pw.TextStyle(
                                  font: font,
                                  fontSize: level0,
                                  color: PdfColor.fromHex("#000000"),
                                ),
                              ),
                            ),
                            pw.Expanded(
                              child: pw.SizedBox(
                                child: pw.Text(
                                  response.booking.keluhan,
                                  style: pw.TextStyle(
                                    font: font,
                                    fontSize: level0,
                                    color: PdfColor.fromHex("#000000"),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (response.booking.pt != "")
                          pw.SizedBox(
                            height: 4.1,
                          ),
                        if (response.booking.pt != "")
                          pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.center,
                            crossAxisAlignment: pw.CrossAxisAlignment.center,
                            children: [
                              pw.Container(
                                width: 100,
                                child: pw.Text(
                                  'Nama Perusahaan',
                                  style: pw.TextStyle(
                                    font: font,
                                    fontSize: level0,
                                    color: PdfColor.fromHex("#000000"),
                                  ),
                                ),
                              ),
                              pw.SizedBox(
                                child: pw.Text(
                                  ' : ',
                                  style: pw.TextStyle(
                                    font: font,
                                    fontSize: level0,
                                    color: PdfColor.fromHex("#000000"),
                                  ),
                                ),
                              ),
                              pw.Expanded(
                                child: pw.SizedBox(
                                  child: pw.Text(
                                    response.booking.pt,
                                    style: pw.TextStyle(
                                      font: font,
                                      fontSize: level0,
                                      color: PdfColor.fromHex("#000000"),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        pw.SizedBox(
                          height: 4.1,
                        ),
                        //
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.center,
                          crossAxisAlignment: pw.CrossAxisAlignment.center,
                          children: [
                            pw.Container(
                              width: 100,
                              child: pw.Text(
                                'Nama Pelanggan',
                                style: pw.TextStyle(
                                  font: font,
                                  fontSize: level0,
                                  color: PdfColor.fromHex("#000000"),
                                ),
                              ),
                            ),
                            pw.SizedBox(
                              child: pw.Text(
                                ' : ',
                                style: pw.TextStyle(
                                  font: font,
                                  fontSize: level0,
                                  color: PdfColor.fromHex("#000000"),
                                ),
                              ),
                            ),
                            pw.Expanded(
                              child: pw.SizedBox(
                                child: pw.Text(
                                  response.booking.namaCustomer,
                                  style: pw.TextStyle(
                                    font: font,
                                    fontSize: level0,
                                    color: PdfColor.fromHex("#000000"),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        pw.SizedBox(
                          height: 4.1,
                        ),
                        //
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.center,
                          crossAxisAlignment: pw.CrossAxisAlignment.center,
                          children: [
                            pw.Container(
                              width: 100,
                              child: pw.Text(
                                'No. Handphone',
                                style: pw.TextStyle(
                                  font: font,
                                  fontSize: level0,
                                  color: PdfColor.fromHex("#000000"),
                                ),
                              ),
                            ),
                            pw.SizedBox(
                              child: pw.Text(
                                ' : ',
                                style: pw.TextStyle(
                                  font: font,
                                  fontSize: level0,
                                  color: PdfColor.fromHex("#000000"),
                                ),
                              ),
                            ),
                            pw.Expanded(
                              child: pw.SizedBox(
                                child: pw.Text(
                                  response.booking.noHpCustomer,
                                  style: pw.TextStyle(
                                    font: font,
                                    fontSize: level0,
                                    color: PdfColor.fromHex("#000000"),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        pw.SizedBox(
                          height: 4.1,
                        ),
                        //
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.center,
                          crossAxisAlignment: pw.CrossAxisAlignment.center,
                          children: [
                            pw.Container(
                              width: 100,
                              child: pw.Text(
                                'Email',
                                style: pw.TextStyle(
                                  font: font,
                                  fontSize: level0,
                                  color: PdfColor.fromHex("#000000"),
                                ),
                              ),
                            ),
                            pw.SizedBox(
                              child: pw.Text(
                                ' : ',
                                style: pw.TextStyle(
                                  font: font,
                                  fontSize: level0,
                                  color: PdfColor.fromHex("#000000"),
                                ),
                              ),
                            ),
                            pw.Expanded(
                              child: pw.SizedBox(
                                child: pw.Text(
                                  response.booking.emailCustomer,
                                  style: pw.TextStyle(
                                    font: font,
                                    fontSize: level0,
                                    color: PdfColor.fromHex("#000000"),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        //
                        pw.SizedBox(
                          height: 4.1,
                        ),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.center,
                          crossAxisAlignment: pw.CrossAxisAlignment.center,
                          children: [
                            pw.Container(
                              width: 100,
                              child: pw.Text(
                                'Plat',
                                style: pw.TextStyle(
                                  font: fontBold,
                                  fontSize: level0,
                                  color: PdfColor.fromHex("#35405A"),
                                ),
                              ),
                            ),
                            pw.SizedBox(
                              child: pw.Text(
                                ' : ',
                                style: pw.TextStyle(
                                  font: fontBold,
                                  fontSize: level0,
                                  color: PdfColor.fromHex("#35405A"),
                                ),
                              ),
                            ),
                            pw.Expanded(
                              child: pw.SizedBox(
                                child: pw.Text(
                                  response.booking.noPolisi,
                                  style: pw.TextStyle(
                                    font: fontBold,
                                    fontSize: level0,
                                    color: PdfColor.fromHex("#35405A"),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        pw.SizedBox(
                          height: 4.1,
                        ),
                        //
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.center,
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Container(
                              width: 100,
                              child: pw.Text(
                                'Kendaraan',
                                style: pw.TextStyle(
                                  font: font,
                                  fontSize: level0,
                                  color: PdfColor.fromHex("#000000"),
                                ),
                              ),
                            ),
                            pw.SizedBox(
                              child: pw.Text(
                                ' : ',
                                style: pw.TextStyle(
                                  font: font,
                                  fontSize: level0,
                                  color: PdfColor.fromHex("#000000"),
                                ),
                              ),
                            ),
                            pw.Expanded(
                              child: pw.SizedBox(
                                child: pw.Text(
                                  ("${response.booking.brandName} ${response.booking.modelName} ${response.booking.varianName}")
                                      .toUpperCase(),
                                  style: pw.TextStyle(
                                    font: font,
                                    fontSize: level0,
                                    color: PdfColor.fromHex("#000000"),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        pw.SizedBox(
                          height: 4.1,
                        ),
                        //
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.center,
                          crossAxisAlignment: pw.CrossAxisAlignment.center,
                          children: [
                            pw.Container(
                              width: 100,
                              child: pw.Text(
                                'Km',
                                style: pw.TextStyle(
                                  font: font,
                                  fontSize: level0,
                                  color: PdfColor.fromHex("#000000"),
                                ),
                              ),
                            ),
                            pw.SizedBox(
                              child: pw.Text(
                                ' : ',
                                style: pw.TextStyle(
                                  font: font,
                                  fontSize: level0,
                                  color: PdfColor.fromHex("#000000"),
                                ),
                              ),
                            ),
                            pw.Expanded(
                              child: pw.SizedBox(
                                child: pw.Text(
                                  response.booking.kmText,
                                  style: pw.TextStyle(
                                    font: font,
                                    fontSize: level0,
                                    color: PdfColor.fromHex("#000000"),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                pw.Container(
                  padding: const pw.EdgeInsets.all(15),
                  child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'Kebijakan Layanan Booking servis :',
                        style: pw.TextStyle(
                          font: font,
                          fontSize: levelmin1,
                          color: PdfColor.fromHex("#5B6282"),
                        ),
                      ),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Container(
                            width: 10,
                            child: pw.Text(
                              '-',
                              style: pw.TextStyle(
                                font: font,
                                fontSize: levelmin2,
                                color: PdfColor.fromHex("#5B6282"),
                              ),
                            ),
                          ),
                          pw.Expanded(
                            child: pw.Text(
                              'Booking Servis yang dilakukan diantara jam 17:00 - 07:59 WIB akan mendapatkan konfirmasi ketersediaan jadwal pada jam 08:00 WIB atau saat mulai jam buka operasional.',
                              style: pw.TextStyle(
                                font: font,
                                fontSize: levelmin2,
                                color: PdfColor.fromHex("#5B6282"),
                              ),
                            ),
                          ),
                        ],
                      ),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Container(
                            width: 10,
                            child: pw.Text(
                              '-',
                              style: pw.TextStyle(
                                font: font,
                                fontSize: levelmin2,
                                color: PdfColor.fromHex("#5B6282"),
                              ),
                            ),
                          ),
                          pw.Expanded(
                            child: pw.Text(
                              'Total estimasi biaya adalah perkiraan biaya sebelum melakukan layanan, untuk biaya sesungguhnya akan disesuaikan dengan servis yang diberikan dan merk serta model kendaraan.',
                              style: pw.TextStyle(
                                font: font,
                                fontSize: levelmin2,
                                color: PdfColor.fromHex("#5B6282"),
                              ),
                            ),
                          ),
                        ],
                      ),
                      //
                      pw.SizedBox(height: 10),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Expanded(
                            child: pw.Column(
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                //
                                pw.Text(
                                  'PT. Brilian Inovasi Gemilang',
                                  style: pw.TextStyle(
                                    font: fontBold,
                                    fontSize: level0,
                                    color: PdfColor.fromHex("#5B6282"),
                                  ),
                                ),
                                pw.Text(
                                  'GKM Green Tower Building, 20th Floor JL. TB Simatupang Kav 89 G Jakarta Selatan, Jakarta 12520, Indonesia',
                                  style: pw.TextStyle(
                                    font: font,
                                    fontSize: levelmin1,
                                    color: PdfColor.fromHex("#5B6282"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          pw.SizedBox(width: 50),
                          pw.Expanded(
                            child: pw.Column(
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(
                                  'Contact Customer Care',
                                  style: pw.TextStyle(
                                    font: fontBold,
                                    fontSize: level0,
                                    color: PdfColor.fromHex("#000000"),
                                  ),
                                ),
                                pw.SizedBox(height: 5),
                                pw.Row(children: [
                                  pw.Expanded(
                                    child: pw.Row(
                                      mainAxisAlignment:
                                          pw.MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.center,
                                      children: [
                                        pw.Image(
                                          cs,
                                          height: 15,
                                        ),
                                        pw.SizedBox(width: 5),
                                        pw.Expanded(
                                          child: pw.Text(
                                            '021-501112777',
                                            style: pw.TextStyle(
                                              font: font,
                                              fontSize: levelmin1,
                                              color:
                                                  PdfColor.fromHex("#1869bb"),
                                            ),
                                          ),
                                        ),
                                        pw.SizedBox(width: 100),
                                      ],
                                    ),
                                  ),
                                  pw.SizedBox(
                                    width: 20,
                                  ),
                                  pw.Expanded(
                                    child: pw.Row(
                                      mainAxisAlignment:
                                          pw.MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.center,
                                      children: [
                                        pw.Image(
                                          wa,
                                          height: 15,
                                        ),
                                        pw.SizedBox(width: 5),
                                        pw.Expanded(
                                          child: pw.Text(
                                            '+6281290190163',
                                            style: pw.TextStyle(
                                              font: font,
                                              fontSize: levelmin1,
                                              color:
                                                  PdfColor.fromHex("#1869bb"),
                                            ),
                                          ),
                                        ),
                                        pw.SizedBox(width: 100),
                                      ],
                                    ),
                                  ),
                                ]),
                                pw.SizedBox(height: 5),
                                pw.Row(children: [
                                  pw.Expanded(
                                    child: pw.Row(
                                      mainAxisAlignment:
                                          pw.MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.center,
                                      children: [
                                        pw.Image(
                                          email,
                                          height: 15,
                                        ),
                                        pw.SizedBox(width: 5),
                                        pw.Expanded(
                                          child: pw.Text(
                                            'cs@montiro.id',
                                            style: pw.TextStyle(
                                              font: font,
                                              fontSize: levelmin1,
                                              color:
                                                  PdfColor.fromHex("#1869bb"),
                                            ),
                                          ),
                                        ),
                                        pw.SizedBox(width: 100),
                                      ],
                                    ),
                                  ),
                                  pw.SizedBox(
                                    width: 20,
                                  ),
                                  pw.Expanded(
                                    child: pw.SizedBox(),
                                  ),
                                ]),
                              ],
                            ),
                          ),
                          pw.SizedBox(width: 15),
                        ],
                      ),
                    ],
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
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                //
                pw.Container(
                  padding: const pw.EdgeInsets.only(left: 15, right: 15),
                  height: 35,
                  color: PdfColor.fromHex("#262262"),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.end,
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      pw.Image(
                        assetImage,
                        height: 20,
                      )
                    ],
                  ),
                ),
                //
                //
                pw.Container(
                  margin: const pw.EdgeInsets.only(
                    left: 15,
                    right: 15,
                    top: 15,
                    bottom: 15,
                  ),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      pw.Container(
                        padding: const pw.EdgeInsets.only(
                            left: 15, right: 15, top: 5, bottom: 5),
                        decoration: pw.BoxDecoration(
                          color: PdfColor.fromHex("#262262"),
                          borderRadius: const pw.BorderRadius.all(
                            pw.Radius.circular(12),
                          ),
                        ),
                        child: pw.Center(
                          child: pw.Text(
                            'Booking Servis',
                            style: pw.TextStyle(
                              font: fontBold,
                              fontSize: level2,
                              color: PdfColor.fromHex("#FFFFFF"),
                            ),
                          ),
                        ),
                      ),
                      pw.Expanded(child: pw.SizedBox()),
                      pw.Center(
                        child: pw.Text(
                          'No. Booking ${response.booking.id}',
                          style: pw.TextStyle(
                            font: fontBold,
                            fontSize: level1,
                            color: PdfColor.fromHex("#000000"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                pw.Container(
                  margin: const pw.EdgeInsets.only(
                    left: 15,
                    right: 15,
                    bottom: 10,
                  ),
                  child: pw.Center(
                    child: pw.Text(
                      'Konfirmasi Booking Servis Bengkel',
                      style: pw.TextStyle(
                        font: fontBold,
                        fontSize: level5,
                        color: PdfColor.fromHex("#000000"),
                      ),
                    ),
                  ),
                ),
                pw.Container(
                  margin: const pw.EdgeInsets.only(
                    left: 15,
                    right: 15,
                    bottom: 15,
                  ),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.SizedBox(
                        width: 300,
                        child: pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              'Bengkel ${response.booking.namaBengkel}',
                              style: pw.TextStyle(
                                font: fontBold,
                                fontSize: level2,
                                color: PdfColor.fromHex("#000000"),
                              ),
                            ),
                            pw.SizedBox(height: 5),
                            pw.Row(
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Image(
                                  pin,
                                  height: 15,
                                ),
                                pw.SizedBox(width: 5),
                                pw.Expanded(
                                  child: pw.Text(
                                    response.booking.alamat,
                                    style: pw.TextStyle(
                                      font: font,
                                      fontSize: levelmin1,
                                      color: PdfColor.fromHex("#1869bb"),
                                    ),
                                  ),
                                ),
                                pw.SizedBox(width: 100),
                              ],
                            ),
                            pw.SizedBox(height: 5),
                            pw.Row(
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              children: [
                                pw.Image(
                                  phone,
                                  height: 15,
                                ),
                                pw.SizedBox(width: 5),
                                pw.Expanded(
                                  child: pw.Text(
                                    response.booking.noHp,
                                    style: pw.TextStyle(
                                      font: font,
                                      fontSize: levelmin1,
                                      color: PdfColor.fromHex("#1869bb"),
                                    ),
                                  ),
                                ),
                                pw.SizedBox(width: 100),
                              ],
                            ),
                          ],
                        ),
                      ),
                      pw.Expanded(child: pw.SizedBox()),
                      pw.Container(
                        height: 50,
                        width: 2,
                        color: PdfColor.fromHex("#F1592A"),
                      ),
                      pw.SizedBox(
                        width: 10,
                      ),
                      pw.SizedBox(
                        width: 150,
                        child: pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              'Datang ke Bengkel',
                              style: pw.TextStyle(
                                font: fontBold,
                                fontSize: level1,
                                color: PdfColor.fromHex("#C3C3C3"),
                              ),
                            ),
                            pw.Row(
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Expanded(
                                  child: pw.Text(
                                    response.booking.tanggalText,
                                    style: pw.TextStyle(
                                      font: font,
                                      fontSize: level1,
                                      color: PdfColor.fromHex("#000000"),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            pw.Row(
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              children: [
                                pw.Image(
                                  watch,
                                  height: 15,
                                ),
                                pw.SizedBox(width: 5),
                                pw.Expanded(
                                  child: pw.Text(
                                    response.booking.timeText,
                                    style: pw.TextStyle(
                                      font: font,
                                      fontSize: level1,
                                      color: PdfColor.fromHex("#000000"),
                                    ),
                                  ),
                                ),
                                pw.SizedBox(width: 100),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                pw.Container(
                  margin: const pw.EdgeInsets.only(
                    left: 15,
                    right: 15,
                    top: 5,
                    bottom: 15,
                  ),
                  padding: const pw.EdgeInsets.all(15),
                  decoration: pw.BoxDecoration(
                    color: PdfColor.fromHex("#F2F8FF"),
                    borderRadius: const pw.BorderRadius.all(
                      pw.Radius.circular(8),
                    ),
                    border: pw.Border.all(
                      color: PdfColor.fromHex("#D4E5F9"),
                      width: 1,
                    ),
                  ),
                  child: pw.Row(
                    children: [
                      pw.Expanded(
                        child: pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Image(
                              calender,
                              height: 15,
                            ),
                            pw.SizedBox(width: 5),
                            pw.Expanded(
                              child: pw.Column(
                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text(
                                    'Atur Jadwal Sendiri',
                                    style: pw.TextStyle(
                                      font: fontBold,
                                      fontSize: level1,
                                      color: PdfColor.fromHex("#5B6282"),
                                    ),
                                  ),
                                  pw.Text(
                                    'Waktu fleksibel menyesuaikan kebutuhan anda',
                                    style: pw.TextStyle(
                                      font: font,
                                      fontSize: levelmin1,
                                      color: PdfColor.fromHex("#5B6282"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      pw.SizedBox(width: 15),
                      pw.Expanded(
                        child: pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Image(
                              cash,
                              height: 15,
                            ),
                            pw.SizedBox(width: 5),
                            pw.Expanded(
                              child: pw.Column(
                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text(
                                    'Estimasi Harga',
                                    style: pw.TextStyle(
                                      font: fontBold,
                                      fontSize: level1,
                                      color: PdfColor.fromHex("#5B6282"),
                                    ),
                                  ),
                                  pw.Text(
                                    'Dapatkan estimasi harga sebelum melakukan servis',
                                    style: pw.TextStyle(
                                      font: font,
                                      fontSize: levelmin1,
                                      color: PdfColor.fromHex("#5B6282"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      pw.SizedBox(width: 15),
                      pw.Expanded(
                        child: pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Image(
                              montir,
                              height: 15,
                            ),
                            pw.SizedBox(width: 5),
                            pw.Expanded(
                              child: pw.Column(
                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text(
                                    'Montir Profesional',
                                    style: pw.TextStyle(
                                      font: fontBold,
                                      fontSize: level1,
                                      color: PdfColor.fromHex("#5B6282"),
                                    ),
                                  ),
                                  pw.Text(
                                    'Dengan tenaga montir profesional, anda tidak perlu khawatir atau ragu',
                                    style: pw.TextStyle(
                                      font: font,
                                      fontSize: levelmin1,
                                      color: PdfColor.fromHex("#5B6282"),
                                    ),
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
                pw.Container(
                  margin: const pw.EdgeInsets.only(
                    left: 15,
                  ),
                  width: double.infinity,
                  child: pw.Text(
                    'Estimasi Biaya',
                    style: pw.TextStyle(
                      font: fontBold,
                      fontSize: level2,
                      color: PdfColor.fromHex("#000000"),
                    ),
                  ),
                ),
                pw.Expanded(
                    child: pw.Container(
                  width: double.infinity,
                  margin: const pw.EdgeInsets.only(
                    left: 15,
                    right: 15,
                    top: 5,
                    bottom: 0,
                  ),
                  padding: const pw.EdgeInsets.all(20),
                  decoration: pw.BoxDecoration(
                    color: PdfColor.fromHex("#FFFFFF"),
                    borderRadius: const pw.BorderRadius.all(
                      pw.Radius.circular(12),
                    ),
                    border: pw.Border.all(
                      color: PdfColor.fromHex("#C3C3C3"),
                      width: 1,
                    ),
                  ),
                  child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Stack(
                        children: [
                          pw.Row(
                            children: [
                              pw.Expanded(
                                child: pw.Column(
                                  mainAxisAlignment: pw.MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    //
                                    for (var model
                                        in response.booking.detailBooking)
                                      pw.Column(
                                        mainAxisAlignment:
                                            pw.MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.start,
                                        children: [
                                          pw.Container(
                                            width: double.infinity,
                                            height: 1,
                                            color: PdfColor.fromHex("#C3C3C3"),
                                          ),
                                          pw.Container(
                                            padding:
                                                const pw.EdgeInsets.all(10),
                                            child: pw.Column(
                                              mainAxisAlignment:
                                                  pw.MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  pw.CrossAxisAlignment.start,
                                              children: [
                                                pw.SizedBox(
                                                  child: pw.Text(
                                                    model.title,
                                                    style: pw.TextStyle(
                                                      font: fontBold,
                                                      fontSize: level1,
                                                      color: PdfColor.fromHex(
                                                          "#C3C3C3"),
                                                    ),
                                                  ),
                                                ),
                                                pw.SizedBox(
                                                  child: pw.Text(
                                                    model.price,
                                                    style: pw.TextStyle(
                                                      font: fontBold,
                                                      fontSize: level0,
                                                      color: PdfColor.fromHex(
                                                          "#C3C3C3"),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),

                                    pw.Container(
                                      width: double.infinity,
                                      height: 1,
                                      color: PdfColor.fromHex("#C3C3C3"),
                                    ),
                                  ],
                                ),
                              ),
                              pw.SizedBox(width: 200),
                            ],
                          ),
                          pw.Positioned.fill(
                            child: pw.Row(
                              children: [
                                pw.Container(
                                  width: 1,
                                  color: PdfColor.fromHex("#C3C3C3"),
                                ),
                              ],
                            ),
                          ),
                          pw.Positioned.fill(
                            child: pw.Row(
                              mainAxisAlignment: pw.MainAxisAlignment.end,
                              crossAxisAlignment: pw.CrossAxisAlignment.end,
                              children: [
                                pw.Container(
                                  width: 200,
                                  color: PdfColor.fromHex("#FF7700"),
                                  child: pw.Center(
                                    child: pw.Text(
                                      "Total Estimasi\n${response.booking.total}",
                                      textAlign: pw.TextAlign.center,
                                      style: pw.TextStyle(
                                        font: fontBold,
                                        fontSize: level2,
                                        color: PdfColor.fromHex("#FFFFFF"),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )),
                pw.Container(
                  padding: const pw.EdgeInsets.all(15),
                  child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'Kebijakan Layanan Booking servis :',
                        style: pw.TextStyle(
                          font: font,
                          fontSize: levelmin1,
                          color: PdfColor.fromHex("#5B6282"),
                        ),
                      ),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Container(
                            width: 10,
                            child: pw.Text(
                              '-',
                              style: pw.TextStyle(
                                font: font,
                                fontSize: levelmin2,
                                color: PdfColor.fromHex("#5B6282"),
                              ),
                            ),
                          ),
                          pw.Expanded(
                            child: pw.Text(
                              'Booking Servis yang dilakukan diantara jam 17:00 - 07:59 WIB akan mendapatkan konfirmasi ketersediaan jadwal pada jam 08:00 WIB atau saat mulai jam buka operasional.',
                              style: pw.TextStyle(
                                font: font,
                                fontSize: levelmin2,
                                color: PdfColor.fromHex("#5B6282"),
                              ),
                            ),
                          ),
                        ],
                      ),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Container(
                            width: 10,
                            child: pw.Text(
                              '-',
                              style: pw.TextStyle(
                                font: font,
                                fontSize: levelmin2,
                                color: PdfColor.fromHex("#5B6282"),
                              ),
                            ),
                          ),
                          pw.Expanded(
                            child: pw.Text(
                              'Total estimasi biaya adalah perkiraan biaya sebelum melakukan layanan, untuk biaya sesungguhnya akan disesuaikan dengan servis yang diberikan dan merk serta model kendaraan.',
                              style: pw.TextStyle(
                                font: font,
                                fontSize: levelmin2,
                                color: PdfColor.fromHex("#5B6282"),
                              ),
                            ),
                          ),
                        ],
                      ),
                      //
                      pw.SizedBox(height: 10),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Expanded(
                            child: pw.Column(
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                //
                                pw.Text(
                                  'PT. Brilian Inovasi Gemilang',
                                  style: pw.TextStyle(
                                    font: fontBold,
                                    fontSize: level0,
                                    color: PdfColor.fromHex("#5B6282"),
                                  ),
                                ),
                                pw.Text(
                                  'GKM Green Tower Building, 20th Floor JL. TB Simatupang Kav 89 G Jakarta Selatan, Jakarta 12520, Indonesia',
                                  style: pw.TextStyle(
                                    font: font,
                                    fontSize: levelmin1,
                                    color: PdfColor.fromHex("#5B6282"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          pw.SizedBox(width: 50),
                          pw.Expanded(
                            child: pw.Column(
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(
                                  'Contact Customer Care',
                                  style: pw.TextStyle(
                                    font: fontBold,
                                    fontSize: level0,
                                    color: PdfColor.fromHex("#000000"),
                                  ),
                                ),
                                pw.SizedBox(height: 5),
                                pw.Row(children: [
                                  pw.Expanded(
                                    child: pw.Row(
                                      mainAxisAlignment:
                                          pw.MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.center,
                                      children: [
                                        pw.Image(
                                          cs,
                                          height: 15,
                                        ),
                                        pw.SizedBox(width: 5),
                                        pw.Expanded(
                                          child: pw.Text(
                                            '021-501112777',
                                            style: pw.TextStyle(
                                              font: font,
                                              fontSize: levelmin1,
                                              color:
                                                  PdfColor.fromHex("#1869bb"),
                                            ),
                                          ),
                                        ),
                                        pw.SizedBox(width: 100),
                                      ],
                                    ),
                                  ),
                                  pw.SizedBox(
                                    width: 20,
                                  ),
                                  pw.Expanded(
                                    child: pw.Row(
                                      mainAxisAlignment:
                                          pw.MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.center,
                                      children: [
                                        pw.Image(
                                          wa,
                                          height: 15,
                                        ),
                                        pw.SizedBox(width: 5),
                                        pw.Expanded(
                                          child: pw.Text(
                                            '+6281290190163',
                                            style: pw.TextStyle(
                                              font: font,
                                              fontSize: levelmin1,
                                              color:
                                                  PdfColor.fromHex("#1869bb"),
                                            ),
                                          ),
                                        ),
                                        pw.SizedBox(width: 100),
                                      ],
                                    ),
                                  ),
                                ]),
                                pw.SizedBox(height: 5),
                                pw.Row(children: [
                                  pw.Expanded(
                                    child: pw.Row(
                                      mainAxisAlignment:
                                          pw.MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.center,
                                      children: [
                                        pw.Image(
                                          email,
                                          height: 15,
                                        ),
                                        pw.SizedBox(width: 5),
                                        pw.Expanded(
                                          child: pw.Text(
                                            'cs@montiro.id',
                                            style: pw.TextStyle(
                                              font: font,
                                              fontSize: levelmin1,
                                              color:
                                                  PdfColor.fromHex("#1869bb"),
                                            ),
                                          ),
                                        ),
                                        pw.SizedBox(width: 100),
                                      ],
                                    ),
                                  ),
                                  pw.SizedBox(
                                    width: 20,
                                  ),
                                  pw.Expanded(
                                    child: pw.SizedBox(),
                                  ),
                                ]),
                              ],
                            ),
                          ),
                          pw.SizedBox(width: 15),
                        ],
                      ),
                    ],
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
      ..setAttribute(
          "download", "Detail-Booking-${response.booking.tanggal}.pdf")
      ..click();
    //
    //window.close();
  }
}
