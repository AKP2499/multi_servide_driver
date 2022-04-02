
import 'package:dunzodriver_copy1/models/ordermodels/order_model.dart';

/// success : true
/// data : {"id":16,"user_id":5,"store_id":1,"service_category_id":12,"coupon_data":null,"order_type":{"id":1,"name":"Purchasing Service","created_at":null,"updated_at":null},"total_price":575,"discount_value":0,"delivery_fee":0,"tax":28.75,"grand_total":603.75,"pickup_address":{"name":"Minerva Berg","service_category_id":12,"mobile":"Enim cupidatat facer","address":"Delectus ab maiores","latitude":"28.3725","longitude":"76.9049"},"delivery_address":{"name":"nh","phone":"yy","address":"P93, New Model Colony, Hosmane, Ward 50, Bhadravathi, Karnataka 577301, India","latitude":13.853548599999999879628376220352947711944580078125,"longitude":75.71667139999999562860466539859771728515625,"house_no":"hhh","building":"bbh"},"distance_travelled":null,"travel_time":null,"payment_id":8,"driver_id":null,"order_status":"PLACED","payment_status":"SUCCESS","payment_method":"COD","json_data":null,"created_at":"2021-12-17T05:21:34.000000Z","updated_at":"2021-12-17T05:21:34.000000Z","store":{"id":1,"admin_id":"4","service_category_id":12,"store_categories":"1,2,3","name":"Minerva Berg","description":"Sunt quia nostrum qu","image":"/storage/stores/1638962187.png","latitude":"28.3725","longitude":"76.9049","address":"Delectus ab maiores","delivery_range":62,"base_distance":66,"base_price":919,"price_per_km":420,"mobile":"Enim cupidatat facer","email":"gupofewy@mailinator.com","order_count":0,"gst_doc":null,"pan_doc":null,"food_license":null,"shop_photo":null,"commission":0,"tax":0,"is_open":false,"active":true,"created_at":"2021-12-08T11:16:27.000000Z","updated_at":"2021-12-08T11:16:27.000000Z"},"user":{"id":5,"name":"Tarun Pal","country_code":"+91","mobile":"7417391228","email":null,"wallet_amount":0,"profile_img":null,"lat":null,"long":null,"status":true,"ref_code":null,"ref_by":null,"created_at":"2021-12-06T05:53:46.000000Z","updated_at":"2021-12-06T05:53:46.000000Z"},"payment":{"id":8,"payment_request_id":null,"ref_no":"ORD-1639718494","user_id":5,"user_type":"App\\Models\\User","order_id":null,"remarks":"Order placed using COD","payment_method":"COD","amount":60375,"gateway_response":"","created_at":"2021-12-17T05:21:34.000000Z","updated_at":"2021-12-17T05:21:34.000000Z"},"driver":null}
/// message : "Saved Successfully"

class OrderCreateResponse {
  bool? _success;
  OrderModel? _data;
  String? _message;


  bool? get success => _success;

  OrderModel? get data => _data;


  String? get message => _message;

  OrderCreateResponse({bool? success, OrderModel? data, String? message}) {
    _success = success;
    _data = data;
    _message = message;
  }

  OrderCreateResponse.fromJson(dynamic json) {
    _success = json['success'];
    if (json['data'] != null) {
      print("IN ORDER MODEL");
      _data = json['data'] != null ? OrderModel.fromJson(json['data']) : null;
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
