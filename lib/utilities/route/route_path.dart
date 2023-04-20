import 'package:ambulance_dashboard/delegator.dart';
import 'package:ambulance_dashboard/utilities/route/routes.dart';
import 'package:ambulance_dashboard/view/Ambulance_VIew/Ambu_Staff_Map.dart';
import 'package:ambulance_dashboard/view/FireBrigade_View/Fire_Staff_Map.dart';
import 'package:ambulance_dashboard/view/Police_View/Police_Staff_Map.dart';
import 'package:ambulance_dashboard/view/login.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.delegator:
        return MaterialPageRoute(builder: (context) {
          return const Delegator();
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
