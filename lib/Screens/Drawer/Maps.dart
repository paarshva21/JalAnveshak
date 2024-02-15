import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class Maps extends StatefulWidget {
  const Maps({Key? key}) : super(key: key);

  @override
  State<Maps> createState() => _mapsState();
}

class _mapsState extends State<Maps> {
  Position? position;
  late GoogleMapController _mapController;
  final Set<Marker> _markers = <Marker>{};

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void setLocation() async {
    position = await getCurrentUserLocation();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    setLocation();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: FutureBuilder<List<Double>?>(
          future: getMarkers(),
          builder: (context, snapshot) {
            print(snapshot.data);
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: GoogleMap(
                initialCameraPosition: const CameraPosition(
                    target: LatLng(19.0968, 72.8517),
                    zoom: 14),
                onMapCreated: _onMapCreated,
                markers: _markers,
                circles: {
                  Circle(
                      circleId: const CircleId("0"),
                      center: const LatLng(19.0968, 72.8517),
                      radius: 750,
                      fillColor: Colors.green.withOpacity(0.5),
                      strokeColor: Colors.green.withOpacity(0.5),
                      strokeWidth: 1)
                },
              ),
            );
          }),
    ));
  }

  Future<List<Double>?> getMarkers() async {
    final response = await http
        .get(Uri.parse('https://bb14-34-69-52-15.ngrok-free.app/process_text'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      debugPrint(data);
    } else {
      debugPrint("error!");
    }
  }

  Future<Position> getCurrentUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    return position;
  }
}
