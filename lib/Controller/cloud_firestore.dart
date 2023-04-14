import 'dart:developer';

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

  @override
  Future statusUpdate(String departmentName, String DocID, int caseID,
      String field, String value) async {
    // field update map models
    Map<String, String> fireStatus = {field: value};

    final databaseReference =
        FirebaseFirestore.instance.collection(departmentName).doc(DocID);
    // updating user's request
    FirebaseFirestore.instance
        .collection('CustomerRequests')
        .where('caseID', isEqualTo: caseID)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        FirebaseFirestore.instance
            .collection('CustomerRequests')
            .doc(doc.id)
            .update(fireStatus);
      });
    });

    // wating for doc set json object on firebase
    await databaseReference.update(fireStatus);
  }

  @override
  Future userAccessUpdate(
      String departmentName, String DocID, String field, bool value) async {
    // field update map models
    Map<String, bool> fireStatus = {field: value};

    final databaseReference =
        FirebaseFirestore.instance.collection(departmentName).doc(DocID);
    // wating for doc set json object on firebase
    await databaseReference.update(fireStatus);
  }
}
