import 'package:dunzodriver_copy1/models/profile_data.dart';

class ProfileDataResponse {
  ProfileDataResponse({
    this.success,
    this.data,
    this.message,
  });

  bool? success;
  ProfileData? data;
  String? message;

  factory ProfileDataResponse.fromJson(Map<String, dynamic> json) => ProfileDataResponse(
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