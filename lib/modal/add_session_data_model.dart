class AddSessionDataModel {
  String? id;
  String? userId;
  String? sessionId;
  int? sessionSelectedDate;
  String? sessionName;
  String? therapyCenter;
  int? createdAt;
  String? selectedMonth;

  AddSessionDataModel({
    this.id,
    this.userId,
    this.sessionSelectedDate,
    this.sessionName,
    this.therapyCenter,
    this.createdAt,
    this.selectedMonth,
  });

  AddSessionDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    userId = json['userId'] ?? "";
    sessionId = json['session_id'] ?? "";
    sessionSelectedDate = json['session_date'] ?? "";
    sessionName = json['session_name'] ?? "";
    therapyCenter = json['therapy_center'] ?? "";
    createdAt = json['created_at'] ?? "";
    selectedMonth = json['session_month'] ?? "";
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'session_id': sessionId,
        'session_date': sessionSelectedDate,
        'session_name': sessionName,
        'therapy_center': therapyCenter,
        'created_at': createdAt,
        'session_month': selectedMonth,
      };
}
