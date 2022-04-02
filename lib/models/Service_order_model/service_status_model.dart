class ServiceStatusResponse {
  bool? success;
  Data? data;
  String? message;

  ServiceStatusResponse({this.success, this.data, this.message});

  ServiceStatusResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int? id;
  int? userId;
  int? vendorId;
  int? serviceCategoryId;
  dynamic? couponData;
  String? orderType;
  int? totalPrice;
  int? discountValue;
  double? tax;
  double? grandTotal;
  dynamic? serviceAddress;
  int? timeslotsId;
  String? serviceDate;
  String? serviceTime;
  dynamic? distanceTravelled;
  int? paymentId;
  String? paymentStatus;
  String? orderStatus;
  String? paymentMethod;
  dynamic? jsonData;
  String? deliveryOtp;
  double? adminCommission;
  double? driverCommission;
  String? createdAt;
  String? updatedAt;
  Service? service;
  User? user;
  int? driverId;
  ServiceCategory? serviceCategory;

  Data(
      {this.id,
        this.userId,
        this.vendorId,
        this.serviceCategoryId,
        this.couponData,
        this.orderType,
        this.totalPrice,
        this.discountValue,
        this.tax,
        this.grandTotal,
        this.serviceAddress,
        this.timeslotsId,
        this.serviceDate,
        this.serviceTime,
        this.distanceTravelled,
        this.paymentId,
        this.paymentStatus,
        this.orderStatus,
        this.paymentMethod,
        this.jsonData,
        this.deliveryOtp,
        this.adminCommission,
        this.driverCommission,
        this.createdAt,
        this.updatedAt,
        this.service,
        this.user,
        this.driverId,
        this.serviceCategory});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    vendorId = json['vendor_id'];
    serviceCategoryId = json['service_category_id'];
    couponData = json['coupon_data'];
    orderType = json['order_type'];
    totalPrice = json['total_price'];
    discountValue = json['discount_value'];
    tax = json['tax']==null?0.0:double.parse(json['tax'].toString());
    grandTotal = json['grand_total']==null?0.0:double.parse(json['tax'].toString());
    serviceAddress = json['service_address'];
    timeslotsId = json['timeslots_id'];
    serviceDate = json['service_date'];
    serviceTime = json['service_time'];
    distanceTravelled = json['distance_travelled'];
    paymentId = json['payment_id'];
    paymentStatus = json['payment_status'];
    orderStatus = json['order_status'];
    paymentMethod = json['payment_method'];
    jsonData = json['json_data'];
    deliveryOtp = json['delivery_otp'];
    adminCommission = (json['admin_commission']==null)?0.0:double.parse(json['admin_commission'].toString());
    driverCommission = json['driver_commission']==null?0.0:double.parse(json['driver_commission'].toString());
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    service =
    json['service'] != null ? new Service.fromJson(json['service']) : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    driverId = json['driver_id'];
    serviceCategory = json['service_category'] != null
        ? new ServiceCategory.fromJson(json['service_category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['vendor_id'] = this.vendorId;
    data['service_category_id'] = this.serviceCategoryId;
    data['coupon_data'] = this.couponData;
    data['order_type'] = this.orderType;
    data['total_price'] = this.totalPrice;
    data['discount_value'] = this.discountValue;
    data['tax'] = this.tax;
    data['grand_total'] = this.grandTotal;
    data['service_address'] = this.serviceAddress;
    data['timeslots_id'] = this.timeslotsId;
    data['service_date'] = this.serviceDate;
    data['service_time'] = this.serviceTime;
    data['distance_travelled'] = this.distanceTravelled;
    data['payment_id'] = this.paymentId;
    data['payment_status'] = this.paymentStatus;
    data['order_status'] = this.orderStatus;
    data['payment_method'] = this.paymentMethod;
    data['json_data'] = this.jsonData;
    data['delivery_otp'] = this.deliveryOtp;
    data['admin_commission'] = this.adminCommission;
    data['driver_commission'] = this.driverCommission;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.service != null) {
      data['service'] = this.service!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['driver_id'] = this.driverId;
    if (this.serviceCategory != null) {
      data['service_category'] = this.serviceCategory!.toJson();
    }
    return data;
  }
}

class Service {
  int? id;
  String? name;
  String? description;
  String? shortDescription;
  String? image;
  int? homeServiceCategoryId;
  int? originalPrice;
  int? discountPrice;
  String? createdAt;
  String? updatedAt;

  Service(
      {this.id,
        this.name,
        this.description,
        this.shortDescription,
        this.image,
        this.homeServiceCategoryId,
        this.originalPrice,
        this.discountPrice,
        this.createdAt,
        this.updatedAt});

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    shortDescription = json['short_description'];
    image = json['image'];
    homeServiceCategoryId = json['home_service_category_id'];
    originalPrice = json['original_price'];
    discountPrice = json['discount_price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['short_description'] = this.shortDescription;
    data['image'] = this.image;
    data['home_service_category_id'] = this.homeServiceCategoryId;
    data['original_price'] = this.originalPrice;
    data['discount_price'] = this.discountPrice;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? countryCode;
  String? mobile;
  String? email;
  double? walletAmount;
  String? profileImg;
  String? fcmToken;
  double? lat;
  double? long;
  bool? status;
  String? refCode;
  String? refBy;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
        this.name,
        this.countryCode,
        this.mobile,
        this.email,
        this.walletAmount,
        this.profileImg,
        this.fcmToken,
        this.lat,
        this.long,
        this.status,
        this.refCode,
        this.refBy,
        this.createdAt,
        this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    countryCode = json['country_code'];
    mobile = json['mobile'];
    email = json['email'];
    walletAmount = json['wallet_amount']==null?0.0:double.parse(json['wallet_amount'].toString());
    profileImg = json['profile_img'];
    fcmToken = json['fcm_token'];
    lat = json['lat'];
    long = json['long'];
    status = json['status'];
    refCode = json['ref_code'];
    refBy = json['ref_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['country_code'] = this.countryCode;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['wallet_amount'] = this.walletAmount;
    data['profile_img'] = this.profileImg;
    data['fcm_token'] = this.fcmToken;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['status'] = this.status;
    data['ref_code'] = this.refCode;
    data['ref_by'] = this.refBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class ServiceCategory {
  String? id;
  String? name;
  String? icon;
  String? backgroundImage;
  int? parent;
  double? tax;
  String? createdAt;
  String? updatedAt;

  ServiceCategory(
      {this.id,
        this.name,
        this.icon,
        this.backgroundImage,
        this.parent,
        this.tax,
        this.createdAt,
        this.updatedAt});

  ServiceCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'];
    backgroundImage = json['background_image'];
    parent = json['parent'];
    tax = json['tax']==null?0.0:double.parse(json['tax'].toString());
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['icon'] = this.icon;
    data['background_image'] = this.backgroundImage;
    data['parent'] = this.parent;
    data['tax'] = this.tax;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
