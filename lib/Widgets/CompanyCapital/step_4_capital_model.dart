import 'dart:convert';

class Step4CapitalModel {
  String step4CapitalAddressController;
  String step4CapitalLandController;
  String step4CapitalMachineController;
  String step4CapitalEquipmentController;
  String step4CapitalAssetsController;
  String step4CapitalServiceAssetsController;
  String step4CapitalTotalController;

  Step4CapitalModel({
    required this.step4CapitalAddressController,
    required this.step4CapitalLandController,
    required this.step4CapitalMachineController,
    required this.step4CapitalEquipmentController,
    required this.step4CapitalAssetsController,
    required this.step4CapitalServiceAssetsController,
    required this.step4CapitalTotalController,
  });
}

String capitalToJson(Step4CapitalModel capital){
  return jsonEncode({
    "step4CapitalAddressController": capital.step4CapitalAddressController,
    "step4CapitalLandController": capital.step4CapitalLandController,
    "step4CapitalMachineController": capital.step4CapitalMachineController,
    "step4CapitalEquipmentController": capital.step4CapitalEquipmentController,
    "step4CapitalAssetsController" : capital.step4CapitalAssetsController,
    "step4CapitalServiceAssetsController": capital.step4CapitalServiceAssetsController,
    "step4CapitalTotalController": capital.step4CapitalTotalController
  });
}

Step4CapitalModel capitalFromJson(String json){
  Map<String, dynamic> data = jsonDecode(json);
  return Step4CapitalModel(
      step4CapitalAddressController: data["step4CapitalAddressController"],
      step4CapitalLandController: data["step4CapitalLandController"],
      step4CapitalMachineController: data["step4CapitalMachineController"],
      step4CapitalEquipmentController: data["step4CapitalEquipmentController"],
      step4CapitalAssetsController: data["step4CapitalAssetsController"],
      step4CapitalServiceAssetsController: data["step4CapitalServiceAssetsController"],
      step4CapitalTotalController: data["step4CapitalTotalController"]);
}