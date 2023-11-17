import 'dart:convert';

class Step4FactoryModel {
  String step4factoryaddressController;
  String step4AddressController;
  String step4teleController;
  String step4powerController;
  String step4power2Controller;
  String step4descController;

  Step4FactoryModel({
    required this.step4factoryaddressController,
    required this.step4AddressController,
    required this.step4teleController,
    required this.step4powerController,
    required this.step4power2Controller,
    required this.step4descController,
  });
}

String storeToJson(Step4FactoryModel store) {
  return jsonEncode({
    'step4factoryaddressController': store.step4factoryaddressController,
    'step4Address':store.step4AddressController,
    'step4teleController': store.step4teleController,
    'step4powerController': store.step4powerController,
    'step4power2Controller': store.step4power2Controller,
    'step4descController': store.step4descController,
  });
}

Step4FactoryModel storeFromJson(String json) {
  Map<String, dynamic> data = jsonDecode(json);
  return Step4FactoryModel(
    step4factoryaddressController: data['step4factoryaddressController'],
    step4AddressController:data['step4Address'],
    step4teleController: data['step4teleController'],
    step4powerController: data['step4powerController'],
    step4power2Controller: data['step4power2Controller'],
    step4descController: data['step4descController'],
  );
}
