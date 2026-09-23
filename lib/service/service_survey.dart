import 'package:dio/dio.dart';
import 'package:montiro_external/model/model_survey.dart';
import 'package:pretty_json/pretty_json.dart';

import '../model/model_garasi.dart';
import '../shared/shared_config.dart';

class ServiceSurvey {
  Dio dio = Dio();

  Future<bool?> updateSurveyVersi2(String apiurl, Map<String, dynamic> payload) async {
    try {
      var apiFull = "${apiurl}survey/v2/update";

      print(apiFull);
      print(prettyJson(payload, indent: 2));

      var response = await dio.post(
        apiFull,
        data: payload,
        options: await Config().getOptions(),
      );

      print(prettyJson(response.data, indent: 2));

      return true;
    } catch (ex) {
      print("Error update survey: $ex");
      return null;
    }
  }

  Future<bool?> updateSurvey(
    String apiurl, 
    String uniqueId,
    double rating,
  ) async {
    var data = {
      "unique_id": uniqueId,
      'rating': rating,
    };
    try {
      var apiFull = "${apiurl}survey/update";
      var response = await dio.post(
        apiFull,
        data: data,
        options: await Config().getOptions(),
      );
      print(apiFull);
      print(prettyJson(data, indent: 2));
      print(prettyJson(response.data, indent: 2));
      return true;
    } catch (ex) {
      return null;
    }
  }

  Future<ResponseSurvey?> detail(
    String apiurl, 
    String uniqueId,
  ) async {
    var data = {
      "unique_id": uniqueId,
    };
    try {
      var apiFull = "${apiurl}survey/detail";
      var response = await dio.post(
        apiFull,
        data: data,
        options: await Config().getOptions(),
      );
      print(apiFull);
      print(prettyJson(data, indent: 2));
      print(prettyJson(response.data, indent: 2));
      return ResponseSurvey.fromJson(
        response.data,
      );
    } catch (ex) {
      return null;
    }
  }

  Future<ResponseGarasi?> garasi(
    String apiurl, 
    String plat,
    String nomoRangka,
  ) async {
    var data = {
      "plat": plat.toUpperCase(),
      "nomor_rangka": nomoRangka,
    };
    try {
      var apiFull = "${apiurl}customer/mobil/garasi/last";
      var response = await dio.post(
        apiFull,
        data: data,
        options: await Config().getOptions(),
      );
      print(apiFull);
      print(prettyJson(data, indent: 2));
      print(prettyJson(response.data, indent: 2));
      return ResponseGarasi.fromJson(
        response.data,
      );
    } catch (ex) {
      return null;
    }
  }
}
