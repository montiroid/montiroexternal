import 'package:montiro_external/service/service_date.dart';

class ResponseCases {
  ResponseCases({
    required this.status,
    required this.data,
  });

  final bool status;
  final List<CaseGroup> data;

  factory ResponseCases.fromJson(Map<String, dynamic> json) => ResponseCases(
        status: json['status'],
        data: (json['data'] as List<dynamic>)
            .map((e) => CaseGroup.fromJson(e))
            .toList(),
      );
}

class CaseGroup {
  CaseGroup({
    required this.title,
    required this.color,
    required this.data,
  });

  final String title;
  final String color;
  final List<CaseItem> data;

  factory CaseGroup.fromJson(Map<String, dynamic> json) => CaseGroup(
        title: json['title'],
        color: json['color'],
        data: (json['data'] as List<dynamic>)
            .map(
              (e) => CaseItem.fromJson(
                e,
                json['title'],
              ),
            )
            .toList(),
      );
}

class CaseItem {
  CaseItem({
    required this.id,
    required this.service,
    required this.agent,
    required this.time,
    required this.groupTitle,
    required this.done,
    required this.pt,
    required this.real_status,
    required this.created_at,
  });

  final int id;
  final int real_status;
  final String service;
  final String agent;
  final String time;
  final String done;
  final String groupTitle;
  final String pt;
  final String created_at;


  bool get isFull {
    switch (groupTitle) {
      case 'New Case':
      case 'Validated':
      case 'On The Way':
        return false;
      default:
        return true;
    }
  }

  String get sisaWaktu {
    if (real_status == 7) {
      return 'HOLD';
    }

    final start = DateTime.tryParse(time);
    if (start == null) return "-";

    Duration sla;
    switch (groupTitle) {
      case 'New Case':
        sla = const Duration(minutes: 10);
        break;
      case 'Validated':
      case 'On The Way':
        sla = const Duration(hours: 1);
        break;
      default:
        return DateHandle().formatWithHour(DateTime.parse(done));
    }

    final deadline = start.add(sla);
    final diff = DateTime.now().difference(deadline);
    final isNegative = diff.isNegative;
    final duration = isNegative ? diff.abs() : diff;

    final h = duration.inHours.toString().padLeft(2, '0');
    final m = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final s = (duration.inSeconds % 60).toString().padLeft(2, '0');

    return "${isNegative ? '' : '- '}$h:$m:$s";
  }

  bool get isNegativeWaktu {

    if (real_status == 7) {
      return false;
    }
    final start = DateTime.tryParse(time);
    if (start == null) return false;

    Duration sla;
    switch (groupTitle) {
      case 'New Case':
        sla = const Duration(minutes: 10);
        break;
      case 'Validated':
      case 'On The Way':
        sla = const Duration(hours: 1);
        break;
      default:
        return false;
    }

    final deadline = start.add(sla);
    final diff = DateTime.now().difference(deadline);
    return !diff.isNegative;
  }

  factory CaseItem.fromJson(Map<String, dynamic> json, String groupTitle) =>
      CaseItem(
        real_status : json['real_status'] ?? 0,
        id: json['id'],
        pt: json['pt'] ?? '',
        service: json['service'] ?? '',
        agent: json['agent'],
        time: json['time'],
        groupTitle: groupTitle,
        done: json['done'] ?? '',
        created_at : json['created_at'] ?? '',
      );
}
