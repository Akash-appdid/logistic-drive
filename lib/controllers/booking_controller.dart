import 'dart:developer';

import 'package:get/get.dart';
import 'package:logistic_driver/data/models/response/booking_model.dart';
import 'package:logistic_driver/data/repositories/booking_repo.dart';

import '../data/api/api_checker.dart';
import '../data/models/response/response_model.dart';

class BookingController extends GetxController implements GetxService {
  final BookingRepo bookingRepo;
  BookingController({required this.bookingRepo});

  //
  bool isOnGoingOrder = true;
  void setIsComplete(bool order) {
    isOnGoingOrder = order;
    update();
  }

  //
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  //----get all booking----------
  List<BookingsModel> bookingsData = [];
  Future<ResponseModel> getAllBooking({String? status}) async {
    ResponseModel responseModel;
    _isLoading = true;
    update();
    try {
      Response response = await bookingRepo.getBookings(status: status);
      if (response.statusCode == 200 && response.body['success']) {
        log("${response.bodyString}", name: 'getAllBooking');
        bookingsData = (response.body['data']['data'] as List<dynamic>)
            .map((res) => BookingsModel.fromJson(res))
            .toList();

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
  Future<ResponseModel> getBookingDetail({required int id}) async {
    ResponseModel responseModel;
    _isLoading = true;
    update();
    try {
      Response response = await bookingRepo.getBookingDetail(id: id);
      if (response.statusCode == 200 && response.body['success']) {
        // _userModel =
        //     UserModel.fromJson(response.body['data'] as Map<String, dynamic>);
        responseModel = ResponseModel(true, 'success');
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
  Future<ResponseModel> startBookingTrip({required String tripOtp}) async {
    ResponseModel responseModel;
    _isLoading = true;
    update();
    try {
      Response response = await bookingRepo.startBookingTrip(tripOtp: tripOtp);
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
}
