import 'dart:developer';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class ExtraMethods {
  String getWhatsAppUrl(String number, [String msg = '']) {
    return 'https://wa.me/91$number?text=$msg';
  }

  /// Also Add Queries in AndroidManifest Refer Url Launcher Package Documentation
  void makeCall(String number) async {
    final url = Uri(scheme: 'tel', path: number);
    if (await canLaunchUrl(url)) {
      launchUrl(url);
    }
  }

  /* void makeCall(String number) {
    if (number.startsWith('+91')) {
      launchInBrowser("tel:$number");
    } else {
      launchInBrowser("tel:+91$number");
    }
  }*/

  void makeMail(String email, [String subject = '']) {
    try {
      Uri emailLaunchUri = Uri(scheme: 'mailto', path: email, queryParameters: {'subject': subject});
      var url = emailLaunchUri.toString().replaceAll('+', ' ');
      launchInBrowser(url);
    } catch (e) {
      log(e.toString(), name: "Error at makeMail");
    }
  }

  static Future<void> launchInBrowser(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
        webViewConfiguration: const WebViewConfiguration(
          headers: <String, String>{'my_header_key': 'my_header_value'},
        ),
      );
    } else {
      Fluttertoast.showToast(msg: 'Invalid url {$url}');
      log('Could not launch $url');
    }
  }

  static Future<void> launchWebsite(String url) async {
    if (!(url.startsWith('http'))) {
      if (!(url.startsWith('https://'))) {
        url = 'https://$url';
      }
    }
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalNonBrowserApplication,
        // headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      log('Could not launch $url');
    }
  }

  static drawGoogleRoute({required double lat, required double long}) {
    try {
      launchUrl(
        Uri.parse(
          'https://www.google.com/maps/dir/?api=1&destination=$lat,$long&travelmode=driving&dir_action=navigate',
        ),
        mode: LaunchMode.externalApplication,
      );
    } catch (ex) {
      Fluttertoast.showToast(msg: 'Incorrect Address');
    }
  }

  static bool isValidAadhaar(String input) {
    final aadhaarRegExp = RegExp(r'^[2-9]{1}[0-9]{11}$');
    return aadhaarRegExp.hasMatch(input);
  }

  static bool isValidPAN(String input) {
    final panRegExp = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$');
    return panRegExp.hasMatch(input.toUpperCase());
  }

  static bool isValidDrivingLicense(String input) {
    final dlRegExp = RegExp(r'^[A-Z]{2}[0-9]{2}[0-9]{4}[0-9]{7,8}$');
    return dlRegExp.hasMatch(input.toUpperCase());
  }
}

String getInitialLetter(String? name) {
  if (name == null || name.isEmpty) return '';
  return name[0].toUpperCase();
}

String formatSentence(String text) {
  return text.split(' ').map((word) {
    if (word.contains('_')) {
      return word.split('_').map((part) => part[0].toUpperCase() + part.substring(1)).join(' ');
    } else {
      return word;
    }
  }).join(' ');
}

String formatPrice(double price) {
  String formatted = price.toStringAsFixed(2); // Ensure 2 decimal places
  if (formatted.endsWith('.00')) {
    return formatted.substring(0, formatted.length - 3); // Remove .00
  } else if (formatted.endsWith('0')) {
    return formatted.substring(0, formatted.length - 1); // Remove trailing 0
  }
  return formatted;
}
