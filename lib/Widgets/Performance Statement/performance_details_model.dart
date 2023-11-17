import 'dart:convert';

class PerformanceDetails {
  String orderId;
  String date;
  String description;
  String quantity;
  String value;
  String nameConsignee;
  String dateDelivery;
  String dateMaterialDelivery;
  String despatchingParticulars;
  String remarks;

  PerformanceDetails({
    required this.orderId,
    required this.date,
    required this.description,
    required this.quantity,
    required this.value,
    required this.nameConsignee,
    required this.dateDelivery,
    required this.dateMaterialDelivery,
    required this.despatchingParticulars,
    required this.remarks,
  });
}

String performanceToJson(PerformanceDetails details) {
  return jsonEncode({
    "orderId": details.orderId,
    "date": details.date,
    "description": details.description,
    "quantity": details.quantity,
    "value": details.value,
    "nameConsignee": details.nameConsignee,
    "dateDelivery": details.dateDelivery,
    "dateMaterialDelivery": details.dateMaterialDelivery,
    "despatchingParticulars": details.despatchingParticulars,
    "remarks": details.remarks
  });
}

PerformanceDetails performanceFromJson(String json) {
  Map<String, dynamic> data = jsonDecode(json);
  return PerformanceDetails(
      orderId: data["orderId"],
      date: data["date"],
      description: data["description"],
      quantity: data["quantity"],
      value: data["value"],
      nameConsignee: data["nameConsignee"],
      dateDelivery: data["dateDelivery"],
      dateMaterialDelivery: data["dateMaterialDelivery"],
      despatchingParticulars: data["despatchingParticulars"],
      remarks: data["remarks"]
  );
}
