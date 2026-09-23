class ResponseAgent {
  final bool status;
  final List<AgentData> data;

  ResponseAgent({
    required this.status,
    required this.data,
  });

  factory ResponseAgent.fromJson(Map<String, dynamic> json) {
    return ResponseAgent(
      status: json['status'] ?? false,
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => AgentData.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class AgentData {
  final String agent;
  final int countHandle;

  AgentData({
    required this.agent,
    required this.countHandle,
  });

  factory AgentData.fromJson(Map<String, dynamic> json) {
    return AgentData(
      agent: json['agent'] ?? '',
      countHandle: json['count_handle'] ?? 0,
    );
  }
}
