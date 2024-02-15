import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class Maps extends StatefulWidget {
  const Maps({Key? key}) : super(key: key);

  @override
  State<Maps> createState() => _MapsState();
}

final Set<Marker> _markers = <Marker>{};
Position? position;

class _MapsState extends State<Maps> {
  late GoogleMapController _mapController;

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
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

  Future<void> getMarkers() async {
    if (kDebugMode) {
      print("getMarkers is entered");
    }
    final response = await http.get(
        Uri.parse('https://9ee4-35-227-54-49.ngrok-free.app/process_text'));
    List data = jsonDecode(response.body);
    if (kDebugMode) {
      print(response.headers);
      print(response.statusCode);
    }
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print("ji");
        print(data);
      }
    } else {
      debugPrint("error!");
    }

    for (int i = 0; i < data.length / 2; i++) {
      _markers.add(Marker(
          markerId: MarkerId((i + 1).toString()),
          position: LatLng(data[i + 5], data[i]),
          icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueAzure)));
    }
  }

  void setLocation() async {
    position = await getCurrentUserLocation();
    _markers.add(Marker(
        markerId: const MarkerId("0"),
        position: LatLng(position!.latitude, position!.longitude)));
    await getMarkers();
    if (kDebugMode) {
      print(_markers);
    }
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
          body: position != null
              ? SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                        target: LatLng(position!.latitude, position!.longitude),
                        zoom: 14),
                    onMapCreated: _onMapCreated,
                    markers: _markers,
                    circles: {
                      Circle(
                          circleId: const CircleId("0"),
                          center:
                              LatLng(position!.latitude, position!.longitude),
                          radius: 750,
                          fillColor: Colors.green.withOpacity(0.5),
                          strokeColor: Colors.green.withOpacity(0.5),
                          strokeWidth: 1)
                    },
                  ),
                )
              : const Center(child: CircularProgressIndicator())),
    );
  }
}
