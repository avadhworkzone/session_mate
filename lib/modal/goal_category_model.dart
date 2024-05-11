class GoalCategoryModel {
  String? id;
  String? ageLevelId;
  String? sessionId;
  List<GoalData>? goal;

  GoalCategoryModel({this.id, this.ageLevelId, this.goal, this.sessionId});

  GoalCategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    sessionId = json['sessionId'] ?? "";
    ageLevelId = json['ageLevelId'];
    if (json['goal'] != null) {
      goal = <GoalData>[];
      json['goal'].forEach((v) {
        goal!.add(new GoalData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sessionId'] = this.sessionId;
    data['ageLevelId'] = this.ageLevelId;
    if (this.goal != null) {
      data['goal'] = this.goal!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GoalData {
  String? goalId;
  String? goalName;

  GoalData({this.goalId, this.goalName});

  GoalData.fromJson(Map<String, dynamic> json) {
    goalId = json['goalId'];
    goalName = json['goalName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['goalId'] = this.goalId;
    data['goalName'] = this.goalName;
    return data;
  }
}
