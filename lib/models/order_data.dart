import 'dart:convert';

import 'order_details_response.dart';


class OrderData {
  OrderData({
    this.id,
    this.userId,
    this.storeId,
    this.serviceCategoryId,
    this.pickupFromStore,
    // this.couponData,
    // this.orderType,
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
    this.driverCommission,
  });

  int? id;
  int? userId;
  int? storeId;
  int? serviceCategoryId;
  bool? pickupFromStore;
  // CouponData? couponData;
  // dynamic orderType;
  // OrderType? orderType;
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
  dynamic paymentId;
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
  dynamic payment;
  dynamic driver;
  ServiceCategory? serviceCategory;
  List<StatusTimestamp>? statusTimestamps;
  List<Item>? items;
  double? driverCommission;


  factory OrderData.fromJson(Map<String, dynamic> json) => OrderData(
    id: json["id"],
    userId: json["user_id"],
    storeId: json["store_id"],
    serviceCategoryId: json["service_category_id"],
    pickupFromStore: json["pickup_from_store"],
    // couponData:json["coupon_data"]!=null? CouponData.fromJson(json["coupon_data"]):null,
    // orderType: OrderType.fromJson(json["order_type"]),
    totalPrice: json["total_price"]!=null?double.parse(json["total_price"].toString()):0.0,
    discountValue: json["discount_value"]!=null?double.parse(json["discount_value"].toString()):0.0,
    deliveryFee:json["delivery_fee"]!=null? double.parse(json["delivery_fee"].toString()):0.0,
    tax:json["tax"]!=null?double.parse(json["tax"].toString()):0.0,
    grandTotal: json["grand_total"]!=null?double.parse(json["grand_total"].toString()):0.0,
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
    user: json["user"]!=null?User.fromJson(json["user"]):User(),
    payment:json["payment"],
    driver: json["driver"],
    serviceCategory: json["service_category"] == null ? null : ServiceCategory.fromJson(json["service_category"]),
    statusTimestamps:json["status_timestamps"]==null?null:List<StatusTimestamp>.from(json["status_timestamps"].map((x) => StatusTimestamp.fromJson(x))),

    items: json["items"]==null?null:List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    driverCommission: json["driver_commission"]!=null?json["driver_commission"].toDouble():0.0,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "store_id": storeId,
    "service_category_id": serviceCategoryId,
    "pickup_from_store": pickupFromStore,
    // "coupon_data": couponData!.toJson(),
    // "order_type": orderType!.toJson(),
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
    "driver_commission": driverCommission,
  };
}
