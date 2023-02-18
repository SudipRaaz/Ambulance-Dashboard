import 'package:flutter/material.dart';
import '../utilities/constant/widgets.dart';

class AddAmbulancePage extends StatefulWidget {
  const AddAmbulancePage({super.key});

  @override
  State<AddAmbulancePage> createState() => _AddAmbulancePageState();
}

class _AddAmbulancePageState extends State<AddAmbulancePage> {
  // text controller
  final TextEditingController nameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String? driverName;
  String? vehicleType;
  String? paramedicAvailability;
  String? vehiclePlateNumber;
  String? contactNumber;
  String? insuranceDocuments;
  String? licenseNumber;
  String? dateOfBirth;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                  Text("Add New Ambulance with Driver"),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 35.0, vertical: 20),
              child: Column(
                children: [
                  Container(
                      width: width,
                      decoration: BoxDecoration(
                          border: Border.all(width: 2),
                          borderRadius: BorderRadius.circular(25)),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    decoration: InputDecoration(
                                        labelText: 'Driver Name'),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter the driver name';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) => driverName = value,
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(
                                        labelText: 'Ambulance Vehicle Type'),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter the ambulance vehicle type';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) => vehicleType = value,
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(
                                        labelText: 'Paramedic Availability'),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter the paramedic availability';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) =>
                                        paramedicAvailability = value,
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(
                                        labelText:
                                            'Ambulance Vehicle Plate Number'),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter the ambulance vehicle plate number';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) =>
                                        vehiclePlateNumber = value,
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(
                                        labelText: 'Contact Number'),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter the contact number';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) => contactNumber = value,
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(
                                        labelText:
                                            'Vehicle Insurance Documents'),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter the vehicle insurance documents';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) =>
                                        insuranceDocuments = value,
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(
                                        labelText: 'License Number'),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter the license number';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) => licenseNumber = value,
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(
                                        labelText: 'Date of Birth'),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter the date of birth';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) => dateOfBirth = value,
                                  ),
                                  addVerticalSpace(50),
                                  ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        _formKey.currentState?.save();
                                        // do something with the saved data
                                      }
                                    },
                                    child: Text('Submit'),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
