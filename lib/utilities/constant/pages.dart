import 'package:ambulance_dashboard/view/Ambulance_VIew/Ambu_Inprogess.dart';
import 'package:ambulance_dashboard/view/Ambulance_VIew/Ambu_history.dart';
import 'package:ambulance_dashboard/view/Ambulance_VIew/Ambu_newRequest.dart';
import 'package:ambulance_dashboard/view/Ambulance_VIew/Ambu_staffs.dart';
import 'package:ambulance_dashboard/view/FireBrigade_View/Fire_Inprogess.dart';
import 'package:ambulance_dashboard/view/FireBrigade_View/Fire_history.dart';
import 'package:ambulance_dashboard/view/FireBrigade_View/Fire_newRequest.dart';
import 'package:ambulance_dashboard/view/FireBrigade_View/Fire_staffs.dart';
import 'package:ambulance_dashboard/view/Police_View/Police_Inprogess.dart';
import 'package:ambulance_dashboard/view/Police_View/Police_history.dart';
import 'package:ambulance_dashboard/view/Police_View/Police_newRequest.dart';
import 'package:ambulance_dashboard/view/Police_View/Police_staffs.dart';
import 'package:flutter/material.dart';

class MyPagesList {
  // ambulance pages
  final List<Widget> ambulancePages = <Widget>[
    AmbuNewRequests(),
    AmbuInProgress(),
    AmbuHistory(),
    const AmbuStaffs(),
  ];

  // fire brigade pages
  final List<Widget> fireBrigadepages = <Widget>[
    FireNewRequests(),
    FireInProgress(),
    FireHistory(),
    const FireStaffs()
  ];

  // police pages
  final List<Widget> policePages = <Widget>[
    PoliceNewRequests(),
    PoliceInProgress(),
    PoliceHistory(),
    const PoliceStaffs()
  ];
}
