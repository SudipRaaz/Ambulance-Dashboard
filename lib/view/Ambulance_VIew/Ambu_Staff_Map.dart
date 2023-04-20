import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AmbulanceStaffTracking extends StatefulWidget {
  AmbulanceStaffTracking({super.key});

  @override
  State<AmbulanceStaffTracking> createState() => _AmbulanceStaffTrackingState();
}

class _AmbulanceStaffTrackingState extends State<AmbulanceStaffTracking> {
  late GoogleMapController mapController;

  // store all the map markers
  List<Marker> staffMarkers = [];

  // marker icons
  BitmapDescriptor? _ambulanceIcon;
  BitmapDescriptor? _patientIcon;

  @override
  void initState() {
    super.initState();
    // call your data fetching methods here
    fetchStaffData();
    fetchRequestData();
    _loadIcons();
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

  // fetch the user reqeust's location
  Future<void> fetchRequestData() async {
    // fetch your data using FutureBuilder here
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('AmbulanceDepartment')
        .where('Status', isEqualTo: 'Waiting')
        .get();
    List<Marker> markers = [];
    querySnapshot.docs.forEach((doc) {
      Marker marker = Marker(
        icon: _patientIcon!,
        markerId: MarkerId(doc['uid'].toString()),
        position:
            LatLng(doc['userLocation'].latitude, doc['userLocation'].longitude),
        infoWindow: InfoWindow(
          title: 'Name: ${doc['name']}',
          snippet: ' Phone Number: ${doc['phoneNumber']}\n UID: ${doc['uid']}',
        ),
      );
      markers.add(marker);
    });
    // add your future markers to the list of staffMarkers
    setState(() {
      staffMarkers.addAll(markers);
    });
  }

  void fetchStaffData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Staffs')
        .where('Category', isEqualTo: 'Ambulance Department')
        .get();
    List<Marker> markers = [];
    querySnapshot.docs.forEach((doc) {
      Marker marker = Marker(
        // icon: _ambulanceIcon?,
        markerId: MarkerId(doc['UID'].toString()),
        position: LatLng(doc['Location'].latitude, doc['Location'].longitude),
        infoWindow: InfoWindow(
          title: 'Staff: ${doc['Name']}',
          snippet:
              ' Phone Number: ${doc['PhoneNumber']}\n   UID: ${doc['UID']}',
        ),
      );
      markers.add(marker);
    });
    // add your future markers to the list of staffMarkers
    setState(() {
      staffMarkers.addAll(markers);
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
            markers: Set<Marker>.of(staffMarkers),
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
