import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:logistic_driver/main.dart';

double appSizeHeight = MediaQuery.sizeOf(navigatorKey.currentContext!).height;
double sizeSizeWidth = MediaQuery.sizeOf(navigatorKey.currentContext!).width;

class PriceConverter {
  static convert(price) {
    return '₹ ${double.parse('$price').toStringAsFixed(2)}';
  }

  static convertRound(price) {
    return '₹ ${double.parse('$price').toInt()}';
  }

  static convertToNumberFormat(num price) {
    final format = NumberFormat("#,##,##,##0.00", "en_IN");
    return '₹ ${format.format(price)}';
  }
}

void showCustomToast(msg, {color}) {
  Fluttertoast.showToast(
    msg: "$msg",
    backgroundColor: color,
    timeInSecForIosWeb: 1,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    webPosition: "center",
    webBgColor: "linear-gradient(to right, #dc1c13, #dc1c13)",
  );
}

String getStringFromList(List<dynamic>? data) {
  String str = data.toString();
  return data.toString().substring(1, str.length - 1);
}

class AppConstants {
  static bool isProduction =
      true; //if want to use live url in debug mode set to production mode true
  String get getBaseUrl => baseUrl;
  set setBaseUrl(String url) => baseUrl = url;
  static const String liveUrl = 'https://easyshiftlogistics.com/';
  static const String localUrl = 'http://192.168.1.29:8003/';
  static String baseUrl = (kReleaseMode || isProduction) ? liveUrl : localUrl;

  //--------auth-----------\\
  static const String loginUri = 'api/driver/v1/auth/otp/send';
  static const String otpVerifyUri = 'api/driver/v1/auth/otp/verify';
  static const String profileUri = 'api/driver/v1/basic/profile';
  static const String logOutUri = 'api/driver/v1/auth/logout';
  static const String updateProfileUri = 'api/driver/v1/basic/update-profile';

  //--------basic---------
  static const String businessSettingUri = 'api/v1/settings';
  static const String dutyOnOffUri = 'api/driver/v1/basic/duty-status';
  static const String analyticsUri = 'api/driver/v1/goods/dashboard/analytics';

  //-------resister-----------
  static const String registerUri = 'api/driver/v1/auth/register';
  static const String vehiclesMaterUri = 'api/driver/v1/basic/vehicles';
  static const String miniTruckUri = 'api/driver/v1/basic/mini-truck';

  //----------bookings----------------
  static const String bookingsUri = 'api/driver/v1/goods/bookings';
  static const String epodUri = 'api/driver/v1/goods/bookings/epod';
  static const String bookingTripStartUri =
      'api/driver/v1/goods/bookings/start';
  static const String bookingTripEndUri = 'api/driver/v1/goods/bookings/end';
  static const String locationMarkAsDone =
      'api/driver/v1/goods/bookings/location-mark-as-done';
  //----------car and bikes--------------
  static const String carAndBikebookingsUri =
      'api/driver/v1/car-and-bike/bookings';
  static const String carAndBikebookingsDetailsUri =
      'api/driver/v1/car-and-bike/bookings';
  static const String bookingTripStartForCarAndBikeUri =
      'api/driver/v1/car-and-bike/bookings/start';
  static const String bookingDeliveredForCarAndBikeUri =
      'api/driver/v1/car-and-bike/bookings/end';
  static const String bookingMarkAsDoneForCarAndBikeUri =
      'api/driver/v1/car-and-bike/bookings/location-mark-as-done';

  //------------order-----------------
  static const String orderAccept =
      'api/driver/v1/two-wheelers/bookings/accept';
  //----------home items-----------------
  static const String homeItemUri = 'api/v1/home-items';
  static const String addHomeItem =
      'api/driver/v1/packers-and-movers/bookings/home-items';
  static const String updateHomeItem =
      'api/driver/v1/packers-and-movers/bookings/home-items';
  static const String deleteHomeItem =
      'api/driver/v1/packers-and-movers/bookings/home-items';

  //-------------location-------------------------
  static const String updateLocationUri = 'api/driver/v1/basic/update-location';

  //----------bike tempo---------------
  static const String acceptOrder =
      'api/driver/v1/two-wheelers/bookings/accept';
  static const String allOrders = 'api/driver/v1/two-wheelers/bookings';
  static const String orderDetail = 'api/driver/v1/two-wheelers/bookings';
  static const String startBikeTempoUri =
      'api/driver/v1/two-wheelers/bookings/verify-otp';
  static const String bikeTempoMarkLocationDone =
      'api/driver/v1/two-wheelers/bookings/mark-location-as-done';
  static const String markAsDeliveredBikeTempo =
      'api/driver/v1/two-wheelers/bookings/mark-as-delivered';
  static const String bikeTempoAnalytic =
      'api/driver/v1/two-wheelers/dashboard/analytics';

  //-------app details-------
  static String appName = 'Easyshift vendor app';
  static String packageName = '';
  static String version = '';
  static String buildNumber = '';
  static const String agoraAppId = 'c87b710048c049f59570bd1895b7e561';
  static const String extras = 'api/v1/extra';
  // Shared Key
  static const String token = 'user_app_token';
  static const String userId = 'user_app_id';
  static const String razorpayKey = 'razorpay_key';
  static const String recentOrders = 'recent_orders';
  static const String isUser = 'is_user';
  static const String profile =
      "https://s3-alpha-sig.figma.com/img/885b/4adb/5485ef1e61a0b521b0bd6a047e74046d?Expires=1743984000&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=KDrR8SVdeRKeWZDWZktd9QCWI~qKsH~4CrO2DQyhFi-wX~OE7KEgGObqWYYiy3NjPeqnML538nR2XzdG~fvaiSCwQ7uGP0FTvliC5Q-oLodsoHDejk4Nnh-Ba9o9lNMnmp4IMX-Z3N9BsIzIbf13jddUobuh2yeMAbVF5tP0Xjv-7Pccy3-GZvmdQ06WXBsuuLRAmYQnteZr1gsx-nO8sSLrWpKUFjedbMbAQjGeD4AdmaycBYhdzyvLVqiSUoiKNgHvHvf17Bjb0nH5wl2jxmyNPiwERGImW8cZqMkTKGGR4bFqFC~HcwKRRtSuG7O0-8TArOEuEPgG5i6G-XDDRA__";
}
