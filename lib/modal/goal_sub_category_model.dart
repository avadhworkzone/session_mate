class GoalSubCategoryModel {
  String? goalId;
  String? id;
  List<String>? subGoal;

  GoalSubCategoryModel({this.goalId, this.id, this.subGoal});

  GoalSubCategoryModel.fromJson(Map<String, dynamic> json) {
    goalId = json['goalId'];
    id = json['id'];
    subGoal = json['subGoal'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['goalId'] = this.goalId;
    data['id'] = this.id;
    data['subGoal'] = this.subGoal;
    return data;
  }
}
