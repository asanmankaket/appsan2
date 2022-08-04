import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMaps extends StatefulWidget {
  GoogleMaps({Key? key, @required latilongti}) : super(key: key);
  dynamic latilongti;
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
  final TextEditingController _latilongti = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Map"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.done,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context, _latilongti.text);
              // do something
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
            markerId: MarkerId("1"),
            position: widget.latilongti,
          )
        },
      ),
    );
  }

  _handleTap(LatLng tappedPoint) {
    setState(() {
      _latilongti.text = tappedPoint.toString();
      myMarker = [];
      myMarker.add(Marker(
        markerId: MarkerId(tappedPoint.toString()),
        position: tappedPoint,
      ));
    });
  }
}
