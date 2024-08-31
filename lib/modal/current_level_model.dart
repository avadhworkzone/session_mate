class CurrentLevelModel {
  String? name;
  String? id;
  bool? status = false;

  CurrentLevelModel({this.name, this.id});

  CurrentLevelModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['id'] = id;
    data['status'] = this.status;
    return data;
  }
}
