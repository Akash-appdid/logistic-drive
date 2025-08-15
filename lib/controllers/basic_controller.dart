import 'dart:async';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logistic_driver/controllers/booking_controller.dart';
import 'package:logistic_driver/controllers/location_controller.dart';
import 'package:logistic_driver/data/models/response/analytics_model.dart';
import 'package:logistic_driver/data/models/response/response_model.dart';
import 'package:logistic_driver/data/repositories/basic_repo.dart';

import '../data/api/api_checker.dart';
import '../data/models/response/business_setting_model.dart';
import '../services/constants.dart';

enum BussinessSettingName {
  privacyPolicy,
  aboutUs,
  contactUs,
  termsAndCondition,
  helpCenter
}

class BasicController extends GetxController implements GetxService {
  final BasicRepo basicRepo;
  BasicController({required this.basicRepo});
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  //
  //--dashbord screen complete and ongoing order toggle
  bool isOnGoingOrder = true;
  void setIsComplete(bool order) {
    isOnGoingOrder = order;
    update();
  }

  //----get bussiness setting ----
  int? appVersion;
  String? androidAppLink;
  List<BussinessSetting> bussinessSettings = [];
  Future<ResponseModel> getBussinessSetting() async {
    ResponseModel responseModel;
    _isLoading = true;
    update();
    try {
      Response response = await basicRepo.getBussinessSettingData();
      if (response.statusCode == 200 && response.body['success']) {
        log(response.bodyString.toString(), name: "getBussinessSettingData");
        bussinessSettings = (response.body['data'] as List<dynamic>)
            .map((response) => BussinessSetting.fromJson(response))
            .toList();
        responseModel = ResponseModel(true, 'success');
      } else {
        ApiChecker.checkApi(response);
        responseModel = ResponseModel(false, "${response.statusText}");
      }
    } catch (e) {
      log('---- ${e.toString()} ----', name: "ERROR AT getBussinessSetting()");
      responseModel = ResponseModel(false, "$e");
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  String? getAppLinkAndAppVersion(String key) {
    if (bussinessSettings.isNotEmpty) {
      for (var element in bussinessSettings) {
        if (element.key == key) {
          return element.value;
        }
      }
    }
    return null;
  }

  //
  Future<String> getHtmlContent(BussinessSettingName name) async {
    log('$name');
    for (int i = 0; i < bussinessSettings.length; i++) {
      if (name == BussinessSettingName.privacyPolicy) {
        if (bussinessSettings[i].key == 'privacy_policy') {
          return bussinessSettings[i].value ?? 'NA';
        }
      } else if (name == BussinessSettingName.contactUs) {
        if (bussinessSettings[i].key == 'contact_us') {
          return bussinessSettings[i].value ?? 'NA';
        }
      } else if (name == BussinessSettingName.aboutUs) {
        if (bussinessSettings[i].key == 'about_us') {
          return bussinessSettings[i].value ?? 'NA';
        }
      } else if (name == BussinessSettingName.helpCenter) {
        if (bussinessSettings[i].key == 'help_center') {
          return bussinessSettings[i].value ?? 'NA';
        }
      } else if (name == BussinessSettingName.termsAndCondition) {
        if (bussinessSettings[i].key == 'terms_and_condition') {
          return bussinessSettings[i].value ?? 'NA';
        }
      }
    }
    return 'NA';
  }

  String? getBusinessSettingValue(String key) {
    return bussinessSettings
        .firstWhere(
          (setting) => setting.key == key,
          orElse: () => BussinessSetting(),
        )
        .value;
  }

  //-----------------duty on off-------------------
  bool isDutyOn = false;
  void setIsDutyOn(bool duty) {
    isDutyOn = duty;
    update();
  }

  Future<ResponseModel> toggleDutyOnOff() async {
    ResponseModel responseModel;
    _isLoading = true;
    update();
    try {
      Response response = await basicRepo.toggleDutyOnOff(isDuty: isDutyOn);
      if (response.statusCode == 200 && response.body['success']) {
        log(response.bodyString.toString(), name: "toggleDutyOnOff");
        // bussinessSettings = (response.body['data'] as List<dynamic>)
        //     .map((response) => BussinessSetting.fromJson(response))
        //     .toList();
        responseModel = ResponseModel(true, 'success');
      } else {
        ApiChecker.checkApi(response);
        responseModel = ResponseModel(false, "${response.statusText}");
      }
    } catch (e) {
      log('---- ${e.toString()} ----', name: "ERROR AT toggleDutyOnOff()");
      responseModel = ResponseModel(false, "$e");
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  //------------------get analytics data-----------------------
  Analytics? analytics;
  Future<ResponseModel> getAnalyticsData() async {
    ResponseModel responseModel;
    _isLoading = true;
    update();
    try {
      Response response = await basicRepo.getAnalyticsData();
      if (response.statusCode == 200 && response.body['success']) {
        log(response.bodyString.toString(), name: "getAnalyticsData");
        analytics = Analytics.fromJson(response.body);

        responseModel = ResponseModel(true, 'success');
      } else {
        ApiChecker.checkApi(response);
        responseModel = ResponseModel(false, "${response.statusText}");
      }
    } catch (e) {
      log('---- ${e.toString()} ----', name: "ERROR AT getAnalyticsData()");
      responseModel = ResponseModel(false, "$e");
    }
    _isLoading = false;
    update();
    return responseModel;
  }
  //----------------------update location--------------------
  //

  Future<ResponseModel> updateLocation(Map<String, dynamic> data) async {
    log("location$data");
    ResponseModel responseModel;
    _isLoading = true;
    update();
    log("response.body.toString()${AppConstants.baseUrl}${AppConstants.loginUri}",
        name: "login");
    try {
      Response response = await basicRepo.updateLocation(data: data);
      if (response.statusCode == 200 && response.body['success']) {
        responseModel =
            ResponseModel(true, '${response.body['message']}', response.body);
      } else {
        responseModel = ResponseModel(false, response.statusText!);
      }
    } catch (e) {
      responseModel = ResponseModel(false, "CATCH");
      log('+++++++++++++++++++++++++++++++++++ ${e.toString()} +++++++++++++++++++++++++++++++++++++',
          name: "ERROR AT updateLocation()");
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  //--------------bike and tempo analytic-----------------
  bool isAnalyticLoading = false;
  Analytics? analyticsDataOfBikeTempo;
  Future<ResponseModel> getBikeTempoAnalyticsData() async {
    ResponseModel responseModel;
    isAnalyticLoading = true;
    update();
    try {
      Response response = await basicRepo.getBikeTempoAnalytic();
      if (response.statusCode == 200 && response.body['success']) {
        log(response.bodyString.toString(), name: "getBikeTempoAnalyticsData");
        analyticsDataOfBikeTempo = Analytics.fromJson(response.body);

        responseModel = ResponseModel(true, 'success');
      } else {
        ApiChecker.checkApi(response);
        responseModel = ResponseModel(false, "${response.statusText}");
      }
    } catch (e) {
      log('---- ${e.toString()} ----',
          name: "ERROR AT getBikeTempoAnalyticsData()");
      responseModel = ResponseModel(false, "$e");
    }
    isAnalyticLoading = false;
    update();
    return responseModel;
  }

  LatLng currlocation = LatLng(19.1985659, 72.9532572);
  Timer? _locationTimer;

  void initsendinglocation() {
    _locationTimer?.cancel();
    LocationController locationCtrl = LocationController();
    if (Get.find<BookingController>().isanyongoing) {
      log(currlocation.toString());
      _locationTimer = Timer.periodic(Duration(seconds: 10), (timer) {
        locationCtrl.fetchCurrentLocationPlace().then((val) {
          updateLocation(locationCtrl.updateLocationData());
        });
        log(currlocation.toString(), name: "location10second");
      });
    }
  }
}
