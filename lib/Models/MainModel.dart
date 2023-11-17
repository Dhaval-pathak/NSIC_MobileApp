// To parse this JSON data, do
//
//     final mainModel = mainModelFromJson(jsonString);

import 'dart:convert';

MainModel mainModelFromJson(String str) => MainModel.fromJson(json.decode(str));

String mainModelToJson(MainModel data) => json.encode(data.toJson());

class MainModel {
  int id;
  String name;

  MainModel({
    required this.id,
    required this.name,
  });

  factory MainModel.fromJson(Map<String, dynamic> json) => MainModel(
    id: json["Id"],
    name: json["Name"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "Name": name,
  };
}
