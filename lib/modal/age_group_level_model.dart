class AgeGroupLevelModel {
  String? id;
  String? level;
  String? sessionId;

  AgeGroupLevelModel({
    this.id,
    this.level,
    this.sessionId,
  });

  AgeGroupLevelModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    level = json['level'] ?? "";
    sessionId = json['sessionId'] ?? "";
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'level': level,
        'sessionId': sessionId,
      };
}
