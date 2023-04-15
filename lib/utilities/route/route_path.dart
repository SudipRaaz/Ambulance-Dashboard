import 'package:ambulance_dashboard/delegator.dart';
import 'package:ambulance_dashboard/utilities/route/routes.dart';
import 'package:ambulance_dashboard/view/Ambulance_VIew/Ambu_Staff_Map.dart';
import 'package:ambulance_dashboard/view/FireBrigade_View/Fire_Staff_Map.dart';
import 'package:ambulance_dashboard/view/Police_View/Police_Staff_Map.dart';
import 'package:ambulance_dashboard/view/history_page.dart';
import 'package:ambulance_dashboard/view/inprogress_page.dart';
import 'package:ambulance_dashboard/view/login.dart';
import 'package:ambulance_dashboard/view/management_page.dart';
import 'package:ambulance_dashboard/view/newAmbulance_page.dart';
import 'package:ambulance_dashboard/view/police_page.dart';
import 'package:flutter/material.dart';

import '../../view/newRequest_page.dart';

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.delegator:
        return MaterialPageRoute(builder: (context) {
          return Delegator();
        });

      case RouteNames.ambulanceStaffTracking:
        return MaterialPageRoute(builder: (context) {
          return AmbulanceStaffTracking();
        });

      case RouteNames.fireBrigadeStaffTracking:
        return MaterialPageRoute(builder: (context) {
          return FireBrigadeStaffTracking();
        });

      case RouteNames.policeStaffTracking:
        return MaterialPageRoute(builder: (context) {
          return PoliceStaffTracking();
        });

      case RouteNames.newRequestPage:
        return MaterialPageRoute(builder: (context) {
          return NewRequestHome();
        });

      case RouteNames.inProgressPage:
        return MaterialPageRoute(builder: (context) {
          return InProgressPage();
        });

      case RouteNames.historyPage:
        return MaterialPageRoute(builder: (context) {
          return HistoryPage();
        });

      case RouteNames.addAmbulancePage:
        return MaterialPageRoute(builder: (context) {
          return AddAmbulancePage();
        });

      case RouteNames.managementPage:
        return MaterialPageRoute(builder: (context) {
          return ManagementPage();
        });

      case RouteNames.policePage:
        return MaterialPageRoute(builder: (context) {
          return PolicePage();
        });

      case RouteNames.loginPage:
        return MaterialPageRoute(builder: (context) {
          return LoginPage();
        });

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(child: Text("no route defined")),
          );
        });
    }
  }
}
