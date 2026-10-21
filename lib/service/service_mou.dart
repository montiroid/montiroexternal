import 'package:dio/dio.dart';
import 'package:montiro_external/service/service_booking.dart';
import 'package:pretty_json/pretty_json.dart';
import '../model/response_mitra_detail.dart';
import '../shared/shared_config.dart';

class ServiceMou {
  Dio dio = Dio();

  Future<ResponseMitraDetail> detail(int idMitra) async {
    var apiFull = "${apiProd}mitra/detail";
    var data = {"id": idMitra};
    print(apiFull);
    print(prettyJson(data, indent: 2));
    var response = await dio.post(
      apiFull,
      data: data,
      options: await Config().getOptions(),
    );
    print(prettyJson(response.data, indent: 2));
    return ResponseMitraDetail.fromJson(response.data);
  }

  Future<bool> submitMou({
    required int idMitra,
    required int type, // 1 = Towing, 2 = Montir
    required String signature,
  }) async {
    try {
      var url = "${apiProd}mitra/submit/mou";

      var formData = FormData();
      formData.fields.addAll([
        MapEntry('id_mitra', idMitra.toString()),
        MapEntry('type', type.toString()),
        MapEntry('signature', signature),
      ]);

      print('Submit MoU ID Mitra: $idMitra, Type: $type');

      var response = await dio.post(
        url,
        data: formData,
        options: await Config().getMultipartOptions(),
      );

      print(prettyJson(response.data, indent: 2));
      return response.data['status'] == true;
    } catch (ex) {
      print('Error submit MoU: $ex');
      return false;
    }
  }
}