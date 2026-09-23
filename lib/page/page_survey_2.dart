import 'package:flutter/material.dart';
import 'package:montiro_external/page/page_survey.dart';
import 'package:montiro_external/shared/shared_config.dart';
import 'package:montiro_external/widget/widget_loading.dart';
import 'package:montiro_external/widget/widget_toolbar_main.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import '../provider/provider_survey_v2.dart';
import '../shared/shared_color.dart';
import '../shared/shared_font.dart';

class PageSurveyVersi2 extends StatefulWidget {
  const PageSurveyVersi2({super.key});

  @override
  PageSurveyVersi2State createState() => PageSurveyVersi2State();
}

class PageSurveyVersi2State extends State<PageSurveyVersi2> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProviderSurveyVersi2>(context, listen: false).detail();
    });
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<ProviderSurveyVersi2>(context);
    return Scaffold(
      appBar: Config.appBarCustom,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: SizedBox(
              width: AppResponsive.isDesktop(context)
                  ? 500
                  : MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  WidgetToolbarMain(
                    title: 'Survey',
                    onRefresh: () {
                      prov.detail();
                    },
                  ),
                  if (prov.isLoading) ...[
                    const Align(child: CustomLoading()),
                  ] else if (prov.responseSurvey == null &&
                      prov.responseGarasi == null) ...[
                    Align(
                      child: Text(
                        'Terjadi Kesalahan. Mohon Muat Ulang Halaman Ini',
                        style: AppFonts.normalText,
                      ),
                    )
                  ] else if (prov.responseSurvey!.detail.ratingPuas ==
                      null) ...[
                    const SizedBox(height: 15),
                    ItemUserGarage(
                      model: prov.responseGarasi!.data,
                    ),
                    // Container(
                    //   margin: const EdgeInsets.only(bottom: 15),
                    //   padding: const EdgeInsets.all(15),
                    //   decoration: BoxDecoration(
                    //     color: Colors.white,
                    //     borderRadius: BorderRadius.circular(10),
                    //     border: Border.all(color: Colors.grey.withAlpha(90)),
                    //   ),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Text(
                    //         'Nomor HP (Ovo/Gopay)',
                    //         style: AppFonts.moreSmall,
                    //       ),
                    //       const SizedBox(height: 8),
                    //       TextField(
                    //         keyboardType: TextInputType.number,
                    //         controller: prov.phoneController,
                    //         decoration: const InputDecoration(
                    //           hintText: 'Contoh: 081234567890',
                    //           border: OutlineInputBorder(),
                    //         ),
                    //       ),
                    //       const SizedBox(height: 8),
                    //       Text(
                    //         'Dapatkan saldo OVO/Gopay dengan mengisi nomor HP Anda. Saldo akan dikirimkan maksimal 7 hari kerja setelah survey selesai.',
                    //         style: AppFonts.moreSmall
                    //             .copyWith(color: AppColor.secondColor),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        border: Border.all(
                          color: Colors.grey.withAlpha(90),
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Case ID',
                                  style: AppFonts.moreSmall,
                                ),
                              ),
                              Text(
                                prov.responseSurvey!.detail.titleTransaksi,
                                style: AppFonts.smallTextBold,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Layanan',
                                  style: AppFonts.moreSmall,
                                ),
                              ),
                              Text(
                                prov.responseSurvey!.detail.layananName
                                    .toUpperCase(),
                                style: AppFonts.smallText,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    ...prov.questions.map((q) {
                      return Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 20),
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          border: Border.all(color: Colors.grey.withAlpha(90)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(q.text, style: AppFonts.smallText),
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 15, right: 15, top: 15),
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Tidak Sama Sekali",
                                      style: TextStyle(fontSize: 12)),
                                  Text("Ragu", style: TextStyle(fontSize: 12)),
                                  Text("Sangat Mungkin",
                                      style: TextStyle(fontSize: 12)),
                                ],
                              ),
                            ),
                            SfSlider(
                              min: 1.0,
                              max: 10.0,
                              value: q.rating,
                              interval: 1,
                              stepSize: 1,
                              showLabels: true,
                              activeColor: AppColor.orange,
                              inactiveColor: AppColor.grey,
                              onChanged: (dynamic newValue) {
                                prov.updateRating(q.id, newValue);
                              },
                            ),
                            if (q.hasFreeText) ...[
                              const SizedBox(height: 15),
                              TextField(
                                maxLines: 3,
                                onChanged: (val) =>
                                    prov.updateAlasan(q.id, val),
                                decoration: const InputDecoration(
                                  hintText:
                                      "Tulis alasan Anda memilih skor ini...",
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                  ),
                                ),
                              ),
                            ]
                          ],
                        ),
                      );
                    }).toList(),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          prov.updateSurveyVersi2(
                            context,
                            prov.uniqueId,
                          );
                        },
                        child: Container(
                          //height: 40,
                          width: double.infinity,
                          padding: const EdgeInsets.only(
                            left: 15,
                            right: 15,
                            top: 8,
                            bottom: 8,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColor.secondColor,
                              width: 2,
                            ),
                            color: AppColor.secondColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(100)),
                          ),
                          child: Center(
                            child: Text(
                              'Kirim',
                              textAlign: TextAlign.center,
                              style: AppFonts.normalText.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 75),
                  ] else ...[
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/checked.png",
                            height: 75,
                          ),
                          const SizedBox(height: 15),
                          Center(
                            child: Text(
                              'Terimakasih Atas Partisipasi Anda\nSalam Montiro.id',
                              textAlign: TextAlign.center,
                              style: AppFonts.bigText,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
