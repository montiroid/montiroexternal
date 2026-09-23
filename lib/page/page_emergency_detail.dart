import 'package:flutter/material.dart';
import 'package:montiro_external/shared/shared_config.dart';
import 'package:provider/provider.dart';
import 'package:timelines/timelines.dart';
import '../provider/provider_emergency_detail.dart';
import '../shared/shared_color.dart';
import '../shared/shared_font.dart';
import '../widget/widget_loading.dart';
import '../widget/widget_toolbar_main.dart';

class PageEmergencyDetail extends StatefulWidget {
  const PageEmergencyDetail({super.key});

  @override
  PageEmergencyDetailState createState() => PageEmergencyDetailState();
}

class PageEmergencyDetailState extends State<PageEmergencyDetail> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProviderEmergencyDetail>(context, listen: false).detail();
    });
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<ProviderEmergencyDetail>(context);
    return WillPopScope(
      onWillPop: () {
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
                      title: 'Detail Emergency Service',
                      onRefresh: () {
                        prov.detail();
                      },
                    ),
                    Expanded(
                      child: prov.isLoading
                          ? const Align(child: CustomLoading())
                          : prov.responseEmergencyDetail == null
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
                                      // Info Mitra/Montir
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
                                              if (prov.model!.mitra_image
                                                      .isNotEmpty ||
                                                  prov.model!.mitra_nama
                                                      .isNotEmpty)
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    if (prov.model!.mitra_nama
                                                        .isNotEmpty)
                                                      Expanded(
                                                        child: SizedBox(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                'Mitra ${prov.model!.mitra_nama}',
                                                                style: AppFonts
                                                                    .normalTextBold,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                              if (prov.model!.mitra_nama
                                                      .isNotEmpty ||
                                                  prov.model!.mitra_image
                                                      .isNotEmpty)
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                              // Alamat
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
                                              // Kendaraan
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
                                                          prov.model!.car
                                                              .toUpperCase(),
                                                          style: AppFonts
                                                              .normalText,
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        if (prov.model!.noPolisi
                                                            .isNotEmpty)
                                                          Text(
                                                            prov.model!
                                                                .noPolisi,
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
                                              // Keluhan
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
                                              // Tanggal
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
                                                          prov.model!.date,
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
                                              // Layanan
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .miscellaneous_services,
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
                                                          prov.model!
                                                              .layananName,
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
                                             
                                            ],
                                          ),
                                        ),
                                      ),
                                      // Ulasan
                                      if (prov.model!.ulasan.isNotEmpty ||
                                          prov.model!.rating > 0)
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
                                              prov.model!.ulasan.isEmpty
                                                  ? Container()
                                                  : SizedBox(
                                                      width: double.infinity,
                                                      child: Text(
                                                        prov.model!.ulasan,
                                                        style:
                                                            AppFonts.smallText,
                                                      ),
                                                    ),
                                              prov.model!.rating == 0
                                                  ? Container()
                                                  : Column(children: [
                                                      const SizedBox(
                                                        height: 15,
                                                      ),
                                                      SizedBox(
                                                        width: double.infinity,
                                                        child: Text(
                                                          'Rating: ${prov.model!.rating}%',
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
                                      // Status Timeline
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
                                                    .filteredEmergencyStatus
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
                                                              .filteredEmergencyStatus[
                                                                  index]
                                                              .statusText,
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
                                                                    .filteredEmergencyStatus[
                                                                        index]
                                                                    .date,
                                                                style: AppFonts
                                                                    .smallTextGrey,
                                                              ),
                                                            ),
                                                            if (prov.model!
                                                                    .status ==
                                                                8)
                                                              if (prov.model!
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
                                                            prov.model!
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
                    // // Tombol Aksi
                    // if (prov.model != null)
                    //   if (prov.model!.status == 4 || prov.model!.status == 6)
                    //     Container(
                    //       decoration: const BoxDecoration(
                    //           boxShadow: <BoxShadow>[
                    //             BoxShadow(
                    //                 color: Colors.black54,
                    //                 blurRadius: 5.0,
                    //                 offset: Offset(0.0, 0.75))
                    //           ],
                    //           color: Colors.white),
                    //       padding: const EdgeInsets.only(
                    //         top: Config.defaultMarginSide,
                    //         bottom: Config.defaultMarginSide,
                    //         left: Config.defaultMarginSide,
                    //         right: Config.defaultMarginSide,
                    //       ),
                    //       child: Column(
                    //         children: [
                    //           Container(
                    //             margin: const EdgeInsets.only(
                    //               left: 15,
                    //               right: 15,
                    //             ),
                    //             child: Column(
                    //               mainAxisAlignment: MainAxisAlignment.start,
                    //               crossAxisAlignment: CrossAxisAlignment.start,
                    //               children: [
                    //                 GestureDetector(
                    //                   onTap: () {
                    //                     if (prov.model!.status == 4) {
                    //                       prov.qrCode(context);
                    //                     } else {
                    //                       prov.getInspeksiReport(context);
                    //                     }
                    //                   },
                    //                   child: Container(
                    //                     width: double.infinity,
                    //                     padding: const EdgeInsets.only(
                    //                       left: 15,
                    //                       right: 15,
                    //                       top: 8,
                    //                       bottom: 8,
                    //                     ),
                    //                     decoration: BoxDecoration(
                    //                       border: Border.all(
                    //                         color: AppColor.orange,
                    //                         width: 2,
                    //                       ),
                    //                       color: AppColor.orange,
                    //                       borderRadius: const BorderRadius.all(
                    //                           Radius.circular(5)),
                    //                     ),
                    //                     child: Center(
                    //                       child: Text(
                    //                         prov.model!.status == 4
                    //                             ? 'Show Qr Code\nKonfirmasi Kedatangan Mitra'
                    //                             : 'Lihat Hasil Inspeksi',
                    //                         textAlign: TextAlign.center,
                    //                         style: AppFonts.normalText.copyWith(
                    //                           color: Colors.white,
                    //                         ),
                    //                       ),
                    //                     ),
                    //                   ),
                    //                 ),
                    //                 // Tombol Hubungi Mitra
                    //                 if (prov.model!.mitra_phone.isNotEmpty &&
                    //                     prov.model!.mitra_phone != "0")
                    //                   const SizedBox(height: 10),
                    //                 if (prov.model!.mitra_phone.isNotEmpty &&
                    //                     prov.model!.mitra_phone != "0")
                    //                   GestureDetector(
                    //                     onTap: () {
                    //                       prov.contactMitra(context);
                    //                     },
                    //                     child: Container(
                    //                       width: double.infinity,
                    //                       padding: const EdgeInsets.only(
                    //                         left: 15,
                    //                         right: 15,
                    //                         top: 8,
                    //                         bottom: 8,
                    //                       ),
                    //                       decoration: BoxDecoration(
                    //                         border: Border.all(
                    //                           color: AppColor.mainColor,
                    //                           width: 2,
                    //                         ),
                    //                         color: Colors.white,
                    //                         borderRadius:
                    //                             const BorderRadius.all(
                    //                                 Radius.circular(5)),
                    //                       ),
                    //                       child: Center(
                    //                         child: Text(
                    //                           'Hubungi Mitra',
                    //                           textAlign: TextAlign.center,
                    //                           style:
                    //                               AppFonts.normalText.copyWith(
                    //                             color: AppColor.mainColor,
                    //                           ),
                    //                         ),
                    //                       ),
                    //                     ),
                    //                   ),
                    //               ],
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                  
                  
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
