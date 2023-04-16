import 'dart:developer';
import 'package:ambulance_dashboard/model/caseTrackingModel.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CaseTracking_Map extends StatefulWidget {
  CaseTracking_Model caseTracking;
  CaseTracking_Map({required this.caseTracking, super.key});

  @override
  State<CaseTracking_Map> createState() => _CaseTracking_MapState();
}

class _CaseTracking_MapState extends State<CaseTracking_Map> {
  // GeoPoint staffCurrentLocation;
  late GoogleMapController mapController;

  // store all the map markers
  List<Marker> MapMarkers = [];
  late CaseTracking_Model caseTrackingData;

  // marker icons
  BitmapDescriptor? _ambulanceIcon;
  BitmapDescriptor? _patientIcon;

  @override
  void initState() {
    super.initState();
    caseTrackingData = widget.caseTracking;
    // call your data fetching methods here
    _loadIcons();
    fetchFutureData();
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

  Future<void> fetchFutureData() async {
    // fetch your data using FutureBuilder here
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('Staffs')
        .doc(caseTrackingData.staffID)
        .get();
    log('${doc['Location'].latitude}, ${doc['Location'].longitude}');
    List<Marker> markers = [];
    Marker marker = Marker(
      icon: _ambulanceIcon ?? BitmapDescriptor.defaultMarker,
      markerId: MarkerId('staff Currnet location'),
      position: LatLng(doc['Location'].latitude, doc['Location'].longitude),
      infoWindow: InfoWindow(
        title: 'Name: ${doc['Name']}',
        // snippet: ' Phone Number: ${doc['PhoneNumber']}\n   UID: ${doc['UID']}',
        snippet: ' staff current location',
      ),
    );
    markers.add(marker);

    // user's requested location
    markers.add(Marker(
      icon: _patientIcon ?? BitmapDescriptor.defaultMarker,
      markerId: MarkerId(caseTrackingData.userID),
      position: LatLng(caseTrackingData.userLocation.latitude,
          caseTrackingData.userLocation.longitude),
      infoWindow: InfoWindow(
        title: 'Name: ${caseTrackingData.name}',
        snippet:
            ' Phone Number: ${caseTrackingData.phoneNumber}\n   UID: ${caseTrackingData.userID}',
      ),
    ));

    // staff allocated at
    markers.add(Marker(
      icon: BitmapDescriptor.defaultMarker,
      markerId: MarkerId(caseTrackingData.staffID),
      position: LatLng(caseTrackingData.staffLocation.latitude,
          caseTrackingData.staffLocation.longitude),
      infoWindow: InfoWindow(
        title: 'Route Begins Here',
        // snippet: ' Phone Number: ${caseTrackingData.phoneNumber}\n   UID: ${caseTrackingData.userID}',
      ),
    ));

    // add your future markers to the list of staffMarkers
    setState(() {
      MapMarkers.addAll(markers);
      log(MapMarkers.length.toString());
    });
  }

  void fetchStreamData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Staffs')
        .where('Category', isEqualTo: 'Police Department')
        .get();
    List<Marker> markers = [];
    querySnapshot.docs.forEach((doc) {
      Marker marker = Marker(
        // icon: _ambulanceIcon!,
        markerId: MarkerId(doc['UID'].toString()),
        position: LatLng(doc['Location'].latitude, doc['Location'].longitude),
        infoWindow: InfoWindow(
          title: 'Name: ${doc['Name']}',
          snippet:
              ' Phone Number: ${doc['PhoneNumber']}\n   UID: ${doc['UID']}',
        ),
      );
      markers.add(marker);
    });
    // add your future markers to the list of staffMarkers
    setState(() {
      MapMarkers.addAll(markers);
      log('Marker length: ${MapMarkers.length}');
    });
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text('Back'),
          backgroundColor: Color.fromARGB(81, 33, 149, 243),
          elevation: 0,
        ),
        body: SizedBox(
          height: _height,
          width: _width,
          child: GoogleMap(
            mapType: MapType.normal,
            markers: Set<Marker>.of(MapMarkers),
            initialCameraPosition: const CameraPosition(
                target: LatLng(
                  27.6683,
                  85.3205,
                ),
                zoom: 12),
          ),
        ));
  }
}
