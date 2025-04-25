import 'package:get/get.dart';

import '../../services/constants.dart';
import '../api/api_client.dart';

class PakerAndMoverRepo {
  final ApiClient apiClient;
  PakerAndMoverRepo({required this.apiClient});
  //-------------------home items------------------
  Future<Response> gethomeItemList() async =>
      await apiClient.getData(AppConstants.homeItemUri);
  Future<Response> updateHomeItem(dynamic data) async =>
      await apiClient.putData(AppConstants.updateHomeItem, data);
  Future<Response> addHomeItem(dynamic data) async =>
      await apiClient.postData(AppConstants.addHomeItem, data);
  Future<Response> deleteHomeItem({required int id}) async =>
      await apiClient.deleteData("${AppConstants.deleteHomeItem}/$id");
}
