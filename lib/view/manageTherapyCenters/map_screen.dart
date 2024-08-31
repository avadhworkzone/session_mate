<<<<<<< Updated upstream
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
=======
import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:session_mate/commonWidget/commom_textfield.dart';
import 'package:google_places_for_flutter/google_places_for_flutter.dart';
import 'package:session_mate/commonWidget/custom_btn.dart';
import 'package:session_mate/modal/therapy_center_data_model.dart';
import 'package:session_mate/modal/therapy_center_location_data_model.dart';
import 'package:session_mate/service/auth_service.dart';
import 'package:session_mate/service/session_service.dart';
import 'package:session_mate/utils/app_colors.dart';
import 'package:session_mate/utils/app_enum.dart';
import 'package:session_mate/utils/app_snackbar.dart';
import 'package:session_mate/utils/app_string.dart';
import 'package:session_mate/utils/loading_dialog.dart';
import 'package:session_mate/utils/regex.dart';
import 'package:session_mate/utils/shared_preference_utils.dart';
import 'package:session_mate/utils/size_config_utils.dart';
import 'package:session_mate/view/manageSession/manage_sessions.dart';
import 'package:session_mate/view/manageTherapyCenters/manage_therapy_centers.dart';

class MapScreen extends StatefulWidget {
  final String? lat;
  final String? long;

  const MapScreen({Key? key, this.lat, this.long}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? _controller1;

  // Completer<GoogleMapController> _controller = Completer();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController countryController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController townCityController = TextEditingController();
  TextEditingController flatHouseNOController = TextEditingController();
  TextEditingController areaStreetController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController centerCodeController = TextEditingController();

  Marker? _marker;
  LatLng? therapyCenterLatLng;

  var cityName;
  var state;
  var address;
  var lat;
  var long;
  var centerCode;
  var userId;
  bool isCenterCodeNotVerify = false;
  late List<TherapyCenterDataModel> therapyCenterData;
  TherapyCenterDataModel therapyCenterDataModel = TherapyCenterDataModel();

  @override
  void initState() {
    initData();
    super.initState();
  }

  initData() async {
    showLoadingDialog(context: context);
    SessionService().getTherapyDropdownCenter().then((data) {
      if (data != []) {
        setState(() {
          therapyCenterData = data;
          print('location data is ${jsonEncode(therapyCenterData)}');
        });
      } else {
        therapyCenterData = [];
        logs('Data is null');
      }
    }).catchError((error) {
      logs('Error fetching data: $error');
    });
    getLocation();
  }

  getLocation({double? latit, double? longit}) async {

    // await Geolocator.getCurrentPosition().then((currLocation) async {
    _controller1?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(latit ?? double.parse(widget.lat!),
          longit ?? double.parse(widget.long!)),
      zoom: 16.0,
    )));

    // setState(() {
    therapyCenterLatLng = LatLng(latit ?? double.parse(widget.lat!),
        longit ?? double.parse(widget.long!));

    print("Current therapyCenterLatLng :- $therapyCenterLatLng");
    // });
    var addresses = await placemarkFromCoordinates(
        latit ?? double.parse(widget.lat!),
        longit ?? double.parse(widget.long!));

    ///currLocation.longitude
    var first = addresses.first;

    print(addresses);
    print(first);

    cityName = first.locality;
    state = first.administrativeArea;

    address = '${first.street} $cityName, $state';
    lat = latit ?? widget.lat ?? "";
    long = longit ?? widget.long ?? "";

    // _marker = Marker(
    //   // markerId: const MarkerId('currentLocation'),
    //   markerId: const MarkerId('therapyLocation'),
    //   position: LatLng(latit ?? double.parse(widget.lat!),
    //       longit ?? double.parse(widget.long!)),
    //   infoWindow: const InfoWindow(title: 'Current Location'),
    // );

    countryController.text = first.country.toString();
    stateController.text = first.administrativeArea.toString();
    townCityController.text = first.locality.toString();
    landmarkController.text = first.subLocality.toString();
    pincodeController.text = first.postalCode.toString();

    if (latit == null && longit == null) {
      hideLoadingDialog(context: context);
    }

    setState(() {});
    // });
  }

  void _handleMapTap(LatLng tappedPoint) async {
    if (centerCodeController.text.isNotEmpty) {
      _updateMarker(tappedPoint.latitude, tappedPoint.longitude);
    }
  }

  Future<void> _updateMarker(double latitude, double longitude) async {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

    therapyCenterLatLng = LatLng(
        double.parse(latitude.toString()), double.parse(longitude.toString()));

    _marker = Marker(
      markerId: const MarkerId('therapyCenterLocation'),
      position: LatLng(latitude, longitude),
      infoWindow: const InfoWindow(title: 'Current Location'),
    );

    address = await placemarkFromCoordinates(
        double.parse(latitude.toString()), double.parse(longitude.toString()));
    var first = address.first;

    print(address);
    print(first);

    cityName = first.locality;
    state = first.administrativeArea;
    address = '${first.street} $cityName, $state';
    lat = latitude.toString() ?? "";
    long = longitude.toString() ?? "";

    countryController.text = first.country.toString();
    stateController.text = first.administrativeArea.toString();
    townCityController.text = first.locality.toString();
    landmarkController.text = first.subLocality.toString();
    pincodeController.text = first.postalCode.toString();

    setState(() {});
  }

  void addOnTap() {
    if (formKey.currentState!.validate()) {

      bool matchFound = false;

      for (var index = 0; index < therapyCenterData.length; index++) {

        print("CURRENT MOBILE NUMBER :- ${SharedPreferenceUtils.getUserId()}");

        if (therapyCenterData[index].userId == SharedPreferenceUtils.getUserId()) {
          print(
              "therapyCenterData therapyCenterCode :- ${therapyCenterData[index].therapyCenterCode}");
          print(
              "CHECK CONDITION :- ${centerCodeController.text == therapyCenterData[index].therapyCenterCode}");

          if (centerCodeController.text ==
              therapyCenterData[index].therapyCenterCode) {

            isCenterCodeNotVerify = false;



            lat = double.parse(
                "${therapyCenterData[index].location?[0].lattitude}");
            long = double.parse(
                "${therapyCenterData[index].location?[0].longitude}");


            therapyCenterLatLng = LatLng(
                lat ?? double.parse(widget.lat ?? '0.0'),
                long ?? double.parse(widget.long ?? '0.0'));

            print("Selected ID :- ${therapyCenterData[index].id}");
            SessionService.updateIsFeatchTherapyCenter("${therapyCenterData[index].id}");
            // therapyCenterData[index].isFeatchCenter = true;
            // print("isFeatchCenter :- ${therapyCenterData[index].isFeatchCenter}");

            print("lat :- $lat , long :- $long");

            addLocation();
            // Get.back();
            Get.offAll(const ManageTherapyCenters());

            centerCodeController.clear();
            matchFound = true;
            break; // Exit the loop since we found a match
          }
        }
      }

      if (!matchFound) {
        isCenterCodeNotVerify = true;
        therapyCenterLatLng = LatLng(double.parse(widget.lat ?? '0.0'),
            double.parse(widget.long ?? '0.0'));

        addLocation();
        // Get.back();
        Get.offAll(const ManageTherapyCenters());

        print("Do Not Match Center Code");
        showErrorSnackBar("Do Not Match Center Code", "");

        centerCodeController.clear();
      }
    }
  }

  addLocation() async {

    print("isCenterCodeNotVerify :- $isCenterCodeNotVerify");

    _controller1?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: isCenterCodeNotVerify
          ? LatLng(double.parse(widget.lat!), double.parse(widget.long!))
          : LatLng(lat ?? double.parse(widget.lat ?? '0.0'),
              long ?? double.parse(widget.long ?? '0.0')),
      zoom: 16.0,
    )));

    // setState(() {
    // therapyCenterLatLng = LatLng(lat ?? double.parse(widget.lat ?? '0.0'), long ?? double.parse(widget.long ?? '0.0'));

    // });

    print("therapyCenterLatLng :- $therapyCenterLatLng");
    print(
        "Postion :- ${LatLng(lat ?? double.parse(widget.lat ?? '0.0'), long ?? double.parse(widget.long ?? '0.0'))}");

    if (!isCenterCodeNotVerify) {
      _marker = Marker(
        markerId: const MarkerId('therapyCenterLocation'),
        position: LatLng(lat ?? double.parse(widget.lat ?? '0.0'),
            long ?? double.parse(widget.long ?? '0.0')),
        infoWindow: const InfoWindow(title: 'therapyCenterLocation'),
      );

      print("_marker :- $_marker");


    } else {
      _marker = null;
      print("No marker shown as isCenterCodeNotVerify is true");
    }


    // locationModel.city = townCityController.text.trim();
    // locationModel.state = stateController.text.trim();
    // locationModel.userId = SharedPreferenceUtils.getUserId();
    // locationModel.country = countryController.text.trim();
    // locationModel.flatHouseNo = flatHouseNOController.text.trim();
    // locationModel.areaStreet = areaStreetController.text.trim();
    // locationModel.landmark = landmarkController.text.trim();
    // locationModel.pincode = pincodeController.text.trim();
    // locationModel.locationUniqueCode = generateRandomTransID(8);

    // final status = await SessionService.addTherapyCenter(locationModel);

    // if (status) {
    //   hideLoadingDialog(context: context);
    //   // Get.back();
    // } else {
    //   hideLoadingDialog(context: context);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: therapyCenterLatLng == null
            ? const SizedBox()
            : SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    /// Map Location Search Field
                    // Padding(
                    //   padding: EdgeInsets.symmetric(
                    //       horizontal: 10.w, vertical: 10.w),
                    //   child: SingleChildScrollView(
                    //     child: SearchGooglePlacesWidget(
                    //       placeType: PlaceType.address,
                    //       placeholder: 'Enter the address',
                    //       apiKey: 'AIzaSyD5lnnFHXOzYrVCh8bhzqDIMgXm2XLq6x0',
                    //       onSearch: (Place place) {},
                    //       onSelected: (Place place) async {
                    //         var geolocation = await place.geolocation;
                    //         //
                    //         // var destinationCoordinates = LatLng(
                    //         //     geolocation?.coordinates.latitude,
                    //         //     geolocation?.coordinates.longitude);
                    //
                    //         // List<Placemark> place1 = [];
                    //         // List<Placemark> newPlace =
                    //         //     await placemarkFromCoordinates(
                    //         //         geolocation?.coordinates.latitude,
                    //         //         geolocation?.coordinates.longitude);
                    //         // print(newPlace);
                    //         // if (!mounted) return;
                    //         // setState(() {
                    //         //   place1 = newPlace;
                    //         //   print('===${place1.first}');
                    //         // });
                    //         WidgetsBinding.instance
                    //             .addPostFrameCallback((timeStamp) {
                    //           // showLoadingDialog(context: context);
                    //           getLocation(
                    //               latit: geolocation?.coordinates.latitude,
                    //               longit: geolocation?.coordinates.longitude);
                    //           setState(() {});
                    //         });
                    //
                    //         // setDestination(place);
                    //       },
                    //     ),
                    //   ),
                    // ),

                    /// Google Map
                    Expanded(
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                            target: therapyCenterLatLng!, zoom: 17),
                        markers:
                            _marker != null ? Set<Marker>.of([_marker!]) : {},
                        mapType: MapType.normal,
                        onTap: (tappedPoint) {
                          print("tappedPoint :- $tappedPoint");
                          _handleMapTap(tappedPoint);
                        },
                        zoomGesturesEnabled: true,
                        zoomControlsEnabled: true,
                        myLocationEnabled: false,
                        onMapCreated: (GoogleMapController controller) {
                          /// _controller.complete(controller);
                          _controller1 = controller;
                        },
                        padding: const EdgeInsets.only(
                          top: 40.0,
                        ),
                        onCameraMove: (position) {},
                      ),
                    ),

                    SizeConfig.sH20,

                    /// Bottom Sheet
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomBtn(
                          height: 50,
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => SingleChildScrollView(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 15.w),
                                  child: Form(
                                    key: formKey,
                                    child: Column(
                                      children: [
                                        SizeConfig.sH17,

                                        // CommonTextField(
                                        //   regularExpression:
                                        //       RegularExpressionUtils
                                        //           .mapScreenField,
                                        //   title: AppStrings.countryRegion,
                                        //   contentPadding: EdgeInsets.only(
                                        //       bottom: 9.w, top: 6.w),
                                        //   titleFontWeight: FontWeight.w600,
                                        //   textEditController: countryController,
                                        //   validationType:
                                        //       ValidationTypeEnum.mapScreenField,
                                        // ),
                                        // SizeConfig.sH8,
                                        // CommonTextField(
                                        //   regularExpression:
                                        //       RegularExpressionUtils
                                        //           .mapScreenField,
                                        //   title: AppStrings.state,
                                        //   contentPadding: EdgeInsets.only(
                                        //       bottom: 9.w, top: 6.w),
                                        //   titleFontWeight: FontWeight.w600,
                                        //   textEditController: stateController,
                                        //   validationType:
                                        //       ValidationTypeEnum.mapScreenField,
                                        // ),
                                        // SizeConfig.sH8,
                                        // CommonTextField(
                                        //   regularExpression:
                                        //       RegularExpressionUtils
                                        //           .mapScreenField,
                                        //   title: AppStrings.cityTown,
                                        //   contentPadding: EdgeInsets.only(
                                        //       bottom: 9.w, top: 6.w),
                                        //   titleFontWeight: FontWeight.w600,
                                        //   textEditController:
                                        //       townCityController,
                                        //   validationType:
                                        //       ValidationTypeEnum.mapScreenField,
                                        // ),
                                        // SizeConfig.sH8,
                                        // CommonTextField(
                                        //   regularExpression:
                                        //       RegularExpressionUtils
                                        //           .mapScreenField,
                                        //   title: AppStrings.flatHouseNo,
                                        //   contentPadding: EdgeInsets.only(
                                        //       bottom: 9.w, top: 6.w),
                                        //   titleFontWeight: FontWeight.w600,
                                        //   textEditController:
                                        //       flatHouseNOController,
                                        //   validationType:
                                        //       ValidationTypeEnum.mapScreenField,
                                        // ),
                                        // SizeConfig.sH8,
                                        // CommonTextField(
                                        //   regularExpression:
                                        //       RegularExpressionUtils
                                        //           .mapScreenField,
                                        //   title: AppStrings.areaStreet,
                                        //   contentPadding: EdgeInsets.only(
                                        //       bottom: 9.w, top: 6.w),
                                        //   titleFontWeight: FontWeight.w600,
                                        //   textEditController:
                                        //       areaStreetController,
                                        //   validationType:
                                        //       ValidationTypeEnum.mapScreenField,
                                        // ),
                                        // SizeConfig.sH8,
                                        // CommonTextField(
                                        //   regularExpression:
                                        //       RegularExpressionUtils
                                        //           .mapScreenField,
                                        //   title: AppStrings.landmark,
                                        //   contentPadding: EdgeInsets.only(
                                        //       bottom: 9.w, top: 6.w),
                                        //   titleFontWeight: FontWeight.w600,
                                        //   textEditController:
                                        //       landmarkController,
                                        //   validationType:
                                        //       ValidationTypeEnum.mapScreenField,
                                        // ),

                                        // SizeConfig.sH8,

                                        CommonTextField(
                                          keyBoardType: TextInputType.text,
                                          title: AppStrings.centerCode,
                                          contentPadding: EdgeInsets.only(
                                              bottom: 9.w, top: 15.w),
                                          titleFontWeight: FontWeight.w600,
                                          textEditController:
                                              centerCodeController,
                                          readOnly: false,
                                          // Ensure this is set to false
                                          isValidate: true,
                                          // Ensure validation is enabled
                                          isCapitalize: false,
                                          // Set capitalization as needed
                                          inputLength: 100,
                                          // Adjust as needed
                                          maxLine: 1,
                                          // Adjust max lines as needed
                                          maxLength: 100,
                                          // Adjust max length as needed
                                          obscureValue: false,
                                          // Set to true if you want to hide input like passwords
                                          isOutlineInputBorder: false,
                                          // Set based on your UI requirement
                                          borderColor: AppColors.black1c
                                              .withOpacity(0.4),
                                          // Adjust border color
                                          hintText: 'Enter center code',
                                          // Adjust hint text as needed
                                          regularExpression: r'^[a-zA-Z0-9]*$',
                                          // Adjust regex pattern as needed
                                          lowerCaseFormatter:
                                              FilteringTextInputFormatter.allow(
                                                  RegExp(r'^[a-zA-Z0-9]*$')),
                                          // Adjust formatter as needed
                                          onChange: (value) {
                                            print("Input changed: $value");
                                          },
                                        ),

                                        SizeConfig.sH15,

                                        CustomBtn(
                                            onTap: () => addOnTap(),
                                            title: AppStrings.add),

                                        SizeConfig.sH15,
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                            // addLocation();
                          },
                          title: AppStrings.submit),
                    ),

                    SizeConfig.sH20,
                  ],
                ),
              ),
      ),
    );
  }

  TherapyCenterLocationDataModel locationModel =
      TherapyCenterLocationDataModel();

  String generateRandomTransID(int length) {
    const String digits = '0123456789';
    Random rnd = Random();

    // Ensure the length is at least 8
    length = length < 8 ? 8 : length;

    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => digits.codeUnitAt(rnd.nextInt(digits.length)),
      ),
    );
  }
}
>>>>>>> Stashed changes
