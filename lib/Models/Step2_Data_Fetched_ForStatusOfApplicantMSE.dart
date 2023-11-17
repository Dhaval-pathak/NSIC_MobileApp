import 'dart:convert';

class Step2FetchedData_ForStatusofApplicantMSE {
  int? fGPtblCUnitId;
  String? fGPtblCUnit1BFactoryAddress;
  String? fGPtblCUnitSSIRegistrationNo;
  String? fGPtblCUnitSSIRegistrationDate;
  String? fGPtblCUnit3A;
  String? fGPtblCUnit3B;
  int? fGPtblCUnit3C123ConstitutionId;
  String? fGPtblCUnit1BFactoryEmail;
  String? fGPtblCUnit3C5;

  Step2FetchedData_ForStatusofApplicantMSE(
      {this.fGPtblCUnitId,
      this.fGPtblCUnit1BFactoryAddress,
      this.fGPtblCUnitSSIRegistrationNo,
      this.fGPtblCUnitSSIRegistrationDate,
      this.fGPtblCUnit3A,
      this.fGPtblCUnit3B,
      this.fGPtblCUnit3C123ConstitutionId,
      this.fGPtblCUnit1BFactoryEmail,
      this.fGPtblCUnit3C5});

  Step2FetchedData_ForStatusofApplicantMSE.fromJson(Map<String, dynamic> json) {
    fGPtblCUnitId = json['fGPtbl_CUnit_Id'];
    fGPtblCUnit1BFactoryAddress = json['fGPtbl_CUnit_1B_Factory_Address'];
    fGPtblCUnitSSIRegistrationNo = json['fGPtbl_CUnit_SSIRegistrationNo'];
    fGPtblCUnitSSIRegistrationDate = json['fGPtbl_CUnit_SSIRegistrationDate'];
    fGPtblCUnit3A = json['fGPtbl_CUnit_3A'];
    fGPtblCUnit3B = json['fGPtbl_CUnit_3B'];
    fGPtblCUnit3C123ConstitutionId = json['fGPtbl_CUnit_3C123_ConstitutionId'];
    fGPtblCUnit1BFactoryEmail = json['fGPtbl_CUnit_1B_Factory_Email'];
    fGPtblCUnit3C5 = json['fGPtbl_CUnit_3C5'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fGPtbl_CUnit_Id'] = this.fGPtblCUnitId;
    data['fGPtbl_CUnit_1B_Factory_Address'] = this.fGPtblCUnit1BFactoryAddress;
    data['fGPtbl_CUnit_SSIRegistrationNo'] = this.fGPtblCUnitSSIRegistrationNo;
    data['fGPtbl_CUnit_SSIRegistrationDate'] =
        this.fGPtblCUnitSSIRegistrationDate;
    data['fGPtbl_CUnit_3A'] = this.fGPtblCUnit3A;
    data['fGPtbl_CUnit_3B'] = this.fGPtblCUnit3B;
    data['fGPtbl_CUnit_3C123_ConstitutionId'] =
        this.fGPtblCUnit3C123ConstitutionId;
    data['fGPtbl_CUnit_1B_Factory_Email'] = this.fGPtblCUnit1BFactoryEmail;
    data['fGPtbl_CUnit_3C5'] = this.fGPtblCUnit3C5;
    return data;
  }
}

Step2FetchedData_ForStatusofApplicantMSE CunitaddressFromJson(String json) {
  Map<String, dynamic> data = jsonDecode(json);
  return Step2FetchedData_ForStatusofApplicantMSE(
    fGPtblCUnitId: data['fGPtblCUnitId'],
    fGPtblCUnit1BFactoryAddress: data['fGPtblCUnit1BFactoryAddress'],
    fGPtblCUnitSSIRegistrationNo: data['fGPtblCUnitSSIRegistrationNo'],
    fGPtblCUnitSSIRegistrationDate: data['fGPtblCUnitSSIRegistrationDate'],
    fGPtblCUnit3A: data['fGPtblCUnit3A'],
    fGPtblCUnit3B: data['fGPtblCUnit3B'],
    fGPtblCUnit3C123ConstitutionId: data['fGPtblCUnit3C123ConstitutionId'],
    fGPtblCUnit1BFactoryEmail: data['fGPtblCUnit1BFactoryEmail'],
    fGPtblCUnit3C5: data['fGPtblCUnit3C5'],
  );
}

String CunitaddressToJson(Step2FetchedData_ForStatusofApplicantMSE address) {
  return jsonEncode({
    "fGPtblCUnitId": address.fGPtblCUnitId,
    "fGPtblCUnit1BFactoryAddress": address.fGPtblCUnit1BFactoryAddress,
    "fGPtblCUnitSSIRegistrationNo": address.fGPtblCUnitSSIRegistrationNo,
    "fGPtblCUnitSSIRegistrationDate": address.fGPtblCUnitSSIRegistrationDate,
    "fGPtblCUnit3A": address.fGPtblCUnit3A,
    "fGPtblCUnit3B": address.fGPtblCUnit3B,
    "fGPtblCUnit3C123ConstitutionId": address.fGPtblCUnit3C123ConstitutionId,
    "fGPtblCUnit1BFactoryEmail": address.fGPtblCUnit1BFactoryEmail,
    "fGPtblCUnit3C5": address.fGPtblCUnit3C5,
  });
}
