import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:session_mate/commonWidget/custom_btn.dart';
import 'package:session_mate/modal/therapy_center_location_data_model.dart';
import 'package:session_mate/service/session_service.dart';
import 'package:session_mate/utils/app_string.dart';
import 'package:session_mate/utils/common_methods.dart';
import 'package:session_mate/utils/loading_dialog.dart';
import 'package:session_mate/utils/shared_preference_utils.dart';
import 'package:session_mate/utils/size_config_utils.dart';

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

  var cityName;
  var state;
  var address;
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

      ///currLocation.longitude
      var first = addresses.first;

      cityName = first.locality;
      state = first.administrativeArea;

      address = '${first.street} ${cityName}, ${state}';
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
    logs('currentLatLng -=------->> ${currentLatLng}');
    _marker = Marker(
      markerId: const MarkerId('currentLocation'),
      position: LatLng(latitude, longitude),
      infoWindow: const InfoWindow(title: 'Current Location'),
    );
    address = await placemarkFromCoordinates(
        double.parse(latitude.toString()), double.parse(longitude.toString()));
    var first = address.first;

    cityName = first.locality;
    state = first.administrativeArea;
    address = '${first.street} $cityName, $state';
    lat = latitude.toString() ?? "";
    long = longitude.toString() ?? "";

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentLatLng == null
          ? const SizedBox()
          : SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Expanded(
                    child: GoogleMap(
                      initialCameraPosition:
                          CameraPosition(target: currentLatLng!, zoom: 17),
                      markers:
                          _marker != null ? Set<Marker>.of([_marker!]) : {},
                      mapType: MapType.normal,
                      onTap: (tappedPoint) {
                        _handleMapTap(tappedPoint);
                      },
                      zoomGesturesEnabled: true,
                      zoomControlsEnabled: true,
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                      padding: const EdgeInsets.only(
                        top: 40.0,
                      ),
                      onCameraMove: (position) {},
                    ),
                  ),
                  SizeConfig.sH20,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomBtn(
                        height: 50,
                        onTap: () {
                          addLocation();
                        },
                        title: AppStrings.submit),
                  ),
                  SizeConfig.sH20,
                ],
              ),
            ),
    );
  }

  TherapyCenterLocationDataModel locationModel =
      TherapyCenterLocationDataModel();

  addLocation() async {
    locationModel.city = cityName;
    locationModel.state = state;
    locationModel.userId = SharedPreferenceUtils.getUserId();
    showLoadingDialog(context: context);

    final status = await SessionService.addTherapyCenter(locationModel);
    if (status) {
      hideLoadingDialog(context: context);
      Get.back();
    } else {
      hideLoadingDialog(context: context);
    }
  }
}
