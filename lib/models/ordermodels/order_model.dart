import 'dart:convert';


import 'package:dunzodriver_copy1/models/order_details_response.dart';

class OrderModel {
  int? _id;
  int? _userId;
  int? _storeId;
  int? _serviceCategoryId;
  ServiceCategory? _serviceCategory;
  dynamic? _couponData;
  Order_type? _orderType;
  double? _totalPrice;
  double? _discountValue;
  double? _deliveryFee;
  double? _tax;
  double? _grandTotal;
  Pickup_address? _pickupAddress;
  Delivery_address? _deliveryAddress;
  dynamic? _distanceTravelled;
  dynamic? _travelTime;
  int? _paymentId;
  dynamic? _driverId;
  String? _orderStatus;
  String? _paymentStatus;
  String? _paymentMethod;
  dynamic? _jsonData;
  DateTime? _createdAt;
  DateTime? _updatedAt;
  Store? _store;
  User? _user;
  Payment? _payment;
  dynamic? _driver;
  List<Item>? _itemList = [];

  int? get id => _id;

  List<Item>? get itemList => _itemList;

  int? get userId => _userId;

  int? get storeId => _storeId;

  int? get serviceCategoryId => _serviceCategoryId;

  CouponData? get couponData => _couponData;

  Order_type? get orderType => _orderType;

  double? get totalPrice => _totalPrice;

  double? get discountValue => _discountValue;

  double? get deliveryFee => _deliveryFee;

  double? get tax => _tax;

  double? get grandTotal => _grandTotal;

  Pickup_address? get pickupAddress => _pickupAddress;

  Delivery_address? get deliveryAddress => _deliveryAddress;

  dynamic? get distanceTravelled => _distanceTravelled;

  dynamic? get travelTime => _travelTime;

  int? get paymentId => _paymentId;

  dynamic? get driverId => _driverId;

  String? get orderStatus => _orderStatus;

  String? get paymentStatus => _paymentStatus;

  String? get paymentMethod => _paymentMethod;

  dynamic? get jsonData => _jsonData;

  DateTime? get createdAt => _createdAt;

  DateTime? get updatedAt => _updatedAt;

  Store? get store => _store;

  User? get user => _user;

  Payment? get payment => _payment;

  dynamic? get driver => _driver;

  ServiceCategory? get serviceCategory => _serviceCategory;

  OrderModel(
      {int? id,
      int? userId,
      int? storeId,
      int? serviceCategoryId,
      dynamic? couponData,
      Order_type? orderType,
        double? totalPrice,
        double? discountValue,
        double? deliveryFee,
      double? tax,
      double? grandTotal,
      Pickup_address? pickupAddress,
      Delivery_address? deliveryAddress,
      dynamic? distanceTravelled,
      dynamic? travelTime,
      int? paymentId,
      dynamic? driverId,
      String? orderStatus,
      String? paymentStatus,
      String? paymentMethod,
      dynamic? jsonData,
      DateTime? createdAt,
      DateTime? updatedAt,
      Store? store,
      User? user,
      Payment? payment,
      dynamic? driver,
      List<Item>? itemList,
      ServiceCategory? serviceCategory}) {
    _id = id;
    _userId = userId;
    _storeId = storeId;
    _serviceCategoryId = serviceCategoryId;
    _couponData = couponData;
    _orderType = orderType;
    _totalPrice = totalPrice;
    _discountValue = discountValue;
    _deliveryFee = deliveryFee;
    _tax = tax;
    _grandTotal = grandTotal;
    _pickupAddress = pickupAddress;
    _deliveryAddress = deliveryAddress;
    _distanceTravelled = distanceTravelled;
    _travelTime = travelTime;
    _paymentId = paymentId;
    _driverId = driverId;
    _orderStatus = orderStatus;
    _paymentStatus = paymentStatus;
    _paymentMethod = paymentMethod;
    _jsonData = jsonData;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _store = store;
    _user = user;
    _payment = payment;
    _driver = driver;
    _itemList = itemList;
    _serviceCategory = serviceCategory;
  }

  OrderModel.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _storeId = json['store_id'];
    _serviceCategoryId = json['service_category_id'];
    _couponData = null;
    // if (json['coupon_data'] != null) {
    //   _couponData = CouponModel.fromJson(json['coupon_data'].toString());
    // }

    _orderType = json['order_type'] != null
        ? Order_type.fromJson(json['order_type'])
        : null;
    _totalPrice = double.parse(json['total_price'].toString());
    _discountValue = double.parse(json['discount_value'].toString());
    _deliveryFee = double.parse(json['delivery_fee'].toString());
    _tax = double.parse(json['tax'].toString());
    _grandTotal = double.parse(json['grand_total'].toString());
    _pickupAddress = json['pickup_address'] != null
        ? Pickup_address.fromJson(json['pickup_address'])
        : null;
    _deliveryAddress = json['delivery_address'] != null
        ? Delivery_address.fromJson(json['delivery_address'])
        : null;
    _distanceTravelled = json['distance_travelled'];
    _travelTime = json['travel_time'];
    _paymentId = json['payment_id'];
    _driverId = json['driver_id'];
    _orderStatus = json['order_status'];
    _paymentStatus = json['payment_status'];
    _paymentMethod = json['payment_method'];
    _jsonData = json['json_data'];
    _itemList = [];
    if (json['items'] != null) {
      _itemList = [];
      if (json['items'] != null) {
        json['items'].forEach((v) {
          _itemList?.add(Item.fromJson(v));
        });
      }
    }
    if (json['service_category'] != null) {
      _serviceCategory = ServiceCategory.fromJson(json['service_category']);
    }
    if (json['created_at'] != null) {
      _createdAt = DateTime.parse(json["created_at"].toString());
      _updatedAt = DateTime.parse(json["updated_at"].toString());
    }

    _store = json['store'] != null ? Store.fromJson(json['store']) : null;
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _payment =
        json['payment'] != null ? Payment.fromJson(json['payment']) : null;
    _driver = json['driver'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['store_id'] = _storeId;
    map['service_category_id'] = _serviceCategoryId;
    map['coupon_data'] = _couponData;
    if (_orderType != null) {
      map['order_type'] = _orderType?.toJson();
    }
    map['total_price'] = _totalPrice;
    map['discount_value'] = _discountValue;
    map['delivery_fee'] = _deliveryFee;
    map['tax'] = _tax;
    map['grand_total'] = _grandTotal;
    if (_pickupAddress != null) {
      map['pickup_address'] = _pickupAddress?.toJson();
    }
    if (_deliveryAddress != null) {
      map['delivery_address'] = _deliveryAddress?.toJson();
    }
    map['distance_travelled'] = _distanceTravelled;
    map['travel_time'] = _travelTime;
    map['payment_id'] = _paymentId;
    map['driver_id'] = _driverId;
    map['order_status'] = _orderStatus;
    map['payment_status'] = _paymentStatus;
    map['payment_method'] = _paymentMethod;
    map['json_data'] = _jsonData;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_store != null) {
      map['store'] = _store?.toJson();
    }
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    if (_payment != null) {
      map['payment'] = _payment?.toJson();
    }
    map['driver'] = _driver;

    return map;
  }
}

/// id : 8
/// payment_request_id : null
/// ref_no : "ORD-1639718494"
/// user_id : 5
/// user_type : "App\\Models\\User"
/// order_id : null
/// remarks : "Order placed using COD"
/// payment_method : "COD"
/// amount : 60375
/// gateway_response : ""
/// created_at : "2021-12-17T05:21:34.000000Z"
/// updated_at : "2021-12-17T05:21:34.000000Z"

class Payment {
  int? _id;
  dynamic? _paymentRequestId;
  String? _refNo;
  int? _userId;
  String? _userType;
  dynamic? _orderId;
  String? _remarks;
  String? _paymentMethod;
  int? _amount;
  String? _gatewayResponse;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;

  dynamic? get paymentRequestId => _paymentRequestId;

  String? get refNo => _refNo;

  int? get userId => _userId;

  String? get userType => _userType;

  dynamic? get orderId => _orderId;

  String? get remarks => _remarks;

  String? get paymentMethod => _paymentMethod;

  int? get amount => _amount;

  String? get gatewayResponse => _gatewayResponse;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Payment(
      {int? id,
      dynamic? paymentRequestId,
      String? refNo,
      int? userId,
      String? userType,
      dynamic? orderId,
      String? remarks,
      String? paymentMethod,
      int? amount,
      String? gatewayResponse,
      String? createdAt,
      String? updatedAt}) {
    _id = id;
    _paymentRequestId = paymentRequestId;
    _refNo = refNo;
    _userId = userId;
    _userType = userType;
    _orderId = orderId;
    _remarks = remarks;
    _paymentMethod = paymentMethod;
    _amount = amount;
    _gatewayResponse = gatewayResponse;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Payment.fromJson(dynamic json) {
    _id = json['id'];
    _paymentRequestId = json['payment_request_id'];
    _refNo = json['ref_no'];
    _userId = json['user_id'];
    _userType = json['user_type'];
    _orderId = json['order_id'];
    _remarks = json['remarks'];
    _paymentMethod = json['payment_method'];
    _amount = json['amount'];
    _gatewayResponse = json['gateway_response'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['payment_request_id'] = _paymentRequestId;
    map['ref_no'] = _refNo;
    map['user_id'] = _userId;
    map['user_type'] = _userType;
    map['order_id'] = _orderId;
    map['remarks'] = _remarks;
    map['payment_method'] = _paymentMethod;
    map['amount'] = _amount;
    map['gateway_response'] = _gatewayResponse;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}

/// id : 5
/// name : "Tarun Pal"
/// country_code : "+91"
/// mobile : "7417391228"
/// email : null
/// wallet_amount : 0
/// profile_img : null
/// lat : null
/// long : null
/// status : true
/// ref_code : null
/// ref_by : null
/// created_at : "2021-12-06T05:53:46.000000Z"
/// updated_at : "2021-12-06T05:53:46.000000Z"

class User {
  int? _id;
  String? _name;
  String? _countryCode;
  String? _mobile;
  dynamic? _email;
  int? _walletAmount;
  dynamic? _profileImg;
  dynamic? _lat;
  dynamic? _long;
  bool? _status;
  dynamic? _refCode;
  dynamic? _refBy;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;

  String? get name => _name;

  String? get countryCode => _countryCode;

  String? get mobile => _mobile;

  dynamic? get email => _email;

  int? get walletAmount => _walletAmount;

  dynamic? get profileImg => _profileImg;

  dynamic? get lat => _lat;

  dynamic? get long => _long;

  bool? get status => _status;

  dynamic? get refCode => _refCode;

  dynamic? get refBy => _refBy;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  User(
      {int? id,
      String? name,
      String? countryCode,
      String? mobile,
      dynamic? email,
      int? walletAmount,
      dynamic? profileImg,
      dynamic? lat,
      dynamic? long,
      bool? status,
      dynamic? refCode,
      dynamic? refBy,
      String? createdAt,
      String? updatedAt}) {
    _id = id;
    _name = name;
    _countryCode = countryCode;
    _mobile = mobile;
    _email = email;
    _walletAmount = walletAmount;
    _profileImg = profileImg;
    _lat = lat;
    _long = long;
    _status = status;
    _refCode = refCode;
    _refBy = refBy;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  User.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _countryCode = json['country_code'];
    _mobile = json['mobile'];
    _email = json['email'];
    _walletAmount = json['wallet_amount'];
    _profileImg = json['profile_img'];
    _lat = json['lat'];
    _long = json['long'];
    _status = json['status'];
    _refCode = json['ref_code'];
    _refBy = json['ref_by'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['country_code'] = _countryCode;
    map['mobile'] = _mobile;
    map['email'] = _email;
    map['wallet_amount'] = _walletAmount;
    map['profile_img'] = _profileImg;
    map['lat'] = _lat;
    map['long'] = _long;
    map['status'] = _status;
    map['ref_code'] = _refCode;
    map['ref_by'] = _refBy;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}

/// id : 1
/// admin_id : "4"
/// service_category_id : 12
/// store_categories : "1,2,3"
/// name : "Minerva Berg"
/// description : "Sunt quia nostrum qu"
/// image : "/storage/stores/1638962187.png"
/// latitude : "28.3725"
/// longitude : "76.9049"
/// address : "Delectus ab maiores"
/// delivery_range : 62
/// base_distance : 66
/// base_price : 919
/// price_per_km : 420
/// mobile : "Enim cupidatat facer"
/// email : "gupofewy@mailinator.com"
/// order_count : 0
/// gst_doc : null
/// pan_doc : null
/// food_license : null
/// shop_photo : null
/// commission : 0
/// tax : 0
/// is_open : false
/// active : true
/// created_at : "2021-12-08T11:16:27.000000Z"
/// updated_at : "2021-12-08T11:16:27.000000Z"

class Store {
  int? _id;
  String? _adminId;
  int? _serviceCategoryId;
  String? _storeCategories;
  String? _name;
  String? _description;
  String? _image;
  String? _latitude;
  String? _longitude;
  String? _address;
  int? _deliveryRange;
  int? _baseDistance;
  int? _basePrice;
  int? _pricePerKm;
  String? _mobile;
  String? _email;
  int? _orderCount;
  dynamic? _gstDoc;
  dynamic? _panDoc;
  dynamic? _foodLicense;
  dynamic? _shopPhoto;
  int? _commission;
  int? _tax;
  bool? _isOpen;
  bool? _active;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;

  String? get adminId => _adminId;

  int? get serviceCategoryId => _serviceCategoryId;

  String? get storeCategories => _storeCategories;

  String? get name => _name;

  String? get description => _description;

  String? get image => _image;

  String? get latitude => _latitude;

  String? get longitude => _longitude;

  String? get address => _address;

  int? get deliveryRange => _deliveryRange;

  int? get baseDistance => _baseDistance;

  int? get basePrice => _basePrice;

  int? get pricePerKm => _pricePerKm;

  String? get mobile => _mobile;

  String? get email => _email;

  int? get orderCount => _orderCount;

  dynamic? get gstDoc => _gstDoc;

  dynamic? get panDoc => _panDoc;

  dynamic? get foodLicense => _foodLicense;

  dynamic? get shopPhoto => _shopPhoto;

  int? get commission => _commission;

  int? get tax => _tax;

  bool? get isOpen => _isOpen;

  bool? get active => _active;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Store(
      {int? id,
      String? adminId,
      int? serviceCategoryId,
      String? storeCategories,
      String? name,
      String? description,
      String? image,
      String? latitude,
      String? longitude,
      String? address,
      int? deliveryRange,
      int? baseDistance,
      int? basePrice,
      int? pricePerKm,
      String? mobile,
      String? email,
      int? orderCount,
      dynamic? gstDoc,
      dynamic? panDoc,
      dynamic? foodLicense,
      dynamic? shopPhoto,
      int? commission,
      int? tax,
      bool? isOpen,
      bool? active,
      String? createdAt,
      String? updatedAt}) {
    _id = id;
    _adminId = adminId;
    _serviceCategoryId = serviceCategoryId;
    _storeCategories = storeCategories;
    _name = name;
    _description = description;
    _image = image;
    _latitude = latitude;
    _longitude = longitude;
    _address = address;
    _deliveryRange = deliveryRange;
    _baseDistance = baseDistance;
    _basePrice = basePrice;
    _pricePerKm = pricePerKm;
    _mobile = mobile;
    _email = email;
    _orderCount = orderCount;
    _gstDoc = gstDoc;
    _panDoc = panDoc;
    _foodLicense = foodLicense;
    _shopPhoto = shopPhoto;
    _commission = commission;
    _tax = tax;
    _isOpen = isOpen;
    _active = active;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Store.fromJson(dynamic json) {
    _id = json['id'];
    _adminId = json['admin_id'];
    _serviceCategoryId = json['service_category_id'];
    _storeCategories = json['store_categories'];
    _name = json['name'];
    _description = json['description'];
    _image = json['image'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _address = json['address'];
    _deliveryRange = json['delivery_range'];
    _baseDistance = json['base_distance'];
    _basePrice = json['base_price'];
    _pricePerKm = json['price_per_km'];
    _mobile = json['mobile'];
    _email = json['email'];
    _orderCount = json['order_count'];
    _gstDoc = json['gst_doc'];
    _panDoc = json['pan_doc'];
    _foodLicense = json['food_license'];
    _shopPhoto = json['shop_photo'];
    _commission = json['commission'];
    _tax = json['tax'];
    _isOpen = json['is_open'];
    _active = json['active'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['admin_id'] = _adminId;
    map['service_category_id'] = _serviceCategoryId;
    map['store_categories'] = _storeCategories;
    map['name'] = _name;
    map['description'] = _description;
    map['image'] = _image;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['address'] = _address;
    map['delivery_range'] = _deliveryRange;
    map['base_distance'] = _baseDistance;
    map['base_price'] = _basePrice;
    map['price_per_km'] = _pricePerKm;
    map['mobile'] = _mobile;
    map['email'] = _email;
    map['order_count'] = _orderCount;
    map['gst_doc'] = _gstDoc;
    map['pan_doc'] = _panDoc;
    map['food_license'] = _foodLicense;
    map['shop_photo'] = _shopPhoto;
    map['commission'] = _commission;
    map['tax'] = _tax;
    map['is_open'] = _isOpen;
    map['active'] = _active;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}

/// name : "nh"
/// phone : "yy"
/// address : "P93, New Model Colony, Hosmane, Ward 50, Bhadravathi, Karnataka 577301, India"
/// latitude : 13.853548599999999879628376220352947711944580078125
/// longitude : 75.71667139999999562860466539859771728515625
/// house_no : "hhh"
/// building : "bbh"

class Delivery_address {
  String? _name;
  String? _phone;
  String? _address;
  double? _latitude;
  double? _longitude;
  String? _houseNo;
  String? _building;

  String? get name => _name;

  String? get phone => _phone;

  String? get address => _address;

  double? get latitude => _latitude;

  double? get longitude => _longitude;

  String? get houseNo => _houseNo;

  String? get building => _building;

  Delivery_address(
      {String? name,
      String? phone,
      String? address,
      double? latitude,
      double? longitude,
      String? houseNo,
      String? building}) {
    _name = name;
    _phone = phone;
    _address = address;
    _latitude = latitude;
    _longitude = longitude;
    _houseNo = houseNo;
    _building = building;
  }

  Delivery_address.fromJson(dynamic json) {
    if (json != null) {
      _name = json['name'];
      _phone = json['phone'];
      _address = json['address'];
      _latitude = json['latitude'];
      _longitude = json['longitude'];
      _houseNo = json['house_no'];
      _building = json['building'];
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['name'] = _name;
    map['phone'] = _phone;
    map['address'] = _address;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['house_no'] = _houseNo;
    map['building'] = _building;
    return map;
  }
}

/// name : "Minerva Berg"
/// service_category_id : 12
/// mobile : "Enim cupidatat facer"
/// address : "Delectus ab maiores"
/// latitude : "28.3725"
/// longitude : "76.9049"

class Pickup_address {
  String? _name;
  int? _serviceCategoryId;
  String? _mobile;
  String? _address;
  String? _latitude;
  String? _longitude;

  String? get name => _name;

  int? get serviceCategoryId => _serviceCategoryId;

  String? get mobile => _mobile;

  String? get address => _address;

  String? get latitude => _latitude;

  String? get longitude => _longitude;

  Pickup_address(
      {String? name,
      int? serviceCategoryId,
      String? mobile,
      String? address,
      String? latitude,
      String? longitude}) {
    _name = name;
    _serviceCategoryId = serviceCategoryId;
    _mobile = mobile;
    _address = address;
    _latitude = latitude;
    _longitude = longitude;
  }

  Pickup_address.fromJson(dynamic json) {
    if (json != null) {
      _name = json['name'].toString();
      _serviceCategoryId = json['service_category_id'];
      _mobile = json['mobile'];
      _address = json['address'];
      _latitude = json['latitude'].toString();
      _longitude = json['longitude'].toString();
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['name'] = _name;
    map['service_category_id'] = _serviceCategoryId;
    map['mobile'] = _mobile;
    map['address'] = _address;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    return map;
  }
}

/// id : 1
/// name : "Purchasing Service"
/// created_at : null
/// updated_at : null

class Order_type {
  int? _id;
  String? _name;
  dynamic? _createdAt;
  dynamic? _updatedAt;

  int? get id => _id;

  String? get name => _name;

  dynamic? get createdAt => _createdAt;

  dynamic? get updatedAt => _updatedAt;

  Order_type({int? id, String? name, dynamic? createdAt, dynamic? updatedAt}) {
    _id = id;
    _name = name;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Order_type.fromJson(dynamic json) {
    if (json != null) {
      if (json['id'] != null) {
        _id = json['id'];
      }
      _name = json['name'];
      _createdAt = json['created_at'];
      _updatedAt = json['updated_at'];
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
