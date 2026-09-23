import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:montiro_external/service/service_homeservice.dart';
import 'package:montiro_external/shared/shared_config.dart';

import '../model/model_homeservice_detail.dart';

class ProviderHomeServiceHistoryDetail with ChangeNotifier {
  final int idHomeService;

  ResponseHomeServiceDetail? responseHomeServiceDetail;
  ProviderHomeServiceHistoryDetail(
    this.idHomeService,
  );
  HomeServiceDetail? model;
  var isLoading = true;

  getInspeksiReport(BuildContext context) async {
    // var result = await Navigator.push(
    //   context,
    //   Routes().routeHomeServiceInspeksi(
    //     context,
    //     idHomeService: idHomeService,
    //   ),
    // );
    // if (result) {
    //   Config().showLoading(context);
    //   await detail();
    //   Navigator.pop(context);
    // }
  }

  detailImage(
    BuildContext context,
  ) {
    if (responseHomeServiceDetail == null) return;
    Config().openImage(responseHomeServiceDetail!.homeServiceDetail.receipt);
  }

  detail() async {
    isLoading = true;
    responseHomeServiceDetail = null;
    notifyListeners();
    responseHomeServiceDetail = await ServiceHomeService().historyDetail(
      idHomeService,
    );
    if (responseHomeServiceDetail != null) {
      model = responseHomeServiceDetail?.homeServiceDetail;
    }
    isLoading = false;
    notifyListeners();
  }

  qrCode(
    BuildContext context,
  ) async {
    if (responseHomeServiceDetail == null) return;
    context.pushNamed('qr-code', queryParams: {
      "code": responseHomeServiceDetail!.homeServiceDetail.code,
    });
    await detail();
  }
}
