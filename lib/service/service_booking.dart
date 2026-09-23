
import 'package:dio/dio.dart';
import 'package:pretty_json/pretty_json.dart';
import '../model/model_booking.dart';
import '../model/model_subscribe.dart';
import '../shared/shared_config.dart';

var apiProd = "https://api-webapps.montiro.id/api/";
var apiDev = "https://api-webapps.montiro.id/api/";

class ServiceBooking {
  Dio dio = Dio();
  //

  Future<ResponseSubscribe> detailMembership(
    String id,
  ) async {
    var data = {
      "id": 0,
      "plat": "",
      "payment_code": id,
    };
    try {
      var apiFull = "${apiProd}payment/detail";
      var response = await dio.post(
        apiFull,
        data: data,
        options: await Config().getOptions(),
      );
      print(apiFull);
      print(prettyJson(data, indent: 2));
      print(prettyJson(response.data, indent: 2));
      return ResponseSubscribe.fromJson(
        response.data,
      );
    } catch (ex) {
      return ResponseSubscribe(
        status: false,
        message: "",
        detailPackage: null,
      );
    }
  }

  Future<ResponseBooking> detailBooking(
    int idBooking,
    String email,
  ) async {
    var data = {
      "id_booking": idBooking,
      "email": email,
    };
    try {
      var response = await dio.post(
        "${apiProd}layanan/bo/detail",
        data: data,
        options: await Config().getOptions(),
      );
      print(prettyJson(response.data, indent: 2));
      return ResponseBooking.fromJson(
        response.data,
      );
    } catch (ex) {
      return ResponseBooking(
        status: false,
        booking: Booking(
          pt: "",
          id: 0,
          bookingNo: "",
          tanggal: "",
          namaCustomer: "",
          emailCustomer: "",
          noHpCustomer: "",
          namaBengkel: "",
          noHp: "",
          email: "",
          alamat: "",
          noPolisi: "",
          km: "",
          realTotal: 0,
          varianName: "",
          modelName: "",
          brandName: "",
          ulasan: "",
          keluhan: "",
          tahunProduksi: "",
          statusText: "",
          detailBooking: [],
          total: "",
          isPuas: 0,
        ),
      );
    }
  }
}
