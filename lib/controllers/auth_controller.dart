import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../data/api/api_checker.dart';
import '../data/models/contact_number.dart';
import '../data/models/response/response_model.dart';
import '../data/models/response/user_model.dart';
import '../data/repositories/auth_repo.dart';
import '../services/constants.dart';
import '../services/extensions.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;
  AuthController({required this.authRepo});

  bool _acceptTerms = true;

  late final number = ContactNumber(number: '', countryCode: '+91');
  TextEditingController numberController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  UserModel? _userModel;
  UserModel? get userModel => _userModel;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool get acceptTerms => _acceptTerms;

//-------------Login
  Future<ResponseModel> login({required Map<String, dynamic> data}) async {
    ResponseModel responseModel;
    _isLoading = true;
    update();
    log("response.body.toString()${AppConstants.baseUrl}${AppConstants.loginUri}",
        name: "login");
    try {
      Response response = await authRepo.login(data: data);

      if (response.statusCode == 200 && response.body['success']) {
        responseModel =
            ResponseModel(true, '${response.body['message']}', response.body);
      } else {
        responseModel = ResponseModel(false, response.statusText!);
      }
    } catch (e) {
      responseModel = ResponseModel(false, "CATCH");
      log('++++++++++++++++++++++++++++++++++++++++++++ ${e.toString()} +++++++++++++++++++++++++++++++++++++++++++++',
          name: "ERROR AT login()");
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  //-------------OTP Verification------------------
  String? type;
  Future<ResponseModel> verifyOTP(Map<String, dynamic> data) async {
    ResponseModel responseModel;
    _isLoading = true;
    update();
    try {
      Response response = await authRepo.otpVerification(data: data);
      if (response.statusCode == 200) {
        if (response.body['success'] == true &&
            response.body['otp_verified'] == true &&
            response.body['token'] != null) {
          setUserToken(response.body['token']);
          type = response.body['user_type'];
          responseModel = ResponseModel(
              true, '${response.body['user_type']}', response.body);
        } else {
          responseModel = ResponseModel(
              false, '${response.body['message']}', response.body);
        }
      } else {
        responseModel = ResponseModel(false, response.body['message']);
      }
    } catch (e) {
      responseModel = ResponseModel(false, "CATCH");
      log('++++++++++++++++++++++++++++++++++++++++++++ ${e.toString()} +++++++++++++++++++++++++++++++++++++++++++++',
          name: "ERROR AT verifyOTP()");
    }
    _isLoading = false;
    update();
    return responseModel;
  }

//
  Future<ResponseModel> getUserProfileData() async {
    ResponseModel responseModel;
    _isLoading = true;
    update();
    try {
      Response response = await authRepo.getUserData();
      if (response.statusCode == 200 && response.body['success']) {
        log(response.bodyString.toString(), name: "UserModel");
        _userModel =
            UserModel.fromJson(response.body['data'] as Map<String, dynamic>);
        responseModel = ResponseModel(true, 'success');
      } else {
        ApiChecker.checkApi(response);
        responseModel = ResponseModel(false, "${response.statusText}");
      }
    } catch (e) {
      log('---- ${e.toString()} ----', name: "ERROR AT getUserProfileData()");
      responseModel = ResponseModel(false, "$e");
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  void toggleTerms() {
    _acceptTerms = !_acceptTerms;
    update();
  }

  bool isLoggedIn() {
    return authRepo.isLoggedIn();
  }

  bool clearSharedData() {
    return authRepo.clearSharedData();
  }

  String getUserToken() {
    return authRepo.getUserToken();
  }

  void setUserToken(String id) {
    authRepo.saveUserToken(id);
  }

  bool checkUserData() {
    try {
      if (_userModel!.name.isValid &&
          _userModel!.phone.isValid &&
          _userModel!.email.isValid) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  //-------------------Signup page------------------------
  //----signup page 01------
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController vehicleNumber = TextEditingController();
  //----signup page 02------
  TextEditingController buildYear = TextEditingController();
  //----signup page 04-------
  File? pancard;
  File? drivingLicense;
  File? aadhaarCard;
  //---signup page 05------
  TextEditingController payeeName = TextEditingController();
  TextEditingController accountNumber = TextEditingController();
  TextEditingController ifscCode = TextEditingController();
  TextEditingController bankName = TextEditingController();
  TextEditingController branchName = TextEditingController();
  File? check;

  //-------- accepet tearm and condition
  bool _acceptTermAndCondition = false;

  bool get acceptTermAndCondition => _acceptTermAndCondition;

  void updateAcceptTermAndCondition(bool value) {
    _acceptTermAndCondition = value;
    update();
  }
}
