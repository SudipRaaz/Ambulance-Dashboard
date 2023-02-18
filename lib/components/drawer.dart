import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Drawer Header'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('New Request'),
            onTap: () {
              // Navigate to the New Request page
            },
          ),
          ListTile(
            title: Text('In Progress'),
            onTap: () {
              // Navigate to the In Progress page
            },
          ),
          ListTile(
            title: Text('History'),
            onTap: () {
              // Navigate to the History page
            },
          ),
          ListTile(
            title: Text('Add Ambulance'),
            onTap: () {
              // Navigate to the Add Ambulance page
            },
          ),
        ],
      ),
    );
  }
}
