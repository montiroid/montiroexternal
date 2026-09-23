import 'package:flutter/material.dart';

import '../shared/shared_color.dart';
import '../shared/shared_font.dart';

class WidgetToolbarMain extends StatelessWidget {
  final String title;
  final Function? onRefresh;

  const WidgetToolbarMain({
    super.key,
    required this.title,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [AppColor.mainColor, AppColor.mainColor]),
      ),
      height: 60,
      child: Container(
        margin: const EdgeInsets.only(right: 15),
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 15),
              child: Center(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  style: AppFonts.toolbarFonts.copyWith(color: Colors.white),
                ),
              ),
            ),
            onRefresh != null
                ? Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                        onTap: () {
                          onRefresh!();
                        },
                        child: Container(
                          padding: const EdgeInsets.only(left: 20),
                          color: Colors.transparent,
                          height: 60.0,
                          width: 60,
                          child: const Center(
                            child: Icon(
                              Icons.refresh,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                        )),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
