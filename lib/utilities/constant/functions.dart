import 'package:ambulance_dashboard/Controller/authentication_functions.dart';
import 'package:ambulance_dashboard/utilities/route/routes.dart';
import 'package:flutter/cupertino.dart';

class MyFunctions {
  void logout(BuildContext context) {
    Authentication().signOut();
    Navigator.pushReplacementNamed(context, RouteNames.loginPage);
  }
}
