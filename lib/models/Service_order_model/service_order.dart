
class ServiceResponse {
  bool? success;
  Data? data;
  String? message;

  ServiceResponse({this.success, this.data, this.message});

  ServiceResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
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
  int? currentPage;
  List<ServiceData>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  Data(
      {this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.links,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <ServiceData>[];
      json['data'].forEach((v) {
        data!.add(new ServiceData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class ServiceData {
  int? id;
  int? userId;
  int? vendorId;
  int? serviceCategoryId;
  dynamic? couponData;
  // String? orderType;
  int? totalPrice;
  int? discountValue;
  double? tax;
  double? grandTotal;
  ServiceAddress? serviceAddress;
  int? timeslotsId;
  String? serviceDate;
  String? serviceTime;
  double? distanceTravelled;
  int? paymentId;
  String? paymentStatus;
  String? orderStatus;
  String? paymentMethod;
  dynamic? jsonData;
  String? deliveryOtp;
  String? startOtp;
  double? adminCommission;
  double? driverCommission;
  String? createdAt;
  String? updatedAt;
  User? user;
  int? driverId;
  ServiceCategory? serviceCategory;
  List<Items>? items;

  ServiceData(
      {this.id,
        this.userId,
        this.vendorId,
        this.serviceCategoryId,
        this.couponData,
        // this.orderType,
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
        this.startOtp,
        this.adminCommission,
        this.driverCommission,
        this.createdAt,
        this.updatedAt,
        this.user,
        this.driverId,
        this.serviceCategory,
        this.items});

  ServiceData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    vendorId = json['vendor_id'];
    serviceCategoryId = json['service_category_id'];
    couponData = json['coupon_data'];
    // orderType = json['order_type'];
    totalPrice = json['total_price'];
    discountValue = json['discount_value'];
    tax = json["tax"]!=null?double.parse(json["tax"].toString()):0.0;
    grandTotal = json['grand_total']!=null?double.parse(json['tax'].toString()):0.0;
    serviceAddress = json['service_address'] != null
        ? new ServiceAddress.fromJson(json['service_address'])
        : null;
    timeslotsId = json['timeslots_id'];
    serviceDate = json['service_date'];
    serviceTime = json['service_time'];
    distanceTravelled =((json["distance_travelled"]!=null)?double.parse(json["distance_travelled"].toString()):0.0);
    paymentId = json['payment_id'];
    paymentStatus = json['payment_status'];
    orderStatus = json['order_status'];
    paymentMethod = json['payment_method'];
    jsonData = json['json_data'];
    deliveryOtp = json['delivery_otp'];
    startOtp=json['start_otp'];
    adminCommission = (json['admin_commission'] == null)?0.0:double.parse(json['admin_commission'].toString());
    driverCommission =(json['driver_commission']==null)?0.0:double.parse(json['driver_commission'].toString());
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    driverId = json['driver_id'];
    serviceCategory = json['service_category'] != null
        ? new ServiceCategory.fromJson(json['service_category'])
        : null;
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['vendor_id'] = this.vendorId;
    data['service_category_id'] = this.serviceCategoryId;
    data['coupon_data'] = this.couponData;
    // data['order_type'] = this.orderType;
    data['total_price'] = this.totalPrice;
    data['discount_value'] = this.discountValue;
    data['tax'] = this.tax;
    data['grand_total'] = this.grandTotal;
    if (this.serviceAddress != null) {
      data['service_address'] = this.serviceAddress!.toJson();
    }
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
    data['start_otp']=this.startOtp;
    data['admin_commission'] = this.adminCommission;
    data['driver_commission'] = this.driverCommission;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['driver'] = this.driverId;
    if (this.serviceCategory != null) {
      data['service_category'] = this.serviceCategory!.toJson();
    }
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ServiceAddress {
  int? userId;
  String? name;
  String? phone;
  String? address;
  double? latitude;
  double? longitude;
  String? houseNo;
  String? building;
  String? type;
  String? description;

  ServiceAddress(
      {this.userId,
        this.name,
        this.phone,
        this.address,
        this.latitude,
        this.longitude,
        this.houseNo,
        this.building,
        this.type,
        this.description});

  ServiceAddress.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    name = json['name'];
    phone = json['phone'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    houseNo = json['house_no'];
    building = json['building'];
    type = json['type'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['house_no'] = this.houseNo;
    data['building'] = this.building;
    data['type'] = this.type;
    data['description'] = this.description;
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
    walletAmount = (json['wallet_amount']==null)?0.0:double.parse(json['wallet_amount'].toString());
    profileImg = json['profile_img'];
    fcmToken = json['fcm_token'];
    lat = json['lat'];
    long = json['long'];
    status = json['status'];
    refCode = json['ref_code'];
    refBy = json['ref_by'].toString();
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
    tax = json["tax"]!=null?double.parse(json["tax"].toString()):0.0;
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

class Items {
  int? id;
  int? serviceOrderId;
  String? serviceName;
  int? servicePrice;
  int? discountPrice;
  int? quantity;
  String? createdAt;
  String? updatedAt;

  Items(
      {this.id,
        this.serviceOrderId,
        this.serviceName,
        this.servicePrice,
        this.discountPrice,
        this.quantity,
        this.createdAt,
        this.updatedAt});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceOrderId = json['service_order_id'];
    serviceName = json['service_name'];
    servicePrice = json['service_price'];
    discountPrice = json['discount_price'];
    quantity = json['quantity'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['service_order_id'] = this.serviceOrderId;
    data['service_name'] = this.serviceName;
    data['service_price'] = this.servicePrice;
    data['discount_price'] = this.discountPrice;
    data['quantity'] = this.quantity;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}