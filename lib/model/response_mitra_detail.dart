// ignore_for_file: non_constant_identifier_names

import 'package:intl/intl.dart';

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
        mitraDetail: json["montir"] != null
            ? MitraDetail.fromJson(json)
            : null,
      );
}

class LayananEm {
  LayananEm({
    required this.idLayanan,
    required this.price,
    required this.totalUnit,
  });

  int idLayanan;
  int price;
  int totalUnit;

  factory LayananEm.fromJson(Map<String, dynamic> json) => LayananEm(
        idLayanan: json["id_layanan"] ?? 0,
        price: json["price"] ?? 0,
        totalUnit: json["totalunit"] ?? 0,
      );
}

class MitraDetail {
  MitraDetail({
    required this.id,
    required this.namaPIC,
    required this.jabatanPIC,
    required this.namaMitra,
    required this.alamatMitra,
    required this.fileName,
    required this.urlFile,
    required this.mouSignedAt,
    required this.layanan,
  });

  int id;
  String namaPIC;
  String jabatanPIC;
  String namaMitra;
  String alamatMitra;
  String fileName;
  String urlFile;
  String mouSignedAt;
  List<LayananEm> layanan;

  bool get isSigned => urlFile.isNotEmpty || fileName.isNotEmpty;

  String get hargaMontirJumper => _getHargaById(11);
  String get hargaMontirBan => _getHargaById(12);
  String get hargaMontirBensin => _getHargaById(16);
  String get hargaMontirKunci => _getHargaById(13);

  String get hargaTowingDerek => _getHargaById(14);
  String get hargaTowingRoller => _getHargaById(25);
  String get hargaTowingHidrolik => _getHargaById(26);
  String get hargaTowingWheelLift => _getHargaById(27);

  String get hargaTowingEvakuasi {
    try {
      final layanan14 = layanan.firstWhere((e) => e.idLayanan == 14);
      if (layanan14.totalUnit > 0) {
        return _formatRupiah(layanan14.totalUnit);
      }
    } catch (_) {}
    return "";
  }

  String _getHargaById(int idLayanan) {
    try {
      final item = layanan.firstWhere((e) => e.idLayanan == idLayanan);
      if (item.price > 0) {
        return _formatRupiah(item.price);
      }
    } catch (_) {}
    return "";
  }

  String _formatRupiah(int price) {
    final formatter = NumberFormat("#,###", "id_ID");
    return "Rp${formatter.format(price)}";
  }

  factory MitraDetail.fromJson(Map<String, dynamic> json) {
    final dataMontir = json["montir"] ?? {};
    final dataLayanan = json["layanan"] as List? ?? [];

    return MitraDetail(
      id: dataMontir["id"] ?? 0,
      namaPIC: dataMontir["mitra_pic"] ?? "",
      jabatanPIC: dataMontir["mitra_jabatan"] ?? "Owner",
      namaMitra: (dataMontir["bengkel_nama"] != null &&
              dataMontir["bengkel_nama"].toString().isNotEmpty)
          ? dataMontir["bengkel_nama"]
          : (dataMontir["nama"] ?? ""),
      alamatMitra: dataMontir["alamat"] ?? "",
      fileName: dataMontir["file_name"] ?? "",
      urlFile: dataMontir["url_file_aggrement"] ?? "",
      mouSignedAt: dataMontir["mou_signed_at"] ?? "",
      layanan: dataLayanan.map((e) => LayananEm.fromJson(e)).toList(),
    );
  }
}