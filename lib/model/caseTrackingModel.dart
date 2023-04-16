import 'package:cloud_firestore/cloud_firestore.dart';

class CaseTracking_Model {
  String staffID;
  String userID;
  String name;
  String phoneNumber;
  GeoPoint userLocation;
  GeoPoint staffLocation;

  CaseTracking_Model(
      {required this.staffID,
      required this.userID,
      required this.name,
      required this.phoneNumber,
      required this.userLocation,
      required this.staffLocation});
}
