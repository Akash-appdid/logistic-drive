import 'dart:convert';
import 'dart:developer';

import 'package:get/instance_manager.dart';
import 'package:logistic_driver/controllers/auth_controller.dart';
import 'package:logistic_driver/controllers/basic_controller.dart';
import 'package:logistic_driver/data/api/api_client.dart';
import 'package:logistic_driver/data/repositories/auth_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/permission_controller.dart';
import '../data/api/api_calls.dart';
import 'constants.dart';

class Init {
  getBaseUrl() async {
    ApiCalls calls = ApiCalls();
    await calls.apiCallWithResponseGet('https://fishcary.com/fishcary/api/link2.php?for=true').then((value) {
      log(value.toString());
      AppConstants().setBaseUrl = jsonDecode(value)['link'];
      log(AppConstants().getBaseUrl, name: 'BASE');
    });
  }

  initialize() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    Get.lazyPut<SharedPreferences>(() => sharedPreferences);
    try {
      //-------Repo
      Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.baseUrl, sharedPreferences: Get.find()));
      Get.lazyPut(() => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
      //--------Controller
      Get.lazyPut(() => PermissionController());
      Get.lazyPut(() => AuthController(authRepo: Get.find()));
      Get.lazyPut(() => BasicController());
    } catch (e) {
      log('---- ${e.toString()} ----', name: "ERROR AT initialize()");
    }
  }
}
