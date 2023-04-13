import 'package:ambulance_dashboard/model/FireBrigade_model.dart';
import 'package:ambulance_dashboard/model/allocatingAmbulance.dart';
import 'package:ambulance_dashboard/model/police_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class MyCloudStoreBase {
  // registering user data to database
  // Future registerUser(String? uid, String name, String email, int phoneNumber);

  Future allocateAmbulanceStaff(
      String ambulanceDeptDocID, AllocatingAmbulance allocationData);

  Future allocateFireBrigadeStaff(
      String fireDeptDocID, FireBrigade_model allocationData);

  Future allocatePoliceStaff(
      String policeDeptDocID, Police_model allocationData);
}
