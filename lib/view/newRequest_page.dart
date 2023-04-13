import 'package:ambulance_dashboard/view/Ambulance_VIew/Ambu_newRequest.dart';
import 'package:ambulance_dashboard/view/FireBrigade_View/Fire_newRequest.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Controller/authentication_functions.dart';

class NewRequestHome extends StatelessWidget {
  const NewRequestHome({super.key});

  @override
  Widget build(BuildContext context) {
    final userID = Authentication().currentUser!.uid;
    final userProfile = FirebaseFirestore.instance
        .collection('Administrators')
        .doc(userID)
        .snapshots();

    return StreamBuilder(
        stream: userProfile,
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Error: ${snapshot.hasError}");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.connectionState == ConnectionState.none) {
            return Text("Error: " + snapshot.error.toString());
          }
          if (snapshot.hasData) {
            Authentication().signOut();
            // mapping json data to map
            Map<String, dynamic> data =
                snapshot.data?.data() as Map<String, dynamic>;

            // redirecting user based upon their departments
            // if (data['Category'] == 'Ambulance Department' &&
            //     data['Role'] == 'Ambulance Administrator') {
            return AmbuNewRequests();
            // } else if (data['Category'] == 'FireBrigade Department' &&
            //     data['Role'] == 'FireBrigade Administrator') {
            // return FireNewRequests();
            // } else if (data['Category'] == 'Police Department' &&
            //     data['Role'] == 'Police Administrator') {}

            // return Center(
            //   child: Text('Contact your respective department'),
            // );
          }
          return Text("Error loading");
        });
  }
}
