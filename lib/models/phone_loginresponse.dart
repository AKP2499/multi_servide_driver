
class PhoneLoginResponse {
  PhoneLoginResponse({
    this.success,
    this.data,
    this.message,
  });

  bool? success;
  Data? data;
  String? message;

  factory PhoneLoginResponse.fromJson(Map<String, dynamic> json) => PhoneLoginResponse(
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
    this.statusCode,
  });

  int? statusCode;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    statusCode: json["status_code"],
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
  };
}
