import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import '../model/model_garasi.dart';
import '../provider/provider_survey.dart';
import '../shared/shared_color.dart';
import '../shared/shared_config.dart';
import '../shared/shared_font.dart';
import '../widget/widget_loading.dart';
import '../widget/widget_toolbar_main.dart';

class PageSurveyVersi extends StatefulWidget {
  const PageSurveyVersi({super.key});

  @override
  PageSurveyVersiState createState() => PageSurveyVersiState();
}

class PageSurveyVersiState extends State<PageSurveyVersi> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProviderSurvey>(context, listen: false).detail();
    });
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<ProviderSurvey>(context);
    return WillPopScope(
      onWillPop: () {
        //prov.back(context);
        return Future.value(true);
      },
      child: Scaffold(
        appBar: Config.appBarCustom,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
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
                    Expanded(
                      child: prov.isLoading
                          ? const Align(child: CustomLoading())
                          : prov.responseSurvey == null &&
                                  prov.responseGarasi == null
                              ? Align(
                                  child: Text(
                                    'Terjadi Kesalahan. Mohon Muat Ulang Halaman Ini',
                                    style: AppFonts.normalText,
                                  ),
                                )
                              : prov.responseSurvey!.detail.ratingPuas == null
                                  ? SingleChildScrollView(
                                      controller: ScrollController(),
                                      child: Container(
                                        color: Colors.white,
                                        padding: const EdgeInsets.all(16),
                                        child: Column(
                                          children: [
                                            ItemUserGarage(
                                              model: prov.responseGarasi!.data,
                                            ),
                                            Container(
                                              width: double.infinity,
                                              padding: const EdgeInsets.all(15),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(10)),
                                                border: Border.all(
                                                  color:
                                                      Colors.grey.withAlpha(90),
                                                ),
                                              ),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          'Case ID',
                                                          style: AppFonts
                                                              .moreSmall,
                                                        ),
                                                      ),
                                                      Text(
                                                        'EM-${prov.responseSurvey!.detail.idTransaksi}',
                                                        style: AppFonts
                                                            .smallTextBold,
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          'Layanan',
                                                          style: AppFonts
                                                              .moreSmall,
                                                        ),
                                                      ),
                                                      Text(
                                                        prov.responseSurvey!
                                                            .detail.layananName
                                                            .toUpperCase(),
                                                        style:
                                                            AppFonts.smallText,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 15),
                                            Container(
                                              width: double.infinity,
                                              padding: const EdgeInsets.all(15),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(10)),
                                                border: Border.all(
                                                  color:
                                                      Colors.grey.withAlpha(90),
                                                ),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Dalam skala 1 hingga 10, seberapa besar kemungkinan Anda merekomendasikan produk atau layanan kami kepada teman atau kolega?',
                                                    textAlign: TextAlign.start,
                                                    style: AppFonts.smallText,
                                                  ),
                                                  const SizedBox(height: 15),
                                                  SfSliderTheme(
                                                    data: SfSliderThemeData(
                                                      activeLabelStyle:
                                                          TextStyle(
                                                        color:
                                                            AppColor.mainColor,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      inactiveLabelStyle:
                                                          TextStyle(
                                                        color: Colors.grey[700],
                                                      ),
                                                    ),
                                                    child: SfSlider(
                                                      min: 1.0,
                                                      max: 10.0,
                                                      value: prov.ratingVersi2,
                                                      interval: 1,
                                                      stepSize: 1,
                                                      //showTicks: true,
                                                      showLabels: true,
                                                      // enableTooltip: true,
                                                      activeColor:
                                                          AppColor.orange,
                                                      inactiveColor:
                                                          AppColor.grey,
                                                      onChanged:
                                                          (dynamic newValue) {
                                                        prov.onRatingChangeVersi2(
                                                            newValue);
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                            MouseRegion(
                                              cursor: SystemMouseCursors.click,
                                              child: GestureDetector(
                                                onTap: () {
                                                  prov.updateSurveyVersi2(
                                                      context);
                                                },
                                                child: Container(
                                                  //height: 40,
                                                  width: double.infinity,
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 15,
                                                    right: 15,
                                                    top: 8,
                                                    bottom: 8,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color:
                                                          AppColor.secondColor,
                                                      width: 2,
                                                    ),
                                                    color: AppColor.secondColor,
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                100)),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      'Kirim',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: AppFonts.normalText
                                                          .copyWith(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 75),
                                          ],
                                        ),
                                      ),
                                    )
                                  : Container(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                    ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomRadioButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const CustomRadioButton({
    Key? key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          color: Colors.white,
          // margin: const EdgeInsets.only(bottom: 5),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          child: Row(
            children: [
              if (isSelected)
                ImageIcon(
                  const AssetImage("assets/on.png"),
                  size: 20,
                  color: AppColor.mainColor,
                ),
              if (!isSelected)
                const ImageIcon(
                  AssetImage("assets/off.png"),
                  size: 20,
                  color: Colors.grey,
                ),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  title,
                  style: AppFonts.smallText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ItemUserGarage extends StatelessWidget {
  final GarasiData model;
  //
  const ItemUserGarage({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.only(bottom: Config.defaultMarginSide),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(
                color: Colors.grey.withAlpha(90),
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    model.carBrandName.toUpperCase(),
                                    style: AppFonts.smallText,
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                              ],
                            ),
                            Text(
                              ("${model.modelName} ${model.varianName}")
                                  .toUpperCase(),
                              style: AppFonts.smallText,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                if (model.tahunProduksi != 0) ...[
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          model.platText,
                          style: AppFonts.smallText,
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        ("Tahun Produksi ${model.tahunProduksi}"),
                        style: AppFonts.smallText,
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
