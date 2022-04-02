import 'package:dunzodriver_copy1/models/ordermodels/order_model.dart';

/// success : true
/// data : {"id":16,"user_id":5,"store_id":1,"service_category_id":12,"coupon_data":null,"order_type":{"id":1,"name":"Purchasing Service","created_at":null,"updated_at":null},"total_price":575,"discount_value":0,"delivery_fee":0,"tax":28.75,"grand_total":603.75,"pickup_address":{"name":"Minerva Berg","service_category_id":12,"mobile":"Enim cupidatat facer","address":"Delectus ab maiores","latitude":"28.3725","longitude":"76.9049"},"delivery_address":{"name":"nh","phone":"yy","address":"P93, New Model Colony, Hosmane, Ward 50, Bhadravathi, Karnataka 577301, India","latitude":13.853548599999999879628376220352947711944580078125,"longitude":75.71667139999999562860466539859771728515625,"house_no":"hhh","building":"bbh"},"distance_travelled":null,"travel_time":null,"payment_id":8,"driver_id":null,"order_status":"PLACED","payment_status":"SUCCESS","payment_method":"COD","json_data":null,"created_at":"2021-12-17T05:21:34.000000Z","updated_at":"2021-12-17T05:21:34.000000Z","store":{"id":1,"admin_id":"4","service_category_id":12,"store_categories":"1,2,3","name":"Minerva Berg","description":"Sunt quia nostrum qu","image":"/storage/stores/1638962187.png","latitude":"28.3725","longitude":"76.9049","address":"Delectus ab maiores","delivery_range":62,"base_distance":66,"base_price":919,"price_per_km":420,"mobile":"Enim cupidatat facer","email":"gupofewy@mailinator.com","order_count":0,"gst_doc":null,"pan_doc":null,"food_license":null,"shop_photo":null,"commission":0,"tax":0,"is_open":false,"active":true,"created_at":"2021-12-08T11:16:27.000000Z","updated_at":"2021-12-08T11:16:27.000000Z"},"user":{"id":5,"name":"Tarun Pal","country_code":"+91","mobile":"7417391228","email":null,"wallet_amount":0,"profile_img":null,"lat":null,"long":null,"status":true,"ref_code":null,"ref_by":null,"created_at":"2021-12-06T05:53:46.000000Z","updated_at":"2021-12-06T05:53:46.000000Z"},"payment":{"id":8,"payment_request_id":null,"ref_no":"ORD-1639718494","user_id":5,"user_type":"App\\Models\\User","order_id":null,"remarks":"Order placed using COD","payment_method":"COD","amount":60375,"gateway_response":"","created_at":"2021-12-17T05:21:34.000000Z","updated_at":"2021-12-17T05:21:34.000000Z"},"driver":null}
/// message : "Saved Successfully"

class Order_response {
  bool? _success;
  OrderModel? _data;
  String? _message;

  OrderData? _orderListData;

  bool? get success => _success;

  OrderModel? get data => _data;

  OrderData? get orderListData => _orderListData;

  String? get message => _message;

  Order_response({bool? success, OrderModel? data, String? message}) {
    _success = success;
    _data = data;
    _message = message;
  }

  Order_response.fromJson(dynamic json) {
    _success = json['success'];
    if (json['data'] != null) {
      _orderListData =
          json['data'] != null ? OrderData.fromJson(json['data']) : null;
      // _data = json['data'] != null ? OrderModel.fromJson(json['data']) : null;
      // json['data'].forEach((v) {
      //   _orderList?.add(OrderModel.fromJson(v));
      // });
      // print("IN ORDER MODEL");
      // _data = json['data'] != null ? OrderModel.fromJson(json['data']) : null;
    }
    _message = json['message'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['success'] = _success;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['message'] = _message;
    return map;
  }
}

class OrderData {
  int? _currentPage;
  List<OrderModel>? _orderList = [];
  String? _firstPageUrl;
  int? _from;
  int? _lastPage;
  String? _lastPageUrl;
  List<Links>? _links;
  dynamic? _nextPageUrl;
  String? _path;
  int? _perPage;
  dynamic? _prevPageUrl;
  int? _to;
  int? _total;

  int? get currentPage => _currentPage;

  List<OrderModel>? get orderList => _orderList;

  String? get firstPageUrl => _firstPageUrl;

  int? get from => _from;

  int? get lastPage => _lastPage;

  String? get lastPageUrl => _lastPageUrl;

  List<Links>? get links => _links;

  dynamic? get nextPageUrl => _nextPageUrl;

  String? get path => _path;

  int? get perPage => _perPage;

  dynamic? get prevPageUrl => _prevPageUrl;

  int? get to => _to;

  int? get total => _total;

  Data(
      {int? currentPage,
      List<OrderModel>? data,
      String? firstPageUrl,
      int? from,
      int? lastPage,
      String? lastPageUrl,
      List<Links>? links,
      dynamic? nextPageUrl,
      String? path,
      int? perPage,
      dynamic? prevPageUrl,
      int? to,
      int? total}) {
    _currentPage = currentPage;
    _orderList = data;
    _firstPageUrl = firstPageUrl;
    _from = from;
    _lastPage = lastPage;
    _lastPageUrl = lastPageUrl;
    _links = links;
    _nextPageUrl = nextPageUrl;
    _path = path;
    _perPage = perPage;
    _prevPageUrl = prevPageUrl;
    _to = to;
    _total = total;
  }

  OrderData.fromJson(dynamic json) {
    _currentPage = json['current_page'];
    if (json['data'] != null) {
      _orderList = [];
      json['data'].forEach((v) {
        _orderList?.add(OrderModel.fromJson(v));
      });
    }
    _firstPageUrl = json['first_page_url'];
    _from = json['from'];
    _lastPage = json['last_page'];
    _lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      _links = [];
      json['links'].forEach((v) {
        _links?.add(Links.fromJson(v));
      });
    }
    _nextPageUrl = json['next_page_url'];
    _path = json['path'];
    _perPage = json['per_page'];
    _prevPageUrl = json['prev_page_url'];
    _to = json['to'];
    _total = json['total'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['current_page'] = _currentPage;
    if (_orderList != null) {
      map['data'] = _orderList?.map((v) => v.toJson()).toList();
    }
    map['first_page_url'] = _firstPageUrl;
    map['from'] = _from;
    map['last_page'] = _lastPage;
    map['last_page_url'] = _lastPageUrl;
    if (_links != null) {
      map['links'] = _links?.map((v) => v.toJson()).toList();
    }
    map['next_page_url'] = _nextPageUrl;
    map['path'] = _path;
    map['per_page'] = _perPage;
    map['prev_page_url'] = _prevPageUrl;
    map['to'] = _to;
    map['total'] = _total;
    return map;
  }
}

/// url : null
/// label : "&laquo; Previous"
/// active : false

class Links {
  dynamic? _url;
  String? _label;
  bool? _active;

  dynamic? get url => _url;

  String? get label => _label;

  bool? get active => _active;

  Links({dynamic? url, String? label, bool? active}) {
    _url = url;
    _label = label;
    _active = active;
  }

  Links.fromJson(dynamic json) {
    _url = json['url'];
    _label = json['label'];
    _active = json['active'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['url'] = _url;
    map['label'] = _label;
    map['active'] = _active;
    return map;
  }
}

/// id : 16
/// user_id : 5
/// store_id : 1
/// service_category_id : 12
/// coupon_data : null
/// order_type : {"id":1,"name":"Purchasing Service","created_at":null,"updated_at":null}
/// total_price : 575
/// discount_value : 0
/// delivery_fee : 0
/// tax : 28.75
/// grand_total : 603.75
/// pickup_address : {"name":"Minerva Berg","service_category_id":12,"mobile":"Enim cupidatat facer","address":"Delectus ab maiores","latitude":"28.3725","longitude":"76.9049"}
/// delivery_address : {"name":"nh","phone":"yy","address":"P93, New Model Colony, Hosmane, Ward 50, Bhadravathi, Karnataka 577301, India","latitude":13.853548599999999879628376220352947711944580078125,"longitude":75.71667139999999562860466539859771728515625,"house_no":"hhh","building":"bbh"}
/// distance_travelled : null
/// travel_time : null
/// payment_id : 8
/// driver_id : null
/// order_status : "PLACED"
/// payment_status : "SUCCESS"
/// payment_method : "COD"
/// json_data : null
/// created_at : "2021-12-17T05:21:34.000000Z"
/// updated_at : "2021-12-17T05:21:34.000000Z"
/// store : {"id":1,"admin_id":"4","service_category_id":12,"store_categories":"1,2,3","name":"Minerva Berg","description":"Sunt quia nostrum qu","image":"/storage/stores/1638962187.png","latitude":"28.3725","longitude":"76.9049","address":"Delectus ab maiores","delivery_range":62,"base_distance":66,"base_price":919,"price_per_km":420,"mobile":"Enim cupidatat facer","email":"gupofewy@mailinator.com","order_count":0,"gst_doc":null,"pan_doc":null,"food_license":null,"shop_photo":null,"commission":0,"tax":0,"is_open":false,"active":true,"created_at":"2021-12-08T11:16:27.000000Z","updated_at":"2021-12-08T11:16:27.000000Z"}
/// user : {"id":5,"name":"Tarun Pal","country_code":"+91","mobile":"7417391228","email":null,"wallet_amount":0,"profile_img":null,"lat":null,"long":null,"status":true,"ref_code":null,"ref_by":null,"created_at":"2021-12-06T05:53:46.000000Z","updated_at":"2021-12-06T05:53:46.000000Z"}
/// payment : {"id":8,"payment_request_id":null,"ref_no":"ORD-1639718494","user_id":5,"user_type":"App\\Models\\User","order_id":null,"remarks":"Order placed using COD","payment_method":"COD","amount":60375,"gateway_response":"","created_at":"2021-12-17T05:21:34.000000Z","updated_at":"2021-12-17T05:21:34.000000Z"}
/// driver : null
