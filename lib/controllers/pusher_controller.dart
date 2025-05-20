import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';

import 'package:just_audio/just_audio.dart';
import 'package:logistic_driver/controllers/auth_controller.dart';

import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

import '../data/models/response/order_model.dart';
import '../generated/assets.dart';

class PusherController extends GetxController implements GetxService {
  final PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();

  String bookingTwoWheelerRequestChannel =
      'booking_two_wheeler_request_${Get.find<AuthController>().userModel?.id}';

  final String myEvent = 'my-event';
  final AudioPlayer audioPlayer = AudioPlayer();
  List<OrderModel> orders = [];
  List<Timer> timers = [];

  Future initializePusher({required int driverId}) async {
    try {
      await pusher.init(
        apiKey: '1cdf1e7644ae7f3d2a26',
        cluster: 'ap2',
        onEvent: _onEvent,
        onSubscriptionSucceeded: (channelName, data) {
          log('Connected Successfully to: $channelName', name: 'pusher');
        },
        onError: (message, code, error) {
          log('Error of Connection: $error', name: 'pusher');
        },
      );
      await pusher.connect();
      await pusher.subscribe(
          channelName: 'booking_two_wheeler_request_$driverId');
    } catch (ex) {
      log('---------- $ex ---------', name: 'pusherInitialization');
    }
  }

  void removeItem({required int orderRequestId}) {
    int index = orders.indexWhere((element) => element.id == orderRequestId);
    if (index == -1) return;
    orders.removeAt(index);
    stopAudioPlayer();
    update();
  }

  void _onEvent(PusherEvent event) async {
    // log("${event.data}", name: 'PusherOutput');
    if (event.data == null && event.data is! String) return;
    // log("${event.data}", name: 'PusherOutput');

    try {
      Map<String, dynamic> decodedData = jsonDecode(event.data);
      if (decodedData.isEmpty) return;

      log("${jsonEncode(decodedData['bookingDetails'])}", name: 'Pushe');
      OrderModel order = OrderModel.fromJson(decodedData['bookingDetails']);
      orders.insert(0, order);
      timers.add(Timer(const Duration(seconds: 10), () {
        removeItem(orderRequestId: order.id ?? 0);
      }));
      update();
      // ------ Play Audio ------
      try {
        await audioPlayer.setAudioSource(
          LoopingAudioSource(
            child: AudioSource.asset(Assets.soundNotificationSound),
            count: 4,
          ),
        );
        await audioPlayer.play();
      } catch (e) {
        log("Audio error: $e", name: 'sound');
      }
    } catch (ex) {
      log('----------- $ex -----------', name: 'PusherModelException');
    }
  }

  //accept order
  void stopAudioPlayer() async {
    await audioPlayer.stop();
  }
}
