class Analytics {
  bool? success;
  int? totalOrders;
  int? totalIncome;
  int? paymentReceived;
  int? duePayment;

  Analytics({
    this.success,
    this.totalOrders,
    this.totalIncome,
    this.paymentReceived,
    this.duePayment,
  });

  factory Analytics.fromJson(Map<String, dynamic> json) => Analytics(
        success: json["success"],
        totalOrders: json["total_orders"] ?? 0,
        totalIncome: json["total_income"],
        paymentReceived: json["payment_received"],
        duePayment: json["due_payment"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "total_orders": totalOrders,
        "total_income": totalIncome,
        "payment_received": paymentReceived,
        "due_payment": duePayment,
      };
}
