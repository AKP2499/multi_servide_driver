import 'package:dio/dio.dart';
import 'package:dunzodriver_copy1/api/repositiory.dart';
import 'package:dunzodriver_copy1/models/Service_order_model/service_order.dart';
import 'package:dunzodriver_copy1/models/Service_order_model/service_status_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServiceController extends GetxController {
  final startServiceController = TextEditingController();
  final completedServiceController = TextEditingController();
  var pinn;
  var comPinn;
  RxBool isChecked = false.obs;
  RxString selectedOrderTab = "UPCOMING".obs;
  Rx<ServiceData>? serviceSelectedData = ServiceData().obs;
  Rx<ServiceResponse> storeServiceOrder = ServiceResponse().obs;
  final PagingController<int, ServiceData> pagingControllerOrder =
      PagingController(firstPageKey: 1);
  static const _pageSize = 10;

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<String?> getDriverId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString("driver_id");
    return prefs.getString("driver_id");
  }

  Future<void> saveAccessToken(String tokenData) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString("access_token", tokenData);
    print(tokenData);
  }

  Future<String?> getAccessToken() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString("access_token");
  }

  @override
  void onInit() {
    // TODO: implement onInit
    serviceData();
    fetchPage(1);
    pagingControllerOrder.addPageRequestListener((pageKey) {
      fetchPage(pageKey);
    });
    super.onInit();
  }

  Future<void> fetchPage(int pageKey) async {
    String? accessToken = await getAccessToken();
    print(selectedOrderTab);
    final newServiceItems = await Repository.getServiceCompletedDetails(
        accessToken, pageKey, selectedOrderTab.value, (await getDriverId()));
    if (pageKey == 1) {
      if (pagingControllerOrder.itemList != null) {
        pagingControllerOrder.itemList!.clear();
      }
    }
    print("below new item");
    final isLastPage = newServiceItems.data!.data!.length < _pageSize;
    print("below new ");
    if (isLastPage) {
      print("below new Last True");
      pagingControllerOrder.appendLastPage(newServiceItems.data!.data!);
    } else {
      print("below last ");
      final nextPageKey = pageKey + 1;
      pagingControllerOrder.appendPage(
          newServiceItems.data!.data!, nextPageKey);
    }
    print("below ");
    try {

    }on DioError catch (error) {
      print("below is error");
      Get.snackbar("Error", "${error.response!.statusMessage}");
      print(error.response!.statusMessage);
      pagingControllerOrder.error = error;
    }

    // if (selectedOrderTab.value=="COMPLETED") {
    //
    //
    //
    // }else{
    //   final newServiceItems = await Repository.getServiceDetails(accessToken, pageKey,
    //       selectedOrderTab.value, (await getDriverId())
    //   );
    //   if(pageKey == 1){
    //     if(pagingControllerOrder.itemList!=null){
    //       pagingControllerOrder.itemList!.clear();
    //     }
    //   }
    //   print("below new itme");
    //   print(newServiceItems);
    //   // printError(info: newItems.toJson().toString());
    //   final isLastPage = newServiceItems.data!.data!.length < _pageSize;
    //   if (isLastPage) {
    //     pagingControllerOrder.appendLastPage(newServiceItems.data!.data!);
    //   } else {
    //     final nextPageKey = pageKey + 1;
    //     pagingControllerOrder.appendPage(newServiceItems.data!.data!, nextPageKey);
    //   }
    // }
  }

  Future<ServiceResponse?> serviceData() async {
    String? accessToken = await getAccessToken();
    ServiceResponse? result =
        await Repository.getServiceOrder(accessToken, (await getDriverId()));
    print("response $result");
    if (result!.data != null&& result.success!=null) {
      if (result.success!) {
        print("ServiceData");
        storeServiceOrder.value = result;
        return result;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<ServiceStatusResponse?> acceptServiceOrder(
    String orderId,
  ) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? accessToken = await preferences.getString("access_token");
    ServiceStatusResponse? result = await Repository.markAsAcceptedService(
      orderId,
      accessToken!,
    );
    if (result != null) {
      if (result.success!) {
        print("MaskAsAccepted");
        return result;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<ServiceStatusResponse?> reachedService(
    String orderId,
  ) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? accessToken = await preferences.getString("access_token");
    ServiceStatusResponse? result = await Repository.markAsReached(
      orderId,
      accessToken!,
    );
    if (result != null) {
      if (result.success!) {
        print("MaskAsReached");
        return result;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<ServiceStatusResponse?> startedService(
    String orderId,
  ) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? accessToken = await preferences.getString("access_token");
    ServiceStatusResponse? result = await Repository.markAsStarted(
      orderId,
      accessToken!,
    );
    if (result != null) {
      if (result.success!) {
        print("MaskAsStarted");
        return result;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<ServiceStatusResponse?> finishedService(
    String orderId,
  ) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? accessToken = await preferences.getString("access_token");
    ServiceStatusResponse? result = await Repository.markAsFinished(
      orderId,
      accessToken!,
    );
    if (result != null) {
      if (result.success!) {
        print("MaskAsFinished");
        return result;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<ServiceStatusResponse?> completedService(
    String orderId,
  ) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? accessToken = await preferences.getString("access_token");
    ServiceStatusResponse? result = await Repository.markAsCompleted(
      orderId,
      accessToken!,
    );
    if (result != null) {
      if (result.success!) {
        print("MaskAsCompleted");
        return result;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<ServiceStatusResponse?> cancelService(
    String orderId,
  ) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? accessToken = await preferences.getString("access_token");
    ServiceStatusResponse? result = await Repository.markAsCanceled(
      orderId,
      accessToken!,
    );
    if (result != null) {
      if (result.success!) {
        print("MaskAsCanceled");
        return result;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
}
