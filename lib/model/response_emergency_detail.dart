// ignore_for_file: non_constant_identifier_names

import 'package:intl/intl.dart';
import 'package:montiro_external/service/service_date.dart';

class ResponseEmergencyDetail {
  ResponseEmergencyDetail({
    required this.status,
    required this.messageWA,
    required this.emergencyDetail,
    required this.emergencyStatus,
  });

  bool status;
  String messageWA;
  EmergencyDetail? emergencyDetail;
  List<EmergencyStatus> emergencyStatus;

  factory ResponseEmergencyDetail.fromJson(Map<String, dynamic> json) =>
      ResponseEmergencyDetail(
        messageWA: json["message_wa"] ?? "",
        status: json["status"],
        emergencyDetail: EmergencyDetail.fromJson(json["emergency_detail"]),
        emergencyStatus: List<EmergencyStatus>.from(
            json["emergency_status"].map((x) => EmergencyStatus.fromJson(x))),
      );
}

class EmergencyDetail {
  EmergencyDetail({
    required this.id,
    required this.idModel,
    required this.idMontir,
    required this.custName,
    required this.custEmail,
    required this.custPhone,
    required this.custAddress,
    required this.custAddressNote,
    required this.latitude,
    required this.longitude,
    required this.keluhan,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.noPolisi,
    required this.statusText,
    required this.car,
    required this.mitra_nama,
    required this.mitra_coverage,
    required this.mitra_image,
    required this.distance,
    required this.coverage,
    required this.price,
    required this.layananName,
    required this.receipt,
    required this.rating,
    required this.ulasan,
    required this.code,
    required this.mitra_phone,
    required this.handover_receiver_on_process,
    required this.handover_receiver_on_done,
    required this.handover_receiver_on_process_signed_at,
    required this.handover_receiver_on_done_signed_at,
    // ========== FIELD BARU ==========
    required this.signature_name,
    required this.foto1_name,
    required this.foto2_name,
  });

  int id;
  int idModel;
  int idMontir;
  String custName;
  String custEmail;
  String custPhone;
  String custAddress;
  String custAddressNote;
  double latitude;
  double longitude;
  String keluhan;
  int status;
  DateTime createdAt;
  DateTime updatedAt;
  String noPolisi;
  String statusText;
  String car;
  String mitra_nama;
  String mitra_coverage;
  String mitra_image;
  String mitra_phone;
  String distance;
  String coverage;
  String layananName;
  String receipt;
  int rating;
  String ulasan;
  String code;
  String handover_receiver_on_process;
  String handover_receiver_on_done;
  String handover_receiver_on_process_signed_at;
  String handover_receiver_on_done_signed_at;
  
  // ========== FIELD BARU ==========
  String signature_name;
  String foto1_name;
  String foto2_name;
  
  //
  String get date {
    return DateHandle().formatWithHour(createdAt);
  }

  String get signOnProcessDate {
    try {
      return DateHandle()
          .formatWithHour(DateTime.parse(handover_receiver_on_process_signed_at));
    } catch (e) {
      return "";
    }
  }

  String get signOnDoneDate {
    try {
      return DateHandle().formatWithHour(DateTime.parse(handover_receiver_on_done_signed_at));
    } catch (e) {
      return "";
    }
  }

  int price;

  String get priceText {
    if (price > 0) {
      return "Rp.${NumberFormat("#,###").format(price)}";
    } else {
      return "Belum Diketahui";
    }
  }

  // ========== GETTER UNTUK CEK FILE ==========
  bool get hasSignature => signature_name.isNotEmpty;
  bool get hasFoto1 => foto1_name.isNotEmpty;
  bool get hasFoto2 => foto2_name.isNotEmpty;

  factory EmergencyDetail.fromJson(Map<String, dynamic> json) =>
      EmergencyDetail(
        handover_receiver_on_process:
            json["handover_receiver_on_process"] ?? "",
        handover_receiver_on_done: json["handover_receiver_on_done"] ?? "",
        handover_receiver_on_process_signed_at:
            json["handover_receiver_on_process_signed_at"] ?? "",
        handover_receiver_on_done_signed_at:
            json["handover_receiver_on_done_signed_at"] ?? "",
        mitra_phone: json["mitra_phone"] ?? "0",
        code: json["code"] ?? "",
        ulasan: json["ulasan"] ?? "",
        rating: json["rating"] ?? 0,
        receipt: json["receipt"] ?? "",
        layananName: json["layanan_name"] ?? "",
        price: json["price"] ?? 0,
        coverage: json["mitra_coverage"] ?? "",
        mitra_nama: json["mitra_nama"] ?? "",
        mitra_coverage: json["mitra_coverage"] ?? "",
        mitra_image: json["mitra_image"] ?? "",
        distance: json["distance"] ?? "",
        car: json["car"] ?? "",
        id: json["id"] ?? 0,
        idModel: json["id_model"] ?? 0,
        idMontir: json["id_montir"] ?? 0,
        custName: json["cust_name"] ?? "",
        custEmail: json["cust_email"] ?? "",
        custPhone: json["cust_phone"] ?? "",
        custAddress: json["cust_address"] ?? "",
        custAddressNote: json["cust_address_note"] ?? "",
        latitude: (json["latitude"] ?? 0.0).toDouble(),
        longitude: (json["longitude"] ?? 0.0).toDouble(),
        keluhan: json["keluhan"] ?? "",
        status: json["status"] ?? 0,
        createdAt: DateTime.parse(json["created_at"] ?? "2020-01-01"),
        updatedAt: DateTime.parse(json["updated_at"] ?? "2020-01-01"),
        noPolisi: json["no_polisi"] ?? "",
        statusText: json["status_text"] ?? "",
        // ========== FIELD BARU ==========
        signature_name: json["signature_name"] ?? "",
        foto1_name: json["foto1_name"] ?? "",
        foto2_name: json["foto2_name"] ?? "",
      );
}

class EmergencyStatus {
  EmergencyStatus({
    required this.statusText,
    required this.createdAt,
  });

  String statusText;
  DateTime createdAt;

  String get date {
    return DateHandle().formatWithHour(createdAt);
  }

  factory EmergencyStatus.fromJson(Map<String, dynamic> json) =>
      EmergencyStatus(
        statusText: json["status_text"] ?? "",
        createdAt: DateTime.parse(json["created_at"] ?? "2020-01-01"),
      );
}