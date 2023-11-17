class Step2_Data_Fetched_ForProprietor {
  int? rowno;
  String? fGPtblCompanyDirectorsName;
  String? fGPtblCompanyDirectorsAddress;
  String? fGPtblCompanyDirectorsZip;
  int? fGPtblCompanyDirectorsStateId;
  String? fGPtblMSName;
  int? fGPtblCompanyDirectorsCityId;
  String? fGPtblMCtyName;
  String? fGPtblCompanyDirectorsPhone;
  String? fGPtblCompanyDirectorsShareholder;
  String? fGPtblCompanyDirectorsEmail;
  int? fGPtblCompanyDirectorsExperience;
  String? fGPtblCompanyDirectorsAdhar;

  Step2_Data_Fetched_ForProprietor(
      {this.rowno,
        this.fGPtblCompanyDirectorsName,
        this.fGPtblCompanyDirectorsAddress,
        this.fGPtblCompanyDirectorsZip,
        this.fGPtblCompanyDirectorsStateId,
        this.fGPtblMSName,
        this.fGPtblCompanyDirectorsCityId,
        this.fGPtblMCtyName,
        this.fGPtblCompanyDirectorsPhone,
        this.fGPtblCompanyDirectorsShareholder,
        this.fGPtblCompanyDirectorsEmail,
        this.fGPtblCompanyDirectorsExperience,
        this.fGPtblCompanyDirectorsAdhar});

  Step2_Data_Fetched_ForProprietor.fromJson(Map<String, dynamic> json) {
    rowno = json['rowno'];
    fGPtblCompanyDirectorsName = json['fGPtbl_Company_Directors_Name'];
    fGPtblCompanyDirectorsAddress = json['fGPtbl_Company_Directors_Address'];
    fGPtblCompanyDirectorsZip = json['fGPtbl_Company_Directors_Zip'];
    fGPtblCompanyDirectorsStateId = json['fGPtbl_Company_Directors_StateId'];
    fGPtblMSName = json['fGPtbl_MS_Name'];
    fGPtblCompanyDirectorsCityId = json['fGPtbl_Company_Directors_CityId'];
    fGPtblMCtyName = json['fGPtbl_MCty_Name'];
    fGPtblCompanyDirectorsPhone = json['fGPtbl_Company_Directors_Phone'];
    fGPtblCompanyDirectorsShareholder =
    json['fGPtbl_Company_Directors_Shareholder'];
    fGPtblCompanyDirectorsEmail = json['fGPtbl_Company_Directors_Email'];
    fGPtblCompanyDirectorsExperience =
    json['fGPtbl_Company_Directors_Experience'];
    fGPtblCompanyDirectorsAdhar = json['fGPtbl_Company_Directors_Adhar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rowno'] = this.rowno;
    data['fGPtbl_Company_Directors_Name'] = this.fGPtblCompanyDirectorsName;
    data['fGPtbl_Company_Directors_Address'] =
        this.fGPtblCompanyDirectorsAddress;
    data['fGPtbl_Company_Directors_Zip'] = this.fGPtblCompanyDirectorsZip;
    data['fGPtbl_Company_Directors_StateId'] =
        this.fGPtblCompanyDirectorsStateId;
    data['fGPtbl_MS_Name'] = this.fGPtblMSName;
    data['fGPtbl_Company_Directors_CityId'] = this.fGPtblCompanyDirectorsCityId;
    data['fGPtbl_MCty_Name'] = this.fGPtblMCtyName;
    data['fGPtbl_Company_Directors_Phone'] = this.fGPtblCompanyDirectorsPhone;
    data['fGPtbl_Company_Directors_Shareholder'] =
        this.fGPtblCompanyDirectorsShareholder;
    data['fGPtbl_Company_Directors_Email'] = this.fGPtblCompanyDirectorsEmail;
    data['fGPtbl_Company_Directors_Experience'] =
        this.fGPtblCompanyDirectorsExperience;
    data['fGPtbl_Company_Directors_Adhar'] = this.fGPtblCompanyDirectorsAdhar;
    return data;
  }
}
