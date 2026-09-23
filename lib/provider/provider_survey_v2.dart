import 'package:flutter/material.dart';
import '../model/model_garasi.dart';
import '../model/model_survey.dart';
import '../service/service_survey.dart';
import '../shared/shared_config.dart';

class SurveyQuestion {
  final int id;
  final String text;
  final bool hasFreeText;
  double rating;
  String alasan;

  SurveyQuestion({
    required this.id,
    required this.text,
    this.hasFreeText = false,
    this.rating = 10,
    this.alasan = "",
  });

  Map<String, dynamic> toJson() => {
        "question_id": id,
        "rating": rating,
        "alasan": alasan,
      };
}

class ProviderSurveyVersi2 with ChangeNotifier {
  final String uniqueId;
  final String env;

  ResponseSurvey? responseSurvey;
  ResponseGarasi? responseGarasi;
  var isLoading = true;
  var phoneController =TextEditingController();

  ProviderSurveyVersi2(
    this.uniqueId,
    this.env,
  );

  List<SurveyQuestion> questions = [
    SurveyQuestion(
      id: 1,
      text:
          "Apakah waktu proses dan tunggu layanan yang diminta sudah sesuai dengan Harapan bapak/ibu?",
    ),
    SurveyQuestion(
      id: 2,
      text:
          "Apakah cakupan layanan yang diberikan sudah sesuai dengan Harapan bapak/ibu?",
    ),
    SurveyQuestion(
      id: 3,
      text:
          "Apakah keahlian dari teknisi dan peralatan yang digunakan sudah sesuai dengan Harapan bapak/ibu?",
    ),
    SurveyQuestion(
      id: 4,
      text: "Seberapa besar bapak/ibu akan merekomendasikan layanan ini?",
      hasFreeText: true,
    ),
  ];

  void updateRating(int id, double value) {
    final q = questions.firstWhere((q) => q.id == id);
    q.rating = value;
    notifyListeners();
  }

  void updateAlasan(int id, String value) {
    final q = questions.firstWhere((q) => q.id == id);
    q.alasan = value;
    notifyListeners();
  }

  Future<void> updateSurveyVersi2(BuildContext context, String uniqueId) async {
    Config().showLoading(context);

    final payload = {
      "unique_id": uniqueId,
      "answers": questions.map((q) => q.toJson()).toList(),
      "phone": phoneController.text,
    };

    final result = await ServiceSurvey().updateSurveyVersi2(env, payload);

    if (result == true) {
      responseSurvey = await ServiceSurvey().detail(env, uniqueId);
    }

    notifyListeners();
    Navigator.pop(context);
  }

  detail() async {
    isLoading = true;
    notifyListeners();
    responseSurvey = await ServiceSurvey().detail(
      env,
      uniqueId,
    );
    if (responseSurvey?.detail.type == "MITSUBISHI-LEVEL-3") {
      responseGarasi = ResponseGarasi(
          status: true,
          data: GarasiData(
            modelName: responseSurvey?.detail.carInfo ?? '',
            varianName: '',
            carBrandName: '',
            tahunProduksi: 0,
            platLeft: '',
            platCenter: '',
            platRight: '',
          ));
    } else {
      responseGarasi = await ServiceSurvey().garasi(
        env,
        responseSurvey?.detail.noPolisi ?? '',
        responseSurvey?.detail.nomorRangka ?? '',
      );
    }

    isLoading = false;
    notifyListeners();
  }
}
