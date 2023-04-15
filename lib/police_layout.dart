import 'package:ambulance_dashboard/Controller/authentication_functions.dart';
import 'package:ambulance_dashboard/utilities/constant/functions.dart';
import 'package:ambulance_dashboard/utilities/route/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/tab_manager.dart';
import 'utilities/constant/pages.dart';

class PoliceLayout extends StatefulWidget {
  const PoliceLayout({super.key});

  @override
  State<PoliceLayout> createState() => _PoliceLayoutState();
}

class _PoliceLayoutState extends State<PoliceLayout> {
  @override
  Widget build(BuildContext context) {
    List<Widget> pages = MyPagesList().policePages;
    return Consumer<TabManager>(builder: (context, tabManager, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Police Dashboard"),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 51, 231, 255),
                  Colors.blue,
                  Color.fromARGB(255, 51, 231, 255)
                ],
              ),
            ),
          ),
        ),
        body: Row(
          children: <Widget>[
            NavigationRail(
              backgroundColor: Colors.lightBlue.shade100,
              selectedIndex: tabManager.selectedIndex,
              onDestinationSelected: (int index) {
                if (index == 4) {
                  MyFunctions().logout(context);
                } else {
                  setState(() {
                    tabManager.goToTab(index);
                  });
                }
              },
              labelType: NavigationRailLabelType.all,
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.add),
                  label: Text('New Request'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.inbox),
                  label: Text('In Progress'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.history),
                  label: Text('History'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.group_rounded),
                  label: Text('Manage Staff'),
                ),
                NavigationRailDestination(
                  icon: Icon(
                    Icons.logout,
                    color: Colors.red,
                  ),
                  label: Text('Log Out'),
                ),
              ],
            ),
            const VerticalDivider(thickness: 1, width: 1),
            Expanded(
              child: pages[tabManager.selectedIndex],
            ),
          ],
        ),
      );
    });
  }
}
