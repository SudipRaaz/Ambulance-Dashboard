import 'package:ambulance_dashboard/utilities/route/routes.dart';
import 'package:ambulance_dashboard/view/history_page.dart';
import 'package:ambulance_dashboard/view/inprogress_page.dart';
import 'package:ambulance_dashboard/view/management_page.dart';
import 'package:ambulance_dashboard/view/newAmbulance_page.dart';
import 'package:ambulance_dashboard/view/police_page.dart';
import 'package:flutter/material.dart';

import '../../view/newRequest_page.dart';
import '../../page_layout.dart';

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.pageLayout:
        return MaterialPageRoute(builder: (context) {
          return PageLayout();
        });

      case RouteNames.newRequestPage:
        return MaterialPageRoute(builder: (context) {
          return NewRequestPage();
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

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(child: Text("no route defined")),
          );
        });
    }
  }
}
