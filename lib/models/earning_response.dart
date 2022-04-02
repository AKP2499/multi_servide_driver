class DriverEarningData {
  DriverEarningData({
    this.success,
    this.data,
    this.message,
  });

  bool? success;
  Data? data;
  String? message;

  factory DriverEarningData.fromJson(Map<String, dynamic> json) => DriverEarningData(
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
    this.earnings,
    this.transactions,
  });

  double? earnings;
  List<Transaction>? transactions;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    earnings: double.parse(json["earnings"].toString()),
    transactions: List<Transaction>.from(json["transactions"].map((x) => Transaction.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "earnings": earnings,
    "transactions": List<dynamic>.from(transactions!.map((x) => x.toJson())),
  };
}

class Transaction {
  Transaction({
    this.id,
    this.paymentId,
    this.orderId,
    this.entityType,
    this.entityId,
    this.amount,
    this.remarks,
    this.isSettled,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? paymentId;
  int? orderId;
  String? entityType;
  int? entityId;
  double? amount;
  String? remarks;
  bool? isSettled;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
    id: json["id"],
    paymentId: json["payment_id"],
    orderId: json["order_id"],
    entityType: json["entity_type"],
    entityId: json["entity_id"],
    amount: double.parse(json["amount"].toString()),
    remarks: json["remarks"],
    isSettled: json["is_settled"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "payment_id": paymentId,
    "order_id": orderId,
    "entity_type": entityType,
    "entity_id": entityId,
    "amount": amount,
    "remarks": remarks,
    "is_settled": isSettled,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}