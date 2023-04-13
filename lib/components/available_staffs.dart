import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../view/Ambulance_VIew/Ambu_newRequest.dart';

class GetAvailableStaff extends StatefulWidget {
  MyCallback callbackClass;
  String departmentCategory;

  GetAvailableStaff({
    super.key,
    required this.callbackClass,
    required this.departmentCategory,
  });

  @override
  State<GetAvailableStaff> createState() => Get_AvailableStaffState();
}

class Get_AvailableStaffState extends State<GetAvailableStaff> {
  String? selectedOption; // selected option
  String? staffID; // staff ID
  GeoPoint? StaffLocation; // staff location

  @override
  Widget build(BuildContext context) {
    // getting the list of available staffs
    final availableStaffRef = FirebaseFirestore.instance
        .collection('Staffs')
        .where('Category', isEqualTo: widget.departmentCategory)
        .where('ActiveStatus', isEqualTo: true)
        .where('HasAccess', isEqualTo: true)
        .get();

    // list of available staffs
    List availableStaff;
    // list of available staff options
    List<String> options;

    return FutureBuilder(
        future: availableStaffRef,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            availableStaff = [];
            options = [];

            snapshot.data!.docs.map((DocumentSnapshot document) {
              Map staffInfo = document.data() as Map<String, dynamic>;
              availableStaff.add(staffInfo);
            }).toList();

            for (int i = 0; i < availableStaff.length; i++) {
              options.add(availableStaff[i]['UID'].toString());
            }

            // returning a list of all available staff
            return DropdownButton<String>(
              value: selectedOption,
              hint: const Text('Select an option'),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    selectedOption = newValue;
                  });

                  for (int i = 0; i < availableStaff.length; i++) {
                    if (availableStaff[i]['UID'].toString() == selectedOption) {
                      // staffProvider.setStaffID(availableStaff[i]['UID']);
                      staffID = availableStaff[i]['UID'];
                      StaffLocation = availableStaff[i]['Location'];

                      // making sure data is not null
                      if (staffID != null && StaffLocation != null) {
                        widget.callbackClass(
                            newValue, staffID!, StaffLocation!);
                      }
                    }
                    log('from available staff class : ${availableStaff[i]['Location']},  ${availableStaff[i]['UID']}}');
                  }
                }
              },
              items: options.map((String option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
            );
          } else {
            return const Text('Error');
          }
        });
  }
}
