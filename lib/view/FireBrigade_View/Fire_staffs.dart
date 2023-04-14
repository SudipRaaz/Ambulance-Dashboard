import 'dart:developer';

import 'package:ambulance_dashboard/Controller/cloud_firestore.dart';
import 'package:ambulance_dashboard/Controller/cloud_firestore_base.dart';
import 'package:ambulance_dashboard/utilities/InfoDisp/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FireStaffs extends StatefulWidget {
  const FireStaffs({super.key});

  @override
  State<FireStaffs> createState() => _FireStaffsState();
}

class _FireStaffsState extends State<FireStaffs> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

// getting user requests
    final _requestStream = FirebaseFirestore.instance
        .collection('Staffs')
        .where('Category', isEqualTo: 'FireBrigade Department')
        .snapshots();

    // list
    List staffData;
    late bool staffStatus;

    return StreamBuilder<QuerySnapshot>(
        stream: _requestStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            //clearing the productsDocs list
            staffData = [];

            snapshot.data!.docs.map((DocumentSnapshot document) {
              Map historyData = document.data() as Map<String, dynamic>;
              historyData['documentID'] = document.id;
              staffData.add(historyData);
            }).toList();

            return Scaffold(
                body: SingleChildScrollView(
                    child: Column(children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 35.0, vertical: 50),
                child: Container(
                    width: width,
                    decoration: BoxDecoration(
                        border: Border.all(width: 2),
                        borderRadius: BorderRadius.circular(25)),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: DataTable(
                        columns: const <DataColumn>[
                          DataColumn(label: Text('Staff ID')),
                          DataColumn(label: Text('Staff Name')),
                          DataColumn(label: Text('Staff Number')),
                          DataColumn(label: Text('Staff Email')),
                          DataColumn(label: Text('Active Status')),
                          DataColumn(label: Text('Access')),
                        ],
                        rows: List<DataRow>.generate(staffData.length, (index) {
                          // user's access value
                          staffStatus = staffData[index]['HasAccess'];

                          return DataRow(
                            cells: <DataCell>[
                              DataCell(SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Text(staffData[index]['UID']))),
                              DataCell(SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text(staffData[index]['Name']))),
                              DataCell(Text(
                                  staffData[index]['PhoneNumber'].toString())),
                              DataCell(Text(staffData[index]['Email'])),
                              DataCell(Text(
                                  staffData[index]['ActiveStatus'].toString())),
                              // DataCell(Text(staffData[index]['HasAccess']
                              //     .toString())),
                              DataCell(
                                Switch(
                                    activeTrackColor: Colors.greenAccent,
                                    inactiveTrackColor: Colors.redAccent,
                                    activeColor: Colors.white,
                                    value: staffStatus,
                                    onChanged: (bool newValue) {
                                      try {
                                        MyCloudStoreBase obj = MyCloudStore();
                                        obj
                                            .userAccessUpdate(
                                                'Staffs',
                                                staffData[index]['documentID'],
                                                'HasAccess',
                                                newValue)
                                            .then((value) =>
                                                Message.flutterToast(context,
                                                    "Access Modified"));
                                      } catch (e) {
                                        Message.flutterToast(
                                            context, 'Error: $e ');
                                      }
                                      setState(() {
                                        staffStatus = newValue;
                                      });
                                    }),
                              ),
                            ],
                          );
                        }),
                      ),
                    )),
              )
            ])));
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
