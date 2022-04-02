
class OrderStatusResponse {
  OrderStatusResponse({
    this.success,
    this.data,
    this.message,
  });

  bool? success;
  Data? data;
  String? message;

  factory OrderStatusResponse.fromJson(Map<String, dynamic> json) => OrderStatusResponse(
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
    this.userId,
    this.storeId,
    this.serviceCategoryId,
    this.pickupFromStore,
    this.couponData,
    this.orderType,
    this.totalPrice,
    this.discountValue,
    this.deliveryFee,
    this.tax,
    this.grandTotal,
    this.tip,
    this.pickupAddress,
    this.deliveryAddress,
    this.distanceTravelled,
    this.travelTime,
    this.preparationTime,
    this.paymentId,
    this.driverId,
    this.orderStatus,
    this.paymentStatus,
    this.paymentMethod,
    this.jsonData,
    this.pickupOtp,
    this.deliveryOtp,
    this.createdAt,
    this.updatedAt,
    this.store,
    this.user,
    this.payment,
    this.driver,
    this.serviceCategory,
    this.statusTimestamps,
    this.items,
  });

  int? id;
  int? userId;
  int? storeId;
  int? serviceCategoryId;
  bool? pickupFromStore;
  CouponData? couponData;
  OrderType? orderType;
  double? totalPrice;
  double? discountValue;
  double? deliveryFee;
  double? tax;
  double? grandTotal;
  double? tip;
  PickupAddress? pickupAddress;
  DeliveryAddress? deliveryAddress;
  double? distanceTravelled;
  double? travelTime;
  double? preparationTime;
  int? paymentId;
  dynamic driverId;
  String? orderStatus;
  String? paymentStatus;
  String? paymentMethod;
  JsonData? jsonData;
  String? pickupOtp;
  String? deliveryOtp;
  DateTime? createdAt;
  DateTime? updatedAt;
  Store? store;
  User? user;
  Payment? payment;
  dynamic driver;
  ServiceCategory? serviceCategory;
  List<StatusTimestamp>? statusTimestamps;
  List<Item>? items;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    userId: json["user_id"],
    storeId: json["store_id"],
    serviceCategoryId: json["service_category_id"],
    pickupFromStore: json["pickup_from_store"],
    couponData:json["coupon_data"]!=null ? CouponData.fromJson(json["coupon_data"]) : null,
    orderType: OrderType.fromJson(json["order_type"]),
    totalPrice: double.parse(json["total_price"].toString()),
    discountValue: double.parse(json["discount_value"].toString()),
    deliveryFee: double.parse(json["delivery_fee"].toString()),
    tax:double.parse(json["tax"].toString()),
    grandTotal: double.parse(json["grand_total"].toString()),
    tip: (json["tip"]!=null)?double.parse(json["tip"].toString()):0.0,
    pickupAddress: PickupAddress.fromJson(json["pickup_address"]),
    deliveryAddress: DeliveryAddress.fromJson(json["delivery_address"]),
    distanceTravelled: (json["distance_travelled"]!=null)?double.parse(json["distance_travelled"].toString()):0.0,
    travelTime: (json["travel_time"]!=null)?double.parse(json["travel_time"].toString()):0.0,
    preparationTime: (json["preparation_time"]!=null)?double.parse(json["preparation_time"].toString()):0.0,
    paymentId: json["payment_id"],
    driverId: json["driver_id"],
    orderStatus: json["order_status"],
    paymentStatus: json["payment_status"],
    paymentMethod: json["payment_method"],
    jsonData: json["json_data"]!=null?JsonData.fromJson(json["json_data"]):null,
    pickupOtp: json["pickup_otp"],
    deliveryOtp: json["delivery_otp"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    store:json["store"]!=null? Store.fromJson(json["store"]):null,
    user: User.fromJson(json["user"]),
    payment: Payment.fromJson(json["payment"]),
    driver: json["driver"],
    serviceCategory: ServiceCategory.fromJson(json["service_category"]),
    statusTimestamps: List<StatusTimestamp>.from(json["status_timestamps"].map((x) => StatusTimestamp.fromJson(x))),
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "store_id": storeId,
    "service_category_id": serviceCategoryId,
    "pickup_from_store": pickupFromStore,
    "coupon_data": couponData!.toJson(),
    "order_type": orderType!.toJson(),
    "total_price": totalPrice,
    "discount_value": discountValue,
    "delivery_fee": deliveryFee,
    "tax": tax,
    "grand_total": grandTotal,
    "tip": tip,
    "pickup_address": pickupAddress!.toJson(),
    "delivery_address": deliveryAddress!.toJson(),
    "distance_travelled": distanceTravelled,
    "travel_time": travelTime,
    "preparation_time": preparationTime,
    "payment_id": paymentId,
    "driver_id": driverId,
    "order_status": orderStatus,
    "payment_status": paymentStatus,
    "payment_method": paymentMethod,
    "json_data": jsonData!.toJson(),
    "pickup_otp": pickupOtp,
    "delivery_otp": deliveryOtp,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "store": store!.toJson(),
    "user": user!.toJson(),
    "payment": payment!.toJson(),
    "driver": driver,
    "service_category": serviceCategory!.toJson(),
    "status_timestamps": List<dynamic>.from(statusTimestamps!.map((x) => x.toJson())),
    "items": List<dynamic>.from(items!.map((x) => x.toJson())),
  };
}

class CouponData {
  CouponData({
    this.id,
    this.storeId,
    this.image,
    this.code,
    this.description,
    this.maxUsePerUser,
    this.minCartValue,
    this.startDate,
    this.endDate,
    this.discountType,
    this.discountValue,
    this.maxDiscountValue,
    this.active,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? storeId;
  String? image;
  String? code;
  String? description;
  int? maxUsePerUser;
  int? minCartValue;
  DateTime? startDate;
  DateTime? endDate;
  String? discountType;
  String? discountValue;
  String? maxDiscountValue;
  bool? active;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory CouponData.fromJson(Map<String, dynamic> json) => CouponData(
    id: json["id"],
    storeId: json["store_id"],
    image: json["image"],
    code: json["code"],
    description: json["description"],
    maxUsePerUser: json["max_use_per_user"],
    minCartValue: json["min_cart_value"],
    startDate: DateTime.parse(json["start_date"]),
    endDate: DateTime.parse(json["end_date"]),
    discountType: json["discount_type"],
    discountValue: json["discount_value"],
    maxDiscountValue: json["max_discount_value"],
    active: json["active"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "store_id": storeId,
    "image": image,
    "code": code,
    "description": description,
    "max_use_per_user": maxUsePerUser,
    "min_cart_value": minCartValue,
    "start_date": startDate!.toIso8601String(),
    "end_date": endDate!.toIso8601String(),
    "discount_type": discountType,
    "discount_value": discountValue,
    "max_discount_value": maxDiscountValue,
    "active": active,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}

class DeliveryAddress {
  DeliveryAddress({
    this.id,
    this.name,
    this.phone,
    this.address,
    this.latitude,
    this.longitude,
    this.houseNo,
    this.building,
  });

  int? id;
  String? name;
  String? phone;
  String? address;
  double? latitude;
  double? longitude;
  String? houseNo;
  String? building;

  factory DeliveryAddress.fromJson(Map<String, dynamic> json) => DeliveryAddress(
    id: json["id"],
    name: json["name"],
    phone: json["phone"],
    address: json["address"],
    latitude: double.parse(json["latitude"].toString()),
    longitude: double.parse(json["longitude"].toString()),
    houseNo: json["house_no"],
    building: json["building"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phone": phone,
    "address": address,
    "latitude": latitude,
    "longitude": longitude,
    "house_no": houseNo,
    "building": building,
  };
}

class Item {
  Item({
    this.id,
    this.orderId,
    this.productName,
    this.productPrice,
    this.discountPrice,
    this.quantity,
    this.variantNames,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? orderId;
  String? productName;
  double? productPrice;
  double? discountPrice;
  int? quantity;
  String? variantNames;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    orderId: json["order_id"],
    productName: json["product_name"],
    productPrice: double.parse(json["product_price"].toString()),
    discountPrice: double.parse(json["product_price"].toString()),
    quantity: json["quantity"],
    variantNames: json["variant_names"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_id": orderId,
    "product_name": productName,
    "product_price": productPrice,
    "discount_price": discountPrice,
    "quantity": quantity,
    "variant_names": variantNames,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}

class JsonData {
  JsonData({
    this.ncd,
    this.anyInstruction,
    this.pickupItems,
    this.pickupImages,
  });

  String? ncd;
  String? anyInstruction;
  dynamic pickupItems;
  List<String>? pickupImages;

  factory JsonData.fromJson(Map<String, dynamic> json) => JsonData(
    ncd: json["NCD"],
    anyInstruction: json["any_instruction"],
    pickupItems: json["pickup_items"]!=null?json["pickup_items"]:"",
    pickupImages: (json["pickup_images"]!=null)?List<String>.from(json["pickup_images"].map((x) => x)):[],
  );

  Map<String, dynamic> toJson() => {
    "NCD": ncd,
    "any_instruction": anyInstruction,
    "pickup_items": pickupItems,
    "pickup_images": List<dynamic>.from(pickupImages!.map((x) => x)),
  };
}

class OrderType {
  OrderType({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  dynamic createdAt;
  dynamic updatedAt;

  factory OrderType.fromJson(Map<String, dynamic> json) => OrderType(
    id: json["id"],
    name: json["name"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

class Payment {
  Payment({
    this.id,
    this.paymentRequestId,
    this.refNo,
    this.userId,
    this.userType,
    this.orderId,
    this.remarks,
    this.paymentMethod,
    this.amount,
    // this.gatewayResponse,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? paymentRequestId;
  String? refNo;
  int? userId;
  String? userType;
  dynamic orderId;
  String? remarks;
  String? paymentMethod;
  int? amount;
  // String? gatewayResponse;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
    id: json["id"],
    paymentRequestId: json["payment_request_id"],
    refNo: json["ref_no"],
    userId: json["user_id"],
    userType: json["user_type"],
    orderId: json["order_id"],
    remarks: json["remarks"],
    paymentMethod: json["payment_method"],
    amount: json["amount"],
    // gatewayResponse: json["gateway_response"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "payment_request_id": paymentRequestId,
    "ref_no": refNo,
    "user_id": userId,
    "user_type": userType,
    "order_id": orderId,
    "remarks": remarks,
    "payment_method": paymentMethod,
    "amount": amount,
    // "gateway_response": gatewayResponse,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}

class PickupAddress {
  PickupAddress({
    this.name,
    this.serviceCategoryId,
    this.mobile,
    this.address,
    this.latitude,
    this.longitude,
  });

  String? name;
  int? serviceCategoryId;
  String? mobile;
  String? address;
  double? latitude;
  double? longitude;

  factory PickupAddress.fromJson(Map<String, dynamic> json) => PickupAddress(
    name: json["name"],
    serviceCategoryId: json["service_category_id"],
    mobile: json["mobile"],
    address: json["address"],
    latitude: double.parse(json["latitude"].toString()),
    longitude: double.parse(json["longitude"].toString()),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "service_category_id": serviceCategoryId,
    "mobile": mobile,
    "address": address,
    "latitude": latitude,
    "longitude": longitude,
  };
}

class ServiceCategory {
  ServiceCategory({
    this.id,
    this.icon,
    this.bgImage,
    this.homeView,
    this.name,
    this.description,
    this.serviceTypeId,
    this.discount,
    this.commission,
    this.minPrice,
    this.driverRadius,
    this.baseDistance,
    this.basePrice,
    this.baseKm,
    this.priceKm,
    this.maxOrderDistance,
    this.active,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? icon;
  String? bgImage;
  String? homeView;
  String? name;
  String? description;
  int? serviceTypeId;
  int? discount;
  int? commission;
  String? minPrice;
  String? driverRadius;
  dynamic baseDistance;
  dynamic basePrice;
  dynamic baseKm;
  dynamic priceKm;
  int? maxOrderDistance;
  bool? active;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory ServiceCategory.fromJson(Map<String, dynamic> json) => ServiceCategory(
    id: json["id"],
    icon: json["icon"],
    bgImage: json["bg_image"],
    homeView: json["home_view"],
    name: json["name"],
    description: json["description"],
    serviceTypeId: json["service_type_id"],
    discount: json["discount"],
    commission: json["commission"],
    minPrice: json["min_price"],
    driverRadius: json["driver_radius"],
    baseDistance: json["base_distance"],
    basePrice: json["base_price"],
    baseKm: json["base_km"],
    priceKm: json["price_km"],
    maxOrderDistance: json["max_order_distance"],
    active: json["active"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "icon": icon,
    "bg_image": bgImage,
    "home_view": homeView,
    "name": name,
    "description": description,
    "service_type_id": serviceTypeId,
    "discount": discount,
    "commission": commission,
    "min_price": minPrice,
    "driver_radius": driverRadius,
    "base_distance": baseDistance,
    "base_price": basePrice,
    "base_km": baseKm,
    "price_km": priceKm,
    "max_order_distance": maxOrderDistance,
    "active": active,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}

class StatusTimestamp {
  StatusTimestamp({
    this.id,
    this.orderId,
    this.status,
    this.comment,
    this.createdAt,
  });

  int? id;
  int? orderId;
  String? status;
  String? comment;
  DateTime? createdAt;

  factory StatusTimestamp.fromJson(Map<String, dynamic> json) => StatusTimestamp(
    id: json["id"],
    orderId: json["order_id"],
    status: json["status"],
    comment: json["comment"] ?? "",
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_id": orderId,
    "status": status,
    "comment": comment == null ? null : comment,
    "created_at": createdAt!.toIso8601String(),
  };
}

class Store {
  Store({
    this.id,
    this.adminId,
    this.serviceCategoryId,
    this.storeCategories,
    this.name,
    this.description,
    this.image,
    this.latitude,
    this.longitude,
    this.address,
    this.deliveryRange,
    this.baseDistance,
    this.basePrice,
    this.pricePerKm,
    this.mobile,
    this.email,
    this.orderCount,
    this.gstDoc,
    this.panDoc,
    this.foodLicense,
    this.shopPhoto,
    this.commission,
    this.tax,
    this.isOpen,
    this.active,
    this.paymentMethods,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? adminId;
  int? serviceCategoryId;
  String? storeCategories;
  String? name;
  String? description;
  String? image;
  String? latitude;
  String? longitude;
  String? address;
  int? deliveryRange;
  dynamic baseDistance;
  dynamic basePrice;
  dynamic pricePerKm; //yha error ayega
  String? mobile;
  String? email;
  int? orderCount;
  dynamic gstDoc;
  dynamic panDoc;
  dynamic foodLicense;
  dynamic shopPhoto;
  double? commission;
  double? tax;
  bool? isOpen;
  bool? active;
  String? paymentMethods;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Store.fromJson(Map<String, dynamic> json) => Store(
    id: json["id"],
    adminId: json["admin_id"],
    serviceCategoryId: json["service_category_id"],
    storeCategories: json["store_categories"],
    name: json["name"],
    description: json["description"],
    image: json["image"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    address: json["address"],
    deliveryRange: json["delivery_range"],
    baseDistance: json["base_distance"],
    basePrice: json["base_price"],
    pricePerKm: json["price_per_km"],
    mobile: json["mobile"],
    email: json["email"],
    orderCount: json["order_count"],
    gstDoc: json["gst_doc"],
    panDoc: json["pan_doc"],
    foodLicense: json["food_license"],
    shopPhoto: json["shop_photo"],
    commission: json["commission"].toDouble(),
    tax: json["tax"].toDouble(),
    isOpen: json["is_open"],
    active: json["active"],
    paymentMethods: json["payment_methods"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "admin_id": adminId,
    "service_category_id": serviceCategoryId,
    "store_categories": storeCategories,
    "name": name,
    "description": description,
    "image": image,
    "latitude": latitude,
    "longitude": longitude,
    "address": address,
    "delivery_range": deliveryRange,
    "base_distance": baseDistance,
    "base_price": basePrice,
    "price_per_km": pricePerKm,
    "mobile": mobile,
    "email": email,
    "order_count": orderCount,
    "gst_doc": gstDoc,
    "pan_doc": panDoc,
    "food_license": foodLicense,
    "shop_photo": shopPhoto,
    "commission": commission,
    "tax": tax,
    "is_open": isOpen,
    "active": active,
    "payment_methods": paymentMethods,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}

class User {
  User({
    this.id,
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
    this.updatedAt,
  });

  int? id;
  String? name;
  String? countryCode;
  String? mobile;
  dynamic email;
  double? walletAmount;
  dynamic profileImg;
  String? fcmToken;
  dynamic lat;
  dynamic long;
  bool? status;
  String? refCode;
  dynamic refBy;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    countryCode: json["country_code"],
    mobile: json["mobile"],
    email: json["email"],
    walletAmount: (json['wallet_amount']==null)?0:double.parse(json['wallet_amount'].toString()),
    profileImg: json["profile_img"],
    fcmToken: json["fcm_token"],
    lat: json["lat"],
    long: json["long"],
    status: json["status"],
    refCode: json["ref_code"],
    refBy: json["ref_by"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "country_code": countryCode,
    "mobile": mobile,
    "email": email,
    "wallet_amount": walletAmount,
    "profile_img": profileImg,
    "fcm_token": fcmToken,
    "lat": lat,
    "long": long,
    "status": status,
    "ref_code": refCode,
    "ref_by": refBy,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}
