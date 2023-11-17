import 'dart:convert';

class Step4FacilitiesModel {
  String facilitiesAddressController;
  String plantAndMachineDetailsController;
  String technicalFlowDetailsController;
  String qualityControlDetailsController;
  String testingDetailsController;

  Step4FacilitiesModel(
      {required this.facilitiesAddressController,
      required this.plantAndMachineDetailsController,
      required this.qualityControlDetailsController,
      required this.technicalFlowDetailsController,
      required this.testingDetailsController});
}

String facilitiesToJson(Step4FacilitiesModel facilities){
  return jsonEncode({
    "facilitiesAddressController": facilities.facilitiesAddressController,
    "plantAndMachineDetailsController": facilities.plantAndMachineDetailsController,
    "technicalFlowDetailsController": facilities.technicalFlowDetailsController,
    "qualityControlDetailsController": facilities.qualityControlDetailsController,
    "testingDetailsController": facilities.testingDetailsController
  });
}

Step4FacilitiesModel facilitiesFromJson(String json){
  Map<String , dynamic> data = jsonDecode(json);
  return Step4FacilitiesModel(
      facilitiesAddressController: data["facilitiesAddressController"],
      plantAndMachineDetailsController: data["plantAndMachineDetailsController"],
      qualityControlDetailsController: data["qualityControlDetailsController"],
      technicalFlowDetailsController: data["technicalFlowDetailsController"],
      testingDetailsController: data["testingDetailsController"]
  );
}