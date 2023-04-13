// To parse this JSON data, do
//
//     final allocatingStaff = allocatingStaffFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

Police_model allocatingStaffFromJson(String str) =>
    Police_model.fromJson(json.decode(str));

String allocatingStaffToJson(Police_model data) => json.encode(data.toJson());

class Police_model {
  Police_model({
    required this.status,
    required this.caseID,
    required this.allotedAt,
    required this.policeAllotedId,
    required this.policeLocation,
    required this.policeServiceAlloted,
    required this.responseMessage,
  });

  String status;
  int caseID;
  DateTime allotedAt;
  String policeAllotedId;
  GeoPoint policeLocation;
  bool policeServiceAlloted;
  String responseMessage;

  factory Police_model.fromJson(Map<String, dynamic> json) => Police_model(
        caseID: json["caseID"] as int,
        status: json["Status"],
        allotedAt: json["allotedAt"] as DateTime,
        policeAllotedId: json["policeAllotedID"],
        policeLocation: json["policeLocation"] as GeoPoint,
        policeServiceAlloted: json["policeServiceAlloted"] as bool,
        responseMessage: json["responseMessage"],
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "caseID": caseID,
        "allotedAt": allotedAt,
        "policeAllotedID": policeAllotedId,
        "policeLocation": policeLocation,
        "policeServiceAlloted": policeServiceAlloted,
        "responseMessage": responseMessage,
      };
}
