import 'dart:developer';

import 'package:ambulance_dashboard/Controller/cloud_firestore.dart';
import 'package:ambulance_dashboard/Controller/cloud_firestore_base.dart';
import 'package:ambulance_dashboard/components/available_staffs.dart';
import 'package:ambulance_dashboard/model/allocatingAmbulance.dart';
import 'package:ambulance_dashboard/model/staff_data.dart';
import 'package:ambulance_dashboard/utilities/InfoDisp/message.dart';
import 'package:ambulance_dashboard/utilities/constant/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/drop_down.dart';

typedef void MyCallback(String option, String id, GeoPoint location);

class NewRequestPage extends StatefulWidget {
  const NewRequestPage({super.key});

  @override
  State<NewRequestPage> createState() => _NewRequestPageState();
}

class _NewRequestPageState extends State<NewRequestPage> {
  // staff UID
  String? staffUID;
  // location of staff
  GeoPoint? staffLocation;
  // controller for response text field
  TextEditingController responseMessageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    // getting user requests
    final _requestStream = FirebaseFirestore.instance
        .collection('AmbulanceDepartment')
        .where('Status', isEqualTo: 'Waiting')
        .snapshots();

    // list options
    String? _selectedOption;
    List<String> _options = [];

    // list
    List newRequests;
    List availableStaff;
    return Consumer<StaffData>(builder: (context, staffProvider, child) {
      return StreamBuilder<QuerySnapshot>(
          stream: _requestStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasData) {
              //clearing the productsDocs list
              newRequests = [];

              snapshot.data!.docs.map((DocumentSnapshot document) {
                Map historyData = document.data() as Map<String, dynamic>;
                historyData['documentID'] = document.id;
                newRequests.add(historyData);
              }).toList();

              return Scaffold(
                body: SizedBox(
                  height: _height,
                  width: _width,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      // formating timestamp from firebase data
                      Timestamp timestamp = newRequests[index]['requestedAt'];
                      DateTime dateTime = timestamp.toDate();

                      // requested service name
                      var requestService = '';

                      if (newRequests[index]['ambulanceService']) {
                        requestService = '\n      Ambulance Service';
                      }
                      if (newRequests[index]['fireBrigadeService']) {
                        requestService =
                            '$requestService\n      Fire Brigade Service';
                      }
                      if (newRequests[index]['policeService']) {
                        requestService =
                            '$requestService\n      Police Service';
                      }

                      final customerLocation =
                          newRequests[index]['userLocation'] as GeoPoint;

                      return CaseTile(_width, newRequests, index, dateTime,
                          customerLocation, _selectedOption);
                    },
                    itemCount: newRequests.length,
                  ),
                ),
              );
            }
            return Text("Error: Request");
          });
    });
  }

  // ignore: non_constant_identifier_names
  Padding CaseTile(double width, List<dynamic> newRequests, int index,
      DateTime dateTime, GeoPoint customerLocation, String? selectedOption) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 20),
      child: Column(
        children: [
          Container(
            width: width,
            decoration: BoxDecoration(
                border: Border.all(width: 2),
                borderRadius: BorderRadius.circular(25)),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        '''
Status: ${newRequests[index]['Status']}
Case ID: ${newRequests[index]['caseID']}
Requester ID: ${newRequests[index]['uid']}
Requester Name: ${newRequests[index]['name']}
Contact: ${newRequests[index]['phoneNumber']}
Requested At
    Date: ${dateTime.year}/${dateTime.month}/${dateTime.day}
    Time: ${dateTime.hour}:${dateTime.minute}:${dateTime.second}
Location: ${customerLocation.latitude}, ${customerLocation.longitude} 
Message: ${newRequests[index]['message']}
''',
                        textAlign: TextAlign.start,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text("Assigned Team ID: "),
                          GetAvailableStaff(
                            selectedOption: (value) {
                              selectedOption = value;
                            },
                          ),
                        ],
                      ),
                      const Text("Reponse Message: "),
                      SizedBox(
                          height: 100,
                          width: width / 5,
                          child: TextField(
                            controller: responseMessageController,
                            decoration: const InputDecoration(
                                fillColor: (Colors.black12), filled: true),
                          )),
                      ElevatedButton(
                          onPressed: () {
                            if (selectedOption != null) {
                              // current time stamp
                              Timestamp timestamp = Timestamp.now();
                              DateTime allotedAt = timestamp.toDate();

                              staffUID = StaffData().staffID;
                              staffLocation = StaffData().position as GeoPoint;

                              log('${staffUID}, ${selectedOption}, ${staffLocation}');

                              // if (staffUID != null) {
                              //   final ambulanceAllocationData =
                              //       AllocatingAmbulance(
                              //           status: 'In Progress',
                              //           allotedAt: allotedAt,
                              //           ambulanceAllotedId: staffUID!,
                              //           ambulanceLocation: staffLocation!,
                              //           ambulanceServiceAlloted: true,
                              //           responseMessage:
                              //               responseMessageController.text);
                              //   MyCloudStoreBase obj = MyCloudStore();
                              //   obj
                              //       .allocateAmbulanceStaff(
                              //           newRequests[index]['documentID'],
                              //           ambulanceAllocationData)
                              //       .onError((error, stackTrace) =>
                              //           Message.flutterToast(
                              //               context, stackTrace.toString()))
                              //       .then((value) => Message.flutterToast(
                              //           context, value.toString()));
                              // } else {
                              //   Message.flushBarErrorMessage(
                              //       context, 'Could not retrive staff UID');
                              // }
                            }
                            log('${newRequests[index]['documentID']}');
                          },
                          child: const Text('Confirm Change')),
                    ],
                  ),
                  const Text("")
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
