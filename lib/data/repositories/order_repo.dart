import 'package:get/get.dart';

import '../../services/constants.dart';
import '../api/api_client.dart';

class OrderRepo {
  final ApiClient apiClient;
  OrderRepo({required this.apiClient});

  ///
  Future<Response> orderAccept({required Map<String, dynamic> data}) async =>
      await apiClient.postData(AppConstants.acceptOrder, data);

  ///
  Future<Response> getAllOrders() async =>
      await apiClient.getData(AppConstants.allOrders);

  ///
  Future<Response> getOrderDetail({required int id}) async =>
      await apiClient.getData("${AppConstants.orderDetail}/$id");
}
