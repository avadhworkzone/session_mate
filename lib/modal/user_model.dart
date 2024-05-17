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
  String? registrationDate;
  String? role;
  String? userName;
  String? centerCode;

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
    this.registrationDate,
    this.role,
    this.userName,
    this.centerCode,
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
    registrationDate = json['registrationDate'] ?? "";
    role = json['role'] ?? "";
    userName = json['userName'] ?? "";
    centerCode = json['centerCode'] ?? "";
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
        'registrationDate': registrationDate,
        'role': role,
        'userName': userName,
        'centerCode': centerCode,
      };
}
