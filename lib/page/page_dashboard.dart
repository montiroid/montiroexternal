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
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth > 1200;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            // ===== HEADER =====
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, 2),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Filter Section
                  Expanded(
                    flex: 2,
                    child: Wrap(
                      spacing: 12,
                      runSpacing: 8,
                      alignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        _buildFilterDate(prov),
                        _buildFilterCompany(prov),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: AppColor.grey, width: 1.5),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'Monthly Total : ${prov.layanan.total}',
                            style: AppFonts.smallTextBold.copyWith(
                              fontSize: isLargeScreen ? 16 : 14,
                              color: AppColor.dark,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Title
                  Expanded(
                    flex: 1,
                    child: Text(
                      'Dashboard Case Monitoring'.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: AppFonts.mediumInterBoldText.copyWith(
                        color: AppColor.dark,
                        fontSize: isLargeScreen ? 22 : 18,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),

            // ===== MAIN CONTENT =====
            Expanded(
              child: Container(
                color: Colors.grey[100],
                padding: const EdgeInsets.all(8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: prov.cases.data.map((model) {
                    final color = _hexToColor(model.color);
                    final items = model.data;
                    return Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black,
                              offset: Offset(0, 2),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Header Group
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 16,
                              ),
                              decoration: BoxDecoration(
                                color: color,
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(12),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    model.title,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: isLargeScreen ? 18 : 15,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      '${model.data.length}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: isLargeScreen ? 16 : 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // List Cases
                            Expanded(
                              child: Container(
                                color: Colors.grey[50],
                                padding: const EdgeInsets.all(6),
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
                                      isLargeScreen: isLargeScreen,
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

            // ===== FOOTER =====
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, -2),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Agents
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: 40,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: prov.agents.data.length,
                        itemBuilder: (context, index) {
                          final item = prov.agents.data[index];
                          return Container(
                            margin: const EdgeInsets.only(right: 16),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.grey.shade300,
                                width: 1.5,
                              ),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  item.agent,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: isLargeScreen ? 16 : 14,
                                    color: AppColor.dark,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.blueAccent,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    item.countHandle.toString(),
                                    style: TextStyle(
                                      fontSize: isLargeScreen ? 16 : 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  // Legends
                  Expanded(
                    flex: 2,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (int i = 0;
                              i < prov.layanan.data.length;
                              i++) ...[
                            LegendItem(
                              item: prov.layanan.data[i],
                              isLargeScreen: isLargeScreen,
                            ),
                            if (i != prov.layanan.data.length - 1)
                              const SizedBox(width: 20),
                          ],
                        ],
                      ),
                    ),
                  ),
                  // Total
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColor.grey, width: 1.5),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'Total : ${prov.layanan.totalLayanan}',
                      style: AppFonts.normalTextBold.copyWith(
                        fontSize: isLargeScreen ? 20 : 16,
                        color: AppColor.dark,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===== Filter Date =====
  Widget _buildFilterDate(ProviderDashboard prov) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => prov.chooseDateStart(context),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: AppColor.grey, width: 1.5),
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.calendar_today,
                size: 18,
                color: AppColor.dark,
              ),
              const SizedBox(width: 8),
              Text(
                prov.timeStartText,
                style: AppFonts.smallText.copyWith(
                  color: AppColor.dark,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 10),
              Icon(Icons.arrow_drop_down, size: 20, color: AppColor.dark),
            ],
          ),
        ),
      ),
    );
  }

  // ===== Filter Company =====
  Widget _buildFilterCompany(ProviderDashboard prov) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => prov.getPerusahaan(context),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: AppColor.grey, width: 1.5),
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.business, size: 18, color: AppColor.dark),
              const SizedBox(width: 8),
              Text(
                prov.perusahaanText,
                style: AppFonts.smallText.copyWith(
                  color: AppColor.dark,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 10),
              Icon(Icons.arrow_drop_down, size: 20, color: AppColor.dark),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// CASE CARD
// ============================================================
class CaseCard extends StatefulWidget {
  final CaseItem item;
  final Color color;
  final String timeBlink;
  final bool isLargeScreen;

  const CaseCard({
    super.key,
    required this.item,
    required this.color,
    required this.timeBlink,
    this.isLargeScreen = false,
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
    final clean = s.startsWith('-') ? s.substring(1) : s;
    final parts = clean.split(':');
    if (parts.length != 3) return null;
    final h = int.tryParse(parts[0]) ?? 0;
    final m = int.tryParse(parts[1]) ?? 0;
    final sec = int.tryParse(parts[2]) ?? 0;
    return Duration(hours: h, minutes: m, seconds: sec);
  }

  bool get _shouldBlink {
    if (widget.item.isFull) return false;
    if (widget.item.isNegativeWaktu) return true;
    final sisaDur = _parseSisa(widget.item.sisaWaktu);
    final blinkLimit = _parseBlinkLimit(widget.timeBlink);
    if (sisaDur == null) return false;
    return sisaDur <= blinkLimit;
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final baseColor = _shouldBlink ? Colors.red : widget.color;
    final isLarge = widget.isLargeScreen;
    final fontSize = isLarge ? 16.0 : 13.0;
    final smallFontSize = isLarge ? 13.0 : 11.0;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: _shouldBlink
            ? (_blink ? baseColor.withValues(alpha: 0.12) : Colors.white)
            : baseColor.withValues(alpha: 0.08),
        border: Border.all(color: baseColor, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // === TOP ROW: Timer + Sisa Waktu ===
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // ID + Agent
              Expanded(
                child: Text(
                  '#${item.id} • ${item.agent.toUpperCase()}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize,
                    color: AppColor.dark,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // Timer Badge
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: _shouldBlink && _blink
                      ? Colors.red
                      : Colors.orange.shade700,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  item.sisaWaktu,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: smallFontSize,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),

          // === Service Name ===
          Text(
            item.service,
            style: TextStyle(
              fontSize: smallFontSize,
              fontWeight: FontWeight.w500,
              color: AppColor.dark.withValues(alpha: 0.8),
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          const SizedBox(height: 4),

          // === Bottom Row: PT + Created At ===
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // PT
              Flexible(
                child: Text(
                  item.pt.toUpperCase(),
                  style: TextStyle(
                    fontSize: smallFontSize - 1,
                    fontWeight: FontWeight.bold,
                    color: AppColor.dark.withValues(alpha: 0.6),
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              // Created At
              Text(
                '🕒 ${item.createdAt}',
                style: TextStyle(
                  fontSize: smallFontSize - 1,
                  color: AppColor.dark.withValues(alpha: 0.5),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ============================================================
// LEGEND ITEM
// ============================================================
class LegendItem extends StatelessWidget {
  const LegendItem({super.key, required this.item, this.isLargeScreen = false});

  final LayananItem item;
  final bool isLargeScreen;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: isLargeScreen ? 18 : 14,
          height: isLargeScreen ? 18 : 14,
          decoration: const BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '${item.title} (${item.count})',
          style: AppFonts.smallText.copyWith(
            color: AppColor.dark,
            fontSize: isLargeScreen ? 15 : 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
