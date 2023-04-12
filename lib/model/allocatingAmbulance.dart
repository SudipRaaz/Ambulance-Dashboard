// To parse this JSON data, do
//
//     final allocatingStaff = allocatingStaffFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

AllocatingAmbulance allocatingStaffFromJson(String str) =>
    AllocatingAmbulance.fromJson(json.decode(str));

String allocatingStaffToJson(AllocatingAmbulance data) =>
    json.encode(data.toJson());

class AllocatingAmbulance {
  AllocatingAmbulance({
    required this.status,
    required this.caseID,
    required this.allotedAt,
    required this.ambulanceAllotedId,
    required this.ambulanceLocation,
    required this.ambulanceServiceAlloted,
    required this.responseMessage,
  });

  String status;
  int caseID;
  DateTime allotedAt;
  String ambulanceAllotedId;
  GeoPoint ambulanceLocation;
  bool ambulanceServiceAlloted;
  String responseMessage;

  factory AllocatingAmbulance.fromJson(Map<String, dynamic> json) =>
      AllocatingAmbulance(
        caseID: json["caseID"] as int,
        status: json["Status"],
        allotedAt: json["allotedAt"] as DateTime,
        ambulanceAllotedId: json["ambulanceAllotedID"],
        ambulanceLocation: json["ambulanceLocation"] as GeoPoint,
        ambulanceServiceAlloted: json["ambulanceServiceAlloted"] as bool,
        responseMessage: json["responseMessage"],
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "caseID": caseID,
        "allotedAt": allotedAt,
        "ambulanceAllotedID": ambulanceAllotedId,
        "ambulanceLocation": ambulanceLocation,
        "ambulanceServiceAlloted": ambulanceServiceAlloted,
        "responseMessage": responseMessage,
      };
}
