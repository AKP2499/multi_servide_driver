

class SettingResponse {
  SettingResponse({
    this.success,
    this.data,
    this.message,
  });

  bool? success;
  Data? data;
  String? message;

  factory SettingResponse.fromJson(Map<String, dynamic> json) => SettingResponse(
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
    this.appName,
    this.appDescription,
    this.taxPercentage,
    this.razorpayKey,
    this.aboutUs,
    this.privacyPolicy,
    this.refundPolicy,
    this.referalAmount,
    this.referalOrderCount,
    this.driverBootcashLimit,
    this.orderPolicy,
    this.termsConditions,
    this.iosVersion,
    this.androidVersion,
    this.iosForceUpdate,
    this.androidForceUpdate,
    this.maintainenceMode,
    this.findDriverInRadius,
    this.deliveryFeeCommission,
    this.tipCommission,
    this.vendorIosVersion,
    this.vendorAndroidVersion,
    this.vendorIosForceUpdate,
    this.vendorAndroidForceUpdate,
    this.contactPhone,
    this.contactEmail,
    this.driverIncentivePerHour,
    this.minHourForIncentive,
    this.driverAndroidVersion,
    this.homeServiceBooking,

  });

  String? appName;
  String? appDescription;
  String? taxPercentage;
  String? razorpayKey;
  String? aboutUs;
  String? privacyPolicy;
  String? refundPolicy;
  String? referalAmount;
  String? referalOrderCount;
  double? driverBootcashLimit;
  String? orderPolicy;
  String? termsConditions;
  String? iosVersion;
  String? androidVersion;
  String? iosForceUpdate;
  String? androidForceUpdate;
  String? maintainenceMode;
  String? findDriverInRadius;
  String? deliveryFeeCommission;
  String? tipCommission;
  String? vendorIosVersion;
  String? vendorAndroidVersion;
  String? vendorIosForceUpdate;
  String? vendorAndroidForceUpdate;
  String? contactPhone;
  String? contactEmail;
  String? driverIncentivePerHour;
  String? minHourForIncentive;
  String? driverAndroidVersion;
  bool? homeServiceBooking;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    appName: json["app_name"],
    appDescription: json["app_description"],
    taxPercentage: json["tax_percentage"],
    razorpayKey: json["razorpay_key"],
    aboutUs: json["about_us"],
    privacyPolicy: json["privacy_policy"],
    refundPolicy: json["refund_policy"],
    referalAmount: json["referal_amount"],
    referalOrderCount: json["referal_order_count"],
    driverBootcashLimit: json["driver_bootcash_limit"]!=null?double.parse(json["driver_bootcash_limit"].toString()):0.0,
    orderPolicy: json["order_policy"],
    termsConditions: json["terms_&_conditions"],
    iosVersion: json["ios_version"],
    androidVersion: json["android_version"],
    iosForceUpdate: json["ios_force_update"],
    androidForceUpdate: json["android_force_update"],
    maintainenceMode: json["maintenance_mode"],
    findDriverInRadius: json["find_driver_in_radius"],
    deliveryFeeCommission: json["delivery_fee_commission"],
    tipCommission: json["tip_commission"],
    vendorIosVersion: json["vendor_ios_version"],
    vendorAndroidVersion: json["vendor_android_version"],
    vendorIosForceUpdate: json["vendor_ios_force_update"],
    vendorAndroidForceUpdate: json["vendor_android_force_update"],
    contactPhone: json["contact_phone"],
    contactEmail: json["contact_email"],
    driverIncentivePerHour: json["driver_incentive_per_hour"],
    minHourForIncentive: json["min_hours_for_incentive"],
    driverAndroidVersion: json["driver_android_version"],
    homeServiceBooking: json['home_service_booking'],
  );

  Map<String, dynamic> toJson() => {
    "app_name": appName,
    "app_description": appDescription,
    "tax_percentage": taxPercentage,
    "razorpay_key": razorpayKey,
    "about_us": aboutUs,
    "privacy_policy": privacyPolicy,
    "refund_policy": refundPolicy,
    "referal_amount": referalAmount,
    "referal_order_count": referalOrderCount,
    "driver_bootcash_limit": driverBootcashLimit,
    "order_policy": orderPolicy,
    "terms_&_conditions": termsConditions,
    "ios_version": iosVersion,
    "android_version": androidVersion,
    "ios_force_update": iosForceUpdate,
    "android_force_update": androidForceUpdate,
    "maintainence_mode": maintainenceMode,
    "find_driver_in_radius": findDriverInRadius,
    "delivery_fee_commission": deliveryFeeCommission,
    "tip_commission": tipCommission,
    "vendor_ios_version": vendorIosVersion,
    "vendor_android_version": vendorAndroidVersion,
    "vendor_ios_force_update": vendorIosForceUpdate,
    "vendor_android_force_update": vendorAndroidForceUpdate,
    "contact_phone": contactPhone,
    "contact_email": contactEmail,
    "driver_incentive_per_hour":driverIncentivePerHour,
    "min_hours_for_incentive":minHourForIncentive,
    "driver_android_version":driverAndroidVersion,
    "home_service_booking":homeServiceBooking,
  };
}
