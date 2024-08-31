class StrategiesModel {
  String? goalId;
  String? id;
  List<String>? strategies;

  StrategiesModel({this.goalId, this.id, this.strategies});

  StrategiesModel.fromJson(Map<String, dynamic> json) {
    goalId = json['goalId'];
    id = json['id'];
    strategies = json['strategies'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['goalId'] = this.goalId;
    data['id'] = this.id;
    data['strategies'] = this.strategies;
    return data;
  }
}
