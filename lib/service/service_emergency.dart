

import 'package:dio/dio.dart';
import 'package:montiro_external/model/response_emergency_detail.dart';
import 'package:pretty_json/pretty_json.dart';
import '../shared/shared_config.dart';
import 'service_booking.dart';

class ServiceEmergency {
  Dio dio = Dio();

  Future<ResponseEmergencyDetail> detail(int id) async {
    var apiFull = "${apiProd}emergency/detail";
    var data = {"id": id};
    print(apiFull);
    print(prettyJson(data, indent: 2));
    var response = await dio.post(
      apiFull,
      data: data,
      options: await Config().getOptions(),
    );
    print(prettyJson(response.data, indent: 2));
    return ResponseEmergencyDetail.fromJson(response.data);
  }

  Future<bool> submit({
    required int id,
    required String signature,
    required int type,
    String? image1,
    String? image2,
  }) async {
    try {
      var url = "${apiProd}emergency/submit/handover";
      
      // PAKAI FORM DATA MULTIPART
      var formData = FormData();
      
      // Text fields
      formData.fields.addAll([
        MapEntry('id', id.toString()),
        MapEntry('type', type.toString()),
        MapEntry('signature', signature), // ganti dari 'image' ke 'signature'
      ]);
      
      // Image 1 (opsional)
      if (image1 != null && image1.isNotEmpty) {
        formData.fields.add(MapEntry('image1', image1));
      }
      
      // Image 2 (opsional)
      if (image2 != null && image2.isNotEmpty) {
        formData.fields.add(MapEntry('image2', image2));
      }
      
      print('Submit handover ID: $id, Type: $type');
      print('Image1: ${image1 != null ? 'Yes' : 'No'}');
      print('Image2: ${image2 != null ? 'Yes' : 'No'}');
      
      var response = await dio.post(
        url,
        data: formData,
        options: await Config().getMultipartOptions(),
      );
      
      print(prettyJson(response.data, indent: 2));
      return response.data['status'] == true;
      
    } catch (ex) {
      print('Error submit handover: $ex');
      return false;
    }
  }

}