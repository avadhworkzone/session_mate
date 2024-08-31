class SessionListData {
  String? id;
  String? sessionName;
  String? image;

  SessionListData({
    this.id,
    this.sessionName,
    this.image,
  });

  SessionListData.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    sessionName = json['sessionName'] ?? "";
    image = json['image'] ?? "";
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'sessionName': sessionName,
        'image': image,
      };
}
