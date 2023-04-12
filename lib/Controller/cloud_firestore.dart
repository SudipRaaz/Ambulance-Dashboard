import 'package:ambulance_dashboard/model/allocatingAmbulance.dart';
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

  // @override
  // Future submitFeedback(int? rating, String? comment, String? report) async {
  //   // collection reference and doc id naming
  //   final docUser = FirebaseFirestore.instance.collection('CustomerCare').doc();

  //   final feeback =
  //       CustomerCare(rating: rating, comment: comment, report: report);
  //   // wating for doc set josn object on firebase
  //   await docUser.set(feeback.toJson());
  // }
}
