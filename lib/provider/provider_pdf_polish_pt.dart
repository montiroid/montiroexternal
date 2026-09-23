import 'package:flutter/material.dart';
import 'package:montiro_external/provider/provider_igloo.dart';

import '../service/service_booking.dart';
import 'provider_scomadi.dart';
import 'provider_tokio.dart';

class ProviderPdfPolishPT with ChangeNotifier {
  final String id;

  ProviderPdfPolishPT(
    this.id,
  );

  var isLoading = true;

  download(BuildContext context) async {
    var response = await ServiceBooking().detailMembership(
      id,
    );
    notifyListeners();

    if (response.detailPackage == null) {
      return;
    }

    if (response.detailPackage!.id_perusahaan == 0) {
      return;
    }

    if (response.detailPackage!.id_perusahaan == 11) {
       await scomadiPdf(response: response);
    }
        if (response.detailPackage!.id_perusahaan == 14) {
       await iglooPdf(response: response);
    }
    else {
      await tokioPdf(response: response);
    }
   
    isLoading = false;
    notifyListeners();
  }
}
