class SessionListData {
  String? id;
  String? sessionName;

  SessionListData({
    this.id,
    this.sessionName,
  });

  SessionListData.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    sessionName = json['sessionName'] ?? "";
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'sessionName': sessionName,
      };
}
