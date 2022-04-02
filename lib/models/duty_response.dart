class DriverDutyResponse {
  DriverDutyResponse({
    this.success,
    this.data,
    this.message,
  });

  bool? success;
  Data? data;
  String? message;

  factory DriverDutyResponse.fromJson(Map<String, dynamic> json) => DriverDutyResponse(
    success: json["success"],
    data: json["data"] != null ? Data.fromJson(json["data"]) : null,
    message: json["message"] as String,
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data == null ? null : data!.toJson(),
    "message": message,
  };
}

class Data {
  Data({
    this.id,
    this.driverId,
    this.startTime,
    this.endTime,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? driverId;
  String? startTime;
  String? endTime;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    driverId: json["driver_id"],
    startTime: json["start_time"],
    endTime: json["end_time"] ?? "",
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "driver_id": driverId,
    "start_time": startTime,
    "end_time": endTime,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}
