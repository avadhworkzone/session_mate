class AddSessionDataModel {
  String? userId;
  String? sessionId;
  String? sessionSelectedDate;
  String? sessionName;

  AddSessionDataModel({
    this.userId,
    this.sessionSelectedDate,
    this.sessionName,
  });

  AddSessionDataModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'] ?? "";
    sessionId = json['sessionId'] ?? "";
    sessionSelectedDate = json['session_date'] ?? "";
    sessionName = json['session_name'] ?? "";
  }

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'sessionId': sessionId,
        'session_date': sessionSelectedDate,
        'session_name': sessionName,
      };
}
