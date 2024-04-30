class UserModel {
  String? id;
  String? email;
  String? mobileNumber;
  String? password;

  UserModel({
    this.email,
    this.password,
    this.id,
    this.mobileNumber,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    email = json['email'] ?? "";
    password = json['password'] ?? "";
    mobileNumber = json['mobileNumber'] ?? "";
  }

  Map<String, dynamic> toJson() => {
        'id': mobileNumber,
        'email': email,
        'password': password,
        'mobileNumber': mobileNumber,
      };
}
