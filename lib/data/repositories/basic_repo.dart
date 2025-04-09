import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/constants.dart';
import '../api/api_client.dart';

class BasicRepo {
  final SharedPreferences sharedPreferences;
  final ApiClient apiClient;
  BasicRepo({required this.sharedPreferences, required this.apiClient});

  //----get bussiness setting----
  Future<Response> getBussinessSettingData() async =>
      await apiClient.getData(AppConstants.businessSettingUri);
}
