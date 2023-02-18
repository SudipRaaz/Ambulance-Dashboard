import 'package:flutter/material.dart';

import '../utilities/constant/widgets.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          // ElevatedButton(
          //   onPressed: () {
          //     Navigator.pushNamed(context, RouteNames.addAmbulancePage);
          //   },
          //   child: Text("new request page updated"),
          // ),
          addVerticalSpace(30),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              verticalDirection: VerticalDirection.up,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("New Requests"),
                Row(
                  children: const [Icon(Icons.filter_list), Text("Filter")],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 20),
            child: Column(
              children: [
                Container(
                  width: _width,
                  decoration: BoxDecoration(
                      border: Border.all(width: 2),
                      borderRadius: BorderRadius.circular(25)),
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '''
Status: Done
Requester ID: 32132
Requester Name: Ram prasad
Contact: 98600000
Requested At
      Date: 6/01/2022
      Time: 2:23 PM
Message: xxxxx
''',
                          textAlign: TextAlign.start,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              '''
Assigned Team ID: 3123
Assigned At
       Date: 16/01/2023
       Time: 3:00 PM
Location
        Latitude: 87498
        longitude: 89465
Reponse Message''',
                              textAlign: TextAlign.left,
                            ),
                            Text("Reponded message")
                          ],
                        ),
                        Text("")
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
