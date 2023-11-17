import 'dart:convert';

class StoreModel {
  String sno;
  String location;
  String description;
  String bisSpecification;
  String model;
  String limitingSizeCapacity;
  String monthlyProductionCapacity;
  String numberOfShifts;

  StoreModel({
    required this.sno,
    required this.location,
    required this.description,
    required this.bisSpecification,
    required this.model,
    required this.limitingSizeCapacity,
    required this.monthlyProductionCapacity,
    required this.numberOfShifts,
  });
}

String storeToJson(StoreModel store) {
  return jsonEncode({
    'sno': store.sno,
    'location': store.location,
    'description': store.description,
    'bis_specification': store.bisSpecification,
    'model': store.model,
    'limiting_size_capacity': store.limitingSizeCapacity,
    'monthly_production_capacity': store.monthlyProductionCapacity,
    'number_of_shifts': store.numberOfShifts,
  });
}

StoreModel storeFromJson(String json) {
  Map<String, dynamic> data = jsonDecode(json);
  return StoreModel(
    sno: data['sno'],
    location: data['location'],
    description: data['description'],
    bisSpecification: data['bis_specification'],
    model: data['model'],
    limitingSizeCapacity: data['limiting_size_capacity'],
    monthlyProductionCapacity: data['monthly_production_capacity'],
    numberOfShifts: data['number_of_shifts'],
  );
}
