import 'dart:async';

import 'package:dunzodriver_copy1/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  final Location _location = Location();
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kLake =  CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
  static const CameraPosition _kGooglePlex =  CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    _location.onLocationChanged.listen((l) {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 20,
        toolbarHeight: 100,
        backgroundColor: Constant.primary,
        centerTitle:true,
      ),
      body:  Stack(
        children: [
          GoogleMap(
            myLocationEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            initialCameraPosition: _kGooglePlex,
          ),
          DraggableScrollableSheet(
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                // child: MapBottomSheet1(),
                child: null,
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent,
              );
            },
            initialChildSize: 0.4,
            maxChildSize: 0.5,
            minChildSize: 0.3,
            expand: true,


          ),
          //
          // Positioned(
          //   child: Container(
          //     child: MapBottomSheet1(),
          //     height: 200,
          //     width: MediaQuery.of(context).size.width,
          //     color: Colors.transparent,
          //   ),
          //   bottom: 20,
          // ),
        ],
      ),
    );
  }
}
