class SyncDriverResponse {
  SyncDriverResponse({
    this.success,
    this.data,
    this.message,
  });

  bool? success;
  Data? data;
  String? message;

  factory SyncDriverResponse.fromJson(Map<String, dynamic> json) => SyncDriverResponse(
    success: json["success"],
    data: Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data!.toJson(),
    "message": message,
  };
}

class Data {
  Data({
    this.id,
    this.name,
    this.countryCode,
    this.mobile,
    this.email,
    this.dob,
    this.secondaryMobile,
    this.cashInHand,
    this.incentive,
    this.profileImg,
    this.fcmToken,
    this.latitude,
    this.longitude,
    this.vehicleType,
    this.vehicleRegNo,
    this.vehicleColor,
    this.vehicleImg,
    this.dlPhoto,
    this.aadharPhoto,
    this.aadharPhotoBack,
    this.serviceTypeId,
    this.bankName,
    this.accountNo,
    this.ifscCode,
    this.branchName,
    this.emergencyContactName,
    this.emergencyContactNo,
    this.emergencyContactRelation,
    this.languages,
    this.active,
    this.isVerified,
    this.onDuty,
    this.cashInHandOverflow,
    this.resetOtp,
    this.createdAt,
    this.updatedAt,
    this.duty,
  });

  int? id;
  String? name;
  String? countryCode;
  String? mobile;
  String? email;
  DateTime? dob;
  String? secondaryMobile;
  double? cashInHand;
  double? incentive;
  String? profileImg;
  String? fcmToken;
  String? latitude;
  String? longitude;
  String? vehicleType;
  String? vehicleRegNo;
  String? vehicleColor;
  dynamic vehicleImg;
  String? dlPhoto;
  String? aadharPhoto;
  String? aadharPhotoBack;
  int? serviceTypeId;
  String? bankName;
  String? accountNo;
  String? ifscCode;
  String? branchName;
  String? emergencyContactName;
  String? emergencyContactNo;
  String? emergencyContactRelation;
  String? languages;
  bool? active;
  bool? isVerified;
  int? onDuty;
  int? cashInHandOverflow;
  dynamic resetOtp;
  DateTime? createdAt;
  DateTime? updatedAt;
  Duty? duty;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    countryCode: json["country_code"],
    mobile: json["mobile"],
    email: json["email"],
    dob: DateTime.parse(json["dob"]),
    secondaryMobile: json["secondary_mobile"],
    cashInHand: json["cash_in_hand"].toDouble(),
    incentive: json["incentive"].toDouble(),
    profileImg: json["profile_img"],
    fcmToken: json["fcm_token"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    vehicleType: json["vehicle_type"],
    vehicleRegNo: json["vehicle_reg_no"],
    vehicleColor: json["vehicle_color"],
    vehicleImg: json["vehicle_img"],
    dlPhoto: json["dl_photo"],
    aadharPhoto: json["aadhar_photo"],
    aadharPhotoBack: json["aadhar_photo_back"],
    serviceTypeId: json["service_type_id"],
    bankName: json["bank_name"],
    accountNo: json["account_no"],
    ifscCode: json["ifsc_code"],
    branchName: json["branch_name"],
    emergencyContactName: json["emergency_contact_name"],
    emergencyContactNo: json["emergency_contact_no"],
    emergencyContactRelation: json["emergency_contact_relation"],
    languages: json["languages"],
    active: json["active"],
    isVerified: json["is_verified"],
    onDuty: json["on_duty"],
    cashInHandOverflow: json["cash_in_hand_overflow"],
    resetOtp: json["reset_otp"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    duty: (json["duty"] == null)?null:Duty.fromJson(json["duty"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "country_code": countryCode,
    "mobile": mobile,
    "email": email,
    "dob": "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
    "secondary_mobile": secondaryMobile,
    "cash_in_hand": cashInHand,
    "incentive": incentive,
    "profile_img": profileImg,
    "fcm_token": fcmToken,
    "latitude": latitude,
    "longitude": longitude,
    "vehicle_type": vehicleType,
    "vehicle_reg_no": vehicleRegNo,
    "vehicle_color": vehicleColor,
    "vehicle_img": vehicleImg,
    "dl_photo": dlPhoto,
    "aadhar_photo": aadharPhoto,
    "aadhar_photo_back": aadharPhotoBack,
    "service_type_id": serviceTypeId,
    "bank_name": bankName,
    "account_no": accountNo,
    "ifsc_code": ifscCode,
    "branch_name": branchName,
    "emergency_contact_name": emergencyContactName,
    "emergency_contact_no": emergencyContactNo,
    "emergency_contact_relation": emergencyContactRelation,
    "languages": languages,
    "active": active,
    "is_verified": isVerified,
    "on_duty": onDuty,
    "cash_in_hand_overflow": cashInHandOverflow,
    "reset_otp": resetOtp,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "duty": duty!.toJson(),
  };
}

class Duty {
  Duty({
    this.id,
    this.driverId,
    this.startTime,
    this.endTime,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? driverId;
  String? startTime;
  dynamic endTime;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Duty.fromJson(Map<String, dynamic> json) => Duty(
    id: json["id"],
    driverId: json["driver_id"],
    startTime: json["start_time"],
    endTime: json["end_time"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );
  Map<String, dynamic> toJson() => {
    "id": id,
    "driver_id": driverId,
    "start_time": startTime,
    "end_time": endTime,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}
