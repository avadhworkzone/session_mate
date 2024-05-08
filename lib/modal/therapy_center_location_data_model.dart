class TherapyCenterLocationDataModel {
  String? locationId;
  String? city;
  String? state;
  String? userId;

  TherapyCenterLocationDataModel({
    this.locationId,
    this.city,
    this.state,
    this.userId,
  });

  TherapyCenterLocationDataModel.fromJson(Map<String, dynamic> json) {
    locationId = json['locationId'] ?? "";
    city = json['city'] ?? "";
    state = json['state'] ?? "";
    userId = json['userId'] ?? "";
  }

  Map<String, dynamic> toJson() => {
        'locationId': locationId,
        'city': city,
        'state': state,
        'userId': userId,
      };
}
