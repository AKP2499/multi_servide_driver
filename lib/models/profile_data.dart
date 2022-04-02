class ProfileData {
  ProfileData({
    this.onDuty,
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
    this.createdAt,
    this.updatedAt,
    this.token,
    this.tokenType,
    this.activeTime,
    this.kycs
  });
  int?onDuty;
  int? id;
  String? name;
  String? countryCode;
  String? mobile;
  String? dob;
  String? secondaryMobile;
  String? email;
  double? cashInHand;
  double? incentive;
  String? profileImg;
  String? vehicleType;
  String? vehicleRegNo;
  String? vehicleColor;
  String? vehicleImg;
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
  DateTime? createdAt;
  DateTime? updatedAt;
  String? token;
  String? tokenType;
  String? activeTime;
  List<Kycs>? kycs;

  factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
    onDuty: json["on_duty"],
    id: json["id"],
    name: json["name"],
    countryCode: json["country_code"],
    mobile: json["mobile"],
    email: json["email"],
    dob: json["dob"],
    secondaryMobile: json["secondary_mobile"],
    cashInHand:json["cash_in_hand"]!=null?double.parse(json["cash_in_hand"].toString()):0.0,
    incentive: double.parse(json["incentive"].toString()),
    profileImg: json["profile_img"],
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
    languages:json["languages"],
    active: json["active"],
    isVerified: json["is_verified"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    token: json["token"],
    tokenType: json["token_type"],
    activeTime: json["active_time"],
    kycs: List<Kycs>.from((json["kyc"]==null)?[]:json["kyc"].map((x)=>Kycs.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "country_code": countryCode,
    "mobile": mobile,
    "email": email,
    "dob": dob,
    "secondary_mobile": secondaryMobile,
    "cash_in_hand": cashInHand,
    "profile_img": profileImg,
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
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "token": token,
    "token_type": tokenType,
    "active_time": activeTime,
    "kyc": List<dynamic>.from(kycs!.map((x) =>x.toJson())),
  };
}

class Kycs {
  Kycs({
    this.id,
    this.driverId,
    this.docType,
    this.status,
    this.createdAt,
    this.updatedAt,
});
  int? id;
  String? driverId;
  String? docType;
  String? status;
  String? createdAt;
  String? updatedAt;

  factory Kycs.fromJson(Map<String ,dynamic>json)=>Kycs(
    id: (json['id']==null)?null:json['id'],
    driverId: (json['driver_id']==null)?null:json['driver_id'],
    docType: (json['doc_type']==null)?null:json['doc_type'],
    status: (json['status']==null)?null:json['status'],
    createdAt: (json['created_at']==null)?null:json['created_at'],
    updatedAt: (json['updated_at']==null)?null:json['updated_at'],
  );
  Map<String ,dynamic> toJson()=>{
    'id':id,
    'driver_id':driverId,
    'doc_type':docType,
    'status':status,
    'created_at':createdAt,
    'updated_at':updatedAt,
  };
}