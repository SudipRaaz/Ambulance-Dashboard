import 'package:ambulance_dashboard/view/history_page.dart';
import 'package:ambulance_dashboard/view/inprogress_page.dart';
import 'package:ambulance_dashboard/view/management_page.dart';
import 'package:ambulance_dashboard/view/newAmbulance_page.dart';
import 'package:ambulance_dashboard/view/newRequest_page.dart';
import 'package:ambulance_dashboard/view/police_page.dart';
import 'package:flutter/material.dart';

class MyPagesList {
  final List<Widget> pages = <Widget>[
    NewRequestPage(),
    InProgressPage(),
    HistoryPage(),
    AddAmbulancePage(),
    ManagementPage(),
    PolicePage()
  ];
}
