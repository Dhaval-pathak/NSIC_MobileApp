import 'dart:convert';

class ProprietorModel{
  String name;
  String address;
  String pin;
  String state;
  String city;
  String telephone;
  String email;
  String lengthOfExperience;
  String adhar;
  String shareholding;

  ProprietorModel({
    required this.name,
    required this.address,
    required this.pin,
    required this.state,
    required this.city,
    required this.telephone,
    required this.email,
    required this.lengthOfExperience,
    required this.adhar,
    required this.shareholding,

});
}
String proprietorToJson(ProprietorModel proprietor){
    return jsonEncode({
      'name':proprietor.name,
      'address':proprietor.address,
      'pin':proprietor.pin,
      'state':proprietor.state,
      'city':proprietor.city,
      'telephone':proprietor.telephone,
      'email':proprietor.email,
      'length_of_experience':proprietor.lengthOfExperience,
    'adhar':proprietor.adhar,
    'shareholding':proprietor.shareholding
    });
}

ProprietorModel proprietorFromJson(String json){
  Map<String,dynamic> data=jsonDecode(json);
  return ProprietorModel(
    name: data['name'],
    address: data['address'],
    pin: data['pin'],
    state: data['state'],
    city: data['city'],
    telephone: data['telephone'],
    email: data['email'],
  lengthOfExperience:data['length_of_experience'],
    adhar: data['adhar'],
    shareholding: data['shareholding'],

  );
}