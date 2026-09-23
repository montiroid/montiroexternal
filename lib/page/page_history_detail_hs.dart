import 'package:flutter/material.dart';
import 'package:montiro_external/shared/shared_config.dart';
import 'package:provider/provider.dart';
import 'package:timelines/timelines.dart';
import '../provider/provider_history_detail_hs.dart';
import '../shared/shared_color.dart';
import '../shared/shared_font.dart';
import '../widget/widget_loading.dart';
import '../widget/widget_toolbar_main.dart';

class PageUserHomeServiceDetail extends StatefulWidget {
  const PageUserHomeServiceDetail({super.key});

  @override
  PageUserHomeServiceDetailState createState() =>
      PageUserHomeServiceDetailState();
}

class PageUserHomeServiceDetailState extends State<PageUserHomeServiceDetail> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProviderHomeServiceHistoryDetail>(context, listen: false)
          .detail();
    });
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<ProviderHomeServiceHistoryDetail>(context);
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
                      title: 'Detail Home Service',
                      onRefresh: () {
                        prov.detail();
                      },
                    ),
                    Expanded(
                      child: prov.isLoading
                          ? const Align(child: CustomLoading())
                          : prov.responseHomeServiceDetail == null
                              ? Align(
                                  child: Text(
                                    'Terjadi Kesalahan. Mohon Muat Ulang Halaman Ini',
                                    style: AppFonts.normalText,
                                  ),
                                )
                              : SingleChildScrollView(
                                  controller: ScrollController(),
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: Config.defaultMarginSide,
                                            right: Config.defaultMarginSide,
                                            top: Config.defaultMarginSide),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          border: Border.all(
                                            color: Colors.grey.withAlpha(90),
                                          ),
                                        ),
                                        child: Container(
                                          padding: const EdgeInsets.all(15),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: AppResponsive
                                                            .isDesktop(context)
                                                        ? 100
                                                        : MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            6,
                                                    height: AppResponsive
                                                            .isDesktop(context)
                                                        ? 100
                                                        : MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            6,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        topRight:
                                                            Radius.circular(5),
                                                        topLeft:
                                                            Radius.circular(5),
                                                        bottomLeft:
                                                            Radius.circular(5),
                                                        bottomRight:
                                                            Radius.circular(5),
                                                      ),
                                                      child: LoadImageWithURL(
                                                        url: prov
                                                            .model!.montirImage,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 15,
                                                  ),
                                                  Expanded(
                                                    child: SizedBox(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            prov.model!
                                                                .montirName,
                                                            style: AppFonts
                                                                .normalTextBold,
                                                          ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                  left: 5,
                                                                  right: 5,
                                                                  top: 5,
                                                                  bottom: 5,
                                                                ),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      const BorderRadius
                                                                              .all(
                                                                          Radius.circular(
                                                                              5)),
                                                                  border: Border
                                                                      .all(
                                                                    color: AppColor
                                                                        .mainColor,
                                                                  ),
                                                                ),
                                                                child: Row(
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .work,
                                                                      size: 15,
                                                                      color: AppColor
                                                                          .secondColor,
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    Text(
                                                                      prov.model!
                                                                          .tahun,
                                                                      style: AppFonts
                                                                          .smallText
                                                                          .copyWith(
                                                                        color: AppColor
                                                                            .secondColor,
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                width: 10,
                                                              ),
                                                              Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                  left: 5,
                                                                  right: 5,
                                                                  top: 5,
                                                                  bottom: 5,
                                                                ),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      const BorderRadius
                                                                              .all(
                                                                          Radius.circular(
                                                                              5)),
                                                                  border: Border
                                                                      .all(
                                                                    color: AppColor
                                                                        .mainColor,
                                                                  ),
                                                                ),
                                                                child: Row(
                                                                  children: [
                                                                    ImageIcon(
                                                                      const AssetImage(
                                                                          "assets/ic_like.png"),
                                                                      size: 15,
                                                                      color: AppColor
                                                                          .secondColor,
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    Text(
                                                                      prov.model!
                                                                          .rate,
                                                                      style: AppFonts
                                                                          .smallText
                                                                          .copyWith(
                                                                        color: AppColor
                                                                            .secondColor,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                      left: 3,
                                                      right: 3,
                                                      top: 4,
                                                    ),
                                                    width: 18,
                                                    height: 18,
                                                    child: Image.asset(
                                                        "assets/icon_location.png"),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          prov.model!
                                                              .custAddress,
                                                          style: AppFonts
                                                              .normalText,
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          "Catatan : ${prov.model!.custAddressNote}",
                                                          style: AppFonts
                                                              .smallTextGrey,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Icon(
                                                    Icons.car_repair_sharp,
                                                    size: 20,
                                                    color: AppColor.mainColor,
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          prov.model!.mobil
                                                              .toUpperCase(),
                                                          style: AppFonts
                                                              .normalText,
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          "${prov.model!.kmText} Km",
                                                          style: AppFonts
                                                              .smallTextGrey,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Icon(
                                                    Icons.sync_problem,
                                                    size: 20,
                                                    color: AppColor.mainColor,
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          prov.model!.keluhan,
                                                          style: AppFonts
                                                              .normalText,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Icon(
                                                    Icons.date_range_sharp,
                                                    size: 20,
                                                    color: AppColor.mainColor,
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          prov.model!.tanggal,
                                                          style: AppFonts
                                                              .normalText,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(15),
                                        margin: const EdgeInsets.only(
                                          top: Config.defaultMarginSide,
                                          left: Config.defaultMarginSide,
                                          right: Config.defaultMarginSide,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          border: Border.all(
                                            color: Colors.grey.withAlpha(90),
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            ListView.builder(
                                              shrinkWrap: true,
                                              controller: ScrollController(),
                                              itemCount: prov
                                                  .responseHomeServiceDetail!
                                                  .homeServiceDetail
                                                  .homeserviceBookDetail
                                                  .length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return ItemDetail(
                                                  prov
                                                      .responseHomeServiceDetail!
                                                      .homeServiceDetail
                                                      .homeserviceBookDetail[
                                                          index]
                                                      .title,
                                                  prov
                                                      .responseHomeServiceDetail!
                                                      .homeServiceDetail
                                                      .homeserviceBookDetail[
                                                          index]
                                                      .price,
                                                );
                                              },
                                            ),
                                            if (prov.responseHomeServiceDetail!
                                                    .homeServiceDetail.total !=
                                                "Rp 0")
                                              const SizedBox(height: 15),
                                            if (prov.responseHomeServiceDetail!
                                                    .homeServiceDetail.total !=
                                                "Rp 0")
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      'Total Estimasi',
                                                      style: AppFonts
                                                          .normalTextBold,
                                                    ),
                                                  ),
                                                  Text(
                                                    prov
                                                        .responseHomeServiceDetail!
                                                        .homeServiceDetail
                                                        .total,
                                                    style: AppFonts
                                                        .normalTextBold
                                                        .copyWith(
                                                      color: AppColor.orange,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                          ],
                                        ),
                                      ),
                                      if (prov.responseHomeServiceDetail!
                                                  .homeServiceDetail.isPuas !=
                                              null ||
                                          prov.responseHomeServiceDetail!
                                                  .homeServiceDetail.ulasan !=
                                              "")
                                        Container(
                                          width: double.infinity,
                                          margin: const EdgeInsets.only(
                                            top: Config.defaultMarginSide,
                                            left: Config.defaultMarginSide,
                                            right: Config.defaultMarginSide,
                                          ),
                                          padding: const EdgeInsets.only(
                                            left: 15,
                                            right: 15,
                                            top: 10,
                                            bottom: 10,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10)),
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
                                                      'Ulasan Anda',
                                                      style: AppFonts.moreSmall,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              prov
                                                          .responseHomeServiceDetail!
                                                          .homeServiceDetail
                                                          .ulasan ==
                                                      ""
                                                  ? Container()
                                                  : SizedBox(
                                                      width: double.infinity,
                                                      child: Text(
                                                        prov
                                                            .responseHomeServiceDetail!
                                                            .homeServiceDetail
                                                            .ulasan,
                                                        style:
                                                            AppFonts.smallText,
                                                      ),
                                                    ),
                                              prov
                                                          .responseHomeServiceDetail!
                                                          .homeServiceDetail
                                                          .isPuas ==
                                                      null
                                                  ? Container()
                                                  : Column(children: [
                                                      const SizedBox(
                                                        height: 15,
                                                      ),
                                                      SizedBox(
                                                        width: double.infinity,
                                                        child: Text(
                                                          prov
                                                                      .responseHomeServiceDetail!
                                                                      .homeServiceDetail
                                                                      .isPuas ==
                                                                  1
                                                              ? 'PUAS'
                                                              : 'TIDAK PUAS',
                                                          textAlign:
                                                              TextAlign.end,
                                                          style: AppFonts
                                                              .smallTextBold,
                                                        ),
                                                      ),
                                                    ])
                                            ],
                                          ),
                                        ),
                                      Container(
                                        padding: const EdgeInsets.only(
                                          top: Config.defaultMarginSide,
                                          left: Config.defaultMarginSide,
                                          right: Config.defaultMarginSide,
                                        ),
                                        margin: const EdgeInsets.only(
                                          top: Config.defaultMarginSide,
                                          left: Config.defaultMarginSide,
                                          right: Config.defaultMarginSide,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          border: Border.all(
                                            color: Colors.grey.withAlpha(90),
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Status Detail',
                                              style: AppFonts.bigText,
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            FixedTimeline.tileBuilder(
                                              theme: TimelineThemeData(
                                                nodePosition: 0,
                                                color: const Color.fromARGB(
                                                    255, 11, 7, 7),
                                                indicatorTheme:
                                                    const IndicatorThemeData(
                                                  position: 0,
                                                  size: 20.0,
                                                ),
                                                connectorTheme:
                                                    const ConnectorThemeData(
                                                  thickness: 2.5,
                                                ),
                                              ),
                                              builder:
                                                  TimelineTileBuilder.connected(
                                                connectionDirection:
                                                    ConnectionDirection.before,
                                                itemCount: prov
                                                    .responseHomeServiceDetail!
                                                    .homeServiceDetail
                                                    .homeserviceStatusDetail
                                                    .length,
                                                contentsBuilder: (_, index) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 15.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                          prov
                                                              .responseHomeServiceDetail!
                                                              .homeServiceDetail
                                                              .homeserviceStatusDetail[
                                                                  index]
                                                              .title,
                                                          style: AppFonts
                                                              .normalText,
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                prov
                                                                    .responseHomeServiceDetail!
                                                                    .homeServiceDetail
                                                                    .homeserviceStatusDetail[
                                                                        index]
                                                                    .tanggal,
                                                                style: AppFonts
                                                                    .smallTextGrey,
                                                              ),
                                                            ),
                                                            if (prov
                                                                    .responseHomeServiceDetail!
                                                                    .homeServiceDetail
                                                                    .homeserviceStatusDetail[
                                                                        index]
                                                                    .status ==
                                                                6)
                                                              GestureDetector(
                                                                onTap: () {
                                                                  prov.getInspeksiReport(
                                                                      context);
                                                                },
                                                                child:
                                                                    Container(
                                                                  margin: const EdgeInsets
                                                                          .only(
                                                                      left: 10),
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                    left: 15,
                                                                    right: 15,
                                                                    top: 3,
                                                                    bottom: 3,
                                                                  ),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      width: 2,
                                                                      color: Colors
                                                                          .grey,
                                                                    ),
                                                                    color: AppColor
                                                                        .orange,
                                                                    borderRadius:
                                                                        const BorderRadius
                                                                            .all(
                                                                      Radius
                                                                          .circular(
                                                                        5,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  child: Text(
                                                                    "Lihat Hasil",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: AppFonts
                                                                        .smallText
                                                                        .copyWith(
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            if (prov
                                                                    .responseHomeServiceDetail!
                                                                    .homeServiceDetail
                                                                    .homeserviceStatusDetail[
                                                                        index]
                                                                    .status ==
                                                                8)
                                                              if (prov
                                                                      .responseHomeServiceDetail!
                                                                      .homeServiceDetail
                                                                      .receipt !=
                                                                  "")
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    prov.detailImage(
                                                                        context);
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    margin: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            10),
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .only(
                                                                      left: 15,
                                                                      right: 15,
                                                                      top: 3,
                                                                      bottom: 3,
                                                                    ),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        width:
                                                                            2,
                                                                        color: Colors
                                                                            .grey,
                                                                      ),
                                                                      color: AppColor
                                                                          .orange,
                                                                      borderRadius:
                                                                          const BorderRadius
                                                                              .all(
                                                                        Radius
                                                                            .circular(
                                                                          5,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    child: Text(
                                                                      "Lihat Invoice",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: AppFonts
                                                                          .smallText
                                                                          .copyWith(
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 20,
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                                indicatorBuilder: (_, index) {
                                                  return DotIndicator(
                                                    color: index == 0 &&
                                                            prov
                                                                    .responseHomeServiceDetail!
                                                                    .homeServiceDetail
                                                                    .homeserviceStatusDetail[
                                                                        index]
                                                                    .status !=
                                                                8
                                                        ? const Color(
                                                            0xff66c97f)
                                                        : Colors.grey
                                                            .withAlpha(90),
                                                    child: const Icon(
                                                      Icons.check,
                                                      color: Colors.white,
                                                      size: 12.0,
                                                    ),
                                                  );
                                                },
                                                connectorBuilder:
                                                    (_, index, ___) =>
                                                        SolidLineConnector(
                                                  color:
                                                      Colors.grey.withAlpha(90),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 75),
                                    ],
                                  ),
                                ),
                    ),
                    if (prov.model != null)
                      if (prov.model!.status == 4 || prov.model!.status == 6)
                        Container(
                          decoration: const BoxDecoration(
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Colors.black54,
                                    blurRadius: 5.0,
                                    offset: Offset(0.0, 0.75))
                              ],
                              color: Colors.white),
                          padding: const EdgeInsets.only(
                            top: Config.defaultMarginSide,
                            bottom: Config.defaultMarginSide,
                            left: Config.defaultMarginSide,
                            right: Config.defaultMarginSide,
                          ),
                          child: Column(
                            children: [
                              // const SizedBox(height: 20),
                              Container(
                                margin: const EdgeInsets.only(
                                  left: 15,
                                  right: 15,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        if (prov.model!.status == 4) {
                                          prov.qrCode(context);
                                        } else {
                                          prov.getInspeksiReport(context);
                                        }
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
                                            color: AppColor.orange,
                                            width: 2,
                                          ),
                                          color: AppColor.orange,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(5)),
                                        ),
                                        child: Center(
                                          child: Text(
                                            prov.model!.status == 4
                                                ? 'Show Qr Code\nKonfirmasi Kedatangan Montir'
                                                : 'Lihat Hasil Inspeksi',
                                            textAlign: TextAlign.center,
                                            style: AppFonts.normalText.copyWith(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
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

class ItemDetail extends StatelessWidget {
  final String title;
  final String price;

  const ItemDetail(this.title, this.price, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            // border: Border.all(
            //   color: AppColor.grey,
            //   width: 1,
            // ),
            // borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 10,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                title,
                                style: AppFonts.normalText,
                              ),
                            ),
                          ],
                        ),
                        if (price != "Rp 0") const SizedBox(height: 3),
                        if (price != "Rp 0")
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Harga",
                                  style: AppFonts.normalText.copyWith(
                                    color: AppColor.grey,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(price, style: AppFonts.normalText),
                            ],
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          height: 1,
          color: AppColor.grey,
        )
      ],
    );
  }
}
