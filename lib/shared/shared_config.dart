import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:montiro_external/widget/widget_custom_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

import 'shared_color.dart';

class AppResponsive extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const AppResponsive(
      {Key? key,
      required this.mobile,
      required this.tablet,
      required this.desktop})
      : super(key: key);

  /// This size work for my design, maybe you need some changes depend on your design
  /// make function that can help us later
  static bool isMobile(context) => MediaQuery.of(context).size.width < 900;
  static bool isTablet(context) =>
      MediaQuery.of(context).size.width < 1100 &&
      MediaQuery.of(context).size.width >= 900;
  static bool isDesktop(context) => MediaQuery.of(context).size.width >= 900;

  @override
  Widget build(BuildContext context) {
    if (isDesktop(context)) {
      return desktop;
    } else if (isTablet(context)) {
      return tablet;
    } else {
      return mobile;
    }
  }
}

class Config {
  openImage(String url) async {
    if (url != "") {
      await launch(url);
    }
  }

  static const defaultMarginSide = 15.0;

  Future<Options> getOptions() async {
    var options = Options(
      validateStatus: (status) {
        return status! < 499;
      },
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': "",
      },
    );
    return options;
  }

Future<Options> getMultipartOptions() async {

  var options = Options(
    validateStatus: (status) {
      return status! < 499;
    },
    headers: {
      'Accept': 'application/json',
      'Authorization': "",
    },
  );
  return options;
}

  Future showLoading(BuildContext context) {
    return CustomAlert.showLoading(context);
  }

  static PreferredSize appBarCustom = PreferredSize(
    preferredSize: const Size.fromHeight(0.0),
    child: AppBar(
      elevation: 0,
      backgroundColor: AppColor.mainColor,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              colors: <Color>[
                AppColor.secondColor,
                AppColor.mainColor,
              ]),
        ),
      ),
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),
  );
}
