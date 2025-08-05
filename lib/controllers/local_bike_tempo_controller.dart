import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:logistic_driver/data/models/response/local_bike_tempo_model.dart';
import 'package:logistic_driver/data/repositories/local_bike_tempo_booking_repo.dart';

import '../data/api/api_checker.dart';
import '../data/models/response/response_model.dart';
import '../services/constants.dart';

class LocalBikeTempoController extends GetxController implements GetxService {
  final LocalBikeTempoBookingRepo localBikeTempoBookingRepo;
  LocalBikeTempoController({required this.localBikeTempoBookingRepo});

//
  bool _isLoading = false;
  bool get isLoading => _isLoading;
//------------handle list page Api---------
  bool isLoadData = false;
  void setIsLoadData({required bool isload}) {
    isLoadData = isload;
    update();
  }

//-
  Future<ResponseModel> acceptOrder({required Map<String, dynamic> data}) async {
    ResponseModel responseModel;
    _isLoading = true;
    update();
    try {
      Response response = await localBikeTempoBookingRepo.orderAccept(data: data);
      if (response.statusCode == 200 && response.body['success']) {
        responseModel = ResponseModel(true, response.body['message']);
      } else {
        ApiChecker.checkApi(response);
        responseModel = ResponseModel(false, "${response.statusText}");
      }
    } catch (e) {
      log('---- ${e.toString()} ----', name: "ERROR AT acceptOrder()");
      responseModel = ResponseModel(false, "$e");
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  ///---------pagination------------
  bool isPagination = false;
  Timer? timer;
  bool isFinished = false;

  // ScrollController scrollController = ScrollController();
  int offset = 1;
  double scrollPercentage = 0.0;

  void bookingInitMethodForPagination({required bool isOnGoingOrder, required ScrollController scrollController}) async {
    offset = 1;
    scrollPercentage = 0.0;
    scrollController.addListener(() {
      onScroll(isOnGoingOrder: isOnGoingOrder, scrollController: scrollController);
    });
  }

  void onScroll({required bool isOnGoingOrder, required ScrollController scrollController}) {
    double maxScroll = scrollController.position.maxScrollExtent;
    double currentScroll = scrollController.position.pixels;
    double percentage = (currentScroll / maxScroll) * 100;
    scrollPercentage = percentage;
    update();

    if (scrollPercentage >= 70) {
      loadMoreData(isOnGoingOrder: isOnGoingOrder);
    }
  }

  Future<void> loadMoreData({String? status, required bool isOnGoingOrder}) async {
    if (isPagination) return;
    try {
      offset += 1;
      //
      if (!isFinished) {
        log(offset.toString(), name: "Check Offset");
        log("$scrollPercentage", name: "Scroll Percentage");

        String url = '${AppConstants.allOrders}?status=${isOnGoingOrder ? 'ongoing' : 'delivered'}&page=$offset';

        log(url, name: 'ORDERURI');
        await getAllOrder(url: url);
      }
    } catch (e) {
      log('Error loading more data: $e', error: e);
    }
  }

  ///----get order--------
  List<LocalBikeTempoBookingModel> allOrderData = [];
  Future<ResponseModel> getAllOrder({String? status, String? url, bool isClear = false}) async {
    ResponseModel responseModel;
    if (isClear) {
      allOrderData.clear();
      isFinished = false;
    }
    if (isFinished) {
      return ResponseModel(true, 'finished');
    }
    _isLoading = isClear;
    isPagination = true;

    update();
    try {
      Response response = await localBikeTempoBookingRepo.getAllOrders(status: status, url: url);
      if (response.statusCode == 200 && response.body['success']) {
        log("${response.bodyString}", name: 'getAllBooking');
        var bookings = (response.body['data']['data'] as List<dynamic>).map((res) => LocalBikeTempoBookingModel.fromJson(res)).toList();
        if (bookings.isEmpty) {
          isFinished = true;
        }
        allOrderData.addAll(bookings);
        isLoadData = false;
        _isLoading = false;
        update();
        // updateIndexOfAllBookingOrder();
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

  //---------------detail data--------------
  LocalBikeTempoBookingModel? localBikeTempoBookingData;
  Future<ResponseModel> getLocalBikeTempBookingDetailData({required int id}) async {
    ResponseModel responseModel;
    _isLoading = true;
    update();
    try {
      Response response = await localBikeTempoBookingRepo.getLocalBikeTempoBookingDetail(id: id);
      if (response.statusCode == 200 && response.body['success']) {
        log('${response.bodyString}', name: 'getBookingDetail');
        localBikeTempoBookingData = LocalBikeTempoBookingModel.fromJson(response.body['data']);
        responseModel = ResponseModel(true, 'success');
        updateIndexOfBookingOrder();
        selectLocation();
      } else {
        ApiChecker.checkApi(response);
        responseModel = ResponseModel(false, "${response.statusText}");
      }
    } catch (e) {
      log('---- ${e.toString()} ----', name: "ERROR AT getLocalBikkTempBookingDetailData()");
      responseModel = ResponseModel(false, "$e");
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  ///-------------location--------------
  LocationofLocalBike? selectedLocation;

  void updateIndexOfBookingOrder() {
    if (localBikeTempoBookingData?.locations == null) return;
    int pickupIndex = 1;
    int dropIndex = 1;
    for (var location in localBikeTempoBookingData!.locations!) {
      if (location.type == 'pickup') {
        location.pickupIndex = pickupIndex++;
      } else if (location.type == 'drop') {
        location.dropIndex = dropIndex++;
      }
    }
    update();
  }

  void updateIndexOfAllBookingOrder() {
    for (var location in allOrderData) {
      int pickupIndex = 1;
      int dropIndex = 1;
      for (LocationofLocalBike element in location.locations ?? []) {
        if (element.type == 'pickup') {
          element.pickupIndex = pickupIndex++;
        } else if (element.type == 'drop') {
          element.dropIndex = dropIndex++;
        }
      }
    }
    update();
  }

  void selectLocation() {
    if (localBikeTempoBookingData?.locations == null) return;
    for (var location in localBikeTempoBookingData!.locations!) {
      if (location.type == 'pickup' && location.status == 'pending') {
        selectedLocation = location;
        selectedLocation?.pickupDoneCount = location.pickupIndex;
        update();
        return;
      }
    }
    for (var location in localBikeTempoBookingData!.locations!) {
      if (location.type == 'drop' && location.status == 'pending') {
        selectedLocation = location;
        selectedLocation?.dropDoneCount = location.dropIndex;
        update();
        return;
      }
    }
  }

  bool isDelivered() {
    if (localBikeTempoBookingData?.locations == null) return false;
    for (var element in localBikeTempoBookingData!.locations!) {
      if (element.status == 'pending') {
        return false;
      }
    }
    return true;
  }

  //------

  // String setStatusOfBooking(BookingsModel? booking) {
  //   if (booking == null) return 'NA';
  //   if (booking.delivered == null) {
  //     final locations = booking.locations ?? [];
  //     for (int i = locations.length - 1; i >= 0; i--) {
  //       final loc = locations[i];
  //       final type = loc.type?.toLowerCase();
  //       if (loc.doneAt != null && (type == 'pickup' || type == 'drop')) {
  //         final index = loc.getItemIndex;
  //         return '${type.capitalizeFirstOfEach} $index';
  //       }
  //     }
  //   }
  //   return booking.status ?? 'NA';
  // }
  //----------------------start tripe bike and tempo-------------------

  Future<ResponseModel> startBikeTempoBookingTrip({
    String? tripOtp,
    required int bookingId,
  }) async {
    ResponseModel responseModel;
    _isLoading = true;
    update();
    try {
      Response response = await localBikeTempoBookingRepo.startBikeTempoTrip(tripOtp: tripOtp, bookingId: bookingId);
      if (response.statusCode == 200 && response.body['success']) {
        // _userModel =
        //     UserModel.fromJson(response.body['data'] as Map<String, dynamic>);
        responseModel = ResponseModel(true, 'success');
      } else {
        ApiChecker.checkApi(response);
        responseModel = ResponseModel(false, "${response.statusText}");
      }
    } catch (e) {
      log('---- ${e.toString()} ----', name: "ERROR AT startBikeTempoBookingTrip()");
      responseModel = ResponseModel(false, "$e");
    }
    _isLoading = false;
    update();
    return responseModel;
  }
  //-------markasdone--------

  //-------------get booking detail------------------
  Future<ResponseModel> loactionMarkAsDone({required Map<String, dynamic> data}) async {
    ResponseModel responseModel;
    _isLoading = true;
    update();
    try {
      Response response = await localBikeTempoBookingRepo.locationMarkAsDone(data: data);
      if (response.statusCode == 200 && response.body['success']) {
        // _userModel =
        //     UserModel.fromJson(response.body['data'] as Map<String, dynamic>);
        responseModel = ResponseModel(true, 'success');
      } else {
        ApiChecker.checkApi(response);
        responseModel = ResponseModel(false, "${response.statusText}");
      }
    } catch (e) {
      log('---- ${e.toString()} ----', name: "ERROR AT loactionMarkAsDone()");
      responseModel = ResponseModel(false, "$e");
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  ///-------markasdelivred-----------

  Future<ResponseModel> markAsDelivredBikeTempo({required int id}) async {
    ResponseModel responseModel;
    _isLoading = true;
    update();
    try {
      Response response = await localBikeTempoBookingRepo.markAsDeliveredBikeTempo(id: id);
      if (response.statusCode == 200 && response.body['success']) {
        // _userModel =
        //     UserModel.fromJson(response.body['data'] as Map<String, dynamic>);
        responseModel = ResponseModel(true, 'success');
      } else {
        ApiChecker.checkApi(response);
        responseModel = ResponseModel(false, "${response.statusText}");
      }
    } catch (e) {
      log('---- ${e.toString()} ----', name: "ERROR AT markAsDelivredBikeTempo()");
      responseModel = ResponseModel(false, "$e");
    }
    _isLoading = false;
    update();
    return responseModel;
  }
}
