import 'package:dunzodriver_copy1/models/profile_data.dart';

class PersonalInformationResponse {
  PersonalInformationResponse({
    this.success,
    this.data,
    this.message,
  });

  bool? success;
  ProfileData? data;
  String? message;

  factory PersonalInformationResponse.fromJson(Map<String, dynamic> json) => PersonalInformationResponse(
    success: json["success"],
    data: (json["data"] == null)?null:ProfileData.fromJson(json["data"]),
    message: json["message"],
  );
  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data!.toJson(),
    "message": message,
  };
}