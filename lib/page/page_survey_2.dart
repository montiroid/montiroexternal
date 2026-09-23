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
                    _buildSuccessSummary(prov),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ================================================================
  // SUMMARY SETELAH SUBMIT / SUDAH DIISI
  // ================================================================
  Widget _buildSuccessSummary(ProviderSurveyVersi2 prov) {
    final detail = prov.responseSurvey!.detail;
    final answers = detail.answers;
    final phone = detail.phoneOvo ?? '';
    final avgRating = detail.averageRating;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),

        // ===== HEADER SUKSES =====
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.green.withAlpha(120)),
          ),
          child: Column(
            children: [
              Image.asset("assets/checked.png", height: 60),
              const SizedBox(height: 12),
              Text(
                'Terimakasih Atas Partisipasi Anda',
                textAlign: TextAlign.center,
                style: AppFonts.bigText,
              ),
              const SizedBox(height: 4),
              Text(
                'Salam Montiro.id',
                textAlign: TextAlign.center,
                style: AppFonts.smallText.copyWith(color: AppColor.secondColor),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),

        // ===== INFO CASE =====
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.withAlpha(90)),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text('Case ID', style: AppFonts.moreSmall),
                  ),
                  Text(detail.titleTransaksi, style: AppFonts.smallTextBold),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text('Layanan', style: AppFonts.moreSmall),
                  ),
                  Text(
                    detail.layananName.toUpperCase(),
                    style: AppFonts.smallText,
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),

        // ===== RINGKASAN RATA-RATA =====
        if (avgRating != null)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.withAlpha(90)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Rata-rata Skor Anda',
                    style: AppFonts.smallTextBold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.orange.withAlpha(30),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${avgRating.toStringAsFixed(1)} / 10',
                        style: AppFonts.smallTextBold.copyWith(
                          color: Colors.orange.shade800,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: 15),

        // ===== DETAIL JAWABAN PER PERTANYAAN =====
        ...answers.map<Widget>((ans) {
          // Cari teks pertanyaan dari prov.questions (by id)
          final q = prov.questions.firstWhere(
            (item) => item.id == ans.questionId,
            orElse: () => SurveyQuestion(
              id: ans.questionId,
              text: 'Pertanyaan ${ans.questionId}',
            ),
          );

          return Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 15),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.withAlpha(90)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nomor + pertanyaan
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColor.orange.withAlpha(40),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '${ans.questionId}',
                        style: AppFonts.moreSmall.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(q.text, style: AppFonts.smallText),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Skor
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.orange.withAlpha(25),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Skor: ${ans.rating.toInt()} / 10',
                        style: AppFonts.moreSmall.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange.shade800,
                        ),
                      ),
                    ],
                  ),
                ),

                // Alasan (kalau ada)
                if (ans.alasan.trim().isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Text(
                    'Alasan:',
                    style: AppFonts.moreSmall.copyWith(
                      color: AppColor.secondColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Text(ans.alasan, style: AppFonts.moreSmall),
                  ),
                ],
              ],
            ),
          );
        }).toList(),

        // ===== NOMOR HP OVO/GOPAY =====
        if (phone.trim().isNotEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.withAlpha(90)),
            ),
            child: Row(
              children: [
                const Icon(Icons.phone_android, size: 18, color: Colors.grey),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Nomor HP (Ovo/Gopay)', style: AppFonts.moreSmall),
                      const SizedBox(height: 2),
                      Text(phone, style: AppFonts.smallTextBold),
                    ],
                  ),
                ),
              ],
            ),
          ),

        const SizedBox(height: 30),
      ],
    );
  }
}