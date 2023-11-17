import 'dart:convert';

Step1InsertResultModel step1InsertResultModelFromJson(String str) => Step1InsertResultModel.fromJson(json.decode(str));

String step1InsertResultModelToJson(Step1InsertResultModel data) => json.encode(data.toJson());

class Step1InsertResultModel {
  String companyId;
  String unitId;
  String errorId;

  Step1InsertResultModel({
    required this.companyId,
    required this.unitId,
    required this.errorId,
  });

  factory Step1InsertResultModel.fromJson(Map<String, dynamic> json) => Step1InsertResultModel(
    companyId: json["CompanyId"],
    unitId: json["UnitId"],
    errorId: json["ErrorId"],
  );

  Map<String, dynamic> toJson() => {
    "CompanyId": companyId,
    "UnitId": unitId,
    "ErrorId": errorId,
  };
}
