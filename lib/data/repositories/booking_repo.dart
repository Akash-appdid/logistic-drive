import 'package:get/get.dart';

import '../../services/constants.dart';
import '../api/api_client.dart';

class BookingRepo {
  final ApiClient apiClient;
  BookingRepo({required this.apiClient});

  //
  Future<Response> getBookings({String? status}) async => await apiClient
      .getData("${AppConstants.bookingsUri}?status=${status ?? 'ongoing'}");

  Future<Response> getBookingDetail({required int id}) async =>
      await apiClient.getData("${AppConstants.bookingsUri}/$id");

  Future<Response> startBookingTrip({required String tripOtp}) async =>
      await apiClient.postData(AppConstants.bookingTripStartUri, {
        'trip_start_otp': tripOtp,
      });

  Future<Response> endBookingTrip({required int id}) async =>
      await apiClient.getData("${AppConstants.bookingTripEndUri}/$id");
}
