import 'package:get/get.dart';

import '../../services/constants.dart';
import '../api/api_client.dart';

class BasicRepo {
  final ApiClient apiClient;
  BasicRepo({required this.apiClient});

  //----get bussiness setting----
  Future<Response> getBussinessSettingData() async =>
      await apiClient.getData(AppConstants.businessSettingUri);

  //---------duty on off------------
  Future<Response> toggleDutyOnOff({required bool isDuty}) async =>
      await apiClient.postData(
          AppConstants.dutyOnOffUri, {'on_duty': isDuty ? 'yes' : 'no'});
  //--------get analytics-------------
  Future<Response> getAnalyticsData() async =>
      await apiClient.getData(AppConstants.analyticsUri);

//-----------update location------------------
  Future<Response> updateLocation({required Map<String, dynamic> data}) async =>
      await apiClient.postData(AppConstants.updateLocationUri, data);

  ///-------bike and tempo analytic-----------
  Future<Response> getBikeTempoAnalytic() async =>
      await apiClient.getData(AppConstants.bikeTempoAnalytic);
}
