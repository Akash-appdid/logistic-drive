import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:intl/intl.dart';
import 'package:logistic_driver/main.dart';

Size size = MediaQuery.of(navigatorKey.currentContext!).size;

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
  String get getBaseUrl => baseUrl;
  set setBaseUrl(String url) => baseUrl = url;

  //TODO: Change Base Url
  static String baseUrl = 'https://www.base-url.in/';
  // static String baseUrl = 'http://192.168.1.5:9000/'; ///USE FOR LOCAL
  //TODO: Change Base Url
  static String appName = 'Logistic Driver';
  static String packageName = '';
  static String version = '';
  static String buildNumber = '';

  static const String agoraAppId = 'c87b710048c049f59570bd1895b7e561';

  static const String loginUri = 'api/v1/user/login';
  static const String profileUri = 'api/v1/user/profile';
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
