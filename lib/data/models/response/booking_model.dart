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
        locations: json["locations"] == null
            ? []
            : List<Location>.from(
                json["locations"]!.map((x) => Location.fromJson(x))),
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
  DateTime? updatedAt;
  int? sequence;

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
}
