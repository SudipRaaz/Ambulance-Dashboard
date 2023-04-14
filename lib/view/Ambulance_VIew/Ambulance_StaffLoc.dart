import 'package:ambulance_dashboard/components/gradientButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyMap extends StatefulWidget {
  MyMap({super.key});
  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  late GoogleMapController _controller;

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> staffLocation = FirebaseFirestore.instance
        .collection('Staffs')
        .where('Category', isEqualTo: 'Ambulance Department')
        .snapshots();

    // list
    List staffLocations;
    List<Marker> markers = [];

    return StreamBuilder(
        stream: staffLocation,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          // if (_added) {
          //   mymap(snapshot);
          // }
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          //clearing the productsDocs list
          staffLocations = [];
          snapshot.data?.docs.map((DocumentSnapshot document) {
            Map historyData = document.data() as Map<String, dynamic>;
            staffLocations.add(historyData);
          }).toList();

          // *************************************************************************
          for (int i = 0; i < staffLocations.length; i++) {
            final ambuStaff = Marker(
              markerId: MarkerId(staffLocations[i]['UID'].toString()),
              position: LatLng(staffLocations[i]['Location'].latitude,
                  staffLocations[i]['Location'].longitude),
              infoWindow: InfoWindow(
                title: 'Name: ${staffLocations[i]['Name']}',
                snippet:
                    ' Phone Number: ${staffLocations[i]['PhoneNumber']}\n UID: ${staffLocations[i]['UID']}',
              ),
              onTap: () {
                // Show further details about the vehicle when tapped
              },
            );
            // adding marker
            markers.add(ambuStaff);
          }
          if (markers.isNotEmpty) {
            return Scaffold(
                body: Stack(children: [
              GoogleMap(
                mapType: MapType.normal,
                myLocationEnabled: true,
                markers: Set<Marker>.of(markers),
                initialCameraPosition: const CameraPosition(
                    target: LatLng(
                      27.6683,
                      85.3205,
                    ),
                    zoom: 13),
              ),
              Positioned(
                right: 40,
                top: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(0.0),
                    elevation: 5,
                  ),
                  onPressed: () {
                    setState(() {});
                  },
                  child: Ink(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Colors.blue,
                        Color.fromARGB(255, 58, 169, 183)
                      ]),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      constraints: const BoxConstraints(minWidth: 88.0),
                      child: Row(
                        children: const [
                          Icon(Icons.refresh),
                          Text('Refresh', textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ]));
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}
