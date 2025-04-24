import 'package:get/get.dart';

import '../../services/constants.dart';
import '../api/api_client.dart';

class BookingRepo {
  final ApiClient apiClient;
  BookingRepo({required this.apiClient});

  //
  Future<Response> getBookings({String? status, String? url}) async =>
      await apiClient.getData(
          url ?? "${AppConstants.bookingsUri}?status=${status ?? 'ongoing'}");

  Future<Response> getBookingDetail({required int id}) async =>
      await apiClient.getData("${AppConstants.bookingsUri}/$id");

  Future<Response> startBookingTrip(
          {required String tripOtp, required int bookingId}) async =>
      await apiClient.postData(AppConstants.bookingTripStartUri, {
        'booking_id': bookingId,
        'trip_start_otp': tripOtp,
      });

  Future<Response> endBookingTrip({required int id}) async =>
      await apiClient.getData("${AppConstants.bookingTripEndUri}/$id");

  Future<Response> locationMarkAsDone({required int id}) async =>
      await apiClient.getData("${AppConstants.locationMarkAsDone}/$id");

//-------------------home items------------------
  Future<Response> gethomeItemList() async =>
      await apiClient.getData(AppConstants.homeItemUri);
  Future<Response> updateHomeItem(dynamic data) async =>
      await apiClient.putData(AppConstants.updateHomeItem, data);
  Future<Response> addHomeItem(dynamic data) async =>
      await apiClient.postData(AppConstants.addHomeItem, data);
}
