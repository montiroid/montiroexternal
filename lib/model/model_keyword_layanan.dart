class ResponseKeywordDetail {
  bool status;
  List<KeywordDetail> keywordDetail;

  ResponseKeywordDetail({
    required this.status,
    required this.keywordDetail,
  });

  factory ResponseKeywordDetail.fromJson(Map<String, dynamic> json) =>
      ResponseKeywordDetail(
        status: json["status"],
        keywordDetail: List<KeywordDetail>.from(
            json["data"].map((x) => KeywordDetail.fromJson(x))),
      );
}

class KeywordDetail {
  int id;
  String name;

  KeywordDetail({
    required this.id,
    required this.name,
  });

  factory KeywordDetail.fromJson(Map<String, dynamic> json) => KeywordDetail(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
