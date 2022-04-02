
class OrderStatistics {
  OrderStatistics({
    this.success,
    this.data,
    this.message,
  });

  bool? success;
  Data? data;
  String? message;

  factory OrderStatistics.fromJson(Map<String, dynamic> json) => OrderStatistics(
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
    this.pending,
    this.completed,
    this.activeTime,
    this.upcomingServiceOrder,
    this.completedServiceOrder
  });

  int? pending;
  int? completed;
  String? activeTime;
  int? upcomingServiceOrder;
  int? completedServiceOrder;


  factory Data.fromJson(Map<String, dynamic> json) => Data(
    pending: json["pending"],
    completed: json["completed"],
    activeTime: json["active_time"],
    upcomingServiceOrder: json["upcoming_service_order"],
    completedServiceOrder: json["completed_service_order"],

  );

  Map<String, dynamic> toJson() => {
    "pending": pending,
    "completed": completed,
    "active_time": activeTime,
    "upcoming_service_order":upcomingServiceOrder,
    "completed_service_order":completedServiceOrder,
  };
}

