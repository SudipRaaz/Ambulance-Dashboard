import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AmbuStaffs extends StatefulWidget {
  const AmbuStaffs({super.key});

  @override
  State<AmbuStaffs> createState() => _AmbuStaffsState();
}

class _AmbuStaffsState extends State<AmbuStaffs> {
  List<Map<String, dynamic>> staffData = [
    {
      'driverName': 'John Doe John Doe John Doe John Doe John Doe John Doe ',
      'driverLicense': 'JJohn Doe John Doe John Doe John Doe',
      'driverContact': 'JJohn Doe John Doe John Doe John Doe',
      'driverAddress': '1JJohn Doe John Doe John Doe John Doe.',
      'vehicleNumber': 'AJohn Doe John Doe John Doe John Doe',
    },
    {
      'driverName': 'Jane Doe',
      'driverLicense': '654321',
      'driverContact': '555-555-5555',
      'driverAddress': '456 Elm St.',
      'vehicleNumber': 'DEF456',
    },
    {
      'driverName': 'Jane Doe',
      'driverLicense': '654321',
      'driverContact': '555-555-5555',
      'driverAddress': '456 Elm St.',
      'vehicleNumber': 'DEF456',
    },
    {
      'driverName': 'Jane Doe',
      'driverLicense': '654321',
      'driverContact': '555-555-5555',
      'driverAddress': '456 Elm St.',
      'vehicleNumber': 'DEF456',
    },
    {
      'driverName': 'Jane Doe',
      'driverLicense': '654321',
      'driverContact': '555-555-5555',
      'driverAddress': '456 Elm St.',
      'vehicleNumber': 'DEF456',
    },
  ];

  void deleteEmployee(int index) {
    setState(() {
      staffData.removeAt(index);
    });
  }

  void updateEmployee(int index) {
    // TODO: Implement update employee functionality
  }

  void controlAccess(int index) {
    // TODO: Implement access control functionality
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

// getting user requests
    final _requestStream = FirebaseFirestore.instance
        .collection('Staffs')
        .where('Category', isEqualTo: 'Ambulance Department')
        .snapshots();

    // list
    List staffData;

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
                          DataColumn(label: Text('Actions')),
                        ],
                        rows: List<DataRow>.generate(
                            staffData.length,
                            (index) => DataRow(
                                  cells: <DataCell>[
                                    DataCell(SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: Text(staffData[index]['UID']))),
                                    DataCell(SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Text(staffData[index]['Name']))),
                                    DataCell(Text(staffData[index]
                                            ['PhoneNumber']
                                        .toString())),
                                    DataCell(Text(staffData[index]['Email'])),
                                    DataCell(Text(staffData[index]
                                            ['ActiveStatus']
                                        .toString())),
                                    DataCell(Text(staffData[index]['HasAccess']
                                        .toString())),
                                    DataCell(
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: Icon(Icons.edit),
                                            onPressed: () =>
                                                updateEmployee(index),
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.security),
                                            onPressed: () =>
                                                controlAccess(index),
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.delete),
                                            onPressed: () =>
                                                deleteEmployee(index),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
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
