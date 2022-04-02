class ApiRoutes{
  // static const String BASE_URL='https://admin.wedun.in';
  // static const String BASE_URL='http://wedun.ssdemo.xyz';
  static const String BASE_URL='http://ssmultiservice.ssdemo.xyz';
  static const String driverPhoneLogin='/api/driver/phonelogin';
  static const String otpVerify='/api/driver/verify';
  static const String informationVerify='/api/driver/update';
  static const String vehicleVerify='/api/vehicle_types';
  static const String getProfile= "/api/driver/profile";
  static const String getOrder="/api/orders";
  static const String driverDuty="/api/driver/duty";
  static const String syncdriver="/api/driver/sync";
  static const String driverEarning="/api/driver/earnings";
  static const String setting="/api/settings";
  static const String orderDetails="/api/orders/";
  static const String pendingOrders="/api/driver/pending_orders";
  static const String orderStatistics="/api/driver/order_stats";
  static const String walletTransactions="/api/driver_wallet_transactions";
  static const String initiateRazorpayPayment="/api/user/razorpay/create";
  static const String verifyPayment="/api/user/razorpay/verify";
  static const String walletRecharge="/api/driver/wallet_recharge";
  static const String rejectOrder="/api/driver/order/driver-cancel";
  // static const String serviceOrder="/api/service/service_order?UPCOMING=true&search=id:";
  static const String serviceCompletedOrder="/api/service/service_order/";
  static const String serviceStatus="/api/service/service_orders/changestatus";

}

