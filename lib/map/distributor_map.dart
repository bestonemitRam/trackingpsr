
import 'package:bmitserp/provider/leaveprovider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';

class MyApps extends StatelessWidget {
  final BitmapDescriptor customIcon;
  final double lat;
  final double long;

  MyApps(this.customIcon, this.lat, this.long);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Distributors'),
      ),
      body: MapScreen(
        customIcon: customIcon,
        lat: lat,
        long: long,
      ),
    );
  }
}

class MapScreen extends StatefulWidget {
  final BitmapDescriptor customIcon;
  final double lat;
  final double long;

  const MapScreen({
    Key? key,
    required this.customIcon,
    required this.lat,
    required this.long,
  }) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;
  double cameraBearing = 30;
  double cameraZoom = 10;
  double cameraTilt = 0;
  double lat = 00.00;
  double long = 00.00;

  final List<Marker> markers = [];

  @override
  Widget build(BuildContext context) {
    final leaveData = Provider.of<LeaveProvider>(context, listen: true);
    final distributor = leaveData.distributor;

    for (int i = 0; i < distributor.length; i++) {
      print(
          'jkdhfhjkghf  ${double.parse(distributor[i].distributorLatitude)}    ${double.parse(distributor[i].distributorLongitude)}');
      setState(() {
        markers.add(
          Marker(
            icon: widget.customIcon,
            markerId: MarkerId(distributor[i].toString()),
            position: LatLng(double.parse(distributor[i].distributorLatitude),
                double.parse(distributor[i].distributorLongitude)),
            infoWindow: InfoWindow(
                snippet: distributor[i].address ?? "",
                title:
                    "${distributor[i].distributorOrgName + ", " + distributor[i].name}"),
          ),
        );
      });
    }

    return GoogleMap(
        onMapCreated: _onMapCreated,
        myLocationButtonEnabled: true,
        compassEnabled: true,
        zoomControlsEnabled: true,
        zoomGesturesEnabled: true,
        circles: Set(),
        myLocationEnabled: true,
        // minMaxZoomPreference: MinMaxZoomPreference(10, 20),
        gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
          Factory<OneSequenceGestureRecognizer>(
            () => EagerGestureRecognizer(),
          ),
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(20.5937, 78.9629),
          zoom: 10,
          tilt: cameraTilt,
          //bearing: cameraBearing,
        ),
        markers: Set.from(markers));
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }
}
