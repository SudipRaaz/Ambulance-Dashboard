import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyMap extends StatefulWidget {
  MyMap({super.key});
  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    _loadIcons();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // call your on-page-build function here
      onPageBuild();
    }
  }

  void onPageBuild() {
    log('page build');
  }

  late GoogleMapController _controller;

  // marker icons
  BitmapDescriptor? _ambulanceIcon;
  BitmapDescriptor? _patientIcon;

  // list
  late List staffLocations;
  List<Marker> staffMarkers = [];

  // marker counter
  int counter = 0;
  // list of requester locations
  late List requesterLocations;
  // List<Marker> requesterMarkers = [];

  getRequesterLocation() {
    // requester marker
    FirebaseFirestore.instance
        .collection('AmbulanceDepartment')
        .where('Status', isEqualTo: 'Waiting')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        // adding new request marker to map
        final requesterMarker = Marker(
          // icon: _ambulanceIcon!,
          markerId: MarkerId(doc['uid'].toString()),
          position: LatLng(
              doc['userLocation'].latitude, doc['userLocation'].longitude),
          infoWindow: InfoWindow(
            title: 'Name: ${doc['name']}',
            snippet:
                ' Phone Number: ${doc['phoneNumber']}\n UID: ${doc['uid']}',
          ),
        );
        counter++;
        staffMarkers.add(requesterMarker);
        log(requesterMarker.toString());
        log('adding requester marker ${staffMarkers.length}');
      });
    });

    // staff marker
    for (int i = 0; i < staffLocations.length; i++) {
      final ambuStaff = Marker(
        icon: _ambulanceIcon!,
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
      counter++;
      // adding marker
      staffMarkers.add(ambuStaff);
    }
  }

  void _loadIcons() async {
    _ambulanceIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(48, 48)),
      'assets/ambulance_marker.png',
    );

    _patientIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(48, 48)),
      'assets/patient_marker.png',
    );
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> staffLocation = FirebaseFirestore.instance
        .collection('Staffs')
        .where('Category', isEqualTo: 'Ambulance Department')
        .snapshots();

    return StreamBuilder(
        stream: staffLocation,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          //clearing the productsDocs list
          staffLocations = [];
          // staffMarkers = [];
          snapshot.data?.docs.map((DocumentSnapshot document) {
            Map historyData = document.data() as Map<String, dynamic>;
            staffLocations.add(historyData);
          }).toList();

          // *************************************************************************
          // getting new request location markers
          getRequesterLocation();

          log(' patient icon: ${staffMarkers}');
          if (staffMarkers.length == counter) {
            return Scaffold(
                body: Stack(children: [
              GoogleMap(
                mapType: MapType.normal,
                markers: Set<Marker>.of(staffMarkers),
                initialCameraPosition: const CameraPosition(
                    target: LatLng(
                      27.6683,
                      85.3205,
                    ),
                    zoom: 12),
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
