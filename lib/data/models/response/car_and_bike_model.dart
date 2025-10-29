import 'dart:convert';

import 'booking_model.dart';
import 'order_model.dart';

List<CarAndBikeModel> carAndBikeModelFromJson(String str) => List<CarAndBikeModel>.from(json.decode(str).map((x) => CarAndBikeModel.fromJson(x)));

String carAndBikeModelToJson(List<CarAndBikeModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CarAndBikeModel {
  int? id;
  String? bookingId;
  int? userId;
  List<VehicleDatum>? vehicleData;
  DateTime? estimatedMovingDate;
  String? whereToMove;
  String? pickupUserName;
  String? pickupUserPhone;
  String? pickupMapLocation;
  String? pickupAddressLineOne;
  String? pickupAddressLineTwo;
  int? pickupStateId;
  String? pickupCity;
  String? pickupPincode;
  String? pickupLatitude;
  String? pickupLongitude;
  String? dropUserName;
  String? dropUserPhone;
  String? dropMapLocation;
  String? dropAddressLineOne;
  String? dropAddressLineTwo;
  int? dropStateId;
  String? dropCity;
  String? dropPincode;
  String? dropLatitude;
  String? dropLongitude;
  String? status;
  dynamic createdAt;
  DateTime? updatedAt;
  String? rcBook;
  String? insurance;
  double? amountForDriver;
  double? amountForUser;
  DateTime? pickupDate;
  DateTime? estimatedDeliveryDate;
  String? deliveryStatus;
  int? driverId;
  DateTime? confirmed;
  String? cancelReason;
  DateTime? cancelled;
  DateTime? intransit;
  DateTime? delivered;
  DateTime? pickupDoneAt;
  DateTime? dropDoneAt;
  String? bookingType;
  User? user;
  Driver? driver;
  List<PayoutBookingGood>? payoutBookingUsers;
  List<PayoutBookingGood>? payoutBookingDriver;

  CarAndBikeModel({
    this.id,
    this.bookingId,
    this.userId,
    this.vehicleData,
    this.estimatedMovingDate,
    this.whereToMove,
    this.pickupUserName,
    this.pickupUserPhone,
    this.pickupMapLocation,
    this.pickupAddressLineOne,
    this.pickupAddressLineTwo,
    this.pickupStateId,
    this.pickupCity,
    this.pickupPincode,
    this.pickupLatitude,
    this.pickupLongitude,
    this.dropUserName,
    this.dropUserPhone,
    this.dropMapLocation,
    this.dropAddressLineOne,
    this.dropAddressLineTwo,
    this.dropStateId,
    this.dropCity,
    this.dropPincode,
    this.dropLatitude,
    this.dropLongitude,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.rcBook,
    this.insurance,
    this.amountForDriver,
    this.amountForUser,
    this.pickupDate,
    this.estimatedDeliveryDate,
    this.deliveryStatus,
    this.driverId,
    this.confirmed,
    this.cancelReason,
    this.cancelled,
    this.intransit,
    this.delivered,
    this.pickupDoneAt,
    this.dropDoneAt,
    this.bookingType,
    this.driver,
    this.user,
    this.payoutBookingUsers,
    this.payoutBookingDriver,
  });

  factory CarAndBikeModel.fromJson(Map<String, dynamic> json) => CarAndBikeModel(
        id: json["id"],
        bookingId: json["booking_id"],
        userId: json["user_id"],
        vehicleData: json["vehicle_data"] == null ? [] : List<VehicleDatum>.from(json["vehicle_data"]!.map((x) => VehicleDatum.fromJson(x))),
        estimatedMovingDate: json["estimated_moving_date"] == null ? null : DateTime.parse(json["estimated_moving_date"]),
        whereToMove: json["where_to_move"],
        pickupUserName: json["pickup_user_name"],
        pickupUserPhone: json["pickup_user_phone"],
        pickupMapLocation: json["pickup_map_location"],
        pickupAddressLineOne: json["pickup_address_line_one"],
        pickupAddressLineTwo: json["pickup_address_line_two"],
        pickupStateId: json["pickup_state_id"],
        pickupCity: json["pickup_city"],
        pickupPincode: json["pickup_pincode"],
        pickupLatitude: json["pickup_latitude"],
        pickupLongitude: json["pickup_longitude"],
        dropUserName: json["drop_user_name"],
        dropUserPhone: json["drop_user_phone"],
        dropMapLocation: json["drop_map_location"],
        dropAddressLineOne: json["drop_address_line_one"],
        dropAddressLineTwo: json["drop_address_line_two"],
        dropStateId: json["drop_state_id"],
        dropCity: json["drop_city"],
        dropPincode: json["drop_pincode"],
        dropLatitude: json["drop_latitude"],
        dropLongitude: json["drop_longitude"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        rcBook: json["rc_book"],
        insurance: json["insurance"],
        amountForDriver: json["amount_for_driver"]?.toDouble(),
        amountForUser: json["amount_for_user"]?.toDouble(),
        pickupDate: json["pickup_date"] == null ? null : DateTime.parse(json["pickup_date"]),
        estimatedDeliveryDate: json["estimated_delivery_date"] == null ? null : DateTime.parse(json["estimated_delivery_date"]),
        deliveryStatus: json["delivery_status"],
        driverId: json["driver_id"],
        confirmed: json["confirmed"] == null ? null : DateTime.parse(json["confirmed"]),
        cancelReason: json["cancel_reason"],
        cancelled: json["cancelled"] == null ? null : DateTime.parse(json["cancelled"]),
        intransit: json["intransit"] == null ? null : DateTime.parse(json["intransit"]),
        delivered: json["delivered"] == null ? null : DateTime.parse(json["delivered"]),
        pickupDoneAt: json["pickup_done_at"] == null ? null : DateTime.parse(json["pickup_done_at"]),
        dropDoneAt: json["drop_done_at"] == null ? null : DateTime.parse(json["drop_done_at"]),
        bookingType: json["booking_type"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        driver: json["driver"] == null ? null : Driver.fromJson(json["driver"]),
        payoutBookingUsers: json["payout_booking_users"] == null ? [] : List<PayoutBookingGood>.from(json["payout_booking_users"]!.map((x) => PayoutBookingGood.fromJson(x))),
        payoutBookingDriver: json["payout_booking_driver"] == null ? [] : List<PayoutBookingGood>.from(json["payout_booking_driver"]!.map((x) => PayoutBookingGood.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "booking_id": bookingId,
        "user_id": userId,
        "vehicle_data": vehicleData,
        "estimated_moving_date":
            "${estimatedMovingDate!.year.toString().padLeft(4, '0')}-${estimatedMovingDate!.month.toString().padLeft(2, '0')}-${estimatedMovingDate!.day.toString().padLeft(2, '0')}",
        "where_to_move": whereToMove,
        "pickup_user_name": pickupUserName,
        "pickup_user_phone": pickupUserPhone,
        "pickup_map_location": pickupMapLocation,
        "pickup_address_line_one": pickupAddressLineOne,
        "pickup_address_line_two": pickupAddressLineTwo,
        "pickup_state_id": pickupStateId,
        "pickup_city": pickupCity,
        "pickup_pincode": pickupPincode,
        "pickup_latitude": pickupLatitude,
        "pickup_longitude": pickupLongitude,
        "drop_user_name": dropUserName,
        "drop_user_phone": dropUserPhone,
        "drop_map_location": dropMapLocation,
        "drop_address_line_one": dropAddressLineOne,
        "drop_address_line_two": dropAddressLineTwo,
        "drop_state_id": dropStateId,
        "drop_city": dropCity,
        "drop_pincode": dropPincode,
        "drop_latitude": dropLatitude,
        "drop_longitude": dropLongitude,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt?.toIso8601String(),
        "rc_book": rcBook,
        "insurance": insurance,
        "amount_for_driver": amountForDriver,
        "amount_for_user": amountForUser,
        "pickup_date": pickupDate?.toIso8601String(),
        "estimated_delivery_date": estimatedDeliveryDate?.toIso8601String(),
        "delivery_status": deliveryStatus,
        "driver_id": driverId,
        "confirmed": confirmed?.toIso8601String(),
        "cancel_reason": cancelReason,
        "cancelled": cancelled?.toIso8601String(),
        "intransit": intransit?.toIso8601String(),
        "delivered": delivered?.toIso8601String(),
        "pickup_done_at": pickupDoneAt?.toIso8601String(),
        "drop_done_at": dropDoneAt?.toIso8601String(),
        "booking_type": bookingType,
      };

  String get getPickupAddress {
    String address = '';
    if (pickupAddressLineTwo != null) {
      address = "$pickupAddressLineOne $pickupAddressLineTwo $pickupCity $pickupPincode";
    } else {
      address = "$pickupAddressLineOne $pickupCity $pickupPincode";
    }
    return address;
  }

  String get getDropAddress {
    String address = '';
    if (dropAddressLineTwo != null) {
      address = "$dropAddressLineOne $dropAddressLineTwo $dropCity $dropPincode";
    } else {
      address = "$dropAddressLineOne $dropCity $dropPincode";
    }
    return address;
  }

  double get remaingAmount {
    double amt = 0;
    if (payoutBookingDriver == null) amt = 0;
    if (payoutBookingDriver!.isEmpty) amt = 0;
    for (var element in payoutBookingDriver!) {
      amt += (element.amount ?? 0).toDouble();
    }

    return amt;
  }

  double get calcualteRemaingAmtAfterSubAmt => (amountForDriver?.toDouble() ?? 0) - remaingAmount;

  bool get isDelivered => (status != null && status == 'delivered');
}

class VehicleDatum {
  String? type;
  String? model;

  VehicleDatum({
    this.type,
    this.model,
  });

  factory VehicleDatum.fromJson(Map<String, dynamic> json) => VehicleDatum(
        type: json["type"],
        model: json["model"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "model": model,
      };
}
