<<<<<<< Updated upstream
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
=======
class TherapyCenterLocationDataModel {
  String? locationId;
  String? city;
  String? state;
  String? userId;
  String? therapyCenterCode;
  String? lattitude;
  String? longitude;
  String? country;
  String? flatHouseNo;
  String? areaStreet;
  String? landmark;
  String? locationUniqueCode;
  String? pincode;

  TherapyCenterLocationDataModel({
    this.locationId,
    this.lattitude,
    this.longitude,
    this.therapyCenterCode,
    this.city,
    this.state,
    this.userId,
    this.country,
    this.flatHouseNo,
    this.areaStreet,
    this.landmark,
    this.pincode,
    this.locationUniqueCode,
  });

  TherapyCenterLocationDataModel.fromJson(Map<String, dynamic> json) {
    locationId = json['locationId'] ?? "";
    lattitude = json['lattitude'] ?? "";
    longitude = json['longitude'] ?? "";
    city = json['city'] ?? "";
    therapyCenterCode = json['therapyCenterCode'] ?? '';
    state = json['state'] ?? "";
    userId = json['userId'] ?? "";
    country = json['country'] ?? "";
    flatHouseNo = json['flatHouseNo'] ?? "";
    areaStreet = json['areaStreet'] ?? "";
    landmark = json['landmark'] ?? "";
    pincode = json['pincode'] ?? "";
    locationUniqueCode = json['locationUniqueCode'] ?? "";
  }

  Map<String, dynamic> toJson() => {
        'locationId': locationId,
        'longitude': longitude,
        'lattitude': lattitude,
        'city': city,
        'state': state,
        'userId': userId,
        'country': country,
        "therapyCenterCode": therapyCenterCode,
        'flatHouseNo': flatHouseNo,
        'areaStreet': areaStreet,
        'landmark': landmark,
        'pincode': pincode,
        'locationUniqueCode': locationUniqueCode,
      };
}
>>>>>>> Stashed changes
