import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final String? lat;
  final String? long;

  const MapScreen({Key? key, this.lat, this.long}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();

  Marker? _marker;
  LatLng? currentLatLng;

  var country;
  var countryCode;
  var cityName;
  var state;
  var address;
  var pinCode;
  var lat;
  var long;

  @override
  void initState() {
    initData();
    super.initState();
  }

  initData() async {
    await Geolocator.getCurrentPosition().then((currLocation) async {
      setState(() {
        currentLatLng =
            LatLng(double.parse(widget.lat!), double.parse(widget.long!));
      });
      var addresses = await placemarkFromCoordinates(
          double.parse(widget.lat!), double.parse(widget.long!));
      print('addresses-->>${addresses}');

      ///currLocation.longitude
      var first = addresses.first;
      country = first.country;
      countryCode = first.isoCountryCode;
      cityName = first.locality;
      state = first.administrativeArea;
      pinCode = first.postalCode;
      address = '${first.street} ${cityName}, ${state}, ${country}, ${pinCode}';
      lat = widget.lat ?? "";
      long = widget.long ?? "";
      _marker = Marker(
        markerId: MarkerId('currentLocation'),
        position: LatLng(double.parse(widget.lat!), double.parse(widget.long!)),
        infoWindow: InfoWindow(title: 'Current Location'),
      );
      setState(() {});
    });
  }

  void _handleMapTap(LatLng tappedPoint) async {
    _updateMarker(tappedPoint.latitude, tappedPoint.longitude);
  }

  Future<void> _updateMarker(double latitude, double longitude) async {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

    currentLatLng = LatLng(
        double.parse(latitude.toString()), double.parse(longitude.toString()));
    _marker = Marker(
      markerId: const MarkerId('currentLocation'),
      position: LatLng(latitude, longitude),
      infoWindow: const InfoWindow(title: 'Current Location'),
    );
    address = await placemarkFromCoordinates(
        double.parse(latitude.toString()), double.parse(longitude.toString()));
    var first = address.first;
    country = first.country;
    countryCode = first.isoCountryCode;
    cityName = first.locality;
    state = first.administrativeArea;
    pinCode = first.postalCode;
    address = '${first.street} $cityName, ${state}, ${country}';
    // area = first.subLocality;
    lat = latitude.toString() ?? "";
    long = longitude.toString() ?? "";
    print('update pinCode----==>>..${pinCode}');

    setState(() {});
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentLatLng == null
          ? const SizedBox()
          : SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: Stack(
                          // alignment: Alignment.center,
                          children: [
                            GoogleMap(
                              initialCameraPosition: CameraPosition(
                                  target: currentLatLng!, zoom: 17),
                              markers: _marker != null
                                  ? Set<Marker>.of([_marker!])
                                  : {},
                              mapType: MapType.normal,
                              onTap: (tappedPoint) {
                                _handleMapTap(tappedPoint);
                              },
                              zoomGesturesEnabled: true,
                              // markers: _markers.toSet(),
                              zoomControlsEnabled: true,
                              // myLocationEnabled: true,
                              // myLocationButtonEnabled: false,
                              onMapCreated: (GoogleMapController controller) {
                                _controller.complete(controller);
                              },
                              padding: const EdgeInsets.only(
                                top: 40.0,
                              ),
                              onCameraMove: (position) {
                                // _debouncer.run(() {
                                // setState(() {
                                // _isLoading = true;
                                // print('_markers.first===${_markers}');
                                // _markers.first = _markers.first
                                //     .copyWith(positionParam: position.target);

                                // lat = position.target.latitude;
                                // lng = position.target.longitude;
                                // printData("My Latitude : ",
                                //     position.target.latitude.toString());
                                // printData("My Longitude : ",
                                //     position.target.longitude.toString());

                                // getAddress(position.target.latitude,
                                //     position.target.longitude);
                                // });
                                //});
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
