import 'dart:async';

import 'package:flutter/material.dart';
import 'package:montiro_external/model/model_cases.dart';
import 'package:montiro_external/model/model_layanan.dart';
import 'package:montiro_external/provider/provider_dashboard.dart';
import 'package:montiro_external/shared/shared_color.dart';
import 'package:montiro_external/shared/shared_font.dart';
import 'package:provider/provider.dart';

class PageDashboard extends StatefulWidget {
  const PageDashboard({super.key});

  @override
  PageDashboardState createState() => PageDashboardState();
}

class PageDashboardState extends State<PageDashboard> {
  //
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<ProviderDashboard>(context, listen: false);
      provider.loadData();
      provider.startAutoReload();
    });
  }

  @override
  void dispose() {
    Provider.of<ProviderDashboard>(context, listen: false).dispose();
    super.dispose();
  }

  Color _hexToColor(String hex) =>
      Color(int.parse('FF${hex.replaceAll('#', '')}', radix: 16));

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<ProviderDashboard>(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              // margin: EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFF6F6F6),
                borderRadius:
                    BorderRadius.circular(12), // opsional, untuk efek halus
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, 4),
                    blurRadius: 8,
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        SizedBox(
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                prov.chooseDateStart(context);
                              },
                              child: Container(
                                height: 25,
                                padding: const EdgeInsets.only(
                                  left: 8,
                                  right: 8,
                                  // top : 5,
                                  // bottom : 5,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColor.grey,
                                    width: 1,
                                  ),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Row(
                                    children: [
                                      Text(
                                        prov.timeStartText,
                                        maxLines: 1,
                                        style: AppFonts.smallText.copyWith(
                                          color: AppColor.dark,
                                          fontSize: 11,
                                        ),
                                      ),
                                      const SizedBox(width: 15),
                                      Image.asset(
                                        "assets/ic_panah.png",
                                        height: 15,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        SizedBox(
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                prov.getPerusahaan(context);
                              },
                              child: Container(
                                height: 25,
                                padding: const EdgeInsets.only(
                                  left: 8,
                                  right: 8,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColor.grey,
                                    width: 1,
                                  ),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Row(
                                    children: [
                                      Text(
                                        prov.perusahaanText,
                                        maxLines: 1,
                                        style: AppFonts.smallText.copyWith(
                                          color: AppColor.dark,
                                          fontSize: 11,
                                        ),
                                      ),
                                      const SizedBox(width: 15),
                                      Image.asset(
                                        "assets/ic_panah.png",
                                        height: 15,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Monthly Total  : ${prov.layanan.total}',
                          maxLines: 1,
                          style: AppFonts.smallTextBold.copyWith(
                            color: AppColor.dark,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    'Dashboard Case Monitoring'.toUpperCase(),
                    maxLines: 1,
                    style: AppFonts.mediumInterBoldText.copyWith(
                      color: AppColor.dark,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                //margin: EdgeInsets.only(top: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: prov.cases.data.map((model) {
                    final color = _hexToColor(model.color);
                    final items = model.data;
                    return Expanded(
                      child: Container(
                        color: Colors.black,
                        padding:
                            const EdgeInsets.only(left: 4, right: 4, top: 4),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              color: color,
                              child: Center(
                                child: Text(
                                  '${model.title} (${model.data.length})',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Expanded(
                              child: Container(
                                color: Colors.grey[100],
                                child: ListView.builder(
                                  itemCount: items.length,
                                  itemBuilder: (context, index) {
                                    final item = items[index];
                                    return CaseCard(
                                      item: item,
                                      color: color,
                                      timeBlink: model.title == "New Case"
                                          ? "05:00"
                                          : model.title == "Validated"
                                              ? "10:00"
                                              : "00:00",
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: const BoxDecoration(
                color: Color(0xFFF6F6F6),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, -2),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 30,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: prov.agents.data.length,
                        itemBuilder: (context, index) {
                          final item = prov.agents.data[index];
                          return Container(
                            margin: const EdgeInsets.only(right: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 6,
                                  offset: Offset(0, 3),
                                ),
                              ],
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(width: 15),
                                Text(
                                  item.agent,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  item.countHandle.toString(),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                const SizedBox(width: 15),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      reverse: true, // Bisa juga dipakai untuk membalik scroll
                      child: Row(
                        textDirection: TextDirection.rtl, // ini yang penting
                        children: [
                          for (int i = 0;
                              i < prov.layanan.data.length;
                              i++) ...[
                            LegendItem(item: prov.layanan.data[i]),
                            if (i != prov.layanan.data.length - 1)
                              const SizedBox(width: 20),
                          ],
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    height: 30,
                    width: 2,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Total : ${prov.layanan.totalLayanan}',
                    style: AppFonts.normalTextBold.copyWith(
                      fontSize: 18,
                      color: AppColor.dark,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CaseCard extends StatefulWidget {
  final CaseItem item;
  final Color color;
  final String timeBlink;

  const CaseCard({
    super.key,
    required this.item,
    required this.color,
    required this.timeBlink,
  });

  @override
  State<CaseCard> createState() => _CaseCardState();
}

class _CaseCardState extends State<CaseCard> {
  late Timer _t;
  bool _blink = true;

  @override
  void initState() {
    super.initState();
    _t = Timer.periodic(const Duration(milliseconds: 500), (_) {
      _blink = !_blink;
      setState(() {});
    });
  }

  @override
  void dispose() {
    _t.cancel();
    super.dispose();
  }

  // ---------- helper ----------
  Duration _parseBlinkLimit(String str) {
    final parts = str.split(':');
    if (parts.length == 2) {
      final m = int.tryParse(parts[0]) ?? 0;
      final s = int.tryParse(parts[1]) ?? 0;
      return Duration(minutes: m, seconds: s);
    } else if (parts.length == 3) {
      final h = int.tryParse(parts[0]) ?? 0;
      final m = int.tryParse(parts[1]) ?? 0;
      final s = int.tryParse(parts[2]) ?? 0;
      return Duration(hours: h, minutes: m, seconds: s);
    }
    return Duration.zero;
  }

  Duration? _parseSisa(String s) {
    // Terima "-HH:MM:SS" atau "HH:MM:SS"
    final clean = s.startsWith('-') ? s.substring(1) : s;
    final parts = clean.split(':');
    if (parts.length != 3) return null;
    final h = int.tryParse(parts[0]) ?? 0;
    final m = int.tryParse(parts[1]) ?? 0;
    final sec = int.tryParse(parts[2]) ?? 0;
    return Duration(hours: h, minutes: m, seconds: sec);
  }

  bool get _shouldBlink {
    // Tidak berkedip jika case penuh
    if (widget.item.isFull) return false;

    // Kedip kalau sudah minus
    if (widget.item.isNegativeWaktu) return true;

    // Kedip kalau sisa <= timeBlink
    final sisaDur = _parseSisa(widget.item.sisaWaktu);
    final blinkLimit = _parseBlinkLimit(widget.timeBlink);
    if (sisaDur == null) return false;
    return sisaDur <= blinkLimit;
  }

  String _formatCreatedAt(String raw) {
    try {
      final dt = DateTime.parse(raw);
      final day = dt.day.toString().padLeft(2, '0');
      final month = dt.month.toString().padLeft(2, '0');
      final year = dt.year.toString().substring(2); // ambil 2 digit terakhir
      final hour = dt.hour.toString().padLeft(2, '0');
      final minute = dt.minute.toString().padLeft(2, '0');
      return '$day-$month-$year, $hour:$minute';
    } catch (_) {
      return '-';
    }
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final baseColor = _shouldBlink ? Colors.red : widget.color;

    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: _shouldBlink
            ? (_blink ? baseColor.withValues(alpha: 0.15) : Colors.transparent)
            : baseColor.withValues(alpha: 0.15),
        border: Border.all(color: baseColor, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // created_at (kiri) + timer badge (kanan)
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '🕒 ${_formatCreatedAt(item.created_at)}',
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    item.sisaWaktu,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 3),

            // id + agent
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${item.id} - ${item.agent.toUpperCase()}',
                    maxLines: 1,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 3),

            // service
            Text(
              item.service,
              maxLines: 1,
              style: const TextStyle(fontSize: 11),
            ),
            const SizedBox(height: 3),

            // pt
            Text(
              item.pt.toUpperCase(),
              maxLines: 1,
              style: const TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LegendItem extends StatelessWidget {
  const LegendItem({super.key, required this.item});

  final LayananItem item;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 15,
          height: 15,
          decoration: const BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          '${item.title} (${item.count})',
          style: AppFonts.smallText.copyWith(color: AppColor.dark),
        ),
      ],
    );
  }
}
