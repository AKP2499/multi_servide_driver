
import 'package:dunzodriver_copy1/models/order_data.dart';
import 'package:dunzodriver_copy1/models/order_details_response.dart';
import 'package:dunzodriver_copy1/models/ordermodels/order_model.dart';

class OrderDetails{
  OrderDetails({
    this.success,
    this.data,
    this.message,
  });

  bool? success;
  OrderData? data;
  String? message;

  factory OrderDetails.fromJson(Map<String, dynamic> json) => OrderDetails(
    success: json["success"],
    data:json["data"]!=null? OrderData.fromJson(json["data"]):null,
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
    this.adminCommission,
    this.driverCommission,
    this.storeCommission,
    this.createdAt,
    this.updatedAt,
    this.store,
    this.user,
    this.payment,
    this.driver,
  });

  int? id;
  int? userId;
  int? storeId;
  int? serviceCategoryId;
  bool? pickupFromStore;
  dynamic couponData;
  OrderType? orderType;
  double? totalPrice;
  double? discountValue;
  double? deliveryFee;
  double? tax;
  double? grandTotal;
  int? tip;
  PickupAddress? pickupAddress;
  dynamic deliveryAddress;
  double? distanceTravelled;
  dynamic travelTime;
  dynamic preparationTime;
  dynamic paymentId;
  dynamic driverId;
  String? orderStatus;
  String? paymentStatus;
  String? paymentMethod;
  dynamic jsonData;
  dynamic pickupOtp;
  dynamic deliveryOtp;
  double? adminCommission;
  double? driverCommission;
  double? storeCommission;
  DateTime? createdAt;
  DateTime? updatedAt;
  Store? store;
  User? user;
  dynamic payment;
  dynamic driver;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    userId: json["user_id"],
    storeId: json["store_id"],
    serviceCategoryId: json["service_category_id"],
    pickupFromStore: json["pickup_from_store"],
    couponData: json["coupon_data"],
    orderType: OrderType.fromJson(json["order_type"]),
    totalPrice: json["total_price"]!=null?json["total_price"].toDouble():0.0,
    discountValue: json["discount_value"]!=null?json["discount_value"].toDouble():0.0,
    deliveryFee: json["delivery_fee"]!=null?json["delivery_fee"].toDouble():0.0,
    tax: json["tax"]!=null?json["tax"].toDouble():0.0,
    grandTotal: json["grand_total"]!=null?json["grand_total"].toDouble():0.0,
    tip: json["tip"],
    pickupAddress: PickupAddress.fromJson(json["pickup_address"]),
    deliveryAddress: Delivery_address.fromJson(json["delivery_address"]),
    distanceTravelled: json["distance_travelled"]!=null?json["distance_travelled"].toDouble():0.0,
    travelTime: json["travel_time"],
    preparationTime: json["preparation_time"],
    paymentId: json["payment_id"],
    driverId: json["driver_id"],
    orderStatus: json["order_status"],
    paymentStatus: json["payment_status"],
    paymentMethod: json["payment_method"],
    jsonData: json["json_data"],
    pickupOtp: json["pickup_otp"],
    deliveryOtp: json["delivery_otp"],
    adminCommission: json["admin_commission"]!=null?json["admin_commission"].toDouble():0.0,
    driverCommission: json["driver_commission"]!=null?json["driver_commission"].toDouble():0.0,
    storeCommission: json["store_commission"]!=null?json["store_commission"].toDouble():0.0,
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    store: (json["store"] == null)?null:Store.fromJson(json["store"]),
    user: User.fromJson(json["user"]),
    payment: json["payment"],
    driver: json["driver"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "store_id": storeId,
    "service_category_id": serviceCategoryId,
    "pickup_from_store": pickupFromStore,
    "coupon_data": couponData,
    "order_type": orderType!.toJson(),
    "total_price": totalPrice,
    "discount_value": discountValue,
    "delivery_fee": deliveryFee,
    "tax": tax,
    "grand_total": grandTotal,
    "tip": tip,
    "pickup_address": pickupAddress,
    "delivery_address": deliveryAddress,
    "distance_travelled": distanceTravelled,
    "travel_time": travelTime,
    "preparation_time": preparationTime,
    "payment_id": paymentId,
    "driver_id": driverId,
    "order_status": orderStatus,
    "payment_status": paymentStatus,
    "payment_method": paymentMethod,
    "json_data": jsonData,
    "pickup_otp": pickupOtp,
    "delivery_otp": deliveryOtp,
    "admin_commission": adminCommission,
    "driver_commission": driverCommission,
    "store_commission": storeCommission,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "store": store!.toJson(),
    "user": user!.toJson(),
    "payment": payment,
    "driver": driver,
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
  String? mobile;
  String? email;
  int? orderCount;
  dynamic gstDoc;
  dynamic panDoc;
  dynamic foodLicense;
  dynamic shopPhoto;
  int? commission;
  int? tax;
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
    mobile: json["mobile"],
    email: json["email"],
    orderCount: json["order_count"],
    gstDoc: json["gst_doc"],
    panDoc: json["pan_doc"],
    foodLicense: json["food_license"],
    shopPhoto: json["shop_photo"],
    commission: json["commission"],
    tax: json["tax"],
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
  int? walletAmount;
  dynamic profileImg;
  String? fcmToken;
  dynamic lat;
  dynamic long;
  bool? status;
  dynamic refCode;
  dynamic refBy;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    countryCode: json["country_code"],
    mobile: json["mobile"],
    email: json["email"],
    walletAmount: json["wallet_amount"],
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
