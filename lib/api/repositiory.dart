import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dunzodriver_copy1/api/api_routes.dart';
import 'package:dunzodriver_copy1/models/Service_order_model/service_order.dart';
import 'package:dunzodriver_copy1/models/Service_order_model/service_status_model.dart';
import 'package:dunzodriver_copy1/models/duty_response.dart';
import 'package:dunzodriver_copy1/models/earning_response.dart';
import 'package:dunzodriver_copy1/models/infomatiion_response.dart';
import 'package:dunzodriver_copy1/models/order_details_response.dart';
import 'package:dunzodriver_copy1/models/order_reject_response.dart';
import 'package:dunzodriver_copy1/models/order_status_change_response.dart';
import 'package:dunzodriver_copy1/models/ordermodels/driver_trans_response.dart';
import 'package:dunzodriver_copy1/models/ordermodels/order_details_accpect_response.dart';
import 'package:dunzodriver_copy1/models/ordermodels/order_stat_response.dart';
import 'package:dunzodriver_copy1/models/otpverification_response.dart';
import 'package:dunzodriver_copy1/models/payment_model/payment_verify_response.dart';
import 'package:dunzodriver_copy1/models/payment_model/razorpay_response.dart';
import 'package:dunzodriver_copy1/models/payment_model/wallet_recharge_response.dart';
import 'package:dunzodriver_copy1/models/phone_loginresponse.dart';
import 'package:dunzodriver_copy1/models/profile_data_response.dart';
import 'package:dunzodriver_copy1/models/select_Item_model.dart';
import 'package:dunzodriver_copy1/models/settingmodels/setting_response.dart';
import 'package:dunzodriver_copy1/models/sync_driver_response.dart';
import 'package:dunzodriver_copy1/models/vehicle_details_response.dart';
import 'package:dunzodriver_copy1/models/vehicle_response.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Repository {
  static Dio get _dio {
    return Dio(
      BaseOptions(
        baseUrl: ApiRoutes.BASE_URL,
        headers: {
          '${Headers.contentTypeHeader}': 'application/json',
        },
        // contentType: Headers.formUrlEncodedContentType,
      ),
    )..interceptors.addAll(
        [
          PrettyDioLogger(requestBody: true),
        ],
      );
  }

  static Dio _dioAccess(String? accessToken) {
    print("brearer token");
    print(accessToken);
    return Dio(
      BaseOptions(
        baseUrl: ApiRoutes.BASE_URL,
        headers: {
          "Authorization": "Bearer $accessToken",
          '${Headers.contentTypeHeader}': '${Headers.jsonContentType}',
          'Accept': 'application/json'
        },
        // contentType: Headers.formUrlEncodedContentType,
      ),
    )..interceptors.addAll(
        [
          PrettyDioLogger(requestBody: true, request: true, responseBody: true),
        ],
      );
  }

  static Dio _dioMultipart(String accessToken) {
    return Dio(
      BaseOptions(
        baseUrl: ApiRoutes.BASE_URL,
        headers: {
          "Authorization": "Bearer $accessToken",
          'Content-Type': 'multipart/form-data',
          "Accept": "application/json"
        },
        // contentType: Headers.formUrlEncodedContentType,
      ),
    )..interceptors.addAll(
        [
          PrettyDioLogger(requestBody: true),
        ],
      );
  }

  //LoginPage_Api
  static Future<PhoneLoginResponse> phoneLogin(String phone) async {
    try {
      final response = await _dio.post(ApiRoutes.driverPhoneLogin, data: {
        'mobile': phone,
      });
      return PhoneLoginResponse.fromJson(response.data);
    } catch (e) {
      print(e);
      return PhoneLoginResponse();
    }
  }

  //OtpVerification api
  static Future<OTPResponse?> otpVerify(String phone, otp) async {
    try {
      final response = await _dio.post(ApiRoutes.otpVerify, data: {
        'mobile': phone,
        'otp': otp,
      });
      return OTPResponse.fromJson(response.data);
    } catch (e) {
      print(e);
      return null;
    }
  }

  // Personal Information
  static Future<PersonalInformationResponse> informationVerify(
    String secondmobile,
    String name,
    String Dob,
    String language,
    String email,
    XFile? profileimage,
    String? accessToken,
  ) async {
    print("language imfo");
    File image = File(profileimage!.path);
    print("language imfo2");
    try {
      FormData formData = FormData();
      if (image != null && image.path.isNotEmpty) {
        var fromData = MultipartFile.fromFile(image.path,
            filename: image.path.split('/').last);
        formData = FormData.fromMap({
          'secondary_mobile': secondmobile,
          'name': name,
          'dob': Dob,
          'languages': language,
          'email':email,
          'profile_img': await fromData,
        });
      } else {
        formData = FormData.fromMap({
          'secondary_mobile': secondmobile,
          'name': name,
          'dob': Dob,
          'languages': language,
        });
      }

      final response = await _dioMultipart(accessToken!)
          .post(ApiRoutes.informationVerify, data: formData);
      return PersonalInformationResponse.fromJson(response.data);
    } catch (e) {
      print(e);
      print("language imfo4");
    }
    return PersonalInformationResponse();
  }

  static Future<VehicleResponse> vehicleVerify() async {
    try {
      final response = await _dio.get(
        ApiRoutes.vehicleVerify,
      );
      if (response.statusCode == 200) {
        return VehicleResponse.fromJson(response.data);
      }
    } catch (e) {
      print(e);
    }
    return VehicleResponse();
  }

  static Future<VehicleDetailsResponse> vehicleDetailsVerify(
    String vehicleType,
    String vehicleRegistrationNumber,
    String vehicleColor,
    XFile? vehicleImage,
    String accessToken,
  ) async {
    File image = File(vehicleImage!.path);
    try {
      var fromData = MultipartFile.fromFile(image.path,
          filename: image.path.split('/').last);
      final response =
          await _dioMultipart(accessToken).post(ApiRoutes.informationVerify,
              data: FormData.fromMap({
                "vehicle_reg_no": vehicleRegistrationNumber,
                "vehicle_color": vehicleColor,
                "vehicle_img": await fromData,
              }));
      if (response.statusCode! >=200&& response.statusCode! <=300) {
        return VehicleDetailsResponse.fromJson(response.data);
      }else{
        Get.snackbar("Error", "${response.statusMessage}");
      }
    } catch (e) {
      print(e);
    }
    return VehicleDetailsResponse();
  }

  static Future<VehicleDetailsResponse> uploadDocuments(
    File? frontAadharCardPhoto,
    File? backAadharCardPhoto,
    File? dLPhoto,
    String accessToken,
  ) async {
    var formDatafrontAadhar = MultipartFile.fromFile(frontAadharCardPhoto!.path,
        filename: frontAadharCardPhoto.path.split('/').last);
    var formDataBackAadhar = MultipartFile.fromFile(backAadharCardPhoto!.path,
        filename: backAadharCardPhoto.path.split('/').last);
    var formDataDl = MultipartFile.fromFile(dLPhoto!.path,
        filename: dLPhoto.path.split('/').last);
    print("DL: ${dLPhoto.path.split('/').last}");
    print("A: ${frontAadharCardPhoto.path.split('/').last}");
    print("AB: ${backAadharCardPhoto.path.split('/').last}");
    final response =
        await _dioMultipart(accessToken).post(ApiRoutes.informationVerify,
            data: FormData.fromMap({
              "aadhar_photo": await formDatafrontAadhar,
              "aadhar_photo_back": await formDataBackAadhar,
              "dl_photo": await formDataDl,
            }));
    return VehicleDetailsResponse.fromJson(response.data);
  }

  static Future<VehicleDetailsResponse> uploadBankAccountDetails(
      String BankName,
      String AccountNumber,
      String IFSCCode,
      String BranchName,
      String accessToken) async {
    try {
      final response = await _dioAccess(accessToken)
          .post(ApiRoutes.informationVerify, data: {
        "bank_name": BankName,
        "account_no": AccountNumber,
        "ifsc_code": IFSCCode,
        "branch_name": BranchName,
      });
      return VehicleDetailsResponse.fromJson(response.data);
    } catch (e) {
      print(e);
    }
    return VehicleDetailsResponse();
  }

  //Emergency contact details
  static Future<VehicleDetailsResponse> emergencyContactDetails(
      String EmergencyContactNumber,
      String EmergencyContactName,
      String YourRelation,
      String? accessToken) async {
    try {
      final response = await _dioAccess(accessToken)
          .post(ApiRoutes.informationVerify, data: {
        "emergency_contact_no": EmergencyContactNumber,
        "emergency_contact_name": EmergencyContactName,
        "emergency_contact_relation": YourRelation,
      });
      return VehicleDetailsResponse.fromJson(response.data);
    } catch (e) {
      print(e);
    }
    return VehicleDetailsResponse();
  }

  // Future<void> convertImageUrlToFile(String imageUrl) async {
  //   final Response responseData = await _dio.get(imageUrl);
  //
  //   Uint8List uint8list = responseData.data;
  //   var buffer = uint8list.buffer;
  //   ByteData byteData = ByteData.view(buffer);
  //   var tempDir = await getTemporaryDirectory();
  //   File file = await File('${tempDir.path}/img').writeAsBytes(
  //       buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
  // }

  static Future<OTPResponse> getProfile(accessToken) async {
    print("getProfileAccessToken");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? accessToken = preferences.getString("access_token");

    try {
      final response = await _dioAccess(accessToken != null
              ? accessToken
              : preferences.getString("access_token")).get(ApiRoutes.getProfile);
      return OTPResponse.fromJson(response.data);
    } catch (e) {
      print(e);
    }
    return OTPResponse();
  }

  static Future<ProfileDataResponse> getProfileHome(accessToken) async {
    print("accessToken edit Profile");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? accessToken = preferences.getString("access_token");

    try {
      final response = await _dioAccess(accessToken != null ? accessToken
              : preferences.getString("access_token"))
          .get(ApiRoutes.getProfile);
      return ProfileDataResponse.fromJson(response.data);
    } catch (e) {
      print(e);
    }
    return ProfileDataResponse();
  }

  static Future<OrderDetailsResponse> getOrderDetails(
      accessToken, pageNumber, String value, String? driverId) async {
    try {
      Map<String, String> data = Map();
      data['page'] = pageNumber.toString();
      if (value == "DELIVERED") {
        data['search'] = "driver_id:" + driverId.toString();
        data['searchJoin'] = "and";
        data['status'] = value;
      } else {
        data['search'] = "driver_id:" + driverId.toString();
        data['searchJoin'] = "and";
      }
      final response = await _dioAccess(accessToken).get(ApiRoutes.pendingOrders, queryParameters: data);
      try {
        return OrderDetailsResponse.fromJson(response.data);
      } catch (e) {
        print(e);
      }
    } catch (e) {
      print(e);
    }
    return OrderDetailsResponse();
  }

  static Future<OrderStatusResponse?> confrimOrder(
    XFile FoodImages,
    List<SelectItem> selectItem,
    String accessToken,
    String orderId,
    String driverComment,
  ) async {
    try {
      File images = File(FoodImages.path);
      String confrimOrderEnd = ApiRoutes.getOrder + "/" + orderId + "/changestatus";
      var fromData = MultipartFile.fromFile(images.path,
          filename: images.path.split('/').last);
      print(accessToken);
      final response = await _dioMultipart(accessToken).post(confrimOrderEnd,
          data: FormData.fromMap({
            'status': "PICKEDUP",
            'pickup_items': selectItem,
            'images[]': await fromData,
            'comment': driverComment,
          }));
      return OrderStatusResponse.fromJson(response.data);
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<OrderStatusResponse?> confrimCabOrder(
      String accessToken,
      String orderId,
      ) async {
    try {
      String confrimOrderEnd = ApiRoutes.getOrder + "/" + orderId + "/changestatus";
      print(accessToken);
      final response = await _dioAccess(accessToken).post(confrimOrderEnd,
          data: FormData.fromMap({
            'status': "PICKEDUP",
          }));
      return OrderStatusResponse.fromJson(response.data);
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<OrderStatusResponse?> markAsDeliveredOrder(
    String comment,
    String orderId,
    String accessToken,
  ) async {
    try {
      String deliveryEndPoint =
          ApiRoutes.getOrder + "/" + orderId + "/changestatus";
      final response =
          await _dioAccess(accessToken).post(deliveryEndPoint, data: {
        'status': "DELIVERED",
        'comment': comment,
      });
      print("Response fetched");
      return OrderStatusResponse.fromJson(response.data);
    } catch (e) {
      print(e);
    }
    return null;
  }

  static Future<OrderStatusResponse?> markAsReachedOrder(
    String comment,
    String orderId,
    String accessToken,
  ) async {
    try {
      String deliveryEndPoint =
          ApiRoutes.getOrder + "/" + orderId + "/changestatus";
      final response =
          await _dioAccess(accessToken).post(deliveryEndPoint, data: {
        'status': "REACHED",
        'comment': comment,
      });
      print("Response fetched");
      return OrderStatusResponse.fromJson(response.data);
    } catch (e) {
      print(e);
    }
    return null;
  }

  static Future<DriverDutyResponse> dutyOnAndOff(
      String accessToken, String type) async {
    try {
      // String driverOnAndOffDuty=ApiRoutes.getProfile+"/"+type+"/duty";
      final data = {
        'type': type,
      };
      final response = await _dioAccess(accessToken).post(ApiRoutes.driverDuty,
          data: data,
          options: Options(followRedirects: false, validateStatus: (status) {
                return status! < 500;
              }));
      return DriverDutyResponse.fromJson(response.data);
    } catch (e) {
      print(e);
    }
    return DriverDutyResponse();
  }

  static Future<SyncDriverResponse?> syncDriver(
    String accessToken,
    String latitude,
    String longitude,
    String fcm_token,
      String bearing,
  ) async {
    print("in sync driver");
    try {
      final response =
          await _dioAccess(accessToken).post(ApiRoutes.syncdriver, data: {
        "latitude": latitude,
        "longitude": longitude,
        "fcm_token": fcm_token,
            "bearing": bearing.trim().isNotEmpty?bearing:"0",
      });
      print("below response");
      print(response.data.toString());
      return SyncDriverResponse.fromJson(response.data);
    } catch (e) {
      print("in catch error");
      print(e);
    }
    // return SyncDriverResponse();
  }

  static Future<DriverEarningData> driverEarning(
    String driverId,
    String accessToken,
    String startDate,
    String endDate,
  ) async {
    Map<String, String> data = Map();
    data['search'] = "driver_id:" + driverId.toString();
    try {
      final response = await _dioAccess(accessToken)
          .post(ApiRoutes.driverEarning, data: {
        "start_date": startDate,
        "end_date": endDate,
        "driver_id": driverId
      });
      return DriverEarningData.fromJson(response.data);
    } catch (e) {
      print(e);
    }
    return DriverEarningData();
  }

  static Future<SettingResponse> getSetting(accessToken) async {
    try {
      final response = await _dioAccess(accessToken).get(
        ApiRoutes.setting,
      );
      if (response.statusCode == 200) {
        return SettingResponse.fromJson(response.data);
      }
    } catch (e) {
      print(e);
    }
    return SettingResponse();
  }

  static Future<OrderDetails> orderDetailsData(
      accessToken, String orderId) async {
    try {

    } catch (e) {
      print(e);
    }
    final response =
    await _dioAccess(accessToken).get(ApiRoutes.orderDetails + orderId);
    if (response.statusCode == 200) {
      return OrderDetails.fromJson(response.data);
    }
    return OrderDetails();
  }

  static Future<OrderDetails?> markAsOrderAccepted(
    String orderId,
    String accessToken,
  ) async {
    try {
      String deliveryEndPoint =
          ApiRoutes.getOrder + "/" + orderId + "/changestatus";
      final response = await _dioAccess(accessToken).post(deliveryEndPoint, data: {
        'status': "DRIVERACCEPTED",
      });
      print(response.data);
      return OrderDetails.fromJson(response.data);
    } on DioError catch (e) {
      print(e.response!.data);
      if(e.response!.statusCode! >=400){
        Map<String ,dynamic> response ={};
        response  =e.response!.data;
        if(response.containsKey("success")){
          return OrderDetails.fromJson(response);
        }
      }
    }
    return null;
  }

  static Future<OrderStatistics> orderStat(accessToken) async {
    try {
      final response =
          await _dioAccess(accessToken).get(ApiRoutes.orderStatistics);
      if (response.statusCode == 200) {
        return OrderStatistics.fromJson(response.data);
      }
    }  catch (e) {
      print(e);
    }
    return OrderStatistics();
  }

  static Future<OrderDetails?> markAsOrderCanceled(
    String orderId,
    String accessToken,
  ) async {
    try {
      String deliveryEndPoint = ApiRoutes.getOrder + "/" + orderId + "/changestatus";
      final response =
          await _dioAccess(accessToken).post(deliveryEndPoint, data: {
        'status': "DRIVERCANCELED",
      });
      print(response.data);
      return OrderDetails.fromJson(response.data);
    }on DioError catch (e) {
      print(e.response!.data);

    }
    return null;
  }

  static Future<CashInHandResponse> walletTrans(
      accessToken, String driverId) async {
    try {
      Map<String, String> data = Map();
      data['search'] = "driver_id:" + driverId.toString();

      final response = await _dioAccess(accessToken)
          .get(ApiRoutes.walletTransactions, queryParameters: data);
      if (response.statusCode == 200) {
        return CashInHandResponse.fromJson(response.data);
      }
    } catch (e) {
      print(e);
    }
    return CashInHandResponse();
  }

  // initiateRazorpay
  static Future<RazorPayPaymentResponse> initiateRazorpay(
    String accessToken,
    String paymentTypeId,
    num amount,
    String remarks,
  ) async {
    try {
      final response = await _dioAccess(accessToken)
          .post(ApiRoutes.initiateRazorpayPayment, data: {
        "payment_type_id": paymentTypeId,
        "amount": amount * 100,
        "remarks": remarks,
      });
      return RazorPayPaymentResponse.fromJson(response.data);
    } catch (e) {
      print(e);
    }
    return RazorPayPaymentResponse();
  }

  static Future<PaymentVerifyResponse> verifyPayment(
    String paymentId,
    String accessToken,
  ) async {
    try {
      final response =
          await _dioAccess(accessToken).post(ApiRoutes.verifyPayment, data: {
        "payment_id": paymentId,
        "payment_type_id": "1",
        "remarks": "payment for bootCash",
      });
      return PaymentVerifyResponse.fromJson(response.data);
    } catch (e) {
      print(e);
    }
    return PaymentVerifyResponse();
  }

  static Future<WalletRechargeResponse> walletRecharge(
    String accessToken,
    String paymentTypeId,
    int amount,
    String remarks,
  ) async {
    try {
      final response =
          await _dioAccess(accessToken).post(ApiRoutes.walletRecharge, data: {
        "payment_type_id": paymentTypeId,
        "amount": amount,
        "remarks": remarks,
      });
      return WalletRechargeResponse.fromJson(response.data);
    } catch (e) {
      print(e);
    }
    return WalletRechargeResponse();
  }

  static Future<RejectResponse> rejectOrder(
      String accessToken, String comment, int orderId) async {
    try {
      final response =
          await _dioAccess(accessToken).post(ApiRoutes.rejectOrder, data: {
        "order_id": orderId,
        "comment": comment,
      });
      return RejectResponse.fromJson(response.data);
    }on DioError catch (e) {
      print(e.response!.data);
      if(e.response!.statusCode! >= 400){
        Map<String , dynamic> response = {};
        response= e.response!.data;
        if(response.containsKey("success")){
          return RejectResponse.fromJson(response);
        }
      }
    }
    return RejectResponse();
  }


  static Future<ServiceResponse?> getServiceOrder(
      accessToken,
      id,
      )async {
    try{
      final response = await _dioAccess(accessToken).get(ApiRoutes.serviceCompletedOrder+id);
      if (response.statusCode==200) {
        print(response);
        return ServiceResponse.fromJson(response.data);
      }
    }on DioError catch(e){
      print(e.response!.data);
      if (e.response!.statusCode! >= 400) {
        Map<String ,dynamic> response ={};
        response =e.response!.data;
        print('ServiceCompletedorder');
        if(response.containsKey("success")){
          return ServiceResponse.fromJson(response);
        }
      }
      return null;
    }
    // final response = await _dioAccess(accessToken).get(ApiRoutes.serviceCompletedOrder + id);
    // if (response.statusCode == 200) {
    //   print(response);
    //   return ServiceResponse.fromJson(response.data);
    // }
  }

  static Future<ServiceStatusResponse?> markAsAcceptedService(
      String orderId,
      String accessToken,
      ) async {
    try {
      final response =
      await _dioAccess(accessToken).post(ApiRoutes.serviceStatus, data: {
        "id":orderId,
        'status': "ACCEPTED",
      });
      print("Response Accepted");
      return ServiceStatusResponse.fromJson(response.data);
    }on DioError catch (e) {
      print(e.response!.statusMessage);
      if(e.response!.statusCode! >=400){
        Get.snackbar("Error", "${e.response!.statusMessage}",backgroundColor:Colors.red );
      }
    }
    return null;
  }
  static Future<ServiceStatusResponse?> markAsStarted(
      String orderId,
      String accessToken,
      ) async {
    try {
      final response =
      await _dioAccess(accessToken).post(ApiRoutes.serviceStatus, data: {
        'id': orderId,
        'status': "STARTED",
      });
      print(" started Response ");
      return ServiceStatusResponse.fromJson(response.data);
    }on DioError catch (e) {
      print(e.response!.statusMessage);
      if(e.response!.statusCode! >=400){
        Get.snackbar("Error", "${e.response!.statusMessage}",backgroundColor:Colors.red );
      }
    }
    return null;
  }
  static Future<ServiceStatusResponse?> markAsFinished(
      String orderId,
      String accessToken,
      ) async {
    try {
      final response =
      await _dioAccess(accessToken).post(ApiRoutes.serviceStatus, data: {
        'id': orderId,
        'status': "FINISHED",
      });
      print("Response fetched");
      return ServiceStatusResponse.fromJson(response.data);
    } on DioError catch (e) {
      print(e.response!.statusMessage);
      if(e.response!.statusCode! >=400){
        Get.snackbar("Error", "${e.response!.statusMessage}",backgroundColor:Colors.red );
      }
    }
    return null;
  }
  static Future<ServiceStatusResponse?> markAsCompleted(
      String orderId,
      String accessToken,
      ) async {
    try {
      final response =
      await _dioAccess(accessToken).post(ApiRoutes.serviceStatus, data: {
        'id': orderId,
        'status': "COMPLETED",
      });
      print("Response fetched");
      return ServiceStatusResponse.fromJson(response.data);
    }on DioError catch (e) {
      print(e.response!.statusMessage);
      if(e.response!.statusCode! >=400){
        Get.snackbar("Error", "${e.response!.statusMessage}",backgroundColor:Colors.red );
      }
    }
    return null;
  }
  static Future<ServiceStatusResponse?> markAsCanceled(
      String orderId,
      String accessToken,
      ) async {
    try {
      final response =
      await _dioAccess(accessToken).post(ApiRoutes.serviceStatus, data: {
        'id': orderId,
        'status': "CANCELLED",
      });
      print("Response fetched");
      return ServiceStatusResponse.fromJson(response.data);
    }on DioError catch (e) {
      print(e.response!.statusMessage);
      if(e.response!.statusCode! >=400){
        Get.snackbar("Error", "${e.response!.statusMessage}",backgroundColor:Colors.red );
      }
    }
    return null;
  }

  static Future<ServiceStatusResponse?> markAsReached(
      String orderId,
      String accessToken,
      ) async {
    try {
      final response =
      await _dioAccess(accessToken).post(ApiRoutes.serviceStatus, data: {
        'id': orderId,
        'status': "REACHED",
      });
      return ServiceStatusResponse.fromJson(response.data);
    }on DioError catch (e) {
      print(e.response!.statusMessage);
      if(e.response!.statusCode! >=400){
        Get.snackbar("Error","${e.response!.statusMessage}",backgroundColor:Colors.red );
      }
    }
    return null;
  }


  static Future<ServiceResponse> getServiceCompletedDetails(
      accessToken, pageNumber, String value, String? driverId) async {
    try {
      print(value);
      Map<String, String> data = {};
      data['page'] = pageNumber.toString();
      if(value=="COMPLETED"){
        data['search'] = "driver_id:" + driverId.toString();
        data['COMPLETED'] = "true";
      }else{
        data['search'] = "driver_id:" + driverId.toString();
        data['UPCOMING'] = "true";
      }

      final response = await _dioAccess(accessToken).get(ApiRoutes.serviceCompletedOrder, queryParameters: data);
      try {
        return ServiceResponse.fromJson(response.data);
      } catch (e) {
        print(e);
      }
    } catch (e) {
      print(e);
    }
    return ServiceResponse();
  }
}
