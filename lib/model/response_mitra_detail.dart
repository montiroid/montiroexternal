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
    required this.namaPIC,
    required this.namaMitra,
    required this.alamatMitra,
    required this.fileName,
    required this.urlFile,
    required this.mouSignedAt,
  });

  int id;
  String namaPIC;
  String namaMitra;
  String alamatMitra;
  String fileName;
  String urlFile;
  String mouSignedAt;

  bool get isSigned => fileName.isNotEmpty;

  factory MitraDetail.fromJson(Map<String, dynamic> json) => MitraDetail(
        id: json["id"] ?? 0,
        namaPIC: json["nama_pic"] ?? "",
        namaMitra: json["nama_mitra"] ?? "",
        alamatMitra: json["alamat_mitra"] ?? "",
        fileName: json["file_name"] ?? "",
        urlFile: json["url_file"] ?? "",
        mouSignedAt: json["mou_signed_at"] ?? "",
      );
}