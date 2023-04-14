import 'dart:developer';

import 'package:ambulance_dashboard/utilities/InfoDisp/message.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AmbulanceStaffTracking extends StatefulWidget {
  List<Marker> marker;
  AmbulanceStaffTracking({required this.marker, super.key});

  @override
  State<AmbulanceStaffTracking> createState() => _AmbulanceStaffTrackingState();
}

class _AmbulanceStaffTrackingState extends State<AmbulanceStaffTracking> {
  late GoogleMapController mapController;

  List<Marker> staffMarker = [];

  // // locations
  // LatLng sourceLocation = LatLng(27.6772194524, 85.3168201447);
  // LatLng destinationLocation = LatLng(27.6841741279, 85.3193950653);

  // bool showMap = false;

  // _getGeoPoints() {
  //   FirebaseFirestore.instance
  //       .collection('Staffs')
  //       .snapshots()
  //       .asyncMap((QuerySnapshot querySnapshot) {
  //     querySnapshot.docs.forEach((doc) {
  //       // creating marker
  //       final ambuStaff = Marker(
  //         markerId: MarkerId(doc['UID'].toString()),
  //         position: LatLng(doc['Location'].latitude, doc['Location'].longitude),
  //         infoWindow: InfoWindow(
  //           title: '${doc['Name']}',
  //           snippet: '${doc['PhoneNumber']}',
  //         ),
  //         onTap: () {
  //           // Show further details about the vehicle when tapped
  //         },
  //       );
  //       // adding marker
  //       marker.add(ambuStaff);
  //     });
  //   });
  // }

  @override
  void initState() {
    super.initState();
    staffMarker = widget.marker;
    // marker.add(
    //   Marker(
    //     markerId: const MarkerId('Source'),
    //     position: sourceLocation,
    //     infoWindow: const InfoWindow(
    //       title: 'Vehicle 1',
    //       snippet: 'Vehicle Type: Sedan',
    //     ),
    //     onTap: () {
    //       // Show further details about the vehicle when tapped
    //     },
    //   ),
    // );
    // _getGeoPoints();
    // if (marker.isNotEmpty) {
    //   showMap = true;
    // }
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Container(
      height: _height,
      width: _width,
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(0, 0),
          zoom: 10,
        ),
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
        markers: Set<Marker>.of(staffMarker),
        // markers: Set.from(marker.map((geoPoint) {
        //   LatLng latLng = LatLng(geoPoint.latitude, geoPoint.longitude);
        //   return Marker(
        //     markerId: MarkerId('$latLng'),
        //     position: geoPoint,
        //   );
        // })),
      ),
    )
        // : Center(child: CircularProgressIndicator()),
        );
  }
}

// class AmbulanceStaff extends StatefulWidget {
//   @override
//   _AmbulanceStaffState createState() => _AmbulanceStaffState();
// }

// class _AmbulanceStaffState extends State<AmbulanceStaff> {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   List<GeoPoint> _geoPoints = [];

//   late GoogleMapController _mapController;

//   @override
//   void initState() {
//     super.initState();
//     _getGeoPoints();
//   }

//   void _getGeoPoints() {
//     _firestore.collection('Staffs').get().then((QuerySnapshot querySnapshot) {
//       querySnapshot.docs.forEach((doc) {
//         GeoPoint geoPoint = doc['Location'];
//         _geoPoints.add(geoPoint);
//       });
//       setState(() {});
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GoogleMap(
//         initialCameraPosition: CameraPosition(
//           target: LatLng(0, 0),
//           zoom: 10,
//         ),
//         onMapCreated: (GoogleMapController controller) {
//           _mapController = controller;
//         },
//         markers: Set.from(_geoPoints.map((geoPoint) {
//           LatLng latLng = LatLng(geoPoint.latitude, geoPoint.longitude);
//           return Marker(
//             markerId: MarkerId('$latLng'),
//             position: latLng,
//           );
//         })),
//       ),
//     );
//   }
// }
