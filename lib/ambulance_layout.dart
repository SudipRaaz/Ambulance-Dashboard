import 'package:ambulance_dashboard/Controller/authentication_functions.dart';
import 'package:ambulance_dashboard/utilities/constant/functions.dart';
import 'package:ambulance_dashboard/utilities/constant/widgets.dart';
import 'package:ambulance_dashboard/utilities/route/routes.dart';
import 'package:ambulance_dashboard/view/Ambulance_VIew/Ambu_Staff_Map.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/tab_manager.dart';
import 'utilities/constant/pages.dart';

class AmbulanceLayout extends StatefulWidget {
  const AmbulanceLayout({super.key});

  @override
  State<AmbulanceLayout> createState() => _AmbulanceLayoutState();
}

class _AmbulanceLayoutState extends State<AmbulanceLayout> {
  @override
  Widget build(BuildContext context) {
    // media height and width
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    List<Widget> pages = MyPagesList().ambulancePages;
    return Consumer<TabManager>(builder: (context, tabManager, child) {
      return Scaffold(
        appBar: AppBar(
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
          title: const Text("Ambulance Dashboard"),
          centerTitle: true,
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
                  label: Text(
                    'New Request',
                  ),
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
