import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logistic_driver/data/models/body/vehicle_model.dart';
import 'package:logistic_driver/data/models/response/vehicle_master_model.dart';
import 'package:logistic_driver/data/repositories/register_repo.dart';
import 'package:logistic_driver/services/extensions.dart';

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

  Future<ResponseModel> registerUser(
      {required Map<String, dynamic> data}) async {
    ResponseModel responseModel;
    _isLoading = true;
    update();
    log("response.body.toString()${AppConstants.baseUrl}${AppConstants.registerUri}",
        name: "login");
    try {
      Response response = await registerRepo.register(data: data);

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
  Future<void> selectYear(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year),
      firstDate: DateTime(now.year),
      lastDate: DateTime(now.year + 50),
      initialDatePickerMode: DatePickerMode.year,
    );

    if (picked != null) {
      log("Selected year: ${picked.year}");
      buildYear.text = picked.year.toString();
    }
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
}
