class ResponseGarasi {
  ResponseGarasi({
    required this.status,
    required this.data,
  });

  final bool status;
  final GarasiData data;

  factory ResponseGarasi.fromJson(Map<String, dynamic> json) => ResponseGarasi(
        status: json["status"],
        data: GarasiData.fromJson(json["data"]),
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
  });

  final String modelName;
  final String varianName;
  final String carBrandName;
  final int tahunProduksi;
  String platLeft;
  String platCenter;
  String platRight;

  String get platText {
    return ("$platLeft $platCenter $platRight").toUpperCase();
  }

  factory GarasiData.fromJson(Map<String, dynamic> json) => GarasiData(
        modelName: json["model_name"],
        varianName: json["varian_name"],
        carBrandName: json["car_brand_name"],
        tahunProduksi: json["tahun_produksi"],
        platLeft: json["plat_left"] ?? "",
        platCenter: json["plat_center"] ?? "",
        platRight: json["plat_right"] ?? "",
      );
}
