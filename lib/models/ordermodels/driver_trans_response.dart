
class CashInHandResponse {
  CashInHandResponse({
    this.success,
    this.data,
    this.message,
  });

  bool? success;
  List<Datum>? data;
  String? message;

  factory CashInHandResponse.fromJson(Map<String, dynamic> json) => CashInHandResponse(
    success: json["success"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
  };
}

class Datum {
  Datum({
    this.id,
    this.driverId,
    this.type,
    this.amount,
    this.openingBalance,
    this.closingBalance,
    this.remarks,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? driverId;
  String? type;
  double? amount;
  double? openingBalance;
  double? closingBalance;
  String? remarks;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    driverId: json["driver_id"],
    type: json["type"],
    amount: json["amount"]!=null?double.parse(json["amount"].toString()):0.0,
    openingBalance: json["opening_balance"]!=null?double.parse(json["opening_balance"].toString()):0.0,
    closingBalance: json["closing_balance"]!=null?double.parse(json["closing_balance"].toString()):0.0,
    remarks: json["remarks"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "driver_id": driverId,
    "type": type,
    "amount": amount,
    "opening_balance": openingBalance,
    "closing_balance": closingBalance,
    "remarks": remarks,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}
