import 'package:ambulance_dashboard/ambulance_layout.dart';
import 'package:ambulance_dashboard/fire_layout.dart';
import 'package:ambulance_dashboard/police_layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Controller/authentication_functions.dart';

class Delegator extends StatelessWidget {
  const Delegator({super.key});

  @override
  Widget build(BuildContext context) {
    // final userID = Authentication().currentUser!.uid;
    // final findDashboard = FirebaseFirestore.instance
    //     .collection('Administrators')
    //     .doc(userID)
    //     .snapshots();

    return AmbulanceLayout();
    // return FireBrigadeLayout();
    // return PoliceLayout();

    // return StreamBuilder(
    //     stream: findDashboard,
    //     builder:
    //         (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
    //       if (snapshot.hasError) {
    //         return Text("Error: ${snapshot.hasError}");
    //       }
    //       if (snapshot.connectionState == ConnectionState.waiting) {
    //         return const Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       }
    //       if (snapshot.connectionState == ConnectionState.none) {
    //         return Text("Error: " + snapshot.error.toString());
    //       }
    //       if (snapshot.hasData) {
    //         Authentication().signOut();
    //         // mapping json data to map
    //         Map<String, dynamic> data =
    //             snapshot.data?.data() as Map<String, dynamic>;

    //         // redirecting user based upon their departments
    //         if (data['Category'] == 'Ambulance Department' &&
    //             data['Role'] == 'Ambulance Administrator') {
    //         return AmbulanceLayout();
    //         } else if (data['Category'] == 'FireBrigade Department' &&
    //             data['Role'] == 'FireBrigade Administrator') {
    //           return FireBrigadeLayout();
    //         } else if (data['Category'] == 'Police Department' &&
    //             data['Role'] == 'Police Administrator') {
    //           return PoliceLayout();
    //         }
    //         return Center(
    //           child: Text('Contact your respective department'),
    //         );
    //       }
    //       return Text("Error loading");
    //     });
  }
}
