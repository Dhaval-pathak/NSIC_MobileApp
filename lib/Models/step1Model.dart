// To parse this JSON data, do
//
//     final step1Model = step1ModelFromJson(jsonString);

import 'dart:convert';

Step1Model step1ModelFromJson(String str) => Step1Model.fromJson(json.decode(str));

String step1ModelToJson(Step1Model data) => json.encode(data.toJson());

class Step1Model {
  MsmeDataBank msmeDataBank;

  Step1Model({
    required this.msmeDataBank,
  });

  factory Step1Model.fromJson(Map<String, dynamic> json) => Step1Model(
    msmeDataBank: MsmeDataBank.fromJson(json["MSMEDataBank"]),
  );

  Map<String, dynamic> toJson() => {
    "MSMEDataBank": msmeDataBank.toJson(),
  };
}

class MsmeDataBank {
  String uan;
  String enterpriseName;
  String aadhaarNo;
  String unitCategory;
  String organisationType;
  String natureOfOperation;
  String state;
  String stateId;
  String district;
  String districtId;
  String lgDtCode;
  String lgStCode;
  String pincode;
  String mobile;
  String email;
  String authorisedPersonName;
  String communicationAddress;
  String socialCaterogy;
  String commencementDate;
  String majorActivity;
  String pwDEntrepreneur;
  String womanEntrepreneur;
  String minority;
  String exServiceman;
  String productDesc;
  Factories factories;

  MsmeDataBank({
    required this.uan,
    required this.enterpriseName,
    required this.aadhaarNo,
    required this.unitCategory,
    required this.organisationType,
    required this.natureOfOperation,
    required this.state,
    required this.stateId,
    required this.district,
    required this.districtId,
    required this.lgDtCode,
    required this.lgStCode,
    required this.pincode,
    required this.mobile,
    required this.email,
    required this.authorisedPersonName,
    required this.communicationAddress,
    required this.socialCaterogy,
    required this.commencementDate,
    required this.majorActivity,
    required this.pwDEntrepreneur,
    required this.womanEntrepreneur,
    required this.minority,
    required this.exServiceman,
    required this.productDesc,
    required this.factories,
  });

  factory MsmeDataBank.fromJson(Map<String, dynamic> json) => MsmeDataBank(
    uan: json["UAN"],
    enterpriseName: json["EnterpriseName"],
    aadhaarNo: json["AadhaarNo"],
    unitCategory: json["UnitCategory"],
    organisationType: json["OrganisationType"],
    natureOfOperation: json["NatureOfOperation"],
    state: json["State"],
    stateId: json["StateID"],
    district: json["District"],
    districtId: json["DistrictID"],
    lgDtCode: json["LG_DT_Code"],
    lgStCode: json["LG_ST_Code"],
    pincode: json["Pincode"],
    mobile: json["Mobile"],
    email: json["Email"],
    authorisedPersonName: json["AuthorisedPersonName"],
    communicationAddress: json["CommunicationAddress"],
    socialCaterogy: json["SocialCaterogy"],
    commencementDate: json["CommencementDate"],
    majorActivity: json["MajorActivity"],
    pwDEntrepreneur: json["PwDEntrepreneur"],
    womanEntrepreneur: json["WomanEntrepreneur"],
    minority: json["Minority"],
    exServiceman: json["Ex-Serviceman"],
    productDesc: json["ProductDesc"],
    factories: Factories.fromJson(json["Factories"]),
  );

  Map<String, dynamic> toJson() => {
    "UAN": uan,
    "EnterpriseName": enterpriseName,
    "AadhaarNo": aadhaarNo,
    "UnitCategory": unitCategory,
    "OrganisationType": organisationType,
    "NatureOfOperation": natureOfOperation,
    "State": state,
    "StateID": stateId,
    "District": district,
    "DistrictID": districtId,
    "LG_DT_Code": lgDtCode,
    "LG_ST_Code": lgStCode,
    "Pincode": pincode,
    "Mobile": mobile,
    "Email": email,
    "AuthorisedPersonName": authorisedPersonName,
    "CommunicationAddress": communicationAddress,
    "SocialCaterogy": socialCaterogy,
    "CommencementDate": commencementDate,
    "MajorActivity": majorActivity,
    "PwDEntrepreneur": pwDEntrepreneur,
    "WomanEntrepreneur": womanEntrepreneur,
    "Minority": minority,
    "Ex-Serviceman": exServiceman,
    "ProductDesc": productDesc,
    "Factories": factories.toJson(),
  };
}

class Factories {
  Factory factoriesFactory;

  Factories({
    required this.factoriesFactory,
  });

  factory Factories.fromJson(Map<String, dynamic> json) => Factories(
    factoriesFactory: Factory.fromJson(json["Factory"]),
  );

  Map<String, dynamic> toJson() => {
    "Factory": factoriesFactory.toJson(),
  };
}

class Factory {
  String address;
  String stateId;
  String state;
  String districtId;
  String district;
  String productName;
  String productCode;
  String pincode;
  String lgDtCode;
  String lgStCode;

  Factory({
    required this.address,
    required this.stateId,
    required this.state,
    required this.districtId,
    required this.district,
    required this.productName,
    required this.productCode,
    required this.pincode,
    required this.lgDtCode,
    required this.lgStCode,
  });

  factory Factory.fromJson(Map<String, dynamic> json) => Factory(
    address: json["Address"],
    stateId: json["StateID"],
    state: json["State"],
    districtId: json["DistrictID"],
    district: json["District"],
    productName: json["ProductName"],
    productCode: json["ProductCode"],
    pincode: json["Pincode"],
    lgDtCode: json["LG_DT_Code"],
    lgStCode: json["LG_ST_Code"],
  );

  Map<String, dynamic> toJson() => {
    "Address": address,
    "StateID": stateId,
    "State": state,
    "DistrictID": districtId,
    "District": district,
    "ProductName": productName,
    "ProductCode": productCode,
    "Pincode": pincode,
    "LG_DT_Code": lgDtCode,
    "LG_ST_Code": lgStCode,
  };
}
