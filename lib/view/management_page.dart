import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ManagementPage extends StatefulWidget {
  const ManagementPage({super.key});

  @override
  State<ManagementPage> createState() => _ManagementPageState();
}

class _ManagementPageState extends State<ManagementPage> {
  List<Map<String, dynamic>> employees = [
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
      employees.removeAt(index);
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
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 50),
        child: Container(
            width: width,
            decoration: BoxDecoration(
                border: Border.all(width: 2),
                borderRadius: BorderRadius.circular(25)),
            child: Padding(
              padding: EdgeInsets.all(15),
              child: DataTable(
                columns: <DataColumn>[
                  DataColumn(label: Text('Driver Name')),
                  DataColumn(label: Text('Driver License')),
                  DataColumn(label: Text('Driver Contact')),
                  DataColumn(label: Text('Driver Address')),
                  DataColumn(label: Text('Vehicle Number')),
                  DataColumn(label: Text('Actions')),
                ],
                rows: List<DataRow>.generate(
                    employees.length,
                    (index) => DataRow(
                          cells: <DataCell>[
                            DataCell(Text(employees[index]['driverName'])),
                            DataCell(Text(employees[index]['driverLicense'])),
                            DataCell(Text(employees[index]['driverContact'])),
                            DataCell(Text(employees[index]['driverAddress'])),
                            DataCell(Text(employees[index]['vehicleNumber'])),
                            DataCell(
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () => updateEmployee(index),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.security),
                                    onPressed: () => controlAccess(index),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () => deleteEmployee(index),
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
}
