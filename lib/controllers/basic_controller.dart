import 'dart:developer';

import 'package:get/get.dart';
import 'package:logistic_driver/data/models/response/response_model.dart';
import 'package:logistic_driver/data/repositories/basic_repo.dart';

import '../data/api/api_checker.dart';
import '../data/models/response/business_setting_model.dart';

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
}

enum BussinessSettingName {
  privacyPolicy,
  aboutUs,
  contactUs,
  termsAndCondition,
  helpCenter
}
