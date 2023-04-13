import 'package:ambulance_dashboard/model/FireBrigade_model.dart';
import 'package:ambulance_dashboard/model/allocatingAmbulance.dart';
import 'package:ambulance_dashboard/model/police_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ambulance_dashboard/Controller/cloud_firestore_base.dart';
import 'package:flutter/material.dart';

class MyCloudStore extends MyCloudStoreBase {
  @override
  Future allocateAmbulanceStaff(
      String documentID, AllocatingAmbulance allocationData) async {
    final ambulanceDepartmentDatabaseReference = FirebaseFirestore.instance
        .collection('AmbulanceDepartment')
        .doc(documentID);
    DateTime time = DateTime.now();
    final ambulanceDepartmentUpdate = AllocatingAmbulance(
        status: allocationData.status,
        caseID: allocationData.caseID,
        allotedAt: allocationData.allotedAt,
        ambulanceAllotedId: allocationData.ambulanceAllotedId,
        ambulanceLocation: allocationData.ambulanceLocation,
        ambulanceServiceAlloted: allocationData.ambulanceServiceAlloted,
        responseMessage: allocationData.responseMessage);

    // updating user's request
    FirebaseFirestore.instance
        .collection('CustomerRequests')
        .where('caseID', isEqualTo: allocationData.caseID)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        FirebaseFirestore.instance
            .collection('CustomerRequests')
            .doc(doc.id)
            .update(ambulanceDepartmentUpdate.toJson());
      });
    });

    // wating for doc set josn object on firebase
    await ambulanceDepartmentDatabaseReference
        .update(ambulanceDepartmentUpdate.toJson());
  }

  @override
  Future allocateFireBrigadeStaff(
      String fireDeptDocID, FireBrigade_model allocationData) async {
    final ambulanceDepartmentDatabaseReference = FirebaseFirestore.instance
        .collection('FireBrigadeDepartment')
        .doc(fireDeptDocID);
    DateTime time = DateTime.now();
    final ambulanceDepartmentUpdate = FireBrigade_model(
        status: allocationData.status,
        caseID: allocationData.caseID,
        allotedAt: allocationData.allotedAt,
        fireBrigadeAllotedId: allocationData.fireBrigadeAllotedId,
        fireBrigadeLocation: allocationData.fireBrigadeLocation,
        fireBrigadeServiceAlloted: allocationData.fireBrigadeServiceAlloted,
        responseMessage: allocationData.responseMessage);

    // updating user's request
    FirebaseFirestore.instance
        .collection('CustomerRequests')
        .where('caseID', isEqualTo: allocationData.caseID)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        FirebaseFirestore.instance
            .collection('CustomerRequests')
            .doc(doc.id)
            .update(ambulanceDepartmentUpdate.toJson());
      });
    });

    // wating for doc set josn object on firebase
    await ambulanceDepartmentDatabaseReference
        .update(ambulanceDepartmentUpdate.toJson());
  }

  @override
  Future allocatePoliceStaff(
      String policeDeptDocID, Police_model allocationData) async {
    final ambulanceDepartmentDatabaseReference = FirebaseFirestore.instance
        .collection('PoliceDepartment')
        .doc(policeDeptDocID);
    DateTime time = DateTime.now();
    final ambulanceDepartmentUpdate = Police_model(
        status: allocationData.status,
        caseID: allocationData.caseID,
        allotedAt: allocationData.allotedAt,
        policeAllotedId: allocationData.policeAllotedId,
        policeLocation: allocationData.policeLocation,
        policeServiceAlloted: allocationData.policeServiceAlloted,
        responseMessage: allocationData.responseMessage);

    // updating user's request
    FirebaseFirestore.instance
        .collection('CustomerRequests')
        .where('caseID', isEqualTo: allocationData.caseID)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        FirebaseFirestore.instance
            .collection('CustomerRequests')
            .doc(doc.id)
            .update(ambulanceDepartmentUpdate.toJson());
      });
    });

    // wating for doc set josn object on firebase
    await ambulanceDepartmentDatabaseReference
        .update(ambulanceDepartmentUpdate.toJson());
  }
}
