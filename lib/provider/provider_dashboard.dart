import 'dart:async';

import 'package:flutter/material.dart';
import 'package:montiro_external/model/model_agent.dart';
import 'package:montiro_external/model/model_cases.dart';
import 'package:montiro_external/model/model_keyword_layanan.dart';
import 'package:montiro_external/model/model_layanan.dart';
import 'package:montiro_external/service/service_dashboard.dart';
import 'package:montiro_external/service/service_date.dart';
import 'package:montiro_external/widget/widget_popup_pt.dart';
import 'package:provider/provider.dart';

class ProviderDashboard with ChangeNotifier {
  DateTime? timeStart = DateTime.now();
  KeywordDetail? perusahaan;

  var cases = ResponseCases(status: false, data: []);
  var layanan = ResponseLayanan(status: false, data: [], total: 0);
  var agents = ResponseAgent(status: false, data: []);

  Timer? _timer;

  loadData() async {
    cases = await ServiceDashboard().dataCases(
      DateHandle().backEndFormat(timeStart ?? DateTime.now()),
      DateHandle().backEndFormat(timeStart ?? DateTime.now()),
      perusahaan?.id ?? 0,
    );
    layanan = await ServiceDashboard().dataLayanan(
      DateHandle().backEndFormat(timeStart ?? DateTime.now()),
      DateHandle().backEndFormat(timeStart ?? DateTime.now()),
      perusahaan?.id ?? 0,
    );
    agents = await ServiceDashboard().dataAgent(
      DateHandle().backEndFormat(timeStart ?? DateTime.now()),
      DateHandle().backEndFormat(timeStart ?? DateTime.now()),
      perusahaan?.id ?? 0,
    );
    notifyListeners();
  }

  getPerusahaan(
    BuildContext context,
  ) async {
    var results = await showModalBottomSheet<KeywordDetail>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) => ChangeNotifierProvider(
        create: (context) => ProviderPopUpPerusahaan(),
        builder: (context, child) => const WidgetPopUpPT(),
      ),
    );
    if (results != null) {
      if (results.id == 0) {
        perusahaan = null;
      } else {
        perusahaan = results;
      }
      notifyListeners();
      loadData();
    }
  }

  void startAutoReload() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 30), (_) {
      loadData();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void chooseDateStart(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022, 02, 15),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      timeStart = pickedDate;
      notifyListeners();
      loadData();
    });
  }

  String get timeStartText {
    if (timeStart == null) return "Periode Mulai";
    return DateHandle().indonesiaFormat(timeStart!);
  }

  String get perusahaanText {
    if (perusahaan == null) return "Group";
    return perusahaan!.name;
  }
}

class ProviderPopUpPerusahaan with ChangeNotifier {
  var data = ResponseKeywordDetail(
    keywordDetail: [],
    status: false,
  );
  load() async {
    data = ResponseKeywordDetail(
      keywordDetail: [],
      status: false,
    );
    notifyListeners();
    var datas = await ServiceDashboard().perusahaan();
    data.keywordDetail.add(
      KeywordDetail(
        id: 0,
        name: "Kosong",
      ),
    );
    data.status = true;
    data.keywordDetail.addAll(datas.keywordDetail);
    notifyListeners();
  }
  //
}
