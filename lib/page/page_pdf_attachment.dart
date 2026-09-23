import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/provider_pdf_attachment.dart';

class PagePdfAttachment extends StatefulWidget {
  const PagePdfAttachment({Key? key}) : super(key: key);
  @override
  PagePdfAttachmentState createState() => PagePdfAttachmentState();
}

class PagePdfAttachmentState extends State<PagePdfAttachment> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProviderPdfAttachment>(context, listen: false)
          .download(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<ProviderPdfAttachment>(context);
    return Material(
      type: MaterialType.transparency,
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (prov.isLoading)
                  Image.asset(
                    "assets/ic_logo_splash.jpg",
                    height: 200,
                  ),
                if (!prov.isLoading)
                  Image.asset(
                    "assets/ic_thanks.jpg",
                    height: 200,
                  )
              ],
            )
          ],
        ),
      ),
    );
  }
}
