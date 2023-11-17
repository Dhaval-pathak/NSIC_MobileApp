// To parse this JSON data, do
//
//     final step4FetchModel = step4FetchModelFromJson(jsonString);

import 'dart:convert';

List<Step4FetchModel> step4FetchModelFromJson(String str) => List<Step4FetchModel>.from(json.decode(str).map((x) => Step4FetchModel.fromJson(x)));

String step4FetchModelToJson(List<Step4FetchModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Step4FetchModel {
  String fGPtblCUnit1BFactoryAddress;
  int fGPtblCUnit3D;
  int fGPtblCUnitId;
  String fGPtblCUnit5A1;
  String fGPtblCUnit5A2;
  String fGPtblCUnit5Bb1;
  String fGPtblCUnit5Bb2;
  String fGPtblCUnit5C;
  double fGPtblCUnit6A1;
  double fGPtblCUnit6A2;
  double fGPtblCUnit6A3;
  double fGPtblCUnit6B;
  double fGPtblCUnit6B2;
  String fGPtblCUnit7A;
  String fGPtblCUnit7B;
  String fGPtblCUnit7C;
  String fGPtblCUnit7D;
  String fGPtblCUnit7E;
  String fGPtblCUnit8;
  String fGPtblCUnit9;
  String fGPtblCUnit10;
  String fGPtblCUnit11;
  String fGPtblCUnit12A;
  String fGPtblCUnit12B;
  String fGPtblCUnit12C;
  String fGPtblCUnit13A;
  String fGPtblCUnit13B;
  int fGPtblCUnitEnterprise;
  int fGPtblCUnitCategoryUnitSizeId;
  dynamic certificateProprietorPartnerDirectors;

  Step4FetchModel({
    required this.fGPtblCUnit1BFactoryAddress,
    required this.fGPtblCUnit3D,
    required this.fGPtblCUnitId,
    required this.fGPtblCUnit5A1,
    required this.fGPtblCUnit5A2,
    required this.fGPtblCUnit5Bb1,
    required this.fGPtblCUnit5Bb2,
    required this.fGPtblCUnit5C,
    required this.fGPtblCUnit6A1,
    required this.fGPtblCUnit6A2,
    required this.fGPtblCUnit6A3,
    required this.fGPtblCUnit6B,
    required this.fGPtblCUnit6B2,
    required this.fGPtblCUnit7A,
    required this.fGPtblCUnit7B,
    required this.fGPtblCUnit7C,
    required this.fGPtblCUnit7D,
    required this.fGPtblCUnit7E,
    required this.fGPtblCUnit8,
    required this.fGPtblCUnit9,
    required this.fGPtblCUnit10,
    required this.fGPtblCUnit11,
    required this.fGPtblCUnit12A,
    required this.fGPtblCUnit12B,
    required this.fGPtblCUnit12C,
    required this.fGPtblCUnit13A,
    required this.fGPtblCUnit13B,
    required this.fGPtblCUnitEnterprise,
    required this.fGPtblCUnitCategoryUnitSizeId,
    this.certificateProprietorPartnerDirectors,
  });

  factory Step4FetchModel.fromJson(Map<String, dynamic> json) => Step4FetchModel(
    fGPtblCUnit1BFactoryAddress: json["fGPtbl_CUnit_1B_Factory_Address"],
    fGPtblCUnit3D: json["fGPtbl_CUnit_3D"],
    fGPtblCUnitId: json["fGPtbl_CUnit_Id"],
    fGPtblCUnit5A1: json["fGPtbl_CUnit_5A1"],
    fGPtblCUnit5A2: json["fGPtbl_CUnit_5A2"],
    fGPtblCUnit5Bb1: json["fGPtbl_CUnit_5BB1"],
    fGPtblCUnit5Bb2: json["fGPtbl_CUnit_5BB2"],
    fGPtblCUnit5C: json["fGPtbl_CUnit_5C"],
    fGPtblCUnit6A1: json["fGPtbl_CUnit_6A1"].toDouble(),
    fGPtblCUnit6A2: json["fGPtbl_CUnit_6A2"].toDouble(),
    fGPtblCUnit6A3: json["fGPtbl_CUnit_6A3"].toDouble(),
    fGPtblCUnit6B: json["fGPtbl_CUnit_6B"].toDouble(),
    fGPtblCUnit6B2: json["fGPtbl_CUnit_6B2"].toDouble(),
    fGPtblCUnit7A: json["fGPtbl_CUnit_7A"],
    fGPtblCUnit7B: json["fGPtbl_CUnit_7B"],
    fGPtblCUnit7C: json["fGPtbl_CUnit_7C"],
    fGPtblCUnit7D: json["fGPtbl_CUnit_7D"],
    fGPtblCUnit7E: json["fGPtbl_CUnit_7E"],
    fGPtblCUnit8: json["fGPtbl_CUnit_8"],
    fGPtblCUnit9: json["fGPtbl_CUnit_9"],
    fGPtblCUnit10: json["fGPtbl_CUnit_10"],
    fGPtblCUnit11: json["fGPtbl_CUnit_11"],
    fGPtblCUnit12A: json["fGPtbl_CUnit_12A"],
    fGPtblCUnit12B: json["fGPtbl_CUnit_12B"],
    fGPtblCUnit12C: json["fGPtbl_CUnit_12C"],
    fGPtblCUnit13A: json["fGPtbl_CUnit_13A"],
    fGPtblCUnit13B: json["fGPtbl_CUnit_13B"],
    fGPtblCUnitEnterprise: json["fGPtbl_CUnit_Enterprise"],
    fGPtblCUnitCategoryUnitSizeId: json["fGPtbl_CUnit_CategoryUnitSizeId"],
    certificateProprietorPartnerDirectors: json["Certificate_Proprietor_Partner_Directors"],
  );

  Map<String, dynamic> toJson() => {
    "fGPtbl_CUnit_1B_Factory_Address": fGPtblCUnit1BFactoryAddress,
    "fGPtbl_CUnit_3D": fGPtblCUnit3D,
    "fGPtbl_CUnit_Id": fGPtblCUnitId,
    "fGPtbl_CUnit_5A1": fGPtblCUnit5A1,
    "fGPtbl_CUnit_5A2": fGPtblCUnit5A2,
    "fGPtbl_CUnit_5BB1": fGPtblCUnit5Bb1,
    "fGPtbl_CUnit_5BB2": fGPtblCUnit5Bb2,
    "fGPtbl_CUnit_5C": fGPtblCUnit5C,
    "fGPtbl_CUnit_6A1": fGPtblCUnit6A1,
    "fGPtbl_CUnit_6A2": fGPtblCUnit6A2,
    "fGPtbl_CUnit_6A3": fGPtblCUnit6A3,
    "fGPtbl_CUnit_6B": fGPtblCUnit6B,
    "fGPtbl_CUnit_6B2": fGPtblCUnit6B2,
    "fGPtbl_CUnit_7A": fGPtblCUnit7A,
    "fGPtbl_CUnit_7B": fGPtblCUnit7B,
    "fGPtbl_CUnit_7C": fGPtblCUnit7C,
    "fGPtbl_CUnit_7D": fGPtblCUnit7D,
    "fGPtbl_CUnit_7E": fGPtblCUnit7E,
    "fGPtbl_CUnit_8": fGPtblCUnit8,
    "fGPtbl_CUnit_9": fGPtblCUnit9,
    "fGPtbl_CUnit_10": fGPtblCUnit10,
    "fGPtbl_CUnit_11": fGPtblCUnit11,
    "fGPtbl_CUnit_12A": fGPtblCUnit12A,
    "fGPtbl_CUnit_12B": fGPtblCUnit12B,
    "fGPtbl_CUnit_12C": fGPtblCUnit12C,
    "fGPtbl_CUnit_13A": fGPtblCUnit13A,
    "fGPtbl_CUnit_13B": fGPtblCUnit13B,
    "fGPtbl_CUnit_Enterprise": fGPtblCUnitEnterprise,
    "fGPtbl_CUnit_CategoryUnitSizeId": fGPtblCUnitCategoryUnitSizeId,
    "Certificate_Proprietor_Partner_Directors": certificateProprietorPartnerDirectors,
  };
}
