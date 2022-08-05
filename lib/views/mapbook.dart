import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMaps extends StatefulWidget {
  GoogleMaps({Key? key, required this.data}) : super(key: key);
  dynamic data;
  @override
  State<GoogleMaps> createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  @override
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(7.1713644, 100.611544),
    zoom: 14,
  );
  @override
  List<Marker> myMarker = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Map"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.cancel_outlined,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        myLocationEnabled: true,
        markers: {
          Marker(
              markerId: MarkerId("book_pinhome"),
              position:
                  LatLng(widget.data['book_lat'], widget.data['book_lng'])),
        },
      ),
    );
  }
}
