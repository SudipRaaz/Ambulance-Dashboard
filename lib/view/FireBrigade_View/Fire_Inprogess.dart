import 'package:ambulance_dashboard/Controller/cloud_firestore.dart';
import 'package:ambulance_dashboard/Controller/cloud_firestore_base.dart';
import 'package:ambulance_dashboard/components/gradientButton.dart';
import 'package:ambulance_dashboard/model/caseTrackingModel.dart';
import 'package:ambulance_dashboard/utilities/InfoDisp/message.dart';
import 'package:ambulance_dashboard/utilities/constant/widgets.dart';
import 'package:ambulance_dashboard/view/caseTracking_Map.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

typedef MyCallback = Function(String option, String id, GeoPoint location);

// ignore: must_be_immutable
class FireInProgress extends StatelessWidget {
  FireInProgress({super.key});

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
        .collection('FireBrigadeDepartment')
        .where('Status', isEqualTo: 'In Progress')
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
                    // alloted date time
                    Timestamp allotedTimestamp =
                        newRequests[index]['allotedAt'];
                    DateTime allotedDate = allotedTimestamp.toDate();

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
                    final assignedStaffLocation =
                        newRequests[index]['fireBrigadeLocation'] as GeoPoint;
                    final respondedMessage =
                        newRequests[index]['responseMessage'];

                    return CaseTile(
                        context,
                        _width,
                        newRequests,
                        index,
                        dateTime,
                        customerLocation,
                        selectedOption,
                        allotedDate,
                        assignedStaffLocation,
                        respondedMessage);
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
      String? selectedOption,
      DateTime allotedDate,
      GeoPoint assignedStaffLocation,
      String respondedMessage) {
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
                    color: Color.fromARGB(255, 228, 252, 94).withOpacity(0.5),
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
Message: ${newRequests[index]['message']}
Location: ${customerLocation.latitude}, ${customerLocation.longitude} 

Requested At
    Date: ${dateTime.year}/${dateTime.month}/${dateTime.day}
    Time: ${dateTime.hour}:${dateTime.minute}:${dateTime.second}

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
                          Text(
                              "Assigned Team ID: ${newRequests[index]['fireBrigadeAllotedID']}"),
                        ],
                      ),
                      Text(
                        '''
Assigned At:
    Date: ${allotedDate.year}/${allotedDate.month}/${allotedDate.day}
    Time: ${allotedDate.hour}:${allotedDate.minute}:${allotedDate.second}
       
Location:
        Latitude: ${assignedStaffLocation.latitude}
        longitude: ${assignedStaffLocation.longitude}
''',
                        textAlign: TextAlign.left,
                      ),
                      const Text("Reponse Message:"),
                      Text(respondedMessage),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30, 30, 0, 0),
                            child: MyGradientButton(
                              text: 'View On Map',
                              onPress: () {
                                GeoPoint userLocation = GeoPoint(
                                    customerLocation.latitude,
                                    customerLocation.longitude);
                                GeoPoint staffLocation = GeoPoint(
                                    assignedStaffLocation.latitude,
                                    assignedStaffLocation.longitude);
                                CaseTracking_Model caseTrackingData =
                                    CaseTracking_Model(
                                        staffID: newRequests[index]
                                            ['fireBrigadeAllotedID'],
                                        userID: newRequests[index]['uid'],
                                        name: newRequests[index]['name'],
                                        phoneNumber: newRequests[index]
                                            ['phoneNumber'],
                                        userLocation: userLocation,
                                        staffLocation: staffLocation);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            CaseTracking_Map(
                                              caseTracking: caseTrackingData,
                                              iconName: 'fireBrigade',
                                            )));
                              },
                              iconData: (Icons.location_pin),
                              gradientColor: const LinearGradient(colors: [
                                Color.fromARGB(255, 22, 228, 255),
                                Colors.blue,
                                Colors.blue,
                                Color.fromARGB(255, 22, 228, 255),
                              ]),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30, 30, 0, 0),
                            child: MyGradientButton(
                              text: '   Mark As Completed',
                              onPress: () {
                                try {
                                  MyCloudStoreBase obj = MyCloudStore();
                                  obj
                                      .statusUpdate(
                                          'AmbulanceDepartment',
                                          newRequests[index]['documentID'],
                                          newRequests[index]['caseID'],
                                          'Status',
                                          'Completed')
                                      .then((value) => Message.flutterToast(
                                          context, "Marked as Completed"));
                                } catch (e) {
                                  Message.flutterToast(context, 'Error ');
                                }
                              },
                              iconData: (Icons.done),
                              gradientColor: const LinearGradient(colors: [
                                Color.fromARGB(255, 22, 228, 255),
                                Colors.blue,
                                Colors.blue,
                                Color.fromARGB(255, 22, 228, 255),
                              ]),
                            ),
                          ),
                        ],
                      ),
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
