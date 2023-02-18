import 'package:flutter/material.dart';

class PolicePage extends StatelessWidget {
  const PolicePage({super.key});

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("For police"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
              child: Container(
                width: _width,
                decoration: BoxDecoration(
                    border: Border.all(width: 2),
                    borderRadius: BorderRadius.circular(25)),
                child: Padding(
                  padding: const EdgeInsets.all(15),
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
            Reponse Message: 
            Message here
            ''',
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                      ElevatedButton(onPressed: () {}, child: Text("Map"))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
