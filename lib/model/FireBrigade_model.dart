// To parse this JSON data, do
//
//     final allocatingStaff = allocatingStaffFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

FireBrigade_model allocatingStaffFromJson(String str) =>
    FireBrigade_model.fromJson(json.decode(str));

String allocatingStaffToJson(FireBrigade_model data) =>
    json.encode(data.toJson());

class FireBrigade_model {
  FireBrigade_model({
    required this.status,
    required this.caseID,
    required this.allotedAt,
    required this.fireBrigadeAllotedId,
    required this.fireBrigadeLocation,
    required this.fireBrigadeServiceAlloted,
    required this.responseMessage,
  });

  String status;
  int caseID;
  DateTime allotedAt;
  String fireBrigadeAllotedId;
  GeoPoint fireBrigadeLocation;
  bool fireBrigadeServiceAlloted;
  String responseMessage;

  factory FireBrigade_model.fromJson(Map<String, dynamic> json) =>
      FireBrigade_model(
        caseID: json["caseID"] as int,
        status: json["Status"],
        allotedAt: json["allotedAt"] as DateTime,
        fireBrigadeAllotedId: json["ambulanceAllotedID"],
        fireBrigadeLocation: json["ambulanceLocation"] as GeoPoint,
        fireBrigadeServiceAlloted: json["ambulanceServiceAlloted"] as bool,
        responseMessage: json["responseMessage"],
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "caseID": caseID,
        "allotedAt": allotedAt,
        "fireBrigadeAllotedID": fireBrigadeAllotedId,
        "fireBrigadeLocation": fireBrigadeLocation,
        "fireBrigadeServiceAlloted": fireBrigadeServiceAlloted,
        "responseMessage": responseMessage,
      };
}
