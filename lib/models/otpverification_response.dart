
import 'package:dunzodriver_copy1/models/profile_data.dart';

class OTPResponse {
  OTPResponse({
    this.success,
    this.data,
    this.message,
  });

  bool? success;
  ProfileData? data;
  String? message;

  factory OTPResponse.fromJson(Map<String, dynamic> json) => OTPResponse(
    success: json["success"],
    data: ProfileData.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data!.toJson(),
    "message": message,
  };
}


