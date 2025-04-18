import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:logistic_driver/data/models/response/booking_model.dart';
import 'package:logistic_driver/data/repositories/booking_repo.dart';

import '../data/api/api_checker.dart';
import '../data/models/response/response_model.dart';
import '../services/constants.dart';

class BookingController extends GetxController implements GetxService {
  final BookingRepo bookingRepo;
  BookingController({required this.bookingRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  //------
  bool isOnGoingOrder = true;
  void setIsComplete(bool order) {
    isOnGoingOrder = order;
    update();
  }

  //---------pagination------------
  bool isPagination = false;
  Timer? timer;
  bool isFinished = false;

  ScrollController scrollController = ScrollController();
  int offset = 1;
  double scrollPercentage = 0.0;

  void bookingInitMethodForPagination() async {
    offset = 1;
    scrollPercentage = 0.0;
    scrollController.addListener(onScroll);
  }

  void onScroll() {
    double maxScroll = scrollController.position.maxScrollExtent;
    double currentScroll = scrollController.position.pixels;
    double percentage = (currentScroll / maxScroll) * 100;
    scrollPercentage = percentage;
    update();

    if (scrollPercentage >= 70) {
      loadMoreData();
    }
  }

  Future<void> loadMoreData({String? status}) async {
    if (isPagination) return;
    try {
      offset += 1;
      //
      if (!isFinished) {
        log(offset.toString(), name: "Check Offset");
        log("$scrollPercentage", name: "Scroll Percentage");

        String url =
            '${AppConstants.bookingsUri}?status=${isOnGoingOrder ? 'ongoing' : 'delivered'}&page=$offset';

        log(url, name: 'ORDERURI');
        await getAllBooking(url: url);
      }
    } catch (e) {
      log('Error loading more data: $e', error: e);
    }
  }

  //----get all booking----------
  List<BookingsModel> bookingsData = [];
  Future<ResponseModel> getAllBooking(
      {String? status, String? url, bool isClear = false}) async {
    ResponseModel responseModel;
    if (isClear) {
      bookingsData.clear();
      isFinished = false;
    }
    if (isFinished) {
      return ResponseModel(true, 'finished');
    }
    _isLoading = isClear;
    isPagination = true;

    update();
    try {
      Response response =
          await bookingRepo.getBookings(status: status, url: url);
      if (response.statusCode == 200 && response.body['success']) {
        log("${response.bodyString}", name: 'getAllBooking');
        var bookings = (response.body['data']['data'] as List<dynamic>)
            .map((res) => BookingsModel.fromJson(res))
            .toList();

        if (bookings.isEmpty) {
          isFinished = true;
        }
        bookingsData.addAll(bookings);
        _isLoading = false;
        update();
        responseModel = ResponseModel(true, 'success');
      } else {
        ApiChecker.checkApi(response);
        responseModel = ResponseModel(false, "${response.statusText}");
      }
    } catch (e) {
      log('---- ${e.toString()} ----', name: "ERROR AT getAllBooking()");
      responseModel = ResponseModel(false, "$e");
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  //-------------get booking detail------------------
  BookingsModel? bookingsDetailData;
  Future<ResponseModel> getBookingDetail({required int id}) async {
    ResponseModel responseModel;
    _isLoading = true;
    update();
    try {
      Response response = await bookingRepo.getBookingDetail(id: id);
      if (response.statusCode == 200 && response.body['success']) {
        log('${response.bodyString}', name: 'getBookingDetail');
        bookingsDetailData = BookingsModel.fromJson(response.body['data']);
        responseModel = ResponseModel(true, 'success');
        selectLocation();
      } else {
        ApiChecker.checkApi(response);
        responseModel = ResponseModel(false, "${response.statusText}");
      }
    } catch (e) {
      log('---- ${e.toString()} ----', name: "ERROR AT getBookingDetail()");
      responseModel = ResponseModel(false, "$e");
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  //-------------start booking trip------------------
  Future<ResponseModel> startBookingTrip({
    required String tripOtp,
    required int bookingId,
  }) async {
    ResponseModel responseModel;
    _isLoading = true;
    update();
    try {
      Response response = await bookingRepo.startBookingTrip(
          tripOtp: tripOtp, bookingId: bookingId);
      if (response.statusCode == 200 && response.body['success']) {
        // _userModel =
        //     UserModel.fromJson(response.body['data'] as Map<String, dynamic>);
        responseModel = ResponseModel(true, 'success');
      } else {
        ApiChecker.checkApi(response);
        responseModel = ResponseModel(false, "${response.statusText}");
      }
    } catch (e) {
      log('---- ${e.toString()} ----', name: "ERROR AT startBookingTrip()");
      responseModel = ResponseModel(false, "$e");
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  //-------------get booking detail------------------
  Future<ResponseModel> endBookingTrip({required int id}) async {
    ResponseModel responseModel;
    _isLoading = true;
    update();
    try {
      Response response = await bookingRepo.endBookingTrip(id: id);
      if (response.statusCode == 200 && response.body['success']) {
        // _userModel =
        //     UserModel.fromJson(response.body['data'] as Map<String, dynamic>);
        responseModel = ResponseModel(true, 'success');
      } else {
        ApiChecker.checkApi(response);
        responseModel = ResponseModel(false, "${response.statusText}");
      }
    } catch (e) {
      log('---- ${e.toString()} ----', name: "ERROR AT endBookingTrip()");
      responseModel = ResponseModel(false, "$e");
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  //-------------get booking detail------------------
  Future<ResponseModel> loactionMarkAsDone({required int id}) async {
    ResponseModel responseModel;
    _isLoading = true;
    update();
    try {
      Response response = await bookingRepo.locationMarkAsDone(id: id);
      if (response.statusCode == 200 && response.body['success']) {
        // _userModel =
        //     UserModel.fromJson(response.body['data'] as Map<String, dynamic>);
        responseModel = ResponseModel(true, 'success');
      } else {
        ApiChecker.checkApi(response);
        responseModel = ResponseModel(false, "${response.statusText}");
      }
    } catch (e) {
      log('---- ${e.toString()} ----', name: "ERROR AT endBookingTrip()");
      responseModel = ResponseModel(false, "$e");
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  //-------------booking timeline----------------\\
  void reorderList({required int oldIndex, required int newIndex}) {
    if (bookingsDetailData == null) return;

    if (bookingsDetailData?.locations == null) return;
    if (bookingsDetailData?.locations?[oldIndex].getLocationType ?? false) {
      Fluttertoast.showToast(
          msg:
              'Position update is not allowed after the product has been dropped.');
    } else {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final tile = bookingsDetailData?.locations?.removeAt(oldIndex);
      if (tile == null) return;
      bookingsDetailData?.locations?.insert(newIndex, tile);
    }
  }

  //-----------------location

  Location? selectedLocation;
  int dropCount = 0;
  int pickupCount = 0;

  void cleanCount() {
    dropCount = 0;
    pickupCount = 0;
    update();
  }

  void selectLocation() {
    if (bookingsDetailData?.locations == null) return;
    for (var location in bookingsDetailData!.locations!) {
      if (location.type == 'pickup' && location.status == 'pending') {
        pickupCount++;
        selectedLocation = location;
        update();
        return;
      } else {
        if (location.type == 'drop' && location.status == 'pending') {
          dropCount++;
          selectedLocation = location;
          update();
          return;
        }
      }
    }
  }

  bool isDelivered() {
    if (bookingsDetailData?.locations == null) return false;
    for (var element in bookingsDetailData!.locations!) {
      if (element.status == 'pending') {
        return false;
      }
    }
    return true;
  }
}
