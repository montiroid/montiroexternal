import 'package:dio/dio.dart';
import 'package:pretty_json/pretty_json.dart';
import '../model/model_homeservice_detail.dart';
import '../shared/shared_config.dart';
import 'service_booking.dart';

class ServiceHomeService {
  Dio dio = Dio();

  Future<ResponseHomeServiceDetail?> historyDetail(int idHomeservice) async {
    //try {
    var data = {
      "id_homeservice": idHomeservice,
      "is_customer": true,
    };
    var apiFull = "${apiProd}homeservice/history/detail";
    print(apiFull);
    print(prettyJson(data, indent: 2));
    var response = await dio.post(
      apiFull,
      data: data,
      options: await Config().getOptions(),
    );
    print(prettyJson(response.data, indent: 2));
    return ResponseHomeServiceDetail.fromJson(
      response.data,
    );
    // } catch (ex) {
    //   return null;
    // }
  }
}
