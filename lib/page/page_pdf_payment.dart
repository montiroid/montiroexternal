import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/provider_pdf_payment.dart';

class PagePdfPayment extends StatefulWidget {
  const PagePdfPayment({Key? key}) : super(key: key);
  @override
  PagePdfPaymentState createState() => PagePdfPaymentState();
}

class PagePdfPaymentState extends State<PagePdfPayment> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProviderPdfPayment>(context, listen: false).download(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<ProviderPdfPayment>(context);
    return Material(
      type: MaterialType.transparency,
      child: Container(
        width: double.infinity,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/ic_logo_blue.png",
              height: 75,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              prov.isLoading
                  ? 'Mohon Tunggu Invoice \nSedang Proses Download'
                  : 'Invoice Anda Berhasil di Download.\nPeriksa di Folder Download. Terimakasih.',
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
