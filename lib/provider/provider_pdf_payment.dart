import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../service/service_booking.dart';
import 'dart:html' as html;
import 'dart:convert';

class ProviderPdfPayment with ChangeNotifier {
  final String id;

  ProviderPdfPayment(
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
    final fontAssets = await rootBundle.load("assets/calibri.ttf");
    final font = pw.Font.ttf(fontAssets);
    final fontAssetsBold = await rootBundle.load("assets/calibrib.ttf");
    final fontBold = pw.Font.ttf(fontAssetsBold);

    var level4 = 14.0;
    var level2 = 12.0;
    var level1 = 11.0;

    var icon = pw.MemoryImage(
      (await rootBundle.load('assets/ic_done.png')).buffer.asUint8List(),
    );

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat(PdfPageFormat.a4.portrait.width,
            PdfPageFormat.a4.portrait.height / 2.5),
        build: (pw.Context context) {
          return pw.Container(
            margin: const pw.EdgeInsets.all(30),
            color: PdfColor.fromHex("#FFFFFF"),
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Text(
                  'Pembayaran Berhasil',
                  style: pw.TextStyle(
                    font: fontBold,
                    fontSize: level4,
                    color: PdfColor.fromHex("#000000"),
                  ),
                ),
                pw.Text(
                  'Montiro Membership Emergency Roadside Assistance',
                  style: pw.TextStyle(
                    font: fontBold,
                    fontSize: level1,
                    color: PdfColor.fromHex("#000000"),
                  ),
                ),
                pw.SizedBox(height: 15),
                pw.Image(
                  icon,
                  height: 50,
                ),
                pw.SizedBox(height: 15),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    pw.SizedBox(width: 100),
                    pw.Expanded(
                      child: pw.Text(
                        'Type Pembayaran',
                        style: pw.TextStyle(
                          font: font,
                          fontSize: level1,
                          color: PdfColor.fromHex("#000000"),
                        ),
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Text(
                        response.detailPackage!.payment_type,
                        style: pw.TextStyle(
                          font: font,
                          fontSize: level1,
                          color: PdfColor.fromHex("#000000"),
                        ),
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 5),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    pw.SizedBox(width: 100),
                    pw.Expanded(
                      child: pw.Text(
                        'Channel Pembayaran',
                        style: pw.TextStyle(
                          font: font,
                          fontSize: level1,
                          color: PdfColor.fromHex("#000000"),
                        ),
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Text(
                        response.detailPackage!.payment_name,
                        style: pw.TextStyle(
                          font: font,
                          fontSize: level1,
                          color: PdfColor.fromHex("#000000"),
                        ),
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 20),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    pw.SizedBox(width: 100),
                    pw.Expanded(
                      child: pw.Text(
                        'Total',
                        style: pw.TextStyle(
                          font: fontBold,
                          fontSize: level2,
                          color: PdfColor.fromHex("#000000"),
                        ),
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Text(
                        response.detailPackage!.priceText,
                        style: pw.TextStyle(
                          font: fontBold,
                          fontSize: level2,
                          color: PdfColor.fromHex("#000000"),
                        ),
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 20),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    pw.SizedBox(width: 100),
                    pw.Expanded(
                      child: pw.Text(
                        'Waktu Pembayaran',
                        style: pw.TextStyle(
                          font: font,
                          fontSize: level1,
                          color: PdfColor.fromHex("#000000"),
                        ),
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Text(
                        response.detailPackage!.paymentAt,
                        style: pw.TextStyle(
                          font: font,
                          fontSize: level1,
                          color: PdfColor.fromHex("#000000"),
                        ),
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 5),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    pw.SizedBox(width: 100),
                    pw.Expanded(
                      child: pw.Text(
                        'ID Pembayaran',
                        style: pw.TextStyle(
                          font: font,
                          fontSize: level1,
                          color: PdfColor.fromHex("#000000"),
                        ),
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Text(
                        response.detailPackage!.paymentCode,
                        style: pw.TextStyle(
                          font: font,
                          fontSize: level1,
                          color: PdfColor.fromHex("#000000"),
                        ),
                      ),
                    ),
                  ],
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
          "Membership-Payment-${response.detailPackage!.brand_name} ${response.detailPackage!.model_name} ${response.detailPackage!.varian_name}. Tahun ${response.detailPackage!.tahunProduksi}.pdf")
      ..click();
    //
    //window.close();
  }
}
