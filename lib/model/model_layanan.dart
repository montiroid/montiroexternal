class ResponseLayanan {
  final bool status;
  final List<LayananItem> data;
  final int total;

  int get totalLayanan {
    return data.fold(0, (total, item) => total + item.count);
  }

  ResponseLayanan({
    required this.status,
    required this.data,
    required this.total,
  });

  factory ResponseLayanan.fromJson(Map<String, dynamic> json) {
    return ResponseLayanan(
      total : json['total_bulan_berjalan'] ?? 0,
      status: json['status'] as bool,
      data: (json['data'] as List<dynamic>)
          .map((item) => LayananItem.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data.map((item) => item.toJson()).toList(),
    };
  }
}

class LayananItem {
  final String title;
  final int count;

  LayananItem({
    required this.title,
    required this.count,
  });

  factory LayananItem.fromJson(Map<String, dynamic> json) {
    return LayananItem(
      title: json['title'] as String,
      count: json['count'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'count': count,
    };
  }
}
