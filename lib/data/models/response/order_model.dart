import 'dart:convert';

OrderModel orderModelFromJson(String str) =>
    OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  int? id;
  String? bookingId;
  int? twoWheelerPackageTypeId;
  int? userId;
  dynamic driverId;
  dynamic promoCodeId;
  int? parcelValue;
  double? subTotalForUser;
  double? subTotalForDriver;
  double? promoCodeDiscountAmount;
  double? totalPayableAmountForUser;
  double? totalPayableAmountForDriver;
  double? commissionAmount;
  int? startOtp;
  String? isStartOtpVerified;
  String? status;
  String? paymentMode;
  DateTime? placed;
  dynamic accepted;
  dynamic inprocess;
  dynamic delivered;
  dynamic cancelled;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? pickupUserName;
  String? pickupUserPhone;
  String? dropUserName;
  String? dropUserPhone;
  String? bookingType;
  dynamic twoWheelerTruckId;
  dynamic easeBuzzOrderTwoWheelerId;
  List<Location>? locations;
  TwoWheelerPackageType? twoWheelerPackageType;
  User? user;

  OrderModel({
    this.id,
    this.bookingId,
    this.twoWheelerPackageTypeId,
    this.userId,
    this.driverId,
    this.promoCodeId,
    this.parcelValue,
    this.subTotalForUser,
    this.subTotalForDriver,
    this.promoCodeDiscountAmount,
    this.totalPayableAmountForUser,
    this.totalPayableAmountForDriver,
    this.commissionAmount,
    this.startOtp,
    this.isStartOtpVerified,
    this.status,
    this.paymentMode,
    this.placed,
    this.accepted,
    this.inprocess,
    this.delivered,
    this.cancelled,
    this.createdAt,
    this.updatedAt,
    this.pickupUserName,
    this.pickupUserPhone,
    this.dropUserName,
    this.dropUserPhone,
    this.bookingType,
    this.twoWheelerTruckId,
    this.easeBuzzOrderTwoWheelerId,
    this.locations,
    this.twoWheelerPackageType,
    this.user,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json["id"],
        bookingId: json["booking_id"],
        twoWheelerPackageTypeId: json["two_wheeler_package_type_id"],
        userId: json["user_id"],
        driverId: json["driver_id"],
        promoCodeId: json["promo_code_id"],
        parcelValue: json["parcel_value"],
        subTotalForUser: json["sub_total_for_user"]?.toDouble(),
        subTotalForDriver: json["sub_total_for_driver"]?.toDouble(),
        promoCodeDiscountAmount: json["promo_code_discount_amount"]?.toDouble(),
        totalPayableAmountForUser:
            json["total_payable_amount_for_user"]?.toDouble(),
        totalPayableAmountForDriver:
            json["total_payable_amount_for_driver"]?.toDouble(),
        commissionAmount: json["commission_amount"]?.toDouble(),
        startOtp: json["start_otp"],
        isStartOtpVerified: json["is_start_otp_verified"],
        status: json["status"],
        paymentMode: json["payment_mode"],
        placed: json["placed"] == null ? null : DateTime.parse(json["placed"]),
        accepted: json["accepted"],
        inprocess: json["inprocess"],
        delivered: json["delivered"],
        cancelled: json["cancelled"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        pickupUserName: json["pickup_user_name"],
        pickupUserPhone: json["pickup_user_phone"],
        dropUserName: json["drop_user_name"],
        dropUserPhone: json["drop_user_phone"],
        bookingType: json["booking_type"],
        twoWheelerTruckId: json["two_wheeler_truck_id"],
        easeBuzzOrderTwoWheelerId: json["ease_buzz_order_two_wheeler_id"],
        locations: json["locations"] == null
            ? []
            : List<Location>.from(
                json["locations"]!.map((x) => Location.fromJson(x))),
        twoWheelerPackageType: json["two_wheeler_package_type"] == null
            ? null
            : TwoWheelerPackageType.fromJson(json["two_wheeler_package_type"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "booking_id": bookingId,
        "two_wheeler_package_type_id": twoWheelerPackageTypeId,
        "user_id": userId,
        "driver_id": driverId,
        "promo_code_id": promoCodeId,
        "parcel_value": parcelValue,
        "sub_total_for_user": subTotalForUser,
        "sub_total_for_driver": subTotalForDriver,
        "promo_code_discount_amount": promoCodeDiscountAmount,
        "total_payable_amount_for_user": totalPayableAmountForUser,
        "total_payable_amount_for_driver": totalPayableAmountForDriver,
        "commission_amount": commissionAmount,
        "start_otp": startOtp,
        "is_start_otp_verified": isStartOtpVerified,
        "status": status,
        "payment_mode": paymentMode,
        "placed": placed?.toIso8601String(),
        "accepted": accepted,
        "inprocess": inprocess,
        "delivered": delivered,
        "cancelled": cancelled,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "pickup_user_name": pickupUserName,
        "pickup_user_phone": pickupUserPhone,
        "drop_user_name": dropUserName,
        "drop_user_phone": dropUserPhone,
        "booking_type": bookingType,
        "two_wheeler_truck_id": twoWheelerTruckId,
        "ease_buzz_order_two_wheeler_id": easeBuzzOrderTwoWheelerId,
        "locations": locations == null
            ? []
            : List<dynamic>.from(locations!.map((x) => x.toJson())),
        "two_wheeler_package_type": twoWheelerPackageType?.toJson(),
        "user": user?.toJson(),
      };
}

class Location {
  int? id;
  int? bookingTwoWheelerId;
  String? type;
  String? addressLineOne;
  dynamic addressLineTwo;
  int? stateId;
  String? city;
  String? pincode;
  String? mapLocation;
  String? latitude;
  String? longitude;
  String? takePayment;
  DateTime? createdAt;
  DateTime? updatedAt;

  Location({
    this.id,
    this.bookingTwoWheelerId,
    this.type,
    this.addressLineOne,
    this.addressLineTwo,
    this.stateId,
    this.city,
    this.pincode,
    this.mapLocation,
    this.latitude,
    this.longitude,
    this.takePayment,
    this.createdAt,
    this.updatedAt,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        id: json["id"],
        bookingTwoWheelerId: json["booking_two_wheeler_id"],
        type: json["type"],
        addressLineOne: json["address_line_one"],
        addressLineTwo: json["address_line_two"],
        stateId: json["state_id"],
        city: json["city"],
        pincode: json["pincode"],
        mapLocation: json["map_location"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        takePayment: json["take_payment"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "booking_two_wheeler_id": bookingTwoWheelerId,
        "type": type,
        "address_line_one": addressLineOne,
        "address_line_two": addressLineTwo,
        "state_id": stateId,
        "city": city,
        "pincode": pincode,
        "map_location": mapLocation,
        "latitude": latitude,
        "longitude": longitude,
        "take_payment": takePayment,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };

  bool get getLocationType => type == 'pickup';

  String get getAddress {
    String address = '';
    if (addressLineTwo != null) {
      address = "$addressLineOne $addressLineTwo $city $pincode";
    } else {
      address = "$addressLineOne $city $pincode";
    }
    return address;
  }
}

class TwoWheelerPackageType {
  int? id;
  String? title;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  TwoWheelerPackageType({
    this.id,
    this.title,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory TwoWheelerPackageType.fromJson(Map<String, dynamic> json) =>
      TwoWheelerPackageType(
        id: json["id"],
        title: json["title"],
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
        "title": title,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class User {
  int? id;
  String? name;
  String? email;
  String? phone;
  dynamic companyName;
  dynamic gstNumber;
  dynamic gstCertificate;
  dynamic msmeCertificate;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  User({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.companyName,
    this.gstNumber,
    this.gstCertificate,
    this.msmeCertificate,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        companyName: json["company_name"],
        gstNumber: json["gst_number"],
        gstCertificate: json["gst_certificate"],
        msmeCertificate: json["msme_certificate"],
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
        "email": email,
        "phone": phone,
        "company_name": companyName,
        "gst_number": gstNumber,
        "gst_certificate": gstCertificate,
        "msme_certificate": msmeCertificate,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
