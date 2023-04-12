import 'package:ambulance_dashboard/model/allocatingAmbulance.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class MyCloudStoreBase {
  // registering user data to database
  // Future registerUser(String? uid, String name, String email, int phoneNumber);

  Future allocateAmbulanceStaff(
      String ambulanceDeptDocID, AllocatingAmbulance allocationData);
}
