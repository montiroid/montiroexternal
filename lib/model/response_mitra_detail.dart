// ignore_for_file: non_constant_identifier_names

class ResponseMitraDetail {
  ResponseMitraDetail({
    required this.status,
    required this.message,
    required this.mitraDetail,
  });

  bool status;
  String message;
  MitraDetail? mitraDetail;

  factory ResponseMitraDetail.fromJson(Map<String, dynamic> json) =>
      ResponseMitraDetail(
        status: json["status"] ?? false,
        message: json["message"] ?? "",
        mitraDetail: json["mitra_detail"] != null
            ? MitraDetail.fromJson(json["mitra_detail"])
            : null,
      );
}

class MitraDetail {
  MitraDetail({
    required this.id,
    required this.type,
    required this.namaPIC,
    required this.namaMitra,
    required this.alamatMitra,
    required this.mouSignedAt,
    required this.mouSignatureName,
    required this.mouReceiverName,
  });

  int id;
  int type; // 1 = towing, 2 = montir
  String namaPIC;
  String namaMitra;
  String alamatMitra;
  String mouSignedAt;
  String mouSignatureName;
  String mouReceiverName;

  bool get isSigned => mouSignedAt.isNotEmpty;

  factory MitraDetail.fromJson(Map<String, dynamic> json) => MitraDetail(
        id: json["id"] ?? 0,
        type: json["type"] ?? 1,
        namaPIC: json["nama_pic"] ?? "",
        namaMitra: json["nama_mitra"] ?? "",
        alamatMitra: json["alamat_mitra"] ?? "",
        mouSignedAt: json["mou_signed_at"] ?? "",
        mouSignatureName: json["mou_signature_name"] ?? "",
        mouReceiverName: json["mou_receiver_name"] ?? "",
      );
}