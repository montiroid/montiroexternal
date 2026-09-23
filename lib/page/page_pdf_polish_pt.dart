import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/provider_pdf_polish_pt.dart';

class PagePdfPolishPT extends StatefulWidget {
  const PagePdfPolishPT({Key? key}) : super(key: key);
  @override
  PagePdfPolishPTState createState() => PagePdfPolishPTState();
}

class PagePdfPolishPTState extends State<PagePdfPolishPT> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProviderPdfPolishPT>(context, listen: false).download(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<ProviderPdfPolishPT>(context);
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
                  ? 'Mohon Tunggu \nSedang Proses Download'
                  : 'Berhasil di Download.\nPeriksa di Folder Download. Terimakasih.',
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
