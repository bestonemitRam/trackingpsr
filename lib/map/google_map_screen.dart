import 'dart:async';
import 'package:bmitserp/map/MapController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({Key? key}) : super(key: key);
  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  final MapController _mapController = Get.put(MapController());
  final Completer<GoogleMapController> _controller = Completer();
  LatLng intialLocation = const LatLng(22.3039, 70.8022);
  final Set<Marker> _markers = {};

  Set<Polygon> _buildPolygons() {
    // Define the polygons to be displayed on the map
    Set<Polygon> polygons = {};

    // Example polygon 1
    final List<LatLng> polygon1Points = [
      LatLng(37.78425, -122.4024),
      LatLng(37.7896, -122.3882),
      LatLng(37.7958, -122.4085),
    ];
    final Polygon polygon1 = Polygon(
      polygonId: PolygonId('polygon1'),
      points: polygon1Points,
      fillColor: Colors.blue.withOpacity(0.5),
      strokeColor: Colors.blue,
      strokeWidth: 2,
    );
    polygons.add(polygon1);

    // Example polygon 2
    final List<LatLng> polygon2Points = [
      LatLng(37.7739, -122.4217),
      LatLng(37.7749, -122.4194),
      LatLng(37.7758, -122.4221),
    ];
    final Polygon polygon2 = Polygon(
      polygonId: PolygonId('polygon2'),
      points: polygon2Points,
      fillColor: Colors.green.withOpacity(0.5),
      strokeColor: Colors.green,
      strokeWidth: 2,
    );
    polygons.add(polygon2);

    // Add more polygons as needed

    return polygons;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: intialLocation,
                zoom: 15.6746,
              ),
              onMapCreated: (controller) {
                _controller.complete(controller);
              },
              markers: Set<Marker>.of(_mapController.markers),
              // markers: {
              //   Marker(
              //     markerId: const MarkerId("1"),
              //     position: intialLocation,
              //   ),
              // },

              // circles: {
              //   Circle(
              //     circleId: CircleId("1"),
              //     center: intialLocation,
              //     radius: 500,
              //     strokeWidth: 2,
              //     fillColor: Color(0xFF006491).withOpacity(0.2),
              //   ),
              // },
              polygons: {
                Polygon(
                  polygonId: const PolygonId("1"),
                  fillColor: Colors.red.withOpacity(0.5),
                  strokeWidth: 2,
                  points: const [
                    LatLng(22.3039, 70.8000),
                    LatLng(22.3029, 70.8022),
                    LatLng(22.3069, 70.8032),
                    LatLng(22.3069, 70.8032),
                    LatLng(22.3049, 70.8022),
                  ],
                ),
                Polygon(
                  polygonId: const PolygonId("2"),
                  fillColor:
                      const Color.fromARGB(255, 22, 20, 20).withOpacity(0.5),
                  strokeWidth: 4,
                  points: const [
                    LatLng(21.3039, 75.8000),
                    LatLng(21.3029, 75.8022),
                    LatLng(21.3069, 75.8032),
                    LatLng(21.3069, 75.8032),
                    LatLng(21.3049, 75.8022),
                  ],
                ),
              },
            ),
          ),
        ],
      ),
    );
  }
}
