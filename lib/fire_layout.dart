import 'package:ambulance_dashboard/Controller/authentication_functions.dart';
import 'package:ambulance_dashboard/utilities/route/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/tab_manager.dart';
import 'utilities/constant/pages.dart';

class FireBrigadeLayout extends StatefulWidget {
  const FireBrigadeLayout({super.key});

  @override
  State<FireBrigadeLayout> createState() => _FireBrigadeLayoutState();
}

class _FireBrigadeLayoutState extends State<FireBrigadeLayout> {
  @override
  Widget build(BuildContext context) {
    List<Widget> pages = MyPagesList().fireBrigadepages;
    return Consumer<TabManager>(builder: (context, tabManager, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Fire Brigade Dashboard"),
          centerTitle: true,
          actions: [
            ElevatedButton(
                onPressed: () {
                  Authentication().signOut();
                  Navigator.pushReplacementNamed(context, RouteNames.loginPage);
                },
                child: const Text(" LogOut "))
          ],
        ),
        body: Row(
          children: <Widget>[
            NavigationRail(
              backgroundColor: Colors.amber,
              selectedIndex: tabManager.selectedIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  tabManager.goToTab(index);
                });
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
