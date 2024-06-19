// ignore_for_file: public_member_api_docs, sort_constructors_first, unnecessary_null_comparison
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:gocab/screens/driver_pin_verify_screen.dart';
import 'package:gocab/utils/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:gocab/widgets/driver_details_widget.dart';

// ignore: must_be_immutable
class CabDetailsScreen extends StatefulWidget {
  LatLng startingPoint;
  LatLng endingPoint;
  final String pin;

  CabDetailsScreen({
    super.key,
    required this.startingPoint,
    required this.endingPoint,
    required this.pin,
  });

  @override
  State<CabDetailsScreen> createState() => _CabDetailsScreenState();
}

class _CabDetailsScreenState extends State<CabDetailsScreen> {
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(20.5937, 78.9629),
    zoom: 14.4746,
  );

  late String _mapStyle;
  GoogleMapController? myMapController;
  Set<Polyline> polylines = {};

  @override
  void initState() {
    super.initState();
    rootBundle.loadString('assets/map_style.txt').then((string) {
      setState(() {
        _mapStyle = string;
      });
    });
  }

  void _zoomOutToShowBothMarkers() {
    if (widget.startingPoint != null && widget.endingPoint != null) {
      LatLngBounds bounds = LatLngBounds(
        southwest: LatLng(
          widget.startingPoint.latitude < widget.endingPoint.latitude
              ? widget.startingPoint.latitude
              : widget.endingPoint.latitude,
          widget.startingPoint.longitude < widget.endingPoint.longitude
              ? widget.startingPoint.longitude
              : widget.endingPoint.longitude,
        ),
        northeast: LatLng(
          widget.startingPoint.latitude > widget.endingPoint.latitude
              ? widget.startingPoint.latitude
              : widget.endingPoint.latitude,
          widget.startingPoint.longitude > widget.endingPoint.longitude
              ? widget.startingPoint.longitude
              : widget.endingPoint.longitude,
        ),
      );

      myMapController!.animateCamera(
        CameraUpdate.newLatLngBounds(bounds, 150),
      );
    }
  }

  void _updatePolyline() {
    if (widget.startingPoint != null && widget.endingPoint != null) {
      setState(() {
        _addPolyline();
      });
    }
  }

  void _addPolyline() {
    polylines.clear();
    polylines.add(
      Polyline(
        polylineId: const PolylineId("route"),
        color: AppColors.blackColor,
        width: 5,
        points: [widget.startingPoint, widget.endingPoint],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.startingPoint != null && widget.endingPoint != null) {
      _addPolyline();
    }

    return Scaffold(
      drawer: Drawer(
        backgroundColor: AppColors.amberColor,
        child: ListView(
          children: [
            DrawerHeader(
                child: Column(
              children: [
                Image.asset(
                  'assets/gocab.png',
                  height: 60,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text("GoCab",
                    style: GoogleFonts.poppins(
                        fontSize: 35, fontWeight: FontWeight.bold))
              ],
            )),
            ListTile(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DriverVerificationScreen(pin: widget.pin),
                    ));
              },
              title: Text("Driver Side",
                  style: GoogleFonts.poppins(
                      fontSize: 20, fontWeight: FontWeight.w600)),
            )
          ],
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              zoomControlsEnabled: false,
              initialCameraPosition: _kGooglePlex,
              markers: {
                if (widget.startingPoint != null)
                  Marker(
                    markerId: const MarkerId("widget.startingPoint"),
                    position: widget.startingPoint,
                    draggable: true,
                    onDragEnd: (value) {
                      setState(() {
                        widget.startingPoint = value;
                        _updatePolyline();
                      });
                    },
                  ),
                if (widget.endingPoint != null)
                  Marker(
                    markerId: const MarkerId("widget.endingPoint"),
                    position: widget.endingPoint,
                    draggable: true,
                    onDragEnd: (value) {
                      setState(() {
                        widget.endingPoint = value;
                        _updatePolyline();
                      });
                    },
                  ),
              },
              polylines: polylines,
              onMapCreated: (GoogleMapController controller) {
                myMapController = controller;
                if (_mapStyle.isNotEmpty) {
                  myMapController!.setMapStyle(_mapStyle);
                }
              },
            ),
            Positioned(
              bottom: 150,
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
            Positioned(
              child: Container(
                width: Get.width,
                height: Get.height * 0.1,
                decoration: const BoxDecoration(color: AppColors.blackColor),
                child: Center(
                  child: Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(children: [
                        TextSpan(
                          text: "Share this Pin to your Driver",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: AppColors.greyColor,
                          ),
                        ),
                        TextSpan(
                          text: '\nPIN: ${widget.pin}',
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.greyColor,
                          ),
                        )
                      ])),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: DriverDetailsWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
