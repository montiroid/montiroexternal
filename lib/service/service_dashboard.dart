import 'package:dio/dio.dart';
import 'package:montiro_external/model/model_agent.dart';
import 'package:montiro_external/model/model_cases.dart';
import 'package:montiro_external/model/model_keyword_layanan.dart';
import 'package:montiro_external/model/model_layanan.dart';
import 'package:montiro_external/service/service_booking.dart';
import 'package:montiro_external/shared/shared_config.dart';
import 'package:pretty_json/pretty_json.dart';

class ServiceDashboard {
  Dio dio = Dio();

  Future<ResponseKeywordDetail> perusahaan() async {
    try {
      var response = await dio.post(
        "${apiProd}bo/package/organisasi",
        options: await Config().getOptions(),
      );
      print(prettyJson(response.data, indent: 2));
      return ResponseKeywordDetail.fromJson(
        response.data,
      );
    } catch (ex) {
      return ResponseKeywordDetail(status: false, keywordDetail: []);
    }
  }

  Future<ResponseCases> dataCases(
    String start,
    String end,
    int idPt,
  ) async {
    var data = {
      "start": start,
      "end": end,
      "id_pt": idPt,
    };
    // try {
    var apiFull = "${apiProd}dashboard/case";
    var response = await dio.post(
      apiFull,
      data: data,
      options: await Config().getOptions(),
    );
    print(apiFull);
    print(prettyJson(data, indent: 2));
    print(prettyJson(response.data, indent: 2));
    return ResponseCases.fromJson(
      response.data,
    );
    // } catch (ex) {
    //   return ResponseCases(
    //     status: false,
    //     data: [],
    //   );
    // }
  }

  Future<ResponseLayanan> dataLayanan(
    String start,
    String end,
    int idPt,
  ) async {
    var data = {
      "start": start,
      "end": end,
      "id_pt": idPt,
    };
    try {
      var apiFull = "${apiProd}dashboard/service";

      print(apiFull);
      print(prettyJson(data, indent: 2));

      var response = await dio.post(
        apiFull,
        data: data,
        options: await Config().getOptions(),
      );

      print(prettyJson(response.data, indent: 2));
      return ResponseLayanan.fromJson(
        response.data,
      );
    } catch (ex) {
      return ResponseLayanan(
        status: false,
        data: [],
        total: 0,
      );
    }
  }

  Future<ResponseAgent> dataAgent(
    String start,
    String end,
    int idPt,
  ) async {
    var data = {
      "start": start,
      "end": end,
      "id_pt": idPt,
    };
    try {
      var apiFull = "${apiProd}dashboard/agent";

      print(apiFull);
      print(prettyJson(data, indent: 2));

      var response = await dio.post(
        apiFull,
        data: data,
        options: await Config().getOptions(),
      );

      print(prettyJson(response.data, indent: 2));
      return ResponseAgent.fromJson(
        response.data,
      );
    } catch (ex) {
      return ResponseAgent(
        status: false,
        data: [],
      );
    }
  }
}
