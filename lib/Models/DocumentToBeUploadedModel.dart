// To parse this JSON data, do
//
//     final documentToBeUploadedModel = documentToBeUploadedModelFromJson(jsonString);

import 'dart:convert';

List<DocumentToBeUploadedModel> documentToBeUploadedModelFromJson(String str) => List<DocumentToBeUploadedModel>.from(json.decode(str).map((x) => DocumentToBeUploadedModel.fromJson(x)));

String documentToBeUploadedModelToJson(List<DocumentToBeUploadedModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DocumentToBeUploadedModel {
  int fGPtblMdId;
  String fGPtblMdDocumentName;
  String link;
  String size;

  DocumentToBeUploadedModel({
    required this.fGPtblMdId,
    required this.fGPtblMdDocumentName,
    required this.link,
    required this.size,
  });

  factory DocumentToBeUploadedModel.fromJson(Map<String, dynamic> json) => DocumentToBeUploadedModel(
    fGPtblMdId: json["fGPtbl_MD_Id"],
    fGPtblMdDocumentName: json["fGPtbl_MD_DocumentName"],
    link: json["Link"],
    size: json["Size"],
  );

  Map<String, dynamic> toJson() => {
    "fGPtbl_MD_Id": fGPtblMdId,
    "fGPtbl_MD_DocumentName": fGPtblMdDocumentName,
    "Link": link,
    "Size": size,
  };
}
