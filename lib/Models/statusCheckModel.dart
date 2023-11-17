
import 'dart:convert';

StatusCheckModel statusCheckModelFromJson(String str) => StatusCheckModel.fromJson(json.decode(str));

String statusCheckModelToJson(StatusCheckModel data) => json.encode(data.toJson());

class StatusCheckModel {
  int status;
  int accessId;
  int branchId;
  dynamic branchName;

  StatusCheckModel({
    required this.status,
    required this.accessId,
    required this.branchId,
    this.branchName,
  });

  factory StatusCheckModel.fromJson(Map<String, dynamic> json) => StatusCheckModel(
    status: json["Status"],
    accessId: json["AccessId"],
    branchId: json["BranchID"],
    branchName: json["BranchName"],
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "AccessId": accessId,
    "BranchID": branchId,
    "BranchName": branchName,
  };
}
