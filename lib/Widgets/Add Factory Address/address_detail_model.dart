import 'dart:convert';

class AddressDetails {
  String address;
  String pin;
  String state;
  String district;
  String tel;
  String email;
  String nature;

  AddressDetails({
    required this.address,
    required this.pin,
    required this.state,
    required this.district,
    required this.tel,
    required this.email,
    required this.nature,
  });
}

String addressToJson(AddressDetails address) {
  return jsonEncode({
    "address": address.address,
    "pin": address.pin,
    "state": address.state,
    "district": address.district,
    "tel": address.tel,
    "email": address.email,
    "nature": address.nature,

  });
}

AddressDetails addressFromJson(String json) {
  Map<String, dynamic> data = jsonDecode(json);
  return AddressDetails(
    address: data['address'],
    pin: data['pin'],
    state: data['state'],
    district: data['district'],
    tel: data['tel'],
    email: data['email'],
    nature: data['nature'],

  );
}
