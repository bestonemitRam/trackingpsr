import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';

class MapScreens extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreens> {
  GoogleMapController? mapController;

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: _onMapCreated,
    
      initialCameraPosition: CameraPosition(
        target:
            LatLng(37.7749, -122.4194), // Initial map center (San Francisco)
        zoom: 12, // Initial zoom level
      ),
      // polygons: Set<Polygon>.of(_buildPolygons()),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  List<Polygon> _buildPolygons() {
    return [
      Polygon(
        polygonId: PolygonId('polygon1'),
        points: [
          LatLng(37.7749, -122.4194),
          LatLng(37.7896, -122.3942),
          LatLng(37.7842, -122.4083),
        ],
        strokeWidth: 2,
        strokeColor: Colors.blue,
        fillColor: Colors.blue.withOpacity(0.5),
      ),
      Polygon(
        polygonId: PolygonId('polygon2'),
        points: [
          LatLng(19.0759837, 72.8776559),
          LatLng(28.679079, 77.069710),
          LatLng(26.850000, 80.949997),
          LatLng(19.0759837, 72.8776559),
        ],
        strokeWidth: 2,
        strokeColor: Colors.red,
        fillColor: Colors.red.withOpacity(0.5),
      ),
    ];
  }
}
