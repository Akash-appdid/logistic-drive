import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:logistic_driver/data/models/response/booking_model.dart';
import 'package:logistic_driver/data/models/response/home_item_model.dart';
import 'package:logistic_driver/data/repositories/booking_repo.dart';
import 'package:logistic_driver/main.dart';
import 'package:logistic_driver/services/extensions.dart';
import 'package:logistic_driver/views/base/dialogs/logout_dialog.dart';

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
        updateIndexOfAllBookingOrder();
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
        updateIndexOfBookingOrder();
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

  void updateIndexOfBookingOrder() {
    if (bookingsDetailData?.locations == null) return;
    int pickupIndex = 1;
    int dropIndex = 1;
    for (var location in bookingsDetailData!.locations!) {
      if (location.type == 'pickup') {
        location.pickupIndex = pickupIndex++;
      } else if (location.type == 'drop') {
        location.dropIndex = dropIndex++;
      }
    }
    update();
  }

  void updateIndexOfAllBookingOrder() {
    for (var location in bookingsData) {
      int pickupIndex = 1;
      int dropIndex = 1;
      for (Location element in location.locations ?? []) {
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
    if (bookingsDetailData?.locations == null) return;
    for (var location in bookingsDetailData!.locations!) {
      if (location.type == 'pickup' && location.status == 'pending') {
        selectedLocation = location;
        selectedLocation?.pickupDoneCount = location.pickupIndex;
        update();
        return;
      }
    }
    for (var location in bookingsDetailData!.locations!) {
      if (location.type == 'drop' && location.status == 'pending') {
        selectedLocation = location;
        selectedLocation?.dropDoneCount = location.dropIndex;
        update();
        return;
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

  //------

  String setStatusOfBooking(BookingsModel? booking) {
    if (booking == null) return 'NA';
    if (booking.delivered == null) {
      final locations = booking.locations ?? [];
      for (int i = locations.length - 1; i >= 0; i--) {
        final loc = locations[i];
        final type = loc.type?.toLowerCase();
        if (loc.doneAt != null && (type == 'pickup' || type == 'drop')) {
          final index = loc.getItemIndex;
          return '${type.capitalizeFirstOfEach} $index';
        }
      }
    }
    return booking.status ?? 'NA';
  }
//--------------------------------home item list------------------------------

  List<HomeItem> homeItemList = [];
  List<List<HomeItem>> groupHomeItemList = [];

  void _getGroupbookingData() {
    List<int> bookedHomeItemIds = bookingsDetailData?.bookingGoodHomeItems!
            .map((e) => e.homeItemId ?? 0)
            .toList() ??
        [];

    List<HomeItem> updatedHomeItemList = homeItemList
        .where((item) => !bookedHomeItemIds.contains(item.id))
        .toList();

    homeItemList = updatedHomeItemList;

    Map<int, List<HomeItem>> groupBookingData = {};
    for (var item in homeItemList) {
      int categoryId = item.homeItemCategoryId ?? 0;
      groupBookingData.putIfAbsent(categoryId, () => []).add(item);
    }

    groupHomeItemList = groupBookingData.values.toList();

    update();
    log("$groupHomeItemList", name: 'Test');
  }

  Future<ResponseModel> getHomeItemList() async {
    ResponseModel responseModel;
    _isLoading = true;
    update();
    try {
      Response response = await bookingRepo.gethomeItemList();
      if (response.statusCode == 200 && response.body['success']) {
        log("${response.bodyString}", name: 'getHomeItemList');

        homeItemList = (response.body['data'] as List<dynamic>)
            .map((res) => HomeItem.fromJson(res))
            .toList();
        _getGroupbookingData();
        responseModel = ResponseModel(true, 'success');
      } else {
        ApiChecker.checkApi(response);
        responseModel = ResponseModel(false, "${response.statusText}");
      }
    } catch (e) {
      log('---- ${e.toString()} ----', name: "ERROR AT getHomeItemList()");
      responseModel = ResponseModel(false, "$e");
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  void addAndUpdateItemQuantity({
    HomeItem? homeItem,
    bool increment = false,
    bool decrement = false,
    bool initialize = false,
    bool isAdd = false,
  }) {
    if (homeItem == null) return;
    if (initialize) {
      homeItem.itemQuantity = 0;
    } else if (isAdd) {
      homeItem.itemQuantity = 1;
    } else if (increment) {
      homeItem.itemQuantity += 1;
    } else if (decrement && homeItem.itemQuantity > 0) {
      homeItem.itemQuantity -= 1;
    }

    update();
  }

  //
  Future<ResponseModel> addHomeItem({dynamic data}) async {
    ResponseModel responseModel;
    _isLoading = true;
    update();
    try {
      Response response = await bookingRepo.addHomeItem(data);
      if (response.statusCode == 200 && response.body['success']) {
        responseModel = ResponseModel(true, response.body['message']);
      } else {
        ApiChecker.checkApi(response);
        responseModel = ResponseModel(false, "${response.statusText}");
      }
    } catch (e) {
      log('---- ${e.toString()} ----', name: "ERROR AT addHomeItem()");
      responseModel = ResponseModel(false, "$e");
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  //--------update home item -----------------
  void updateItemQuantity({
    required BookingGoodHomeItem? homeItem,
    bool initialize = false,
    bool increment = false,
    bool decrement = false,
  }) {
    if (homeItem == null) return;

    if (initialize) {
      homeItem.itemQuantity = homeItem.quantity;
      update();
      return;
    }

    if (homeItem.itemQuantity == null) return;

    if (decrement) {
      if (homeItem.itemQuantity! > 1) {
        homeItem.itemQuantity = homeItem.itemQuantity! - 1;
      } else {
        showDialog(
          context: navigatorKey.currentContext!,
          builder: (context) {
            return ConfirmationDialog(
                borderColor: Colors.red,
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                  size: 30,
                ),
                onTap: () {},
                title:
                    "Are you sure you want to delete ${homeItem.homeItemData?.title}");
          },
        );
      }
    } else if (increment) {
      homeItem.itemQuantity = homeItem.itemQuantity! + 1;
    }

    update();
  }

  //----------------------update home item---------------------------

  Future<ResponseModel> updateHomeItems({dynamic data}) async {
    ResponseModel responseModel;
    _isLoading = true;
    update();
    try {
      Response response = await bookingRepo.updateHomeItem(data);
      if (response.statusCode == 200 && response.body['success']) {
        responseModel = ResponseModel(true, 'success');
      } else {
        ApiChecker.checkApi(response);
        responseModel = ResponseModel(false, "${response.statusText}");
      }
    } catch (e) {
      log('---- ${e.toString()} ----', name: "ERROR AT updateHomeItems()");
      responseModel = ResponseModel(false, "$e");
    }
    _isLoading = false;
    update();
    return responseModel;
  }
  //---------------------------------add item home calculation-------------------------
}
