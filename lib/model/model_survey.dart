class ResponseSurvey {
  ResponseSurvey({
    required this.status,
    required this.detail,
  });

  final bool status;
  final SurveyDetail detail;

  factory ResponseSurvey.fromJson(Map<String, dynamic> json) => ResponseSurvey(
        status: json["status"],
        detail: SurveyDetail.fromJson(json["detail"]),
      );
}

class SurveyDetail {
  SurveyDetail({
    required this.id,
    required this.idTransaksi,
    required this.type,
    this.ratingPuas,
    required this.createdAt,
    this.doneAt,
    required this.uniqueId,
    required this.createdBy,
    required this.layananName,
    required this.noPolisi,
    required this.nomorRangka,
    required this.carInfo,
  });

  final int id;
  final int idTransaksi;
  final String type;
  final int? ratingPuas;
  final String createdAt;
  final dynamic doneAt;
  final String uniqueId;
  final String createdBy;
  final String layananName;
  final String noPolisi;
  final String nomorRangka;
  final String carInfo;

  String get titleTransaksi {
    if (type == "MITSUBISHI-LEVEL-3") {
      return 'SERVICE-$idTransaksi';
    } else {
      return 'EM-$idTransaksi';

    }
  }

  factory SurveyDetail.fromJson(Map<String, dynamic> json) => SurveyDetail(
        id: json["id"],
        carInfo : json["car_info"] ?? "",
        nomorRangka : json["nomor_rangka"] ?? "",
        idTransaksi: json["id_transaksi"],
        type: json["type"],
        ratingPuas: json["rating_puas"],
        createdAt: json["created_at"],
        doneAt: json["done_at"],
        uniqueId: json["unique_id"],
        createdBy: json["created_by"],
        layananName: json["layanan_name"],
        noPolisi: json["no_polisi"],
      );
}
