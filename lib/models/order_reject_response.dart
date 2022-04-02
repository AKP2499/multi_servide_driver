
class RejectResponse {
  RejectResponse({
    this.success,
    this.data,
    this.message,
  });

  bool? success;
  dynamic data;
  String? message;

  factory RejectResponse.fromJson(Map<String, dynamic> json) => RejectResponse(
    success: json["success"],
    data: (json["data"]==null)?null:json["data"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data,
    "message": message,
  };
}
