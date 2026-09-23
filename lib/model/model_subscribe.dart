// ignore_for_file: non_constant_identifier_names

import 'package:intl/intl.dart';

import '../shared/shared_date_handle.dart';

class ResponseSubscribe {
  ResponseSubscribe({
    required this.status,
    required this.message,
    required this.detailPackage,
  });

  final bool status;
  final String message;
  final DetailPackage? detailPackage;

  factory ResponseSubscribe.fromJson(Map<String, dynamic> json) =>
      ResponseSubscribe(
        status: json["status"],
        message: json["message"],
        detailPackage: DetailPackage.fromJson(
          json["detail_package"],
        ),
      );
}

class DetailPackage {
  DetailPackage({
    required this.id,
    required this.idCustomer,
    required this.idVarian,
    required this.plat,
    required this.imageStnk,
    required this.imageBody,
    required this.imagePlat,
    required this.tahunProduksi,
    required this.externalCode,
    required this.paymentCode,
    required this.urlPayment,
    required this.price,
    required this.status,
    required this.activeAt,
    required this.no_member,
    required this.brand_name,
    required this.model_name,
    required this.varian_name,
    required this.payment_type,
    required this.payment_name,
    required this.payment_at,
    required this.month,
    required this.quota_towing,
    required this.quota_aki_drop,
    required this.quota_ban_kempes,
    required this.customer_name,
    required this.perusahaan_name,
    required this.id_perusahaan,
    required this.nomor_asuransi,
    required this.nomor_rangka,
    required this.warna,
    required this.end_at,
  });

  final int id;
  final int idCustomer;
  final int idVarian;
  final String plat;
  final String imageStnk;
  final String imageBody;
  final String imagePlat;
  final int tahunProduksi;
  final String externalCode;
  final String paymentCode;
  final String urlPayment;
  final int price;
  final int status;
  final String activeAt;
  final String no_member;
  final String end_at;
  final String brand_name;
  final String model_name;
  final String varian_name;
  final String payment_type;
  final String payment_name;
  final String payment_at;
  final String customer_name;
  final String perusahaan_name;
  //
  final int month;
  final int id_perusahaan;
  final int quota_towing;
  final int quota_aki_drop;
  final int quota_ban_kempes;
  final String nomor_asuransi;
  final String nomor_rangka;
  final String warna;

  String get idMembership {
    return '${id_perusahaan.toString().padLeft(4, '0')}${id.toString().padLeft(4, '0')}';
  }

  String get mobil {
    return '${brand_name.toUpperCase()} ${model_name.toUpperCase()}';
  }

  //
  String get priceText {
    return "Rp. ${NumberFormat("#,###").format(price)}";
  }

  String get start {
    if (activeAt == "") {
      return "";
    }
    return DateHandle2().shortDate(DateTime.parse(activeAt));
  }

  String get endAt {
    if (end_at == "") {
      return "";
    }
    return DateHandle2().shortDate(DateTime.parse(end_at));
  }

  String get noMember {
    return id.toString();
  }

  String get paymentAt {
    if (payment_at == "") {
      return "";
    }
    return DateHandle2().formatWithHour(DateTime.parse(payment_at));
  }

  String get periode {
    if (activeAt == "") {
      return "";
    }
    return "$start - $endAt";
  }

  String get tanggalSertifikat {
    return "Jakarta, ${DateHandle2().longDate(DateTime.parse(activeAt))}";
  }

  factory DetailPackage.fromJson(Map<String, dynamic> json) => DetailPackage(
        end_at: json["end_at"] ?? "",
        warna: json["warna"] ?? "",
        nomor_rangka: json["nomor_rangka"] ?? "",
        nomor_asuransi: json["nomor_asuransi"] ?? "",
        id_perusahaan: json["id_perusahaan"] ?? 0,
        perusahaan_name: json["perusahaan_name"] ?? "",
        customer_name: json["customer_name"] ?? "",
        month: json["month"] ?? 0,
        quota_towing: json["quota_towing"] ?? 0,
        quota_aki_drop: json["quota_aki_drop"] ?? 0,
        quota_ban_kempes: json["quota_ban_kempes"] ?? 0,
        payment_at: json["payment_at"] ?? "",
        payment_type: json["payment_type"] ?? "",
        payment_name: json["payment_name"] ?? "",
        brand_name: json["brand_name"] ?? "",
        model_name: json["model_name"] ?? "",
        no_member: json["no_member"] ?? "",
        varian_name: json["varian_name"] ?? "",
        id: json["id"],
        idCustomer: json["id_customer"],
        idVarian: json["id_varian"],
        plat: json["plat"],
        imageStnk: json["image_stnk"],
        imageBody: json["image_body"],
        imagePlat: json["image_plat"],
        tahunProduksi: json["tahun_produksi"],
        externalCode: json["external_code"],
        paymentCode: json["payment_code"],
        urlPayment: json["url_payment"],
        price: json["price"],
        status: json["status"],
        activeAt: json["active_at"],
      );
}
