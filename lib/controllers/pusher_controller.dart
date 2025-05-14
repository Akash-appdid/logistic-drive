import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:just_audio/just_audio.dart';

import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

import '../generated/assets.dart';

class PusherController extends GetxController implements GetxService {
  final PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();

  // final String channel = 'my-channel';
  final String channel = 'order_placed_vendor_';
  final String myEvent = 'my-event';
  final AudioPlayer audioPlayer = AudioPlayer();

  List<dynamic> orders = [];
  List<Timer> timers = [];

  Future initializePusher({required int vendorId}) async {
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
          channelName: 'booking_two_wheeler_request_$vendorId');
    } catch (ex) {
      log('---------- $ex ---------', name: 'pusherInitialization');
    }
  }

  // void removeItem({required int orderRequestId}) {
  //   int index = orders
  //       .indexWhere((element) => element.orderRequest?.id == orderRequestId);
  //   if (index == -1) return;

  //   // timers[index].cancel();
  //   // timers.removeAt(index);
  //   orders.removeAt(index);
  //   update();
  // }

  void _onEvent(PusherEvent event) {
    log(event.data, name: 'PusherOutput');
    if (event.data == null && event.data is! String) return;
    log(event.data, name: 'PusherOutput');

    try {
      Map<String, dynamic> decodedData = jsonDecode(event.data);
      if (decodedData.isEmpty) return;

      // PusherMessageModel order = PusherMessageModel.fromJson(decodedData);
      // orders.insert(0, order);

      // timers.add(Timer(const Duration(seconds: 10), () {
      //   removeItem(orderRequestId: order.orderRequest?.id ?? 0);
      // }));
      update();

      // ------ Play Audio ------
      audioPlayer
        ..setAudioSource(
          LoopingAudioSource(
            child: AudioSource.asset(Assets.soundNotificationRinging),
            count: 4,
          ),
        )
        ..play();
    } catch (ex) {
      log('----------- $ex -----------', name: 'PusherModelException');
    }
  }
}
