import 'package:get/get.dart';

import '../../services/constants.dart';
import '../api/api_client.dart';

class LocalBikeTempoBookingRepo {
  final ApiClient apiClient;
  LocalBikeTempoBookingRepo({required this.apiClient});

  ///
  Future<Response> orderAccept({required Map<String, dynamic> data}) async => await apiClient.postData(AppConstants.acceptOrder, data);

  ///

  Future<Response> getAllOrders({String? status, String? url}) async => await apiClient.getData(url ?? "${AppConstants.allOrders}?status=${status ?? 'ongoing'}");

  ///
  Future<Response> getLocalBikeTempoBookingDetail({required int id}) async => await apiClient.getData("${AppConstants.orderDetail}/$id");

  ///

  Future<Response> startBikeTempoTrip({required String? tripOtp, required int bookingId}) async => await apiClient.postData(AppConstants.startBikeTempoUri, {
        'booking_id': bookingId,
        // 'otp': tripOtp,
      });

  ///
  Future<Response> locationMarkAsDone({required Map<String, dynamic> data}) async => await apiClient.postData(AppConstants.bikeTempoMarkLocationDone, data);

  ///
  Future<Response> markAsDeliveredBikeTempo({required int id}) async => await apiClient.getData("${AppConstants.markAsDeliveredBikeTempo}/$id");
}
