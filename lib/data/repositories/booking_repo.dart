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

  Future<Response> uploadEpod({required Map<String, dynamic> data}) async =>
      await apiClient.postData(AppConstants.epodUri, FormData(data));

  //----------car and bikes bookins----------------
  Future<Response> getCarAndBikesBookings(
          {String? status, String? url}) async =>
      await apiClient.getData(url ??
          "${AppConstants.carAndBikebookingsUri}?order_status=${status ?? 'ongoing'}");

  Future<Response> getCarAndBikesBookingDetail({required int id}) async =>
      await apiClient
          .getData("${AppConstants.carAndBikebookingsDetailsUri}/$id");

  Future<Response> startBookingTripForCarAndBike(
          {required String tripOtp, required int bookingId}) async =>
      await apiClient.postData(AppConstants.bookingTripStartForCarAndBikeUri, {
        'booking_id': bookingId,
        'otp': tripOtp,
      });
}
