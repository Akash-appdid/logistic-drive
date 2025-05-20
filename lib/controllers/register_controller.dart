import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logistic_driver/controllers/auth_controller.dart';
import 'package:logistic_driver/data/models/body/vehicle_model.dart';
import 'package:logistic_driver/data/models/response/mini_truck_model.dart';
import 'package:logistic_driver/data/models/response/vehicle_master_model.dart';
import 'package:logistic_driver/data/repositories/register_repo.dart';
import 'package:logistic_driver/services/extensions.dart';

import '../data/api/api_checker.dart';
import '../data/models/response/response_model.dart';

import '../generated/assets.dart';
import '../services/constants.dart';

class RegisterController extends GetxController implements GetxService {
  final RegisterRepo registerRepo;
  RegisterController({required this.registerRepo});
  //
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  //-------------------Signup page------------------------
  //----signup page 01------
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();
  //----signup page 02------
  TextEditingController vehicleNumber = TextEditingController();
  File? selectedRegistrationFile;
  TextEditingController buildYear = TextEditingController();

  int currentYear = DateTime.now().year;
  int startingYear = DateTime.now().year - 100;
  List<int> buildYearList = [];
  void genrateBuildYear() {
    buildYearList = List.generate(
            (currentYear - startingYear) + 1, (index) => startingYear + index)
        .reversed
        .toList();
    update();
  }

  //----signup page 04-------
  File? selectedPancard;
  File? selectedDrivingLicense;
  File? selectedAadhaarCard;
  File? selectedAadhaarBackCard;
  //---signup page 05------
  TextEditingController payeeName = TextEditingController();
  TextEditingController accountNumber = TextEditingController();
  TextEditingController ifscCode = TextEditingController();
  TextEditingController bankName = TextEditingController();
  TextEditingController branchName = TextEditingController();
  File? selecedCancelCheck;
  //
  TextEditingController drivingLiceseNumber = TextEditingController();
  TextEditingController aadharCardNumber = TextEditingController();
  TextEditingController panCardNumber = TextEditingController();

  //------------register data-----------
  Map<String, dynamic> registerData() {
    Map<String, dynamic> data = {};
    data = {
      'name': name.text,
      'email': email.text,
      'vehicle_type': selectedVehicle?.key,
      'vehicle_id': vehicleMasterModel?.id,
      'vehicle_number': vehicleNumber.text,
      'build_year': buildYear.text,
      'registration_certificate': getMultipartFile(selectedRegistrationFile),
      'driving_licence': getMultipartFile(selectedDrivingLicense),
      'aadhar_card_front': getMultipartFile(selectedAadhaarCard),
      'cancel_check': getMultipartFile(selecedCancelCheck),
      'aadhar_card_back': getMultipartFile(selectedAadhaarBackCard),
      'pan_card': getMultipartFile(selectedPancard),
      'payee_name': payeeName.text,
      'account_number': accountNumber.text,
      'ifsc_code': ifscCode.text,
      'bank_name': bankName.text,
      'bank_branch': branchName.text,
      'driving_license_number': drivingLiceseNumber.text,
      'aadhar_card_number': aadharCardNumber.text,
      'pan_card_number': panCardNumber.text,
      "two_wheeler_truck_id": selectedMiniTruck?.id,
    };
    return data;
  }

  Future<ResponseModel> registerUser() async {
    ResponseModel responseModel;
    _isLoading = true;
    update();
    log("response.body.toString()${AppConstants.baseUrl}${AppConstants.registerUri}",
        name: "login");
    try {
      Response response = await registerRepo.register(data: registerData());

      if (response.statusCode == 200 && response.body['success']) {
        responseModel =
            ResponseModel(true, '${response.body['message']}', response.body);
      } else {
        responseModel = ResponseModel(false, response.statusText!);
      }
    } catch (e) {
      responseModel = ResponseModel(false, "CATCH");
      log('++++++++++++++++++++++++++++++++++++++++++++ ${e.toString()} +++++++++++++++++++++++++++++++++++++++++++++',
          name: "ERROR AT registerUser()");
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  VehicleOption? selectedVehicle;
  void selectVehicle(VehicleOption? vehicle) {
    selectedVehicle = vehicle;
    update();
  }

  VehicleMasterModel? vehicleMasterModel;
  void selectedVehicleMaster(VehicleMasterModel? vehicle) {
    vehicleMasterModel = vehicle;
    update();
  }

  List<VehicleOption> vehicleOptions = [
    VehicleOption(
      key: "motorbike",
      vehicleType: "Motorbike (2-wheeler)",
      storageType: "Small Parcel",
      description: "You wish to deliver using a motorcycle or scooter.",
      image: Assets.images2Wheeler,
    ),
    VehicleOption(
      key: "mini_tempo",
      vehicleType: "Mini-Truck (Package Delivery)",
      storageType: "Large Package",
      description: "You have a mini-truck and want to deliver large packages.",
      image: Assets.imagesMiniTruck,
    ),
    VehicleOption(
      key: "open_truck",
      vehicleType: "Open Truck",
      storageType: "Bulky goods",
      description: "Perfect for transporting large and bulky goods.",
      image: Assets.imagesOpenTruck,
    ),
    VehicleOption(
      key: "body_pack_truck",
      vehicleType: "Body Pack Truck",
      storageType: "Secure Storage",
      description: "Ideal for high-volume deliveries with secure storage.",
      image: Assets.imagesBodyPackTruck,
    ),
  ];
  //get vehicle master
  List<VehicleMasterModel> vehicleMasterData = [];
  Future<ResponseModel> getVehicleMasterData(
      {required String vehicleType}) async {
    ResponseModel responseModel;
    _isLoading = true;
    update();
    try {
      Response response =
          await registerRepo.getVehicleMasteData(vehicleType: vehicleType);
      if (response.statusCode == 200 && response.body['success']) {
        log("${response.bodyString}", name: 'getVehicleMasterData');

        vehicleMasterData = (response.body['data'] as List<dynamic>)
            .map((response) => VehicleMasterModel.fromJson(response))
            .toList();

        responseModel =
            ResponseModel(true, '${response.body['message']}', response.body);
      } else {
        responseModel = ResponseModel(false, response.statusText!);
      }
    } catch (e) {
      responseModel = ResponseModel(false, "CATCH");
      log('++++++++++++++++++++++++++++++++++++++++++++ ${e.toString()} +++++++++++++++++++++++++++++++++++++++++++++',
          name: "ERROR AT getVehicleMasterData()");
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  //------selecte file--------
  void selectFiles({
    bool isCertificationOfRegistration = false,
    bool isDrivingLicense = false,
    bool isAadharCard = false,
    bool isAadharBackCard = false,
    bool isPancard = false,
    bool isCancelCheck = false,
    File? val,
  }) {
    if (isCertificationOfRegistration) {
      selectedRegistrationFile = val;
    } else if (isDrivingLicense) {
      selectedDrivingLicense = val;
    } else if (isAadharCard) {
      selectedAadhaarCard = val;
    } else if (isPancard) {
      selectedPancard = val;
    } else if (isCancelCheck) {
      selecedCancelCheck = val;
    } else if (isAadharBackCard) {
      selectedAadhaarBackCard = val;
    }
    update();
  }

  //
  void removeFiles({
    bool isCertificationOfRegistration = false,
    bool isDrivingLicense = false,
    bool isAadharCard = false,
    bool isAadharBackCard = false,
    bool isPancard = false,
    bool isCancelCheck = false,
  }) {
    if (isCertificationOfRegistration) {
      selectedRegistrationFile = null;
    } else if (isDrivingLicense) {
      selectedDrivingLicense = null;
    } else if (isAadharCard) {
      selectedAadhaarCard = null;
    } else if (isPancard) {
      selectedPancard = null;
    } else if (isCancelCheck) {
      selecedCancelCheck = null;
    } else if (isAadharBackCard) {
      selectedAadhaarBackCard = null;
    }

    update();
  }

  //
  void selectBuildYear(DateTime time) {
    buildYear.text = time.year.toString();
    update();
  }

  void cleanAllField() {
    name.clear();
    email.clear();
    address.clear();
    //----signup page 02------
    vehicleNumber.clear();
    selectedRegistrationFile = null;
    buildYear.clear();
    //----signup page 04-------
    selectedPancard = null;
    selectedDrivingLicense = null;
    selectedAadhaarCard = null;
    selectedAadhaarBackCard = null;
    //---signup page 05------
    payeeName.clear();
    accountNumber.clear();
    ifscCode.clear();
    bankName.clear();
    branchName.clear();
    selecedCancelCheck = null;
    selectedVehicle = null;
    vehicleMasterModel = null;

    update();
  }

  //-------pick date----------\\
  void selectYear(int? year) {
    if (year == null) return;
    log("Selected year: ${year}");
    buildYear.text = year.toString();

    update();
  }
  //-----------clean signup page three --------\\

  void cleanSignupPageThree() {
    vehicleMasterModel = null;
    vehicleNumber.clear();
    buildYear.clear();
    update();
  }

  //---------validate image-------\\
  bool isPanValid = false;
  bool isAadharCardFrontValid = false;
  bool isAadharCardBackValid = false;
  bool isRegistrationCertificateValid = false;
  bool isDrivingLicenseValid = false;

  void validateDocuments({isPan = false}) {
    if (isPan) {}
    update();
  }
  //get multipart file function------

  MultipartFile? getMultipartFile(File? file) {
    if (file == null) return null;
    return MultipartFile(file, filename: file.path.fileName);
  }

  //---------------get mini truck data ------------------
  MiniTruckModel? selectedMiniTruck;

  void selectMiniTruck(MiniTruckModel minitruck) {
    selectedMiniTruck = minitruck;
    update();
  }

  List<MiniTruckModel> miniTruckData = [];
  Future<ResponseModel> fetchMiniTruckData() async {
    ResponseModel responseModel;
    _isLoading = true;
    update();
    try {
      Response response = await registerRepo.getMiniTruckData();
      log(response.bodyString.toString(), name: "minitruckData");
      if (response.statusCode == 200 && response.body['success']) {
        miniTruckData = (response.body['data'] as List<dynamic>)
            .map((res) => MiniTruckModel.fromJson(res))
            .toList();
        responseModel = ResponseModel(true, 'success');
      } else {
        ApiChecker.checkApi(response);
        responseModel = ResponseModel(false, "${response.statusText}");
      }
    } catch (e) {
      log('---- ${e.toString()} ----', name: "ERROR AT fetchMiniTruckData()");
      responseModel = ResponseModel(false, "$e");
    }
    _isLoading = false;
    update();
    return responseModel;
  }
  //----------------

  Map<String, dynamic> updateProfileData() {
    final userData = Get.find<AuthController>().userModel;
    Map<String, dynamic> data = {};
    data = {
      'name': name.text,
      'email': email.text,
      'vehicle_type': selectedVehicle?.key,
      'vehicle_id': vehicleMasterModel?.id,
      'vehicle_number': vehicleNumber.text,
      'build_year': buildYear.text,
      if (userData?.registrationCertificate == null)
        'registration_certificate': getMultipartFile(selectedRegistrationFile),
      if (userData?.drivingLicence == null)
        'driving_licence': getMultipartFile(selectedDrivingLicense),
      if (userData?.aadharCardFront == null)
        'aadhar_card_front': getMultipartFile(selectedAadhaarCard),
      if (userData?.cancelCheck == null)
        'cancel_check': getMultipartFile(selecedCancelCheck),
      if (userData?.aadharCardBack == null)
        'aadhar_card_back': getMultipartFile(selectedAadhaarBackCard),
      if (userData?.panCard == null)
        'pan_card': getMultipartFile(selectedPancard),
      'payee_name': payeeName.text,
      'account_number': accountNumber.text,
      'ifsc_code': ifscCode.text,
      'bank_name': bankName.text,
      'bank_branch': branchName.text,
      'driving_license_number': drivingLiceseNumber.text,
      'aadhar_card_number': aadharCardNumber.text,
      'pan_card_number': panCardNumber.text,
      "two_wheeler_truck_id": selectedMiniTruck?.id,
    };
    return data;
  }

  Future<ResponseModel> updateProfile() async {
    ResponseModel responseModel;
    _isLoading = true;
    update();

    try {
      Response response =
          await registerRepo.updateProfile(data: updateProfileData());

      if (response.statusCode == 200 && response.body['success']) {
        responseModel =
            ResponseModel(true, '${response.body['message']}', response.body);
      } else {
        responseModel = ResponseModel(false, response.statusText!);
      }
    } catch (e) {
      responseModel = ResponseModel(false, "CATCH");
      log('++++++++++++++++++++++++++++++++++++++++++++ ${e.toString()} +++++++++++++++++++++++++++++++++++++++++++++',
          name: "ERROR AT updateProfile()");
    }
    _isLoading = false;
    update();
    return responseModel;
  }
}
