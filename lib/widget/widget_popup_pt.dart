import 'package:flutter/material.dart';
import 'package:montiro_external/model/model_keyword_layanan.dart';
import 'package:montiro_external/provider/provider_dashboard.dart';
import 'package:montiro_external/shared/shared_color.dart';
import 'package:montiro_external/shared/shared_font.dart';
import 'package:provider/provider.dart';

class WidgetPopUpPT extends StatefulWidget {
  const WidgetPopUpPT({Key? key}) : super(key: key);

  //
  @override
  WidgetPopUpPTState createState() => WidgetPopUpPTState();
}

class WidgetPopUpPTState extends State<WidgetPopUpPT> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProviderPopUpPerusahaan>(context, listen: false).load();
    });
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<ProviderPopUpPerusahaan>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Column(
            children: [
              Container(
                height: 150,
                color: Colors.transparent,
              ),
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.only(
                        left: 20,
                        bottom: 5,
                        top: 5,
                      ),
                      width: double.infinity,
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Pilih',
                              style: AppFonts.normalTextBold.copyWith(
                                color: AppColor.mainColor,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              color: Colors.transparent,
                              child: Icon(
                                Icons.close,
                                color: AppColor.mainColor,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 1,
                      color: AppColor.mainColor,
                      width: double.infinity,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: prov.data.keywordDetail.isEmpty
                    ? Container()
                    : Container(
                        color: Colors.white,
                        child: CustomScrollView(
                          slivers: [
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  return ItemPopUpPT(
                                    prov.data.keywordDetail[index],
                                    (value) {
                                      Navigator.pop(context, value);
                                    },
                                  );
                                },
                                childCount: prov.data.keywordDetail.length,
                              ),
                            )
                          ],
                        ),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ItemPopUpPT extends StatelessWidget {
  final KeywordDetail model;
  final Function onSelect;
  const ItemPopUpPT(this.model, this.onSelect, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onSelect(model);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(
            color: Colors.grey.withAlpha(90),
          ),
        ),
        child: Row(
          children: [
            Expanded(
                child: Text(
              model.name,
              style: AppFonts.normalTextBold,
            )),
          ],
        ),
      ),
    );
  }
}
