import 'dart:convert';

List<BookingsModel> bookingsModelFromJson(String str) =>
    List<BookingsModel>.from(
        json.decode(str).map((x) => BookingsModel.fromJson(x)));

String bookingsModelToJson(List<BookingsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BookingsModel {
  int? id;
  String? bookingId;
  int? userId;
  int? driverId;
  int? amountForDriver;
  int? amountForUser;
  String? status;
  String? pickupUserName;
  String? pickupUserPhone;
  DateTime? pickupDate;
  DateTime? estimatedDeliveryDate;
  String? dropUserName;
  String? dropUserPhone;
  String? goodTypeId;
  String? truckType;
  int? vehicleId;
  String? vehicleNumber;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? placed;
  DateTime? confirmed;
  DateTime? intransit;
  DateTime? delivered;
  dynamic cancelled;
  dynamic cancelReason;
  int? tripStartOtp;
  String? tripStartOtpVerified;
  List<Location>? locations;
  String? deliveryStatus;
  List<PayoutBookingGood>? payoutBookingGoodDrivers;
  List<PayoutBookingGood>? payoutBookingGoodUsers;
  Vehicle? vehicle;
  Driver? driver;

  BookingsModel({
    this.id,
    this.bookingId,
    this.userId,
    this.driverId,
    this.amountForDriver,
    this.amountForUser,
    this.status,
    this.pickupUserName,
    this.pickupUserPhone,
    this.pickupDate,
    this.estimatedDeliveryDate,
    this.dropUserName,
    this.dropUserPhone,
    this.goodTypeId,
    this.truckType,
    this.vehicleId,
    this.vehicleNumber,
    this.createdAt,
    this.updatedAt,
    this.placed,
    this.confirmed,
    this.intransit,
    this.delivered,
    this.cancelled,
    this.cancelReason,
    this.tripStartOtp,
    this.tripStartOtpVerified,
    this.locations,
    this.deliveryStatus,
    this.payoutBookingGoodDrivers,
    this.payoutBookingGoodUsers,
    this.vehicle,
    this.driver,
  });

  factory BookingsModel.fromJson(Map<String, dynamic> json) => BookingsModel(
        id: json["id"],
        bookingId: json["booking_id"],
        userId: json["user_id"],
        driverId: json["driver_id"],
        amountForDriver: json["amount_for_driver"],
        amountForUser: json["amount_for_user"],
        status: json["status"],
        pickupUserName: json["pickup_user_name"],
        pickupUserPhone: json["pickup_user_phone"],
        pickupDate: json["pickup_date"] == null
            ? null
            : DateTime.parse(json["pickup_date"]),
        estimatedDeliveryDate: json["estimated_delivery_date"] == null
            ? null
            : DateTime.parse(json["estimated_delivery_date"]),
        dropUserName: json["drop_user_name"],
        dropUserPhone: json["drop_user_phone"],
        goodTypeId: json["good_type_id"],
        truckType: json["truck_type"],
        vehicleId: json["vehicle_id"],
        vehicleNumber: json["vehicle_number"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        placed: json["placed"] == null ? null : DateTime.parse(json["placed"]),
        confirmed: json["confirmed"] == null
            ? null
            : DateTime.parse(json["confirmed"]),
        intransit: json["intransit"] == null
            ? null
            : DateTime.parse(json["intransit"]),
        delivered: json["delivered"] == null
            ? null
            : DateTime.parse(json["delivered"]),
        cancelled: json["cancelled"],
        cancelReason: json["cancel_reason"],
        tripStartOtp: json["trip_start_otp"],
        tripStartOtpVerified: json["trip_start_otp_verified"],
        deliveryStatus: json["delivery_status"],
        locations: json["locations"] == null
            ? []
            : List<Location>.from(
                json["locations"]!.map((x) => Location.fromJson(x))),
        payoutBookingGoodDrivers: json["payout_booking_good_drivers"] == null
            ? []
            : List<PayoutBookingGood>.from(json["payout_booking_good_drivers"]!
                .map((x) => PayoutBookingGood.fromJson(x))),
        payoutBookingGoodUsers: json["payout_booking_good_users"] == null
            ? []
            : List<PayoutBookingGood>.from(json["payout_booking_good_users"]!
                .map((x) => PayoutBookingGood.fromJson(x))),
        vehicle:
            json['vehicle'] != null ? Vehicle.fromJson(json['vehicle']) : null,
        driver: json['driver'] != null ? Driver.fromJson(json['driver']) : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "booking_id": bookingId,
        "user_id": userId,
        "driver_id": driverId,
        "amount_for_driver": amountForDriver,
        "amount_for_user": amountForUser,
        "status": status,
        "pickup_user_name": pickupUserName,
        "pickup_user_phone": pickupUserPhone,
        "pickup_date": pickupDate?.toIso8601String(),
        "estimated_delivery_date": estimatedDeliveryDate?.toIso8601String(),
        "drop_user_name": dropUserName,
        "drop_user_phone": dropUserPhone,
        "good_type_id": goodTypeId,
        "truck_type": truckType,
        "vehicle_id": vehicleId,
        "vehicle_number": vehicleNumber,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "placed": placed?.toIso8601String(),
        "confirmed": confirmed?.toIso8601String(),
        "intransit": intransit?.toIso8601String(),
        "delivered": delivered?.toIso8601String(),
        "cancelled": cancelled,
        "cancel_reason": cancelReason,
        "trip_start_otp": tripStartOtp,
        "trip_start_otp_verified": tripStartOtpVerified,
        "locations": locations == null
            ? []
            : List<dynamic>.from(locations!.map((x) => x.toJson())),
      };

  double get remaingAmount {
    double amt = 0;
    if (payoutBookingGoodDrivers == null) amt = 0;
    if (payoutBookingGoodDrivers!.isEmpty) amt = 0;
    for (var element in payoutBookingGoodDrivers!) {
      amt += (element.amount ?? 0).toDouble();
    }

    return amt;
  }

  double get calcualteRemaingAmtAfterSubAmt =>
      (amountForDriver?.toDouble() ?? 0) - remaingAmount;

  bool get isOrderTracking {
    for (var element in locations ?? []) {
      if (element.status != "done") {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }
}

class Location {
  int? id;
  int? bookingGoodId;
  String? type;
  String? addressLineOne;
  String? addressLineTwo;
  int? stateId;
  String? city;
  String? pincode;
  dynamic loadingUnloadingStartTime;
  dynamic loadingUnloadingEndTime;
  dynamic intransitStartTime;
  dynamic intransitEndTime;
  String? mapLocation;
  String? latitude;
  String? longitude;
  String? status;
  DateTime? createdAt;
  DateTime? doneAt;
  DateTime? updatedAt;
  int? sequence;
  int pickupDoneCount;
  int dropDoneCount;
  int pickupIndex;
  int dropIndex;

  Location({
    this.id,
    this.bookingGoodId,
    this.type,
    this.addressLineOne,
    this.addressLineTwo,
    this.stateId,
    this.city,
    this.pincode,
    this.loadingUnloadingStartTime,
    this.loadingUnloadingEndTime,
    this.intransitStartTime,
    this.intransitEndTime,
    this.mapLocation,
    this.latitude,
    this.longitude,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.sequence,
    this.pickupDoneCount = 1,
    this.dropDoneCount = 1,
    this.doneAt,
    this.pickupIndex = 0,
    this.dropIndex = 0,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        id: json["id"],
        bookingGoodId: json["booking_good_id"],
        type: json["type"],
        addressLineOne: json["address_line_one"],
        addressLineTwo: json["address_line_two"],
        stateId: json["state_id"],
        city: json["city"],
        pincode: json["pincode"],
        loadingUnloadingStartTime: json["loading_unloading_start_time"],
        loadingUnloadingEndTime: json["loading_unloading_end_time"],
        intransitStartTime: json["intransit_start_time"],
        intransitEndTime: json["intransit_end_time"],
        mapLocation: json["map_location"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        doneAt:
            json["done_at"] == null ? null : DateTime.parse(json["done_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        sequence: json["sequence"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "booking_good_id": bookingGoodId,
        "type": type,
        "address_line_one": addressLineOne,
        "address_line_two": addressLineTwo,
        "state_id": stateId,
        "city": city,
        "pincode": pincode,
        "loading_unloading_start_time": loadingUnloadingStartTime,
        "loading_unloading_end_time": loadingUnloadingEndTime,
        "intransit_start_time": intransitStartTime,
        "intransit_end_time": intransitEndTime,
        "map_location": mapLocation,
        "latitude": latitude,
        "longitude": longitude,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "sequence": sequence,
      };

  bool get getLocationType => type == 'pickup';

  String get getAddress {
    String address = '';
    if (addressLineTwo != null) {
      address = "$addressLineOne $addressLineTwo $city";
    } else {
      address = "$addressLineOne $city";
    }
    return address;
  }

  bool get orderStatus => status == 'done';

  int get getIndex => type == 'pickup' ? pickupDoneCount : dropDoneCount;
  int get getItemIndex => type == 'pickup' ? pickupIndex : dropIndex;
}

class PayoutBookingGood {
  int? id;
  int? bookingGoodId;
  int? driverId;
  int? amount;
  dynamic remark;
  dynamic file;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? userId;

  PayoutBookingGood({
    this.id,
    this.bookingGoodId,
    this.driverId,
    this.amount,
    this.remark,
    this.file,
    this.createdAt,
    this.updatedAt,
    this.userId,
  });

  factory PayoutBookingGood.fromJson(Map<String, dynamic> json) =>
      PayoutBookingGood(
        id: json["id"],
        bookingGoodId: json["booking_good_id"],
        driverId: json["driver_id"],
        amount: json["amount"],
        remark: json["remark"],
        file: json["file"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "booking_good_id": bookingGoodId,
        "driver_id": driverId,
        "amount": amount,
        "remark": remark,
        "file": file,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user_id": userId,
      };
}

class Vehicle {
  int? id;
  String? name;
  String? type;
  String? weight;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  Vehicle({
    this.id,
    this.name,
    this.type,
    this.weight,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        weight: json["weight"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "weight": weight,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Driver {
  int? id;
  String? vehicleNumber;

  Driver({
    this.id,
    this.vehicleNumber,
  });

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        id: json["id"],
        vehicleNumber: json["vehicle_number"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "vehicle_number": vehicleNumber,
      };
}
