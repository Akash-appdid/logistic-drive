import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:logistic_driver/controllers/booking_controller.dart';
import 'package:logistic_driver/data/repositories/packer_and_mover_repo.dart';

import '../data/api/api_checker.dart';
import '../data/models/response/booking_model.dart';
import '../data/models/response/home_item_model.dart';
import '../data/models/response/response_model.dart';
import '../main.dart';
import '../views/base/dialogs/logout_dialog.dart';

class PackerAndMoverController extends GetxController implements GetxService {
  final PakerAndMoverRepo pakerAndMoverRepo;
  PackerAndMoverController({required this.pakerAndMoverRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  //

  List<HomeItem> homeItemList = [];
  List<List<HomeItem>> groupHomeItemList = [];

  void _getGroupbookingData() {
    final controller = Get.find<BookingController>();
    List<int> bookedHomeItemIds = controller
            .bookingsDetailData?.bookingGoodHomeItems!
            .map((e) => e.homeItemId ?? 0)
            .toList() ??
        [];
    List<HomeItem> updatedHomeItemList = homeItemList
        .where((item) => !bookedHomeItemIds.contains(item.id))
        .toList();

    homeItemList = updatedHomeItemList;

    Map<int, List<HomeItem>> groupBookingData = {};
    for (var item in homeItemList) {
      int categoryId = item.homeItemCategoryId ?? 0;
      groupBookingData.putIfAbsent(categoryId, () => []).add(item);
    }
    groupHomeItemList = groupBookingData.values.toList();
    update();
    log("$groupHomeItemList", name: 'Test');
  }

  bool isAddItem() {
    return groupHomeItemList.any(
      (homeList) => homeList.any((item) => item.itemQuantity != 0),
    );
  }

  Future<ResponseModel> getHomeItemList() async {
    ResponseModel responseModel;
    _isLoading = true;
    update();
    try {
      Response response = await pakerAndMoverRepo.gethomeItemList();
      if (response.statusCode == 200 && response.body['success']) {
        log("${response.bodyString}", name: 'getHomeItemList');

        homeItemList = (response.body['data'] as List<dynamic>)
            .map((res) => HomeItem.fromJson(res))
            .toList();
        _getGroupbookingData();
        responseModel = ResponseModel(true, 'success');
      } else {
        ApiChecker.checkApi(response);
        responseModel = ResponseModel(false, "${response.statusText}");
      }
    } catch (e) {
      log('---- ${e.toString()} ----', name: "ERROR AT getHomeItemList()");
      responseModel = ResponseModel(false, "$e");
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  void addAndUpdateItemQuantity({
    HomeItem? homeItem,
    bool increment = false,
    bool decrement = false,
    bool initialize = false,
    bool isAdd = false,
  }) {
    if (homeItem == null) return;
    if (initialize) {
      homeItem.itemQuantity = 0;
    } else if (isAdd) {
      homeItem.itemQuantity = 1;
    } else if (increment) {
      homeItem.itemQuantity += 1;
    } else if (decrement && homeItem.itemQuantity > 0) {
      homeItem.itemQuantity -= 1;
    }

    update();
  }

  //
  Future<ResponseModel> addHomeItem({dynamic data}) async {
    ResponseModel responseModel;
    _isLoading = true;
    update();
    try {
      Response response = await pakerAndMoverRepo.addHomeItem(data);
      if (response.statusCode == 200 && response.body['success']) {
        responseModel = ResponseModel(true, response.body['message']);
      } else {
        ApiChecker.checkApi(response);
        responseModel = ResponseModel(false, "${response.statusText}");
      }
    } catch (e) {
      log('---- ${e.toString()} ----', name: "ERROR AT addHomeItem()");
      responseModel = ResponseModel(false, "$e");
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  //---------------delete home item from edit---------------------
  Future<ResponseModel> deleteHomeItem({required int id}) async {
    ResponseModel responseModel;
    _isLoading = true;
    update();
    try {
      Response response = await pakerAndMoverRepo.deleteHomeItem(id: id);
      if (response.statusCode == 200 && response.body['success']) {
        responseModel = ResponseModel(true, response.body['message']);
      } else {
        ApiChecker.checkApi(response);
        responseModel = ResponseModel(false, "${response.statusText}");
      }
    } catch (e) {
      log('---- ${e.toString()} ----', name: "ERROR AT deleteHomeItem()");
      responseModel = ResponseModel(false, "$e");
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  //--------update home item -----------------
  void updateItemQuantity({
    required BookingGoodHomeItem? homeItem,
    List<BookingGoodHomeItem>? selectedHomeItemList,
    bool initialize = false,
    bool increment = false,
    bool decrement = false,
  }) {
    if (homeItem == null) return;

    if (initialize) {
      homeItem.itemQuantity = homeItem.quantity;
      update();
      return;
    }

    if (homeItem.itemQuantity == null) return;

    if (decrement) {
      if (homeItem.itemQuantity! > 1) {
        homeItem.itemQuantity = homeItem.itemQuantity! - 1;
      } else {
        deleteHomeItemFromList(
            homeItem: homeItem, selectedHomeItemList: selectedHomeItemList);
      }
    } else if (increment) {
      homeItem.itemQuantity = homeItem.itemQuantity! + 1;
    }
    update();
  }

  //---delete home method---------
  void deleteHomeItemFromList({
    required BookingGoodHomeItem? homeItem,
    List<BookingGoodHomeItem>? selectedHomeItemList,
  }) {
    showDialog(
      barrierDismissible: false,
      context: navigatorKey.currentContext!,
      builder: (context) {
        return ConfirmationDialog(
            isLoading: _isLoading,
            borderColor: Colors.red,
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
              size: 30,
            ),
            onTap: () {
              final controller = Get.find<BookingController>();
              if (homeItem?.id == null) return;
              deleteHomeItem(id: homeItem!.id!).then((value) {
                if (value.isSuccess) {
                  selectedHomeItemList
                      ?.removeWhere((element) => element.id == homeItem.id);
                  update();

                  if (controller.bookingsDetailData != null) {
                    controller.getBookingDetail(
                        id: controller.bookingsDetailData!.id!);
                  }
                }
                Fluttertoast.showToast(msg: value.message);
                Navigator.of(context).pop();
              });
            },
            title:
                "Are you sure you want to delete ${homeItem?.homeItemData?.title}");
      },
    );
  }

  //----------------------update home item---------------------------
  Future<ResponseModel> updateHomeItems({dynamic data}) async {
    ResponseModel responseModel;
    _isLoading = true;
    update();
    try {
      Response response = await pakerAndMoverRepo.updateHomeItem(data);
      if (response.statusCode == 200 && response.body['success']) {
        responseModel = ResponseModel(true, 'success');
      } else {
        ApiChecker.checkApi(response);
        responseModel = ResponseModel(false, "${response.statusText}");
      }
    } catch (e) {
      log('---- ${e.toString()} ----', name: "ERROR AT updateHomeItems()");
      responseModel = ResponseModel(false, "$e");
    }
    _isLoading = false;
    update();
    return responseModel;
  }
}
