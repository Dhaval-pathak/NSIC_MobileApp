// To parse this JSON data, do
//
//     final existingDataModel = existingDataModelFromJson(jsonString);

import 'dart:convert';

List<ExistingDataModel> existingDataModelFromJson(String str) => List<ExistingDataModel>.from(json.decode(str).map((x) => ExistingDataModel.fromJson(x)));

String existingDataModelToJson(List<ExistingDataModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ExistingDataModel {
  int fGPtblCompanyId;
  String fGPtblCompanyGpReferenceNo;
  String fGPtblCompanyName;
  String fGPtblCompanyPan;
  String fGtblCompanyAdharNumber;
  String? fGtblCompanyGstNumber;
  int fGtblCompanyIsScstInitiative;
  String fGPtblCompanyHeadOfficeAddress;
  String fGPtblCompanyHeadOfficeZip;
  int fGPtblCompanyHeadOfficeStateId;
  int fGPtblCompanyHeadOfficeCityId;
  String fGPtblCompanyHeadOfficePhone;
  String fGPtblCompanyHeadOfficeMobile;
  String fGPtblCompanyHeadOfficeFax;
  String fGPtblCompanyHeadOfficeEmail;
  int fGPtblCUnitId;
  int fGPtblCUnitFormtypeId;
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
  int fGPtblCUnitBranchId;
  int fGPtblCUnitBranchUnitId;
  String? fGPtblCUnitBranchAddress;
  String? fGPtblCUnitBranchZip;
  int fGPtblCUnitBranchStateId;
  int fGPtblCUnitBranchCityId;
  String? fGPtblCUnitBranchPhone;
  String? fGPtblCUnitBranchFax;
  String? fGPtblCUnitBranchEmail;

  ExistingDataModel({
    required this.fGPtblCompanyId,
    required this.fGPtblCompanyGpReferenceNo,
    required this.fGPtblCompanyName,
    required this.fGPtblCompanyPan,
    required this.fGtblCompanyAdharNumber,
    this.fGtblCompanyGstNumber,
    required this.fGtblCompanyIsScstInitiative,
    required this.fGPtblCompanyHeadOfficeAddress,
    required this.fGPtblCompanyHeadOfficeZip,
    required this.fGPtblCompanyHeadOfficeStateId,
    required this.fGPtblCompanyHeadOfficeCityId,
    required this.fGPtblCompanyHeadOfficePhone,
    required this.fGPtblCompanyHeadOfficeMobile,
    required this.fGPtblCompanyHeadOfficeFax,
    required this.fGPtblCompanyHeadOfficeEmail,
    required this.fGPtblCUnitId,
    required this.fGPtblCUnitFormtypeId,
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
    required this.fGPtblCUnitBranchId,
    required this.fGPtblCUnitBranchUnitId,
    this.fGPtblCUnitBranchAddress,
    this.fGPtblCUnitBranchZip,
    required this.fGPtblCUnitBranchStateId,
    required this.fGPtblCUnitBranchCityId,
    this.fGPtblCUnitBranchPhone,
    this.fGPtblCUnitBranchFax = "",
    this.fGPtblCUnitBranchEmail,
  });

  factory ExistingDataModel.fromJson(Map<String, dynamic> json) => ExistingDataModel(
    fGPtblCompanyId: json["fGPtbl_Company_Id"],
    fGPtblCompanyGpReferenceNo: json["fGPtbl_Company_GPReferenceNo"],
    fGPtblCompanyName: json["fGPtbl_Company_Name"],
    fGPtblCompanyPan: json["fGPtbl_Company_PAN"],
    fGtblCompanyAdharNumber: json["fGtbl_Company_AdharNumber"],
    fGtblCompanyGstNumber: json["fGtbl_Company_GSTNumber"],
    fGtblCompanyIsScstInitiative: json["fGtbl_Company_IsSCST_Initiative"],
    fGPtblCompanyHeadOfficeAddress: json["fGPtbl_Company_HeadOffice_Address"],
    fGPtblCompanyHeadOfficeZip: json["fGPtbl_Company_HeadOffice_Zip"],
    fGPtblCompanyHeadOfficeStateId: json["fGPtbl_Company_HeadOffice_StateId"],
    fGPtblCompanyHeadOfficeCityId: json["fGPtbl_Company_HeadOffice_CityId"],
    fGPtblCompanyHeadOfficePhone: json["fGPtbl_Company_HeadOffice_Phone"],
    fGPtblCompanyHeadOfficeMobile: json["fGPtbl_Company_HeadOffice_Mobile"],
    fGPtblCompanyHeadOfficeFax: json["fGPtbl_Company_HeadOffice_Fax"],
    fGPtblCompanyHeadOfficeEmail: json["fGPtbl_Company_HeadOffice_Email"],
    fGPtblCUnitId: json["fGPtbl_CUnit_Id"],
    fGPtblCUnitFormtypeId: json["fGPtbl_CUnit_FormtypeId"],
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
    fGPtblCUnitBranchId: json["fGPtbl_CUnitBranch_Id"],
    fGPtblCUnitBranchUnitId: json["fGPtbl_CUnitBranch_UnitId"],
    fGPtblCUnitBranchAddress: json["fGPtbl_CUnitBranch_Address"],
    fGPtblCUnitBranchZip: json["fGPtbl_CUnitBranch_Zip"],
    fGPtblCUnitBranchStateId: json["fGPtbl_CUnitBranch_StateId"],
    fGPtblCUnitBranchCityId: json["fGPtbl_CUnitBranch_CityId"],
    fGPtblCUnitBranchPhone: json["fGPtbl_CUnitBranch_Phone"],
    fGPtblCUnitBranchFax: json["fGPtbl_CUnitBranch_Fax"],
    fGPtblCUnitBranchEmail: json["fGPtbl_CUnitBranch_Email"],
  );

  Map<String, dynamic> toJson() => {
    "fGPtbl_Company_Id": fGPtblCompanyId,
    "fGPtbl_Company_GPReferenceNo": fGPtblCompanyGpReferenceNo,
    "fGPtbl_Company_Name": fGPtblCompanyName,
    "fGPtbl_Company_PAN": fGPtblCompanyPan,
    "fGtbl_Company_AdharNumber": fGtblCompanyAdharNumber,
    "fGtbl_Company_GSTNumber": fGtblCompanyGstNumber,
    "fGtbl_Company_IsSCST_Initiative": fGtblCompanyIsScstInitiative,
    "fGPtbl_Company_HeadOffice_Address": fGPtblCompanyHeadOfficeAddress,
    "fGPtbl_Company_HeadOffice_Zip": fGPtblCompanyHeadOfficeZip,
    "fGPtbl_Company_HeadOffice_StateId": fGPtblCompanyHeadOfficeStateId,
    "fGPtbl_Company_HeadOffice_CityId": fGPtblCompanyHeadOfficeCityId,
    "fGPtbl_Company_HeadOffice_Phone": fGPtblCompanyHeadOfficePhone,
    "fGPtbl_Company_HeadOffice_Mobile": fGPtblCompanyHeadOfficeMobile,
    "fGPtbl_Company_HeadOffice_Fax": fGPtblCompanyHeadOfficeFax,
    "fGPtbl_Company_HeadOffice_Email": fGPtblCompanyHeadOfficeEmail,
    "fGPtbl_CUnit_Id": fGPtblCUnitId,
    "fGPtbl_CUnit_FormtypeId": fGPtblCUnitFormtypeId,
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
    "fGPtbl_CUnitBranch_Id": fGPtblCUnitBranchId,
    "fGPtbl_CUnitBranch_UnitId": fGPtblCUnitBranchUnitId,
    "fGPtbl_CUnitBranch_Address": fGPtblCUnitBranchAddress,
    "fGPtbl_CUnitBranch_Zip": fGPtblCUnitBranchZip,
    "fGPtbl_CUnitBranch_StateId": fGPtblCUnitBranchStateId,
    "fGPtbl_CUnitBranch_CityId": fGPtblCUnitBranchCityId,
    "fGPtbl_CUnitBranch_Phone": fGPtblCUnitBranchPhone,
    "fGPtbl_CUnitBranch_Fax": fGPtblCUnitBranchFax,
    "fGPtbl_CUnitBranch_Email": fGPtblCUnitBranchEmail,
  };
}
