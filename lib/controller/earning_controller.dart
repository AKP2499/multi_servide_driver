import 'package:dunzodriver_copy1/api/repositiory.dart';
import 'package:dunzodriver_copy1/controller/profile_controller.dart';
import 'package:dunzodriver_copy1/models/earning_response.dart' as data;
import 'package:dunzodriver_copy1/models/earning_response.dart';
import 'package:dunzodriver_copy1/models/ordermodels/driver_trans_response.dart';
import 'package:dunzodriver_copy1/models/payment_model/payment_verify_response.dart';
import 'package:dunzodriver_copy1/models/payment_model/razorpay_response.dart';
import 'package:dunzodriver_copy1/models/payment_model/wallet_recharge_response.dart';
import 'package:dunzodriver_copy1/views/navigation_pages/bottomnavigation_dunzo.dart';
import 'package:dunzodriver_copy1/views/navigation_pages/home_page1.dart';
import 'package:dunzodriver_copy1/views/navigation_pages/payout_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EarningController extends GetxController {
  Rx<CashInHandResponse> storedWalletTransactionData = CashInHandResponse().obs;
  Rx<data.Data> earningList = data.Data().obs;
  ProfileController profileController = Get.put(ProfileController());


  Razorpay? razorpay;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    razorpay!.clear();
  }
// TODO: RAZORPAY INTEGRATION //
  void openCheckout(String orderId) async {
    var options = {
      'key': '${profileController.storedSettingData.value.data!.razorpayKey}',
      'amount': num.parse(myControllerPayment.text) * 100,
      'order_id': orderId,
      "currency": "INR",
      'name': '${profileController.profileDataHome.value.name}',
      'description':
          '${profileController.storedSettingData.value.data!.appDescription}',
      'prefill': {
        'contact': '${profileController.profileDataHome.value.mobile}',
        'email': '${profileController.profileDataHome.value.email}'
      },
      // 'external': {
      //   'wallets': ['paytm']
      // }
    };
    try {
      razorpay!.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlerPaymentSuccess(PaymentSuccessResponse response) {
    print("payment success");
    print(response.paymentId);
    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId!,
        toastLength: Toast.LENGTH_SHORT);
    Get.back();
    varifyPayment(response.paymentId!);
  }

  void _handlerErrorFailure(PaymentFailureResponse response) {
    print("payment Error");
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message!,
        toastLength: Toast.LENGTH_SHORT);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("External Error");
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName!,
        toastLength: Toast.LENGTH_SHORT);
  }

  // RazorPay

  // final PagingController<int, OrderData> pagingControllerOrder =
  // PagingController(firstPageKey: 1);
  // @override
  // void onInit() {
  //   pagingControllerOrder.addPageRequestListener((pageKey) {
  //     fetchPage(pageKey);
  //   });
  //   super.onInit();
  //   // getOrderData();
  // }

  RxBool isEarningLoading = true.obs;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final myControllerStartDate = TextEditingController();
  final myControllerEndDate = TextEditingController();
  final myControllerPayment = TextEditingController();


  clearTextInput() {
    myControllerPayment.clear();
  }

  var Dob;
  Rx<DateTime> selectedStartDate = DateTime.now().obs;
  Rx<DateTime> selectedEndDate = DateTime.now().obs;
  RxString selectedEarning = "EARNING".obs;

  // RxString selectedOrderType = "ASSIGNED".obs;
  @override
  void onInit() {
    //TODO Razorpay
    razorpay = Razorpay();
    razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlerPaymentSuccess);
    razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, _handlerErrorFailure);
    razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    //TODO date time
    myControllerStartDate.text = DateFormat('MMMM dd, yyyy')
        .format(DateTime.now().subtract(const Duration(days: 1)));

    myControllerEndDate.text =
        DateFormat('MMMM dd, yyyy').format(DateTime.now());
    super.onInit();
    getAccessToken().then((value) => driverEarning(value!,
        Get.find<ProfileController>().profileDataHome.value.id.toString()));
    // getVehicleList();
    // getProfileData();
  }

//TODO: SAVE ACCESS TOKEN BY SHARED PREFERENCES
  Future<void> saveAccessToken(String tokenData) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString("access_token", tokenData);
    print(tokenData);
  }

  Future<String?> getAccessToken() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString("access_token");
  }

//TODO: DRIVER EARNING
  Future<DriverEarningData> driverEarning(String accessToken, driverId) async {
    isEarningLoading.value = true;
    SharedPreferences prefe = await SharedPreferences.getInstance();
    String? accessToken = prefe.getString("access_token");

    DriverEarningData result = await Repository.driverEarning(driverId,
        accessToken!, myControllerStartDate.text, myControllerEndDate.text);
    if (result.success!) {
      earningList.value = result.data!;
      isEarningLoading.value = false;
      return result;
    } else {
      isEarningLoading.value = false;
      return DriverEarningData();
    }
  }

  Future<CashInHandResponse?> driverWalletTrans(driverId) async {
    String? accessToken = await getAccessToken();
    CashInHandResponse result =
        await Repository.walletTrans(accessToken, driverId);
    if (result.data != null) {
      if (result.success!) {
        print("Driver Wallet Transaction");
        storedWalletTransactionData.value = result;
        return result;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<void> initiateRazorpay(
      String accessToken, paymentTypeId, amount, remarks) async {
    isEarningLoading.value = true;
    SharedPreferences prefe = await SharedPreferences.getInstance();
    String? accessToken = prefe.getString("access_token");
    RazorPayPaymentResponse result = await Repository.initiateRazorpay(
      accessToken!,
      paymentTypeId,
      amount,
      remarks,
    );
    if (result.success!) {
      isEarningLoading.value = false;
      openCheckout(result.data!.id!);
      clearTextInput();
      refresh();
    } else {
      isEarningLoading.value = false;
    }
  }

  Future<void> varifyPayment(String paymentId) async {
    SharedPreferences prefe = await SharedPreferences.getInstance();
    String? accessToken = prefe.getString("access_token");
    PaymentVerifyResponse result = await Repository.verifyPayment(
      paymentId,
      accessToken!,

    );
    if (result.success!) {
      print("walletRecharge");
      walletRecharge(
          result.data!.id.toString(),
          int.parse((result.data!.amount!/100).toStringAsFixed(0)),
        "payment for bootCash",
      );
      const CircularProgressIndicator(
        color: Colors.green,
      );

    } else {
      Fluttertoast.showToast(
          msg: "Payment Failed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  // WalletRecharge
  Future<void> walletRecharge(String paymentTypeId, int amount, String remarks) async {
    SharedPreferences prefe = await SharedPreferences.getInstance();
    String? accessToken = prefe.getString("access_token");
    WalletRechargeResponse result = await Repository.walletRecharge(
      accessToken!,
      paymentTypeId,
      amount,
      remarks,
    );
    if (result.success!) {
      isEarningLoading.value = false;
      selectedEarning.value="CASH IN HAND";
      driverWalletTrans(profileController.profileDataHome.value.id.toString());
      profileController.profileData();
      update();
    } else {
      Fluttertoast.showToast(
          msg: "Wallet Failed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      isEarningLoading.value = false;
    }
  }
}
