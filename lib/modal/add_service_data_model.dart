class AddSessionDataModel {
  String? id;
  String? userId;
  String? sessionId;
  String? sessionSelectedDate;
  String? sessionName;

  AddSessionDataModel({
    this.id,
    this.userId,
    this.sessionSelectedDate,
    this.sessionName,
  });

  AddSessionDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    userId = json['userId'] ?? "";
    sessionId = json['sessionId'] ?? "";
    sessionSelectedDate = json['session_date'] ?? "";
    sessionName = json['session_name'] ?? "";
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'sessionId': sessionId,
        'session_date': sessionSelectedDate,
        'session_name': sessionName,
      };
}
