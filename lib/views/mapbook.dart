import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMaps extends StatefulWidget {
  const GoogleMaps({Key? key, required this.data}) : super(key: key);
  final dynamic data;
  @override
  State<GoogleMaps> createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  List<Marker> myMarker = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 76, 124, 172),
        title: const Text("Map"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
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
        initialCameraPosition: CameraPosition(
            target: LatLng(widget.data['book_lat'], widget.data['book_lng']),
            zoom: 14),
        myLocationEnabled: true,
        markers: {
          Marker(
              markerId: MarkerId(widget.data['book_pinhome']),
              position:
                  LatLng(widget.data['book_lat'], widget.data['book_lng'])),
        },
      ),
    );
  }
}
