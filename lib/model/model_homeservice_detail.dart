import 'package:intl/intl.dart';

import '../service/service_date.dart';

class ResponseHomeServiceDetail {
  ResponseHomeServiceDetail({
    required this.status,
    required this.homeServiceDetail,
  });

  bool status;
  HomeServiceDetail homeServiceDetail;

  factory ResponseHomeServiceDetail.fromJson(Map<String, dynamic> json) =>
      ResponseHomeServiceDetail(
        status: json["status"] ?? false,
        homeServiceDetail:
            HomeServiceDetail.fromJson(json["home_service_detail"]),
      );
}

class HomeServiceDetail {
  HomeServiceDetail({
    required this.montirName,
    required this.montirPhone,
    required this.montirImage,
    required this.montirCoverage,
    required this.montirPengalaman,
    required this.montirRating,
    required this.statusText,
    required this.custName,
    required this.custAddress,
    required this.custAddressNote,
    required this.custPhone,
    required this.custEmail,
    required this.latitude,
    required this.longitude,
    required this.dateService,
    required this.mobil,
    required this.km,
    required this.homeserviceBookDetail,
    required this.homeserviceStatusDetail,
    required this.total,
    required this.keluhan,
    required this.status,
    required this.receipt,
    required this.isPuas,
    required this.ulasan,
    required this.code,
  });

  String montirName;
  String montirPhone;
  String montirImage;
  String montirCoverage;
  int montirPengalaman;
  int montirRating;
  String statusText;
  String custName;
  String custAddress;
  String custAddressNote;
  String custPhone;
  String custEmail;
  double latitude;
  double longitude;
  DateTime dateService;
  String mobil;
  String km;
  String keluhan;
  List<HomeserviceBookDetail> homeserviceBookDetail;
  List<HomeserviceStatusDetail> homeserviceStatusDetail;
  String total;
  int status;
  String receipt;
  int? isPuas;
  String ulasan;
  String code;

  String get kmText {
    return NumberFormat("#,###").format(int.parse(km));
  }

  String get tahun {
    return "$montirPengalaman Tahun";
  }

  String get rate {
    return "$montirRating %";
  }

  String get tanggal {
    return DateHandle().formatWithHour(dateService);
  }

  factory HomeServiceDetail.fromJson(Map<String, dynamic> json) =>
      HomeServiceDetail(
        code: json["code"] ?? "",
        receipt: json["receipt"] ?? "",
        isPuas: json["is_puas"],
        ulasan: json["ulasan"] ?? "",
        status: json["status"] ?? 0,
        keluhan: json["keluhan"] ?? "",
        montirName: json["montir_name"],
        montirPhone: json["montir_phone"] ?? "",
        montirImage: json["montir_image"] ?? "",
        montirCoverage: json["montir_coverage"] ?? "",
        montirPengalaman: json["montir_pengalaman"] ?? 0,
        montirRating: json["montir_rating"] ?? 0,
        statusText: json["status_text"] ?? "",
        custName: json["cust_name"] ?? "",
        custAddress: json["cust_address"] ?? "",
        custAddressNote: json["cust_address_note"] ?? "",
        custPhone: json["cust_phone"] ?? "",
        custEmail: json["cust_email"] ?? "",
        latitude: (json["latitude"] ?? 0).toDouble(),
        longitude: (json["longitude"] ?? 0).toDouble(),
        dateService: DateTime.parse(json["date_service"] ?? "1990-01-01"),
        mobil: json["mobil"] ?? "",
        km: json["km"] ?? "",
        homeserviceBookDetail: json["homeservice_book_detail"] == null
            ? []
            : List<HomeserviceBookDetail>.from(json["homeservice_book_detail"]
                .map((x) => HomeserviceBookDetail.fromJson(x))),
        homeserviceStatusDetail: json["homeservice_status_detail"] == null
            ? []
            : List<HomeserviceStatusDetail>.from(
                json["homeservice_status_detail"]
                    .map((x) => HomeserviceStatusDetail.fromJson(x))),
        total: json["total"] ?? "0",
      );
}

class HomeserviceBookDetail {
  HomeserviceBookDetail({
    required this.title,
    required this.price,
  });

  String title;
  String price;

  factory HomeserviceBookDetail.fromJson(Map<String, dynamic> json) =>
      HomeserviceBookDetail(
        title: json["title"] ?? "",
        price: json["price"] ?? "0",
      );
}

class HomeserviceStatusDetail {
  HomeserviceStatusDetail({
    required this.id,
    required this.idHomeservice,
    required this.status,
    required this.user,
    required this.note,
    required this.description,
    required this.isSend,
    required this.createdAt,
    required this.updatedAt,
    required this.title,
  });

  int id;
  int idHomeservice;
  int status;
  String user;
  String note;
  String title;
  String description;
  int isSend;
  DateTime createdAt;
  DateTime updatedAt;

  String get tanggal {
    return DateHandle().formatWithHour(createdAt);
  }

  factory HomeserviceStatusDetail.fromJson(Map<String, dynamic> json) =>
      HomeserviceStatusDetail(
        title: json["title"] ?? "",
        id: json["id"] ?? 0,
        idHomeservice: json["id_homeservice"] ?? 0,
        status: json["status"] ?? 0,
        user: json["user"] ?? "",
        note: json["note"] ?? "",
        description: json["description"] ?? "",
        isSend: json["is_send"] ?? "",
        createdAt: DateTime.parse(json["created_at"] ?? "1990-01-01"),
        updatedAt: DateTime.parse(json["updated_at"] ?? "1990-01-01"),
      );
}
