import 'package:ambulance_dashboard/Controller/cloud_firestore.dart';
import 'package:ambulance_dashboard/Controller/cloud_firestore_base.dart';
import 'package:ambulance_dashboard/components/available_staffs.dart';
import 'package:ambulance_dashboard/model/allocatingAmbulance.dart';
import 'package:ambulance_dashboard/utilities/InfoDisp/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

typedef MyCallback = Function(String option, String id, GeoPoint location);

// ignore: must_be_immutable
class AmbuNewRequests extends StatelessWidget {
  AmbuNewRequests({super.key});

// staff UID
  String? staffUID;
  // location of staff
  GeoPoint? staffLocation;
  String? selectedOption;
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

    // list
    List newRequests;
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
                      requestService = '$requestService\n      Police Service';
                    }

                    final customerLocation =
                        newRequests[index]['userLocation'] as GeoPoint;

                    return CaseTile(context, _width, newRequests, index,
                        dateTime, customerLocation, selectedOption);
                  },
                  itemCount: newRequests.length,
                ),
              ),
            );
          }
          return const Text("Error: Request");
        });
  }

  // ignore: non_constant_identifier_names
  Padding CaseTile(
      BuildContext context,
      double width,
      List<dynamic> newRequests,
      int index,
      DateTime dateTime,
      GeoPoint customerLocation,
      String? selectedOption) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 20),
      child: Column(
        children: [
          Container(
            width: width,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 252, 94, 94).withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
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
                            callbackClass: (option, id, location) {
                              selectedOption = option;
                              staffUID = id;
                              staffLocation = location;
                            },
                            departmentCategory: 'Ambulance Department',
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
                              if (staffUID != null) {
                                final ambulanceAllocationData =
                                    AllocatingAmbulance(
                                        status: 'In Progress',
                                        caseID: newRequests[index]['caseID'],
                                        allotedAt: allotedAt,
                                        ambulanceAllotedId: staffUID!,
                                        ambulanceLocation: staffLocation!,
                                        ambulanceServiceAlloted: true,
                                        responseMessage:
                                            responseMessageController.text);
                                MyCloudStoreBase obj = MyCloudStore();
                                obj
                                    .allocateAmbulanceStaff(
                                        newRequests[index]['documentID'],
                                        ambulanceAllocationData)
                                    .onError((error, stackTrace) =>
                                        Message.flutterToast(
                                            context, stackTrace.toString()))
                                    .then((value) => Message.flutterToast(
                                        context,
                                        'Staff Assigned Successfully'));
                              } else {
                                Message.flutterToast(
                                    context, 'Could not retrive staff UID');
                              }
                            }
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
