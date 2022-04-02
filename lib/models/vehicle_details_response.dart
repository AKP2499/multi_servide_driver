
import 'package:dunzodriver_copy1/models/phone_loginresponse.dart';

class VehicleDetailsResponse {
  VehicleDetailsResponse({
    this.success,
    this.data,
    this.message,
  });

  bool? success;
  Data? data;
  String? message;

  factory VehicleDetailsResponse.fromJson(Map<String, dynamic> json) => VehicleDetailsResponse(
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
