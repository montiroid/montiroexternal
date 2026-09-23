import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../provider/provider_qr.dart';

class PageQr extends StatefulWidget {
  const PageQr({Key? key}) : super(key: key);
  @override
  PageQrState createState() => PageQrState();
}

class PageQrState extends State<PageQr> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //Provider.of<ProviderQR>(context, listen: false).download(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<ProviderQR>(context);
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
              height: 15,
            ),
            const Text(
              "Perlihatkan QR Code ini pada Mitra kami",
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 15,
            ),
            QrImageView(
              data: prov.code.toUpperCase(),
              version: QrVersions.auto,
              size: 250.0,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              prov.code.toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}
