import 'dart:convert';

List<LocalBikeTempoBookingModel> localBikeTempoBookingModelFromJson(
        String str) =>
    List<LocalBikeTempoBookingModel>.from(
        json.decode(str).map((x) => LocalBikeTempoBookingModel.fromJson(x)));

String localBikeTempoBookingModelToJson(
        List<LocalBikeTempoBookingModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LocalBikeTempoBookingModel {
  int? id;
  String? bookingId;
  int? twoWheelerPackageTypeId;
  int? userId;
  int? driverId;
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
  DateTime? accepted;
  DateTime? inprocess;
  DateTime? delivered;
  DateTime? cancelled;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? pickupUserName;
  String? pickupUserPhone;
  String? dropUserName;
  String? dropUserPhone;
  String? bookingType;
  dynamic twoWheelerTruckId;
  dynamic easeBuzzOrderTwoWheelerId;
  List<LocationofLocalBike>? locations;
  TwoWheelerPackageType? twoWheelerPackageType;
  User? user;
  Driver? driver;

  LocalBikeTempoBookingModel({
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
    this.driver,
  });

  factory LocalBikeTempoBookingModel.fromJson(Map<String, dynamic> json) =>
      LocalBikeTempoBookingModel(
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
        accepted:
            json["accepted"] == null ? null : DateTime.parse(json["accepted"]),
        inprocess: json["inprocess"] == null
            ? null
            : DateTime.parse(json['inprocess']),
        delivered: json["delivered"] == null
            ? null
            : DateTime.parse(json['delivered']),
        cancelled: json["cancelled"] == null
            ? null
            : DateTime.parse(json['cancelled']),
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
            : List<LocationofLocalBike>.from(
                json["locations"]!.map((x) => LocationofLocalBike.fromJson(x))),
        twoWheelerPackageType: json["two_wheeler_package_type"] == null
            ? null
            : TwoWheelerPackageType.fromJson(json["two_wheeler_package_type"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        driver: json["driver"] == null ? null : Driver.fromJson(json["driver"]),
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
        "accepted": accepted?.toIso8601String(),
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
      };

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

  String get getCustomerName => user?.name ?? '';
  String get getCustomerMobileNo => user?.phone ?? '';
  String get getPakageType => twoWheelerPackageType?.title ?? '';
}

class LocationofLocalBike {
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
  String? status;
  DateTime? doneAt;
  int pickupDoneCount;
  int dropDoneCount;
  int pickupIndex;
  int dropIndex;
  String? name;
  String? phone;

  LocationofLocalBike(
      {this.id,
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
      this.status,
      this.doneAt,
      this.pickupDoneCount = 1,
      this.dropDoneCount = 1,
      this.pickupIndex = 0,
      this.dropIndex = 0,
      this.name,
      this.phone});

  factory LocationofLocalBike.fromJson(Map<String, dynamic> json) =>
      LocationofLocalBike(
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
        status: json["status"],
        doneAt: json["done_at"] == null
            ? null
            : DateTime.parse(
                json["done_at"],
              ),
        name: json['name'],
        phone: json['phone'],
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
        "status": status,
        "done_at": doneAt,
      };

  //---

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

  bool get orderStatus => status == 'done';
  String get getIndex => type == 'pickup'
      ? ''
      : dropDoneCount == 1
          ? ''
          : "$dropDoneCount ";
  String get getItemIndex =>
      type == 'pickup' ? '' : "${dropIndex == 1 ? '' : dropIndex}";
}

class Driver {
  int? id;
  String? name;
  String? phone;
  dynamic email;
  String? vehicleType;
  String? vehicleNumber;
  dynamic registrationCertificate;
  int? buildYear;
  dynamic panCard;
  dynamic drivingLicence;
  dynamic aadharCardFront;
  dynamic aadharCardBack;
  dynamic payeeName;
  dynamic accountNumber;
  dynamic ifscCode;
  dynamic bankName;
  dynamic bankBranch;
  dynamic cancelCheck;
  String? onDuty;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic vehicleId;
  dynamic twoWheelerTruckId;
  dynamic panCardNumber;
  dynamic aadharCardNumber;
  dynamic drivingLicenseNumber;
  String? latitude;
  String? longitude;
  DateTime? lastLocationUpdated;

  Driver({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.vehicleType,
    this.vehicleNumber,
    this.registrationCertificate,
    this.buildYear,
    this.panCard,
    this.drivingLicence,
    this.aadharCardFront,
    this.aadharCardBack,
    this.payeeName,
    this.accountNumber,
    this.ifscCode,
    this.bankName,
    this.bankBranch,
    this.cancelCheck,
    this.onDuty,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.vehicleId,
    this.twoWheelerTruckId,
    this.panCardNumber,
    this.aadharCardNumber,
    this.drivingLicenseNumber,
    this.latitude,
    this.longitude,
    this.lastLocationUpdated,
  });

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        vehicleType: json["vehicle_type"],
        vehicleNumber: json["vehicle_number"],
        registrationCertificate: json["registration_certificate"],
        buildYear: json["build_year"],
        panCard: json["pan_card"],
        drivingLicence: json["driving_licence"],
        aadharCardFront: json["aadhar_card_front"],
        aadharCardBack: json["aadhar_card_back"],
        payeeName: json["payee_name"],
        accountNumber: json["account_number"],
        ifscCode: json["ifsc_code"],
        bankName: json["bank_name"],
        bankBranch: json["bank_branch"],
        cancelCheck: json["cancel_check"],
        onDuty: json["on_duty"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        vehicleId: json["vehicle_id"],
        twoWheelerTruckId: json["two_wheeler_truck_id"],
        panCardNumber: json["pan_card_number"],
        aadharCardNumber: json["aadhar_card_number"],
        drivingLicenseNumber: json["driving_license_number"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        lastLocationUpdated: json["last_location_updated"] == null
            ? null
            : DateTime.parse(json["last_location_updated"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "email": email,
        "vehicle_type": vehicleType,
        "vehicle_number": vehicleNumber,
        "registration_certificate": registrationCertificate,
        "build_year": buildYear,
        "pan_card": panCard,
        "driving_licence": drivingLicence,
        "aadhar_card_front": aadharCardFront,
        "aadhar_card_back": aadharCardBack,
        "payee_name": payeeName,
        "account_number": accountNumber,
        "ifsc_code": ifscCode,
        "bank_name": bankName,
        "bank_branch": bankBranch,
        "cancel_check": cancelCheck,
        "on_duty": onDuty,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "vehicle_id": vehicleId,
        "two_wheeler_truck_id": twoWheelerTruckId,
        "pan_card_number": panCardNumber,
        "aadhar_card_number": aadharCardNumber,
        "driving_license_number": drivingLicenseNumber,
        "latitude": latitude,
        "longitude": longitude,
        "last_location_updated": lastLocationUpdated?.toIso8601String(),
      };
}

class TwoWheelerPackageType {
  int? id;
  String? title;

  TwoWheelerPackageType({
    this.id,
    this.title,
  });

  factory TwoWheelerPackageType.fromJson(Map<String, dynamic> json) =>
      TwoWheelerPackageType(
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
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
