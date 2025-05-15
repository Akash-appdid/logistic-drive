import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:logistic_driver/data/repositories/order_repo.dart';

import '../../data/api/api_checker.dart';
import '../../data/models/response/booking_model.dart';
import '../../data/models/response/response_model.dart';

class OrderController extends GetxController implements GetxService {
  final OrderRepo orderRepo;
  OrderController({required this.orderRepo});

//
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<ResponseModel> acceptOrder(
      {required Map<String, dynamic> data}) async {
    ResponseModel responseModel;
    _isLoading = true;
    update();
    try {
      Response response = await orderRepo.orderAccept(data: data);
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

        // String url =
        //     '${AppConstants.allOrders}?status=${isOnGoingOrder ? 'ongoing' : 'delivered'}&page=$offset';

        // log(url, name: 'ORDERURI');
        // await getAllBooking(url: url);
      }
    } catch (e) {
      log('Error loading more data: $e', error: e);
    }
  }

  ///----get order--------
  List<BookingsModel> bookingsData = [];
  Future<ResponseModel> getAllOrder(
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
      Response response = await orderRepo.getAllOrders();
      if (response.statusCode == 200 && response.body['success']) {
        // log("${response.bodyString}", name: 'getAllBooking');
        // var bookings = (response.body['data']['data'] as List<dynamic>)
        //     .map((res) => BookingsModel.fromJson(res))
        //     .toList();
        // if (bookings.isEmpty) {
        //   isFinished = true;
        // }
        // bookingsData.addAll(bookings);
        // _isLoading = false;
        // update();
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
}
