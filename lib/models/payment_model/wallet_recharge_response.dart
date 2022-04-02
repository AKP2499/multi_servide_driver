
class WalletRechargeResponse {
  WalletRechargeResponse({
    this.success,
    this.data,
    this.message,
  });

  bool? success;
  Data? data;
  String? message;

  factory WalletRechargeResponse.fromJson(Map<String, dynamic> json) => WalletRechargeResponse(
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
    this.data,
  });

  String? data;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "data": data,
  };
}
