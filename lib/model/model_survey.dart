class ResponseSurvey {
  ResponseSurvey({
    required this.status,
    required this.detail,
  });

  final bool status;
  final SurveyDetail detail;

  factory ResponseSurvey.fromJson(Map<String, dynamic> json) => ResponseSurvey(
        status: json["status"] ?? false,
        detail: SurveyDetail.fromJson(
          (json["detail"] as Map<String, dynamic>?) ?? {},
        ),
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
    this.averageRating,
    this.phoneOvo,
    this.answers = const [],
    required this.garasi,
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
  final double? averageRating;
  final String? phoneOvo;
  final List<SurveyAnswerItem> answers;
  final GarasiData garasi;

  String get titleTransaksi {
    if (type == "MITSUBISHI-LEVEL-3") {
      return 'SERVICE-$idTransaksi';
    } else {
      return 'EM-$idTransaksi';
    }
  }

  factory SurveyDetail.fromJson(Map<String, dynamic> json) => SurveyDetail(
        id: (json["id"] as num?)?.toInt() ?? 0,
        carInfo: json["car_info"] ?? "",
        nomorRangka: json["nomor_rangka"] ?? "",
        idTransaksi: (json["id_transaksi"] as num?)?.toInt() ?? 0,
        type: json["type"] ?? "",
        ratingPuas: (json["rating_puas"] as num?)?.toInt(),
        createdAt: json["created_at"] ?? "",
        doneAt: json["done_at"],
        uniqueId: json["unique_id"] ?? "",
        createdBy: json["created_by"] ?? "",
        layananName: json["layanan_name"] ?? "",
        noPolisi: json["no_polisi"] ?? "",
        averageRating: json["average_rating"] != null
            ? (json["average_rating"] as num).toDouble()
            : null,
        phoneOvo: json["phone_ovo"],
        answers: json["answers"] != null
            ? (json["answers"] as List)
                .map((e) => SurveyAnswerItem.fromJson(
                      (e as Map<String, dynamic>?) ?? {},
                    ))
                .toList()
            : [],
        garasi: GarasiData.fromJson(
          (json["garasi"] as Map<String, dynamic>?) ?? {},
        ),
      );
}

class SurveyAnswerItem {
  SurveyAnswerItem({
    required this.questionId,
    required this.rating,
    required this.alasan,
  });

  final int questionId;
  final double rating;
  final String alasan;

  factory SurveyAnswerItem.fromJson(Map<String, dynamic> json) =>
      SurveyAnswerItem(
        questionId: (json["question_id"] as num?)?.toInt() ?? 0,
        rating: (json["rating"] as num?)?.toDouble() ?? 0,
        alasan: json["alasan"] ?? "",
      );
}

class GarasiData {
  GarasiData({
    required this.modelName,
    required this.varianName,
    required this.carBrandName,
    required this.tahunProduksi,
    required this.platLeft,
    required this.platCenter,
    required this.platRight,
    required this.nomorRangka,
  });

  final String modelName;
  final String varianName;
  final String carBrandName;
  final int tahunProduksi;
  String platLeft;
  String platCenter;
  String platRight;
  final String nomorRangka;

  String get platText {
    return ("$platLeft $platCenter $platRight").trim().toUpperCase();
  }

  factory GarasiData.fromJson(Map<String, dynamic> json) => GarasiData(
        modelName: json["model_name"] ?? "",
        varianName: json["varian_name"] ?? "",
        carBrandName: json["car_brand_name"] ?? "",
        tahunProduksi: (json["tahun_produksi"] as num?)?.toInt() ?? 0,
        platLeft: json["plat_left"] ?? "",
        platCenter: json["plat_center"] ?? "",
        platRight: json["plat_right"] ?? "",
        nomorRangka: json["nomor_rangka"] ?? "",
      );
}