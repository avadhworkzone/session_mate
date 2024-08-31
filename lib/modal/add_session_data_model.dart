class AddSessionDataModel {
  String? id;
  String? userId;
  String? sessionId;
  int? sessionSelectedDate;
  String? sessionName;
  String? therapyCenter;
  String? selectedCenterTherapistId;
  String? userName;
  int? createdAt;
  String? selectedMonth;

  AddSessionDataModel({
    this.id,
    this.userId,
    this.sessionSelectedDate,
    this.sessionName,
    this.therapyCenter,
    this.selectedCenterTherapistId,
    this.createdAt,
    this.selectedMonth,
    this.userName,
  });

  AddSessionDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    userId = json['userId'] ?? "";
    sessionId = json['session_id'] ?? "";
    sessionSelectedDate = json['session_date'] ?? "";
    sessionName = json['session_name'] ?? "";
    therapyCenter = json['therapy_center'] ?? "";
    selectedCenterTherapistId = json['selected_center_therapist_id'] ?? "";
    createdAt = json['created_at'] ?? "";
    selectedMonth = json['session_month'] ?? "";
    userName = json['userName'] ?? "";
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
        'selected_center_therapist_id': selectedCenterTherapistId,
        'userName': userName,
      };
}
