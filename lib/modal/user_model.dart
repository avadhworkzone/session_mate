class UserModel {
  String? id;
  String? email;
  String? mobileNumber;
  String? password;
  String? subscriptionType;
  String? subscriptionStartDate;
  String? subscriptionEndDate;
  bool? isSubscription;
  String? latitude;
  String? longitude;

  UserModel({
    this.email,
    this.password,
    this.id,
    this.mobileNumber,
    this.subscriptionType,
    this.subscriptionStartDate,
    this.subscriptionEndDate,
    this.isSubscription,
    this.latitude,
    this.longitude,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    email = json['email'] ?? "";
    password = json['password'] ?? "";
    mobileNumber = json['mobileNumber'] ?? "";
    subscriptionType = json['subscriptionType'] ?? "";
    subscriptionStartDate = json['subscriptionStartDate'] ?? "";
    subscriptionEndDate = json['subscriptionEndDate'] ?? "";
    isSubscription = json['isSubscription'] ?? "";
    latitude = json['latitude'] ?? "";
    longitude = json['longitude'] ?? "";
  }

  Map<String, dynamic> toJson() => {
        'id': mobileNumber,
        'email': email,
        'password': password,
        'mobileNumber': mobileNumber,
        'subscriptionType': subscriptionType,
        'subscriptionStartDate': subscriptionStartDate,
        'subscriptionEndDate': subscriptionEndDate,
        'isSubscription': isSubscription,
        'latitude': latitude,
        'longitude': longitude,
      };
}
