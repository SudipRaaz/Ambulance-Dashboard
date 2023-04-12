import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StaffData extends ChangeNotifier {
  String staffID = "";
  GeoPoint? position = null;

  String getStaffID() => staffID;

  GeoPoint? getPosition() => position;

  // updating the tab
  void setStaffID(String uid) {
    staffID = uid;
    notifyListeners();
  }

  // updating the tab
  void setStaffPosition(GeoPoint pos) {
    position = pos;
    notifyListeners();
  }
}
