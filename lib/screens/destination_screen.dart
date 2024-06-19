import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:gocab/screens/cab_details_screen.dart';
import 'package:gocab/utils/app_colors.dart';
import 'package:gocab/widgets/custom_textfield.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:cloud_firestore/cloud_firestore.dart';

class DestinationScreen extends StatefulWidget {
  const DestinationScreen({super.key});

  @override
  State<DestinationScreen> createState() => _DestinationScreenState();
}

class _DestinationScreenState extends State<DestinationScreen> {
  final TextEditingController startingController = TextEditingController();
  final TextEditingController endingController = TextEditingController();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(20.5937, 78.9629),
    zoom: 14.4746,
  );

  late String _mapStyle;
  GoogleMapController? myMapController;
  LatLng? startPoint;
  LatLng? endPoint;
  List<LatLng> polylineCoordinates = [];

  @override
  void initState() {
    super.initState();
    rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyle = string;
    });
  }

  final List<Map<String, dynamic>> places = [
    {"name": "New Delhi", "latitude": 28.6139, "longitude": 77.2090},
    {"name": "Mumbai", "latitude": 19.0760, "longitude": 72.8777},
    {"name": "Bengaluru", "latitude": 12.9716, "longitude": 77.5946},
    {"name": "Kolkata", "latitude": 22.5726, "longitude": 88.3639},
    {"name": "Chennai", "latitude": 13.0827, "longitude": 80.2707},
    {"name": "Hyderabad", "latitude": 17.3850, "longitude": 78.4867},
    {"name": "Pune", "latitude": 18.5204, "longitude": 73.8567},
    {"name": "Jaipur", "latitude": 26.9124, "longitude": 75.7873},
    {"name": "Ahmedabad", "latitude": 23.0225, "longitude": 72.5714},
    {"name": "Surat", "latitude": 21.1702, "longitude": 72.8311},
  ];

  void _setMarkerPosition(String placeName, bool isStartPoint) {
    var place = places.firstWhere(
      (place) => place['name'].toLowerCase() == placeName.toLowerCase(),
      orElse: () => {"latitude": 0.0, "longitude": 0.0},
    );

    setState(() {
      if (isStartPoint) {
        startPoint = LatLng(place['latitude'], place['longitude']);
      } else {
        endPoint = LatLng(place['latitude'], place['longitude']);
      }
      _updatePolyline();
    });

    if (myMapController != null) {
      myMapController!.animateCamera(
        CameraUpdate.newLatLng(LatLng(place['latitude'], place['longitude'])),
      );
    }
  }

  void _updatePolyline() {
    if (startPoint != null && endPoint != null) {
      setState(() {
        polylineCoordinates = [startPoint!, endPoint!];
      });
    }
  }

  void _zoomOutToShowBothMarkers() {
    if (startPoint != null && endPoint != null) {
      LatLngBounds bounds = LatLngBounds(
        southwest: LatLng(
          startPoint!.latitude < endPoint!.latitude
              ? startPoint!.latitude
              : endPoint!.latitude,
          startPoint!.longitude < endPoint!.longitude
              ? startPoint!.longitude
              : endPoint!.longitude,
        ),
        northeast: LatLng(
          startPoint!.latitude > endPoint!.latitude
              ? startPoint!.latitude
              : endPoint!.latitude,
          startPoint!.longitude > endPoint!.longitude
              ? startPoint!.longitude
              : endPoint!.longitude,
        ),
      );

      myMapController!.animateCamera(
        CameraUpdate.newLatLngBounds(bounds, 150),
      );
    }
  }

  Future<String> _getPinFromFirebase() async {
    // Generate a random PIN and store it in Firestore
    String pin = (Random().nextInt(9000) + 1000).toString();
    await FirebaseFirestore.instance.collection('pins').add({'pin': pin});
    return pin;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.amberColor,
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              zoomControlsEnabled: false,
              initialCameraPosition: _kGooglePlex,
              markers: {
                if (startPoint != null)
                  Marker(
                    markerId: const MarkerId("startPoint"),
                    position: startPoint!,
                    draggable: true,
                    onDragEnd: (value) {
                      setState(() {
                        startPoint = value;
                        _updatePolyline();
                      });
                    },
                  ),
                if (endPoint != null)
                  Marker(
                    markerId: const MarkerId("endPoint"),
                    position: endPoint!,
                    draggable: true,
                    onDragEnd: (value) {
                      setState(() {
                        endPoint = value;
                        _updatePolyline();
                      });
                    },
                  ),
              },
              polylines: {
                if (polylineCoordinates.isNotEmpty)
                  Polyline(
                    polylineId: const PolylineId("route"),
                    points: polylineCoordinates,
                    color: AppColors.blackColor,
                    width: 5,
                  ),
              },
              onMapCreated: (GoogleMapController controller) {
                myMapController = controller;
                myMapController!.setMapStyle(_mapStyle);
              },
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.30,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: AppColors.amberColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Where are you going?',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  customTextField(
                    controller: startingController,
                    text: "Starting Point",
                    onChanged: (value) {
                      _setMarkerPosition(value, true);
                    },
                  ),
                  const SizedBox(height: 10),
                  customTextField(
                    controller: endingController,
                    text: "Ending Point",
                    onChanged: (value) {
                      _setMarkerPosition(value, false);
                    },
                  ),
                ],
              ),
            ),
            Positioned(
              top: 20,
              left: 10,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios_outlined,
                  color: AppColors.whiteColor,
                  size: 18,
                ),
              ),
            ),
            Positioned(
              bottom: 100,
              right: 16,
              child: IconButton(
                onPressed: _zoomOutToShowBothMarkers,
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.all(15),
                  ),
                  backgroundColor: MaterialStateProperty.all(
                    AppColors.blackColor,
                  ),
                ),
                icon: const Icon(
                  Icons.my_location_rounded,
                  color: AppColors.whiteColor,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(20),
        width: Get.width,
        height: Get.height * 0.1,
        decoration: const BoxDecoration(color: AppColors.blackColor),
        child: ElevatedButton(
          onPressed: () async {
            if (startingController.text.isEmpty ||
                endingController.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content:
                      Text('Please select both starting and ending points.'),
                  duration: Duration(seconds: 2),
                ),
              );
            } else {
              bool isValidStartingPoint = places.any((place) =>
                  place['name'].toLowerCase() ==
                  startingController.text.toLowerCase());
              bool isValidEndingPoint = places.any((place) =>
                  place['name'].toLowerCase() ==
                  endingController.text.toLowerCase());

              if (isValidStartingPoint && isValidEndingPoint) {
                String pin = await _getPinFromFirebase();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CabDetailsScreen(
                      startingPoint: startPoint!,
                      endingPoint: endPoint!,
                      pin: pin,
                    ),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Invalid Place'),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            }
          },
          child: Text(
            "Confirm Location",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.blackColor,
              letterSpacing: 1,
            ),
          ),
        ),
      ),
    );
  }
}
