

import 'order_data.dart';

class OrderDetailsResponse {
  OrderDetailsResponse({
    this.success,
    this.data,
    this.message,
  });

  bool? success;
  Data? data;
  String? message;

  factory OrderDetailsResponse.fromJson(Map<String, dynamic> json) => OrderDetailsResponse(
    success: json["success"],
    data: Data.fromJson(json["data"]),
    message:(json["message"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data!.toJson(),
    "message": message,
  };
}

class Data {
  Data({
    this.currentPage,
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
    this.total,
  });

  int? currentPage;
  List<OrderData>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    currentPage: json["current_page"],
    data: List<OrderData>.from(json["data"].map((x) => OrderData.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": List<dynamic>.from(links!.map((x) => x.toJson())),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
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
  // DeliveryAddressName? name;
  String? name;
  String? phone;
  String? address;
  dynamic latitude;
  dynamic longitude;
  String? houseNo;
  String? building;

  factory DeliveryAddress.fromJson(Map<String, dynamic> json) => DeliveryAddress(
    id: json["id"],
    // name: json["name"] == null ? null : deliveryAddressNameValues.map![json["name"]],
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
    // "name": name == null ? null : deliveryAddressNameValues.reverse![name],
    "name": name,
    "phone": phone,
    "address": address,
    "latitude": latitude,
    "longitude": longitude,
    "house_no": houseNo,
    "building": building,
  };
}

enum DeliveryAddressName { DOLOREMQUE, TARUN_PAL }

final deliveryAddressNameValues = EnumValues({
  "doloremque": DeliveryAddressName.DOLOREMQUE,
  "Tarun Pal": DeliveryAddressName.TARUN_PAL
});

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
    this.image
  });

  int? id;
  int? orderId;
  String? productName;
  int? productPrice;
  int? discountPrice;
  int? quantity;
  String? variantNames;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    orderId: json["order_id"],
    productName: json["product_name"],
    productPrice: json["product_price"],
    discountPrice: json["discount_price"],
    quantity: json["quantity"],
    variantNames: json["variant_names"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    image: json['product_image']
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
    this.packageContentList,
    this.itemList,
    this.orderedItems,
  });

  String? ncd;
  String? anyInstruction;
  String? packageContentList;
  String? itemList;
  List<String>?orderedItems;

  factory JsonData.fromJson(Map<String, dynamic> json) => JsonData(
    ncd: json["NCD"],
    anyInstruction: json["any_instruction"],
    packageContentList: json["package_content_list"] ?? "",
    itemList: json["item_list"] ?? "",
    orderedItems:json["ordered_items"]!=null?List<String>.from(json["ordered_items"].map((x)=>x)):[],
  );

  Map<String, dynamic> toJson() => {
    "NCD": ncd,
    "any_instruction": anyInstruction,
    "package_content_list": packageContentList,
    "item_list": itemList,
    "ordered_items":List<dynamic>.from(orderedItems!.map((x) => x)),
  };
}

enum Status { PREPARED, PLACED, ACCEPTED ,DELIVERED,PICKEDUP,ASSIGNED,REACHED}

final statusValues = EnumValues({
  "ACCEPTED": Status.ACCEPTED,
  "PLACED": Status.PLACED,
  "DELIVERED":Status.DELIVERED,
  "PREPARED": Status.PREPARED,
  "PICKEDUP": Status.PICKEDUP,
  "ASSIGNED": Status.ASSIGNED,
  "REACHED":Status.REACHED,

});

class OrderType {
  OrderType({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  OrderTypeName? name;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory OrderType.fromJson(Map<String, dynamic> json) => OrderType(
    id: json["id"],
    name: orderTypeNameValues.map![json["name"]],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": orderTypeNameValues.reverse![name],
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
  };
}

enum OrderTypeName { PURCHASING_SERVICE, PICK_DROP, ORDER_ANYTHING }

final orderTypeNameValues = EnumValues({
  "Order Anything": OrderTypeName.ORDER_ANYTHING,
  "Pick & Drop": OrderTypeName.PICK_DROP,
  "Purchasing Service": OrderTypeName.PURCHASING_SERVICE
});

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
    this.gatewayResponse,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  dynamic paymentRequestId;
  String? refNo;
  int? userId;
  UserType? userType;
  dynamic orderId;
  Remarks? remarks;
  PaymentMethod? paymentMethod;
  int? amount;
  String? gatewayResponse;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
    id: json["id"],
    paymentRequestId: json["payment_request_id"],
    refNo: json["ref_no"],
    userId: json["user_id"],
    userType: userTypeValues.map![json["user_type"]],
    orderId: json["order_id"],
    remarks: remarksValues.map![json["remarks"]],
    paymentMethod: paymentMethodValues.map![json["payment_method"]],
    amount: json["amount"],
    gatewayResponse: json["gateway_response"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "payment_request_id": paymentRequestId,
    "ref_no": refNo,
    "user_id": userId,
    "user_type": userTypeValues.reverse![userType],
    "order_id": orderId,
    "remarks": remarksValues.reverse![remarks],
    "payment_method": paymentMethodValues.reverse![paymentMethod],
    "amount": amount,
    "gateway_response": gatewayResponse,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}

enum PaymentMethod { COD }

final paymentMethodValues = EnumValues({
  "COD": PaymentMethod.COD
});

enum Remarks { ORDER_PLACED_USING_COD }

final remarksValues = EnumValues({
  "Order placed using COD": Remarks.ORDER_PLACED_USING_COD
});

enum UserType { APP_MODELS_USER }

final userTypeValues = EnumValues({
  "App\\Models\\User": UserType.APP_MODELS_USER
});

enum PaymentStatus { PENDING }

final paymentStatusValues = EnumValues({
  "PENDING": PaymentStatus.PENDING
});

class PickupAddress {
  PickupAddress({
    this.name,
    this.serviceCategoryId,
    this.mobile,
    this.address,
    this.latitude,
    this.longitude,
    this.id,
    this.userId,
    this.phone,
    this.houseNo,
    this.building,
    this.type,
    this.description,
    this.isDefault,
    this.createdAt,
    this.updatedAt,
  });

  String? name;
  int? serviceCategoryId;
  String? mobile;
  String? address;
  dynamic latitude;
  dynamic longitude;
  int? id;
  int? userId;
  String? phone;
  String? houseNo;
  String? building;
  String? type;
  String? description;
  bool? isDefault;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory PickupAddress.fromJson(Map<String, dynamic> json) => PickupAddress(
    name: json["name"],
    serviceCategoryId: json["service_category_id"],
    mobile: json["mobile"],
    address: json["address"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    id: json["id"],
    userId: json["user_id"],
    phone: json["phone"],
    houseNo: json["house_no"],
    building: json["building"],
    type: json["type"],
    description: json["description"],
    isDefault: json["is_default"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "service_category_id": serviceCategoryId,
    "mobile": mobile,
    "address": address,
    "latitude": latitude,
    "longitude": longitude,
    "id": id,
    "user_id": userId,
    "phone": phone,
    "house_no": houseNo,
    "building": building,
    "type": type,
    "description": description,
    "is_default": isDefault,
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
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
  double? discount;
  double? commission;
  String? minPrice;
  String? driverRadius;
  int? baseDistance;
  int? basePrice;
  int? baseKm;
  int? priceKm;
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
    discount: json["discount"]==null?0.0:double.parse(json["discount"].toString()),
    commission: json["commission"]==null?0.0:double.parse(json["commission"].toString()),
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
    "home_view": homeViewValues.reverse![homeView],
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

enum HomeView { BACKGROUND, CARD }

final homeViewValues = EnumValues({
  "BACKGROUND": HomeView.BACKGROUND,
  "CARD": HomeView.CARD
});

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
  Status? status;
  Comment? comment;
  DateTime? createdAt;

  factory StatusTimestamp.fromJson(Map<String, dynamic> json) => StatusTimestamp(
    id: json["id"],
    orderId: json["order_id"],
    status: statusValues.map![json["status"]],
    comment: json["comment"] == null ? null : commentValues.map![json["comment"]],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_id": orderId,
    "status": statusValues.reverse![status],
    "comment": comment == null ? null : commentValues.reverse![comment],
    "created_at": createdAt!.toIso8601String(),
  };
}

enum Comment { ORDER_PLACED }

final commentValues = EnumValues({
  "Order placed": Comment.ORDER_PLACED
});

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
  dynamic? storeCategories;
  String? name;
  String? description;
  String? image;
  String? latitude;
  String? longitude;
  String? address;
  int? deliveryRange;
  int? baseDistance;
  int? basePrice;
  int? pricePerKm;
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
  // DeliveryAddressName? name;
  String? name;
  String? countryCode;
  String? mobile;
  String? email;
  dynamic walletAmount;
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
    // name: deliveryAddressNameValues.map![json["name"]],
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

class Link {
  Link({
    this.url,
    this.label,
    this.active,
  });

  String? url;
  String? label;
  bool? active;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
