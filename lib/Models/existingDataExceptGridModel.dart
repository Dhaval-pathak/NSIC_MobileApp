// To parse this JSON data, do
//
//     final existingDataExceptGridModel = existingDataExceptGridModelFromJson(jsonString);

import 'dart:convert';

List<ExistingDataExceptGridModel> existingDataExceptGridModelFromJson(String str) => List<ExistingDataExceptGridModel>.from(json.decode(str).map((x) => ExistingDataExceptGridModel.fromJson(x)));

String existingDataExceptGridModelToJson(List<ExistingDataExceptGridModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ExistingDataExceptGridModel {
  int fGPtblCompanyId;
  String fGPtblCompanyGpReferenceNo;
  String fGPtblCompanyName;
  String fGPtblCompanyPan;
  String fGPtblCompanyHeadOfficeAddress;
  String fGPtblCompanyHeadOfficeZip;
  int fGPtblCompanyHeadOfficeStateId;
  int fGPtblCompanyHeadOfficeCityId;
  String fGPtblCompanyHeadOfficePhone;
  String fGPtblCompanyHeadOfficeMobile;
  String fGtblCompanyAdharNumber;
  String fGtblCompanyGstNumber;
  String fGPtblCompanyHeadOfficeFax;
  String fGPtblCompanyHeadOfficeEmail;
  bool fGPtblCompanyMsme;
  bool fGPtblCompanyShareInfo;
  int fGPtblCUnitId;
  int fGPtblCUnitFormtypeId;
  int? fGPtblCUnit3C123ConstitutionId;
  String fGPtblCUnit1BFactoryAddress;
  String fGPtblCUnit1BFactoryZip;
  int fGPtblCUnit1BFactoryStateId;
  int fGPtblCUnit1BFactoryCityId;
  String fGPtblCUnit1BFactoryPhone;
  String fGPtblCUnit1BFactoryFax;
  String fGPtblCUnit1BFactoryEmail;
  int fGPtblCUnitCategoryAreaId;
  int fGPtblCUnitCategoryCastId;
  int fGPtblCUnitCategoryUnitSizeId;
  int fGPtblCUnitEnterprise;
  int existingDataExceptGridModelFGPtblCUnitBranchId;
  int fGPtblCUnitBranchId;
  int fGPtblCUnitBranchUnitId;
  String fGPtblCUnitBranchAddress;
  String fGPtblCUnitBranchZip;
  int fGPtblCUnitBranchStateId;
  int fGPtblCUnitBranchCityId;
  String fGPtblCUnitBranchPhone;
  dynamic fGPtblCUnitBranchFax;
  String fGPtblCUnitBranchEmail;
  String fGPtblCompanyProposalDate;
  int fGtblCompanyIsScstInitiative;
  bool fGPtblIsAyush;

  ExistingDataExceptGridModel({
    required this.fGPtblCompanyId,
    required this.fGPtblCompanyGpReferenceNo,
    required this.fGPtblCompanyName,
    required this.fGPtblCompanyPan,
    required this.fGPtblCompanyHeadOfficeAddress,
    required this.fGPtblCompanyHeadOfficeZip,
    required this.fGPtblCompanyHeadOfficeStateId,
    required this.fGPtblCompanyHeadOfficeCityId,
    required this.fGPtblCompanyHeadOfficePhone,
    required this.fGPtblCompanyHeadOfficeMobile,
    required this.fGtblCompanyAdharNumber,
    required this.fGtblCompanyGstNumber,
    required this.fGPtblCompanyHeadOfficeFax,
    required this.fGPtblCompanyHeadOfficeEmail,
    required this.fGPtblCompanyMsme,
    required this.fGPtblCompanyShareInfo,
    required this.fGPtblCUnitId,
    required this.fGPtblCUnitFormtypeId,
    this.fGPtblCUnit3C123ConstitutionId,
    required this.fGPtblCUnit1BFactoryAddress,
    required this.fGPtblCUnit1BFactoryZip,
    required this.fGPtblCUnit1BFactoryStateId,
    required this.fGPtblCUnit1BFactoryCityId,
    required this.fGPtblCUnit1BFactoryPhone,
    required this.fGPtblCUnit1BFactoryFax,
    required this.fGPtblCUnit1BFactoryEmail,
    required this.fGPtblCUnitCategoryAreaId,
    required this.fGPtblCUnitCategoryCastId,
    required this.fGPtblCUnitCategoryUnitSizeId,
    required this.fGPtblCUnitEnterprise,
    required this.existingDataExceptGridModelFGPtblCUnitBranchId,
    required this.fGPtblCUnitBranchId,
    required this.fGPtblCUnitBranchUnitId,
    required this.fGPtblCUnitBranchAddress,
    required this.fGPtblCUnitBranchZip,
    required this.fGPtblCUnitBranchStateId,
    required this.fGPtblCUnitBranchCityId,
    required this.fGPtblCUnitBranchPhone,
    this.fGPtblCUnitBranchFax,
    required this.fGPtblCUnitBranchEmail,
    required this.fGPtblCompanyProposalDate,
    required this.fGtblCompanyIsScstInitiative,
    required this.fGPtblIsAyush,
  });

  factory ExistingDataExceptGridModel.fromJson(Map<String, dynamic> json) => ExistingDataExceptGridModel(
    fGPtblCompanyId: json["fGPtbl_Company_Id"],
    fGPtblCompanyGpReferenceNo: json["fGPtbl_Company_GPReferenceNo"],
    fGPtblCompanyName: json["fGPtbl_Company_Name"],
    fGPtblCompanyPan: json["fGPtbl_Company_PAN"],
    fGPtblCompanyHeadOfficeAddress: json["fGPtbl_Company_HeadOffice_Address"],
    fGPtblCompanyHeadOfficeZip: json["fGPtbl_Company_HeadOffice_Zip"],
    fGPtblCompanyHeadOfficeStateId: json["fGPtbl_Company_HeadOffice_StateId"],
    fGPtblCompanyHeadOfficeCityId: json["fGPtbl_Company_HeadOffice_CityId"],
    fGPtblCompanyHeadOfficePhone: json["fGPtbl_Company_HeadOffice_Phone"],
    fGPtblCompanyHeadOfficeMobile: json["fGPtbl_Company_HeadOffice_Mobile"],
    fGtblCompanyAdharNumber: json["fGtbl_Company_AdharNumber"],
    fGtblCompanyGstNumber: json["fGtbl_Company_GSTNumber"],
    fGPtblCompanyHeadOfficeFax: json["fGPtbl_Company_HeadOffice_Fax"],
    fGPtblCompanyHeadOfficeEmail: json["fGPtbl_Company_HeadOffice_Email"],
    fGPtblCompanyMsme: json["fGPtbl_Company_MSME"],
    fGPtblCompanyShareInfo: json["fGPtbl_Company_ShareInfo"],
    fGPtblCUnitId: json["fGPtbl_CUnit_Id"],
    fGPtblCUnitFormtypeId: json["fGPtbl_CUnit_FormtypeId"],
    fGPtblCUnit3C123ConstitutionId: json["fGPtbl_CUnit_3C123_ConstitutionId"],
    fGPtblCUnit1BFactoryAddress: json["fGPtbl_CUnit_1B_Factory_Address"],
    fGPtblCUnit1BFactoryZip: json["fGPtbl_CUnit_1B_Factory_Zip"],
    fGPtblCUnit1BFactoryStateId: json["fGPtbl_CUnit_1B_Factory_StateId"],
    fGPtblCUnit1BFactoryCityId: json["fGPtbl_CUnit_1B_Factory_CityId"],
    fGPtblCUnit1BFactoryPhone: json["fGPtbl_CUnit_1B_Factory_Phone"],
    fGPtblCUnit1BFactoryFax: json["fGPtbl_CUnit_1B_Factory_Fax"],
    fGPtblCUnit1BFactoryEmail: json["fGPtbl_CUnit_1B_Factory_Email"],
    fGPtblCUnitCategoryAreaId: json["fGPtbl_CUnit_CategoryAreaId"],
    fGPtblCUnitCategoryCastId: json["fGPtbl_CUnit_CategoryCastId"],
    fGPtblCUnitCategoryUnitSizeId: json["fGPtbl_CUnit_CategoryUnitSizeId"],
    fGPtblCUnitEnterprise: json["fGPtbl_CUnit_Enterprise"],
    existingDataExceptGridModelFGPtblCUnitBranchId: json["fGPtbl_CUnit_BranchId"],
    fGPtblCUnitBranchId: json["fGPtbl_CUnitBranch_Id"],
    fGPtblCUnitBranchUnitId: json["fGPtbl_CUnitBranch_UnitId"],
    fGPtblCUnitBranchAddress: json["fGPtbl_CUnitBranch_Address"],
    fGPtblCUnitBranchZip: json["fGPtbl_CUnitBranch_Zip"],
    fGPtblCUnitBranchStateId: json["fGPtbl_CUnitBranch_StateId"],
    fGPtblCUnitBranchCityId: json["fGPtbl_CUnitBranch_CityId"],
    fGPtblCUnitBranchPhone: json["fGPtbl_CUnitBranch_Phone"],
    fGPtblCUnitBranchFax: json["fGPtbl_CUnitBranch_Fax"],
    fGPtblCUnitBranchEmail: json["fGPtbl_CUnitBranch_Email"],
    fGPtblCompanyProposalDate: json["fGPtbl_Company_ProposalDate"],
    fGtblCompanyIsScstInitiative: json["fGtbl_Company_IsSCST_Initiative"],
    fGPtblIsAyush: json["fGPtbl_IsAyush"],
  );

  Map<String, dynamic> toJson() => {
    "fGPtbl_Company_Id": fGPtblCompanyId,
    "fGPtbl_Company_GPReferenceNo": fGPtblCompanyGpReferenceNo,
    "fGPtbl_Company_Name": fGPtblCompanyName,
    "fGPtbl_Company_PAN": fGPtblCompanyPan,
    "fGPtbl_Company_HeadOffice_Address": fGPtblCompanyHeadOfficeAddress,
    "fGPtbl_Company_HeadOffice_Zip": fGPtblCompanyHeadOfficeZip,
    "fGPtbl_Company_HeadOffice_StateId": fGPtblCompanyHeadOfficeStateId,
    "fGPtbl_Company_HeadOffice_CityId": fGPtblCompanyHeadOfficeCityId,
    "fGPtbl_Company_HeadOffice_Phone": fGPtblCompanyHeadOfficePhone,
    "fGPtbl_Company_HeadOffice_Mobile": fGPtblCompanyHeadOfficeMobile,
    "fGtbl_Company_AdharNumber": fGtblCompanyAdharNumber,
    "fGtbl_Company_GSTNumber": fGtblCompanyGstNumber,
    "fGPtbl_Company_HeadOffice_Fax": fGPtblCompanyHeadOfficeFax,
    "fGPtbl_Company_HeadOffice_Email": fGPtblCompanyHeadOfficeEmail,
    "fGPtbl_Company_MSME": fGPtblCompanyMsme,
    "fGPtbl_Company_ShareInfo": fGPtblCompanyShareInfo,
    "fGPtbl_CUnit_Id": fGPtblCUnitId,
    "fGPtbl_CUnit_FormtypeId": fGPtblCUnitFormtypeId,
    "fGPtbl_CUnit_3C123_ConstitutionId": fGPtblCUnit3C123ConstitutionId,
    "fGPtbl_CUnit_1B_Factory_Address": fGPtblCUnit1BFactoryAddress,
    "fGPtbl_CUnit_1B_Factory_Zip": fGPtblCUnit1BFactoryZip,
    "fGPtbl_CUnit_1B_Factory_StateId": fGPtblCUnit1BFactoryStateId,
    "fGPtbl_CUnit_1B_Factory_CityId": fGPtblCUnit1BFactoryCityId,
    "fGPtbl_CUnit_1B_Factory_Phone": fGPtblCUnit1BFactoryPhone,
    "fGPtbl_CUnit_1B_Factory_Fax": fGPtblCUnit1BFactoryFax,
    "fGPtbl_CUnit_1B_Factory_Email": fGPtblCUnit1BFactoryEmail,
    "fGPtbl_CUnit_CategoryAreaId": fGPtblCUnitCategoryAreaId,
    "fGPtbl_CUnit_CategoryCastId": fGPtblCUnitCategoryCastId,
    "fGPtbl_CUnit_CategoryUnitSizeId": fGPtblCUnitCategoryUnitSizeId,
    "fGPtbl_CUnit_Enterprise": fGPtblCUnitEnterprise,
    "fGPtbl_CUnit_BranchId": existingDataExceptGridModelFGPtblCUnitBranchId,
    "fGPtbl_CUnitBranch_Id": fGPtblCUnitBranchId,
    "fGPtbl_CUnitBranch_UnitId": fGPtblCUnitBranchUnitId,
    "fGPtbl_CUnitBranch_Address": fGPtblCUnitBranchAddress,
    "fGPtbl_CUnitBranch_Zip": fGPtblCUnitBranchZip,
    "fGPtbl_CUnitBranch_StateId": fGPtblCUnitBranchStateId,
    "fGPtbl_CUnitBranch_CityId": fGPtblCUnitBranchCityId,
    "fGPtbl_CUnitBranch_Phone": fGPtblCUnitBranchPhone,
    "fGPtbl_CUnitBranch_Fax": fGPtblCUnitBranchFax,
    "fGPtbl_CUnitBranch_Email": fGPtblCUnitBranchEmail,
    "fGPtbl_Company_ProposalDate": fGPtblCompanyProposalDate,
    "fGtbl_Company_IsSCST_Initiative": fGtblCompanyIsScstInitiative,
    "fGPtbl_IsAyush": fGPtblIsAyush,
  };
}
