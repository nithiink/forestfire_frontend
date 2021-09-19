import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_flutter_web/google_maps_flutter_web.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        // color: Colors.black,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(text: "Map"),
                    TextSpan(text: "View")
                  ]))
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 11.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
