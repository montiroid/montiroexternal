import 'package:flutter/material.dart';
import '../model/model_garasi.dart';
import '../model/model_survey.dart';
import '../service/service_survey.dart';
import '../shared/shared_config.dart';

class ProviderSurvey with ChangeNotifier {
  final String uniqueId;

  ResponseSurvey? responseSurvey;
  ResponseGarasi? responseGarasi;
  var isLoading = true;
  var rating = 5;
  var ratingVersi2 = 10.0;

  ProviderSurvey(
    this.uniqueId,
  );

  onRatingChange(int value) {
    rating = value;
    notifyListeners();
  }

  onRatingChangeVersi2(double value) {
    ratingVersi2 = value;
    notifyListeners();
  }

  updateSurveyVersi2(BuildContext context) async {
    Config().showLoading(context);
    await ServiceSurvey().updateSurvey("", uniqueId, ratingVersi2);
    responseSurvey = await ServiceSurvey().detail(
      "",
      uniqueId,
    );
    notifyListeners();
    Navigator.pop(context);
  }

  detail() async {
    isLoading = true;
    notifyListeners();
    responseSurvey = await ServiceSurvey().detail(
      "",
      uniqueId,
    );
    responseGarasi = await ServiceSurvey().garasi(
      "",
      responseSurvey?.detail.noPolisi ?? '',
      responseSurvey?.detail.nomorRangka ?? '',
    );
    isLoading = false;
    notifyListeners();
  }
}
