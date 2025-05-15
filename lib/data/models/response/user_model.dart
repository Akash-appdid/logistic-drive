import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  int? id;
  String? name;
  String? phone;
  String? email;
  String? vehicleType;
  String? vehicleNumber;
  String? registrationCertificate;
  int? buildYear;
  String? panCard;
  String? drivingLicence;
  String? aadharCardFront;
  String? aadharCardBack;
  String? payeeName;
  String? accountNumber;
  String? ifscCode;
  String? bankName;
  String? bankBranch;
  String? cancelCheck;
  String? onDuty;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic vehicleId;

  UserModel({
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
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
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
      };

  bool get isDuty => onDuty == 'yes';
  bool get isMotorbike => vehicleType == 'motorbike';
}
