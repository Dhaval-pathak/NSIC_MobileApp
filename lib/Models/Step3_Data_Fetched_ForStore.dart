class Step3_Data_Fetched_ForStore {
  int? fGPtblCUnitStoreId;
  String? fGPtblCUnitStoreSNo;
  int? fGPtblCUnitStoreUnitId;
  String? fGPtblCUnitStoreDescriptionStoresProducts;
  String? fGPtblCUnitStoreRefOfBISSpecification;
  String? fGPtblCUnitStoreModelBrand;
  String? fGPtblCUnitStoreLimitingSizeCapacityRating;
  String? fGPtblCUnitStoreAnnualProductionCapacity;
  int? fGPtblCUnitStoreNoOfShifts;


  Step3_Data_Fetched_ForStore(
      {this.fGPtblCUnitStoreId,
        this.fGPtblCUnitStoreSNo,
        this.fGPtblCUnitStoreUnitId,
        this.fGPtblCUnitStoreDescriptionStoresProducts,
        this.fGPtblCUnitStoreRefOfBISSpecification,
        this.fGPtblCUnitStoreModelBrand,
        this.fGPtblCUnitStoreLimitingSizeCapacityRating,
        this.fGPtblCUnitStoreAnnualProductionCapacity,
        this.fGPtblCUnitStoreNoOfShifts,
});

  Step3_Data_Fetched_ForStore.fromJson(Map<String, dynamic> json) {
    fGPtblCUnitStoreId = json['fGPtbl_CUnit_Store_Id'];
    fGPtblCUnitStoreSNo = json['fGPtbl_CUnit_Store_SNo'];
    fGPtblCUnitStoreUnitId = json['fGPtbl_CUnit_Store_UnitId'];
    fGPtblCUnitStoreDescriptionStoresProducts =
    json['fGPtbl_CUnit_Store_DescriptionStoresProducts'];
    fGPtblCUnitStoreRefOfBISSpecification =
    json['fGPtbl_CUnit_Store_RefOfBISSpecification'];
    fGPtblCUnitStoreModelBrand = json['fGPtbl_CUnit_Store_ModelBrand'];
    fGPtblCUnitStoreLimitingSizeCapacityRating =
    json['fGPtbl_CUnit_Store_LimitingSizeCapacityRating'];
    fGPtblCUnitStoreAnnualProductionCapacity =
    json['fGPtbl_CUnit_Store_AnnualProductionCapacity'];
    fGPtblCUnitStoreNoOfShifts = json['fGPtbl_CUnit_Store_NoOfShifts'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fGPtbl_CUnit_Store_Id'] = this.fGPtblCUnitStoreId;
    data['fGPtbl_CUnit_Store_SNo'] = this.fGPtblCUnitStoreSNo;
    data['fGPtbl_CUnit_Store_UnitId'] = this.fGPtblCUnitStoreUnitId;
    data['fGPtbl_CUnit_Store_DescriptionStoresProducts'] =
        this.fGPtblCUnitStoreDescriptionStoresProducts;
    data['fGPtbl_CUnit_Store_RefOfBISSpecification'] =
        this.fGPtblCUnitStoreRefOfBISSpecification;
    data['fGPtbl_CUnit_Store_ModelBrand'] = this.fGPtblCUnitStoreModelBrand;
    data['fGPtbl_CUnit_Store_LimitingSizeCapacityRating'] =
        this.fGPtblCUnitStoreLimitingSizeCapacityRating;
    data['fGPtbl_CUnit_Store_AnnualProductionCapacity'] =
        this.fGPtblCUnitStoreAnnualProductionCapacity;
    data['fGPtbl_CUnit_Store_NoOfShifts'] = this.fGPtblCUnitStoreNoOfShifts;

    return data;
  }
}
