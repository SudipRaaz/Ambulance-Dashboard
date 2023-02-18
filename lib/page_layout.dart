import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/tab_manager.dart';
import 'utilities/constant/pages.dart';

class PageLayout extends StatefulWidget {
  const PageLayout({super.key});

  @override
  State<PageLayout> createState() => _PageLayoutState();
}

class _PageLayoutState extends State<PageLayout> {
  @override
  Widget build(BuildContext context) {
    List<Widget> pages = MyPagesList().pages;
    return Consumer<TabManager>(builder: (context, tabManager, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Ambulance Management Dashboard"),
          centerTitle: true,
          actions: [
            ElevatedButton(onPressed: () {}, child: const Text(" LogOut "))
          ],
        ),
        body:
            // Row(
            //   children: [
            //     Drawer(
            //       child: ListView.separated(
            //           itemBuilder: (context, index) {
            //             return ListTile(
            //               title: Text('New Request'),
            //               onTap: () {
            //                 tabManager.goToTab(index);
            //               },
            //             );
            //           },
            //           separatorBuilder: (context, index) => const SizedBox(
            //                 height: 10,
            //               ),
            //           itemCount: 3),
            //     ),
            //     const VerticalDivider(thickness: 1, width: 1),
            //     Expanded(
            //       child: pages[tabManager.selectedIndex],
            //     ),
            //   ],
            // ),
            Row(
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
              destinations: [
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
                  icon: Icon(Icons.add),
                  label: Text('Add Ambulance'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.group_rounded),
                  label: Text('Manage Ambulance'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.local_police_outlined),
                  label: Text('Police'),
                ),
              ],
            ),
            VerticalDivider(thickness: 1, width: 1),
            Expanded(
              child: pages[tabManager.selectedIndex],
            ),
          ],
        ),

        // bottom navigation bar
        // bottomNavigationBar: BottomNavigationBar(
        //   currentIndex: tabManager.selectedIndex,
        //   //change the body based on the index of the bottom navigation tap
        //   onTap: (index) {
        //     tabManager.goToTab(index);
        //   },
        //   fixedColor: Colors.black,
        //   backgroundColor: Color.fromARGB(115, 248, 248, 248),
        //   items: const <BottomNavigationBarItem>[
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.dashboard_rounded),
        //       label: 'Dashboard',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.history),
        //       label: 'History',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.person),
        //       label: 'Profile',
        //     ),
        //   ],
        // )
      );
    });
  }
}
