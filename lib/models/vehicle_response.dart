
class VehicleResponse {
  VehicleResponse({
    this.success,
    this.data,
    this.message,
  });

  bool? success;
  List<VehicleData>? data;
  String? message;

  factory VehicleResponse.fromJson(Map<String, dynamic> json) => VehicleResponse(
    success: json["success"],
    data: List<VehicleData>.from(json["data"].map((x) => VehicleData.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
  };
}

class VehicleData {
  VehicleData({
    this.id,
    this.name,
    this.icon,
    this.active,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  String? icon;
  bool? active;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory VehicleData.fromJson(Map<String, dynamic> json) => VehicleData(
    id: json["id"],
    name: json["name"],
    icon: json["icon"],
    active: json["active"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "icon": icon,
    "active": active,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}
