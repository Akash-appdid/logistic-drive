import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import '../main.dart';

class LocationController extends GetxController implements GetxService {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? location;
  LatLng? latLng;

  ///
  Future<void> fetchCurrentLocationPlace({bool noAddress = false}) async {
    log('-------------- fetchCurrentLocationPlace CALLED ---------------------');
    _isLoading = true;
    update();

    // Check Location Permission
    await Geolocator.checkPermission().then((value) async {
      if (value != LocationPermission.always && value != LocationPermission.whileInUse) {
        await Geolocator.requestPermission();
      } else if (value == LocationPermission.denied || value == LocationPermission.deniedForever) {
        await Geolocator.openAppSettings();
      } else {
        return;
      }
    });

    // To Turn On Device Location
    await Geolocator.isLocationServiceEnabled().then((value) async {
      if (!value) {
        await Geolocator.openLocationSettings();
      }
    });

    Position position = await Geolocator.getCurrentPosition();
    latLng = LatLng(position.latitude, position.longitude);
    log((position.latitude).toString(), name: 'Latitude');
    log((position.longitude).toString(), name: 'Longitude');

    // -- Update Location --
    // -- Fetch Address --
    if (!noAddress) {
      await getAddressFromLocation(latLng ?? const LatLng(19.198545796504945, 72.95579630029403));
    }
    _isLoading = false;
    update();
  }

  List<Placemark> placeMarkData = [];
  Future<void> getAddressFromLocation(LatLng latLong) async {
    _isLoading = true;
    update();

    try {
      await placemarkFromCoordinates(latLong.latitude, latLong.longitude).then((placeMark) {
        if (placeMark.isNotEmpty) {
          placeMarkData = placeMark;
          log('${placeMark.first.toJson()}', name: "Location");

          List<String?> addressParts = [
            placeMark.first.street,
            placeMark.first.subLocality,
            placeMark.first.administrativeArea,
            placeMark.first.country,
          ].where((part) => part != null && part.isNotEmpty).toList();
          location = addressParts.join(', ');
        }
      });
    } catch (e) {
      log(e.toString(), name: "Error at getAddressFromLocation");
    }
    _isLoading = false;
    update();
  }

  void chooseCurrentLatlog(LatLng? pickedLatLag) {
    latLng = pickedLatLag;
    update();
  }

  void cleanLatLng() {
    latLng = null;
    location = null;
    update();
  }

  //search location
  //for search address
  Timer? timer;
  bool isSearch = false;
  final FocusNode searchFocusNode = FocusNode();
  void dismissKeyboard() {
    if (MediaQuery.of(navigatorKey.currentContext!).viewInsets.bottom > 0) {
      FocusScope.of(navigatorKey.currentContext!).unfocus();
    }
  }

  final TextEditingController searchController = TextEditingController();
  List<dynamic> listOfLocations = [];
  Future<void> searchLocation(String query) async {
    final url = Uri.parse("https://nominatim.openstreetmap.org/search?q=$query&countrycodes=in&format=json&addressdetails=1");
    if (timer?.isActive ?? false) timer?.cancel();
    timer = Timer(const Duration(milliseconds: 500), () async {
      isSearch = true;
      update();
      try {
        final response = await http.get(url);
        if (response.statusCode == 200) {
          listOfLocations = json.decode(response.body);
        }
      } catch (e) {
        log('$e');
      }
      isSearch = false;
      update();
    });
    log("-----------it's work-------");
    log('$listOfLocations');
  }

  void clearSearch() {
    searchController.clear();
    listOfLocations = [];
    update();
  }

  Map<String, dynamic> updateLocationData() {
    return {
      "latitude": latLng?.latitude,
      "longitude": latLng?.longitude,
    };
  }
}
