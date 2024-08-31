class TherapyCenterDataModel {
  TherapyCenterDataModel({
    this.therapyCenterCode,
    this.location,
    this.therapyCenterAddress,
    this.userId,
    this.therapyCenterName,
    this.isFeatchCenter,
    this.id,
  });

  TherapyCenterDataModel.fromJson(dynamic json) {
    therapyCenterCode = json['therapyCenterCode'];
    if (json['location'] != null) {
      location = [];
      json['location'].forEach((v) {
        location?.add(Location.fromJson(v));
      });
    }
    therapyCenterAddress = json['therapyCenterAddress'];
    userId = json['userId'];
    therapyCenterName = json['therapyCenterName'];
    isFeatchCenter = json['isFeatchCenter'];
    id = json['id'];
  }

  String? therapyCenterCode;
  List<Location>? location;
  String? therapyCenterAddress;
  String? userId;
  String? therapyCenterName;
  String? id;
  bool? isFeatchCenter;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['therapyCenterCode'] = therapyCenterCode;
    if (location != null) {
      map['location'] = location?.map((v) => v.toJson()).toList();
    }
    map['therapyCenterAddress'] = therapyCenterAddress;
    map['userId'] = userId;
    map['therapyCenterName'] = therapyCenterName;
    map['isFeatchCenter'] = isFeatchCenter;
    map['id'] = id;
    return map;
  }
}

class Location {
  Location({
    this.lattitude,
    this.longitude,
  });

  Location.fromJson(dynamic json) {
    lattitude = json['lattitude'];
    longitude = json['longitude'];
  }

  String? lattitude;
  String? longitude;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lattitude'] = lattitude;
    map['longitude'] = longitude;
    return map;
  }
}
