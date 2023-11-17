class Step3_Data_Fetched_ForUpperFields {
  int? fGPtblCUnit3D;
  String? fGPtblCUnit3E;
  String? fGPtblCUnit3F;
  String? fGPtblCUnit3G;
  String? fGPtblCUnit3H;
  String? fGPtblCUnit3I;
  String? fGPtblCUnit3J;
  String? fGPtblCUnit3K1;
  String? fGPtblCUnit3L;
  String? fGPtblCUnit3M;
  String? fGPtblCUnit3N;
  String? fGPtblCUnit3O;
  String? fGPtblCUnit4A;
  String? fGPtblCUnit4B;

  Step3_Data_Fetched_ForUpperFields(
      {this.fGPtblCUnit3D,
      this.fGPtblCUnit3E,
      this.fGPtblCUnit3F,
      this.fGPtblCUnit3G,
      this.fGPtblCUnit3H,
      this.fGPtblCUnit3I,
      this.fGPtblCUnit3J,
      this.fGPtblCUnit3K1,
      this.fGPtblCUnit3L,
      this.fGPtblCUnit3M,
      this.fGPtblCUnit3N,
      this.fGPtblCUnit3O,
      this.fGPtblCUnit4A,
      this.fGPtblCUnit4B});

  Step3_Data_Fetched_ForUpperFields.fromJson(Map<String, dynamic> json) {
    fGPtblCUnit3D = json['fGPtbl_CUnit_3D'];
    fGPtblCUnit3E = json['fGPtbl_CUnit_3E'];
    fGPtblCUnit3F = json['fGPtbl_CUnit_3F'];
    fGPtblCUnit3G = json['fGPtbl_CUnit_3G'];
    fGPtblCUnit3H = json['fGPtbl_CUnit_3H'];
    fGPtblCUnit3I = json['fGPtbl_CUnit_3I'];
    fGPtblCUnit3J = json['fGPtbl_CUnit_3J'];
    fGPtblCUnit3K1 = json['fGPtbl_CUnit_3K1'];
    fGPtblCUnit3L = json['fGPtbl_CUnit_3L'];
    fGPtblCUnit3M = json['fGPtbl_CUnit_3M'];
    fGPtblCUnit3N = json['fGPtbl_CUnit_3N'];
    fGPtblCUnit3O = json['fGPtbl_CUnit_3O'];
    fGPtblCUnit4A = json['fGPtbl_CUnit_4A'];
    fGPtblCUnit4B = json['fGPtbl_CUnit_4B'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fGPtbl_CUnit_3D'] = this.fGPtblCUnit3D;
    data['fGPtbl_CUnit_3E'] = this.fGPtblCUnit3E;
    data['fGPtbl_CUnit_3F'] = this.fGPtblCUnit3F;
    data['fGPtbl_CUnit_3G'] = this.fGPtblCUnit3G;
    data['fGPtbl_CUnit_3H'] = this.fGPtblCUnit3H;
    data['fGPtbl_CUnit_3I'] = this.fGPtblCUnit3I;
    data['fGPtbl_CUnit_3J'] = this.fGPtblCUnit3J;
    data['fGPtbl_CUnit_3K1'] = this.fGPtblCUnit3K1;
    data['fGPtbl_CUnit_3L'] = this.fGPtblCUnit3L;
    data['fGPtbl_CUnit_3M'] = this.fGPtblCUnit3M;
    data['fGPtbl_CUnit_3N'] = this.fGPtblCUnit3N;
    data['fGPtbl_CUnit_3O'] = this.fGPtblCUnit3O;
    data['fGPtbl_CUnit_4A'] = this.fGPtblCUnit4A;
    data['fGPtbl_CUnit_4B'] = this.fGPtblCUnit4B;
    return data;
  }
}
