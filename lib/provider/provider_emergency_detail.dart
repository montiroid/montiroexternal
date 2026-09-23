import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:montiro_external/service/service_emergency.dart';
import 'package:montiro_external/shared/shared_config.dart';

import '../model/response_emergency_detail.dart';

class ProviderEmergencyDetail with ChangeNotifier {
  final int idEmergency;

  ResponseEmergencyDetail? responseEmergencyDetail;
  ProviderEmergencyDetail(
    this.idEmergency,
  );
  EmergencyDetail? model;
  List<EmergencyStatus> filteredEmergencyStatus = [];
  var isLoading = true;

  getInspeksiReport(BuildContext context) async {
    // var result = await Navigator.push(
    //   context,
    //   Routes().routeEmergencyInspeksi(
    //     context,
    //     idEmergency: idEmergency,
    //   ),
    // );
    // if (result) {
    //   Config().showLoading(context);
    //   await detail();
    //   Navigator.pop(context);
    // }
  }

  detailImage(BuildContext context) {
    if (responseEmergencyDetail == null ||
        responseEmergencyDetail!.emergencyDetail == null) return;
    Config().openImage(responseEmergencyDetail!.emergencyDetail!.receipt);
  }

  detail() async {
    isLoading = true;
    responseEmergencyDetail = null;
    filteredEmergencyStatus = [];
    notifyListeners();
    
    responseEmergencyDetail = await ServiceEmergency().detail(
      idEmergency,
    );
    
    if (responseEmergencyDetail != null &&
        responseEmergencyDetail!.emergencyDetail != null) {
      model = responseEmergencyDetail!.emergencyDetail;
      filterEmergencyStatus();
    }
    
    isLoading = false;
    notifyListeners();
  }

  void filterEmergencyStatus() {
    if (responseEmergencyDetail == null) return;
    
    // Buat list untuk menyimpan status yang difilter
    List<EmergencyStatus> tempFilteredStatus = [];
    
    // Urutkan berdasarkan createdAt TERBARU ke TERLAMA untuk FILTERING
    // (agar kita ambil entry TERBARU untuk setiap statusText)
    List<EmergencyStatus> sortedStatusForFilter = List.from(responseEmergencyDetail!.emergencyStatus)
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    
    // Filter: hanya ambil yang bukan "BNTR" dan bukan "Hold Validated"
    Set<String> seenStatusText = {};
    for (var status in sortedStatusForFilter) {
      String statusText = status.statusText.trim();
      
      // Skip jika mengandung "BNTR" atau "Hold Validated"
      if (statusText.contains("BNTR") || statusText.contains("Hold Validated")) {
        continue;
      }
      
      // Skip jika sudah ada statusText yang sama (ambil yang TERBARU karena sudah diurutkan dari terbaru)
      if (!seenStatusText.contains(statusText)) {
        seenStatusText.add(statusText);
        tempFilteredStatus.add(status);
      }
    }
    
    // Urutkan kembali dari TERBARU ke TERLAMA untuk timeline (paling atas TERBARU, paling bawah TERLAMA)
    filteredEmergencyStatus = tempFilteredStatus
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  qrCode(BuildContext context) async {
    if (responseEmergencyDetail == null ||
        responseEmergencyDetail!.emergencyDetail == null) return;
    context.pushNamed('qr-code', queryParams: {
      "code": responseEmergencyDetail!.emergencyDetail!.code,
    });
    await detail();
  }

  contactMitra(BuildContext context) {
    if (model == null || model!.mitra_phone.isEmpty || model!.mitra_phone == "0") {
      return;
    }
   // Config().launchPhoneCall(model!.mitra_phone);
  }

  sendWhatsAppMessage(BuildContext context) {
    if (responseEmergencyDetail == null || 
        responseEmergencyDetail!.messageWA.isEmpty) {
      return;
    }
    //Config().launchWhatsApp(responseEmergencyDetail!.messageWA);
  }
}