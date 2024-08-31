class TherapyCenterCodeModel {
  String? centerCode;

  TherapyCenterCodeModel({
    this.centerCode,
  });

  TherapyCenterCodeModel.fromJson(Map<String, dynamic> json) {
    centerCode = json['centerCode'] ?? "";
  }

  Map<String, dynamic> toJson() => {
        'centerCode': centerCode,
      };
}
