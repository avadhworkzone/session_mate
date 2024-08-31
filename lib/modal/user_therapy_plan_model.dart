import 'dart:convert';

UserTherapyDataModel userTherapyDataModelFromJson(String str) =>
    UserTherapyDataModel.fromJson(json.decode(str));

String userTherapyDataModelToJson(UserTherapyDataModel data) => json.encode(data.toJson());

class UserTherapyDataModel {
  String? sessionId;
  String? userId;
  String? childName;
  int? childAge;
  List? goal;
  List? subGoal;
  List? currentLevel;
  List? strategies;

  UserTherapyDataModel({
    this.sessionId,
    this.userId,
    this.childName,
    this.childAge,
    this.goal,
    this.subGoal,
    this.currentLevel,
    this.strategies,
  });

  factory UserTherapyDataModel.fromJson(Map<String, dynamic> json) => UserTherapyDataModel(
        sessionId: json["sessionId"],
        userId: json["userId"],
        childName: json["childName"],
        childAge: json["childAge"],
        goal: json["goal"] == null ? [] : List<String>.from(json["goal"]!.map((x) => x)),
        subGoal: json["subGoal"] == null ? [] : List<String>.from(json["subGoal"]!.map((x) => x)),
        currentLevel: json["currentLevel"] == null
            ? []
            : List<String>.from(json["currentLevel"]!.map((x) => x)),
        strategies:
            json["strategies"] == null ? [] : List<String>.from(json["strategies"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "sessionId": sessionId,
        "userId": userId,
        "childName": childName,
        "childAge": childAge,
        "goal": goal == null ? [] : List<dynamic>.from(goal!.map((x) => x)),
        "subGoal": subGoal == null ? [] : List<dynamic>.from(subGoal!.map((x) => x)),
        "currentLevel": currentLevel == null ? [] : List<dynamic>.from(currentLevel!.map((x) => x)),
        "strategies": strategies == null ? [] : List<dynamic>.from(strategies!.map((x) => x)),
      };
}
