import 'dart:async';
import 'package:dunzodriver_copy1/api/repositiory.dart';
import 'package:dunzodriver_copy1/constant/color.dart';
import 'package:dunzodriver_copy1/controller/profile_controller.dart';
import 'package:dunzodriver_copy1/models/order_data.dart';
import 'package:dunzodriver_copy1/models/order_reject_response.dart';
import 'package:dunzodriver_copy1/models/order_status_change_response.dart';
import 'package:dunzodriver_copy1/models/ordermodels/order_details_accpect_response.dart';
import 'package:dunzodriver_copy1/models/ordermodels/order_stat_response.dart';
import 'package:dunzodriver_copy1/models/select_Item_model.dart';
import 'package:dunzodriver_copy1/views/navigation_pages/bottomnavigation_dunzo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderController extends GetxController {
  final myControllerComment = TextEditingController();
  final pickUpOtpController = TextEditingController();
  BitmapDescriptor pickupIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor dropIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor driverIcon = BitmapDescriptor.defaultMarker;
  String? PickupPinn="";
  String? comment = "";
  RxBool? isLoading = true.obs;
  bool isCompleted = false;
  RxBool isChecked = false.obs;
  RxBool? isImageSelected = false.obs;
  final ImagePicker _picker = ImagePicker();
  RxString selectedOrderType = "ASSIGNED".obs;
  late GoogleMapController mapController;
  RxBool? isAccept = false.obs;
  var pinn;


  Rx<OrderStatistics> orderStatisticsDetails = OrderStatistics().obs;
  RxInt counter = 30.obs;
  late Timer timer;

  bool countDown = true;

  void startTimer() {
    print("startTimer");
    counter.value = 30;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (counter.value > 0) {
        counter.value--;
      } else {
        timer.cancel();
      }
    });
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Rx<CameraPosition> initialCameraPosition =  const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  ).obs;
  Rx<XFile> foodImage = XFile("").obs;

  Future getFoodImage() async {
    print("get food image");
   final XFile? tempFoodImage = await _picker.pickImage(source: ImageSource.camera);
    foodImage.value = tempFoodImage!;
    isImageSelected!.value = true;
  }


  // void getImageVehicle() async {
  //   print("get images");
  //   final XFile? image =await _picker.pickImage(source: ImageSource.gallery);
  //   imagevehicle!.value= image!;
  //   print("upload bike image");
  // }
  //
  // Future getImagePanCard() async {
  //   final XFile? image = await _picker.pickImage(source: ImageSource.camera);
  //   imagePanCard!.value = image!;
  // }

  var PickUpItem;

  Rx<OrderData>? selectedOrder = OrderData().obs;
  RxList<SelectItem> selectedItemList = [SelectItem()].obs;

  Rx<OrderDetails> storedOrderDetails = OrderDetails().obs;

  RxBool? isOrderLoading = true.obs;
  RxList<String> itemList = [""].obs;

  Future<void> saveAccessToken(String tokenData) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString("access_token", tokenData);
    print(tokenData);
  }

  Future<String?> getAccessToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString("access_token");
    return prefs.getString("access_token");
  }

  Future<void> saveDriverId(String driverId) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString("driver_id", driverId);
    print(driverId);
  }

  Future<String?> getDriverId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString("driver_id");
    return prefs.getString("driver_id");
  }

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  RxList<OrderData> orderDataDetails = [OrderData()].obs;

  static const _pageSize = 10;

  final PagingController<int, OrderData> pagingControllerOrder = PagingController(firstPageKey: 1);

  @override
  void onInit() {
    orderStatistics();
    setSourceAndDestinationIcons();
    fetchPage(1);
    pagingControllerOrder.addPageRequestListener((pageKey) {
      fetchPage(pageKey);
    });
    super.onInit();
    // getOrderData();
  }

  // Future<OrderDetailsResponse?> getOrderData(int pageKey) async {
  //   // String? accessToken=await getAccessToken();
  //   //  isOrderLoading!.value=true;
  //   //  OrderDetailsResponse result=await Repository.getOrderDetails(accessToken);
  //   //  if(result.data != null){
  //   //    if(result.success!){
  //   //      print("orderData");
  //   //      orderDataDetails.value=result.data!.data!;
  //   //      getItemList();
  //   //
  //   //      isOrderLoading!.value=false;
  //   //      return result;
  //   //    }else{
  //   //      isOrderLoading!.value=false;
  //   //      return null;
  //   //
  //   //    }
  //   //  }else{
  //   //    return null;
  //   //  }
  // }

  Future<void> fetchPage(int pageKey) async {
    // String? accessToken = await getAccessToken();
    try {

    } catch (error) {
      print("below is error");
      print(error);
      pagingControllerOrder.error = error;
    }
    String? accessToken = await getAccessToken();
    final newItems = await Repository.getOrderDetails(accessToken, pageKey,
        selectedOrderType.value, (await getDriverId()));
    if(newItems.message!.contains("DELIVERED")){
      selectedOrderType.value = "DELIVERED";
      update();
    }else{
      selectedOrderType.value="ASSIGNED";
      update();
    }
    if (pageKey == 1) {
      if (pagingControllerOrder.itemList != null) {
        pagingControllerOrder.itemList!.clear();
      }
    }

    // printError(info: newItems.toJson().toString());
    final isLastPage = newItems.data!.data!.length < _pageSize;
    if (isLastPage) {
      pagingControllerOrder.appendLastPage(newItems.data!.data!);
    } else {
      final nextPageKey = pageKey + 1;
      pagingControllerOrder.appendPage(newItems.data!.data!, nextPageKey);
    }
  }

  List<String> getItemList(OrderData orderData) {
    List<String> temp = [''];
    temp.clear();

    for (int j = 0; j < orderData.items!.length; j++) {
      temp.add(orderData.items!.elementAt(j).productName!);
    }
    return temp;
  }

  Future<OrderStatusResponse?> confrimOrder(String orderId,) async {
    String? accessToken = await getAccessToken();
    OrderStatusResponse? result = (await Repository.confrimOrder(
      foodImage.value,
      selectedItemList.value,
      accessToken!,
      orderId,
      comment!,
    ));
    print("Order Id${orderId}");
    print("result: ${result}");
    if (result != null) {
      foodImage.value = XFile("");
      if (result.success!) {
        print('verified');
        return result;
      } else {
        print('hajqqqqj');
        foodImage.value = XFile("");
        return null;
      }
    } else {
      return null;
    }
  }

  Future<OrderStatusResponse?> cabConfrimOrder(String orderId,) async {
    String? accessToken = await getAccessToken();
    OrderStatusResponse? result = (await Repository.confrimCabOrder(
      accessToken!,
      orderId,
    ));
    if (result != null) {
      if (result.success!) {
        print("ConfrimOtp");
        return result;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<OrderStatusResponse?> deliveredOrder(String orderId,
      String comment,) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? accessToken = await preferences.getString("access_token");
    print("access token");
    print(accessToken);

    OrderStatusResponse? result = await Repository.markAsDeliveredOrder(
      comment,
      orderId,
      accessToken!,
    );
    if (result != null) {
      if (result.success!) {
        print("REACHED");
        return result;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<OrderStatusResponse?> reachedOrder(String orderId,
      String comment,) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? accessToken = await preferences.getString("access_token");
    print("access token");
    print(accessToken);

    OrderStatusResponse? result = await Repository.markAsReachedOrder(
      comment,
      orderId,
      accessToken!,
    );
    if (result != null) {
      if (result.success!) {
        print("deliveredOtpVerified");
        return result;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
  // Location currentLocation = Location();
  //
  // void getLocation() async{
  //   var location = await currentLocation.getLocation();
  //   currentLocation.onLocationChanged.listen((LocationData loc){
  //
  //     mapController.animateCamera(CameraUpdate.newCameraPosition(
  //         CameraPosition(
  //       target: LatLng(37.42796133580664, -122.085749655962),
  //       zoom: 12.0,
  //     )));
  //     print(loc.latitude);
  //     print(loc.longitude);
  //     markers.values;
  //     LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0);
  //   });
  // }


  void updateInitialPosition(LatLng latlng){
    initialCameraPosition = CameraPosition(target: latlng,zoom: 20.0).obs;
    getPolyline();
    try {
      mapController.moveCamera(CameraUpdate.newLatLngZoom(
          initialCameraPosition.value.target, 15));

    } catch (e) {
      print(e);
    }
  }


  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};

  addPolyLine(List<LatLng> polylineCoordinates) {
    polylines.clear();
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      points: polylineCoordinates,
      width: 4,
      color: Constant.secondary,
    );
    polylines[id] = polyline;
    update();
    mapController.animateCamera(
      CameraUpdate.newLatLngBounds(
        boundsFromLatLngList(polylineCoordinates),
        100,
      ),
    );

  }

  void setSourceAndDestinationIcons() async {
    pickupIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(devicePixelRatio: 2.5),
        "lib/Images/pickup_icon.png");
    dropIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(devicePixelRatio: 2.5),
        "lib/Images/drop_icon.png");
    driverIcon = await BitmapDescriptor.fromAssetImage(
         const ImageConfiguration(devicePixelRatio: 2.5,),
        "lib/Images/delivery_icon.png",);
    update();
  }

  LatLngBounds boundsFromLatLngList(List<LatLng> list) {
    assert(list.isNotEmpty);
    double? x0, x1, y0, y1;
    for (LatLng latLng in list) {
      if (x0 == null) {
        x0 = x1 = latLng.latitude;
        y0 = y1 = latLng.longitude;
      } else {
        if (latLng.latitude > x1!) x1 = latLng.latitude;
        if (latLng.latitude < x0) x0 = latLng.latitude;
        if (latLng.longitude > y1!) y1 = latLng.longitude;
        if (latLng.longitude < y0!) y0 = latLng.longitude;
      }
    }
    return LatLngBounds(northeast: LatLng(x1!, y1!), southwest: LatLng(x0!, y0!));
  }

  void getPolyline() async {
    print("live location");
    print(double.parse(Get.find<ProfileController>().syncLat!.value.toString()));


    List<LatLng> polylineCoordinates = [];
    PointLatLng startLocation= const PointLatLng(0.0, 0.0);
    PointLatLng endLocation= const PointLatLng(0.0, 0.0);
    if( (selectedOrder!.value.orderStatus=="ASSIGNED")){
      startLocation= PointLatLng(double.parse(Get.find<ProfileController>().syncLat!.value.toString()),
          double.parse(Get.find<ProfileController>().syncLong!.value.toString()));
          endLocation= PointLatLng( double.parse(selectedOrder!.value.pickupAddress!.latitude!.toString()),
              double.parse(selectedOrder!.value.pickupAddress!.longitude!.toString()));

    }else if(selectedOrder!.value.orderStatus=="PICKEDUP"){
      startLocation=PointLatLng(double.parse(Get.find<ProfileController>().syncLat!.value.toString()),
          double.parse(Get.find<ProfileController>().syncLong!.value.toString()));
      endLocation= PointLatLng(double.parse(selectedOrder!.value.deliveryAddress!.latitude!.toString()),
          double.parse(selectedOrder!.value.deliveryAddress!.longitude!.toString()));

    }else if(selectedOrder!.value.orderStatus=="REACHED"){
      startLocation=PointLatLng( double.parse(selectedOrder!.value.pickupAddress!.latitude!.toString()),
          double.parse(selectedOrder!.value.pickupAddress!.longitude!.toString()));
      endLocation= PointLatLng(double.parse(selectedOrder!.value.deliveryAddress!.latitude!.toString()),
          double.parse(selectedOrder!.value.deliveryAddress!.longitude!.toString()));

    }else if(selectedOrder!.value.orderStatus=="DELIVERED"){
      startLocation=PointLatLng( double.parse(selectedOrder!.value.pickupAddress!.latitude!.toString()),
          double.parse(selectedOrder!.value.pickupAddress!.longitude!.toString()));
      endLocation= PointLatLng(double.parse(selectedOrder!.value.deliveryAddress!.latitude!.toString()),
          double.parse(selectedOrder!.value.deliveryAddress!.longitude!.toString()));
    }
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        "AIzaSyBIvvIdFLH_dzuu__7c8WQKhxfvDSOL2Zw",
      // Get.find<ProfileController>().storedSettingData.value.data!.androidForceUpdate!,
        startLocation,
      endLocation,
      travelMode: TravelMode.driving
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    addPolyLine(polylineCoordinates);
  }

  Future<OrderDetails?> orderDetails(String orderId) async {
    List<LatLng> polylineCoordinates = [];
    isLoading!.value = true;
    String? accessToken = await getAccessToken();
    OrderDetails result =
    await Repository.orderDetailsData(accessToken, orderId);
    if (result.data != null) {
      if (result.success!){
        print("orderDetails");
        storedOrderDetails.value = result;
        selectedOrder!.value = result.data!;
        markers.clear();
        print(double.parse(selectedOrder!.value.pickupAddress!.latitude.toString()));
        print(double.parse(selectedOrder!.value.deliveryAddress!.latitude.toString()));
        initialCameraPosition = CameraPosition(
            target: (selectedOrder!.value.store==null)?LatLng(
                    double.parse(selectedOrder!.value.pickupAddress!.latitude.toString()),
                  double.parse(selectedOrder!.value.pickupAddress!.longitude.toString())
            ):LatLng(double.parse(selectedOrder!.value.store!.latitude.toString()),
                double.parse(selectedOrder!.value.store!.longitude.toString())),
            zoom: 14.4746,
            bearing: 90)
            .obs;
        final marker = Marker(
          markerId: const MarkerId('Pickup Location'),
          position: LatLng(
              double.parse(selectedOrder!.value.pickupAddress!.latitude.toString()),
              double.parse(selectedOrder!.value.pickupAddress!.longitude.toString())),
          icon: pickupIcon,
          infoWindow: InfoWindow(
            title: 'PickUP At ${selectedOrder!.value.user!.name}',
            snippet: '${selectedOrder!.value.pickupAddress!.address}',
          ),
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: const Offset(0.5, 0.5),
        );
        markers[MarkerId('${selectedOrder!.value.pickupAddress}')] = marker;
        final markerDelivery = Marker(
          markerId: const MarkerId('Drop Location'),
          position: LatLng(
              double.parse(selectedOrder!.value.deliveryAddress!.latitude.toString()),
              double.parse(selectedOrder!.value.deliveryAddress!.longitude.toString())),
          icon: dropIcon,
          infoWindow: InfoWindow(
            title: 'Drop At ${selectedOrder!.value.user!.name}',
            snippet: '${selectedOrder!.value.deliveryAddress!.address}',
          ),
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: const Offset(0.5, 0.5),
        );
        markers[MarkerId('${selectedOrder!.value.deliveryAddress}')] = markerDelivery;
        final driverMarker =Marker(
          markerId: const MarkerId('Driver Location'),
          position: LatLng(
              double.parse(Get.find<ProfileController>().syncLat!.value.toString()),
              double.parse(Get.find<ProfileController>().syncLong!.value.toString())),
          icon: driverIcon,
          infoWindow: InfoWindow(
            title: 'Driver Location',
            snippet: '${selectedOrder!.value.deliveryAddress!.address}',
          ),
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: const Offset(0.5, 0.5),
        );
        markers[MarkerId('${selectedOrder!.value.driver}')] = driverMarker;
        isLoading!.value = false;
        getPolyline();
        try {
          mapController.moveCamera(CameraUpdate.newLatLngZoom(
              initialCameraPosition.value.target, 15));
        } catch (e) {
          print(e);
        }

        update();
        return result;
      } else {
        storedOrderDetails.value = OrderDetails(data: null);
        isLoading!.value = false;
        return null;
      }
    } else {
      return null;
    }
  }

  Future<OrderDetails?> acceptedOrder(String orderId,) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? accessToken = await preferences.getString("access_token");

    OrderDetails? result = await Repository.markAsOrderAccepted(
      orderId,
      accessToken!,
    );
    if (result != null&&result.success !=null) {
      if (result.success!) {
        print("MaskAsAccepted");
        return result;
      } else {
        Get.offAll(const BottomNavigation());
        return null;
      }
    } else {
      return null;
    }
  }

  Future<OrderStatistics?> orderStatistics() async {
    // isLoading!.value = true;
    String? accessToken = await getAccessToken();
    OrderStatistics result = await Repository.orderStat(accessToken);
    if (result.data != null) {
      if (result.success!) {
        print("Order Statistics Data");
        orderStatisticsDetails.value = result;
        isLoading!.value = false;
        return result;
      } else {
        isLoading!.value = false;
        return null;
      }
    } else {
      return null;
    }
  }

  Future<OrderDetails?> cancelOrder(String orderId,) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? accessToken = await preferences.getString("access_token");

    OrderDetails? result = await Repository.markAsOrderCanceled(
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

  Future<RejectResponse> rejectOrder(String comment,
      int orderId,) async {
    SharedPreferences prefe = await SharedPreferences.getInstance();
    String? accessToken = prefe.getString("access_token");
    RejectResponse? result = await Repository.rejectOrder(
        accessToken!
        comment,
        orderId
    );
    if (result != null && result.success!=null) {
      if (result.success!) {
        print("reject order");
        Get.off(const BottomNavigation());
        return result;
      } else {
        Get.off(const BottomNavigation());
        return result;
      }
    } else {
      return RejectResponse();
    }
  }

}
