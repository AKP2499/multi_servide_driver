
import 'package:avatar_view/avatar_view.dart';
import 'package:dunzodriver_copy1/constant/color.dart';
import 'package:dunzodriver_copy1/controller/order_controller.dart';
import 'package:dunzodriver_copy1/models/order_status_change_response.dart';
import 'package:dunzodriver_copy1/views/navigation_pages/bottomnavigation_dunzo.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:url_launcher/url_launcher.dart';

class CabService extends StatefulWidget {
  String order_id;

  CabService(this.order_id, {Key? key}) : super(key: key);

  @override
  _CabServiceState createState() => _CabServiceState();
}

class _CabServiceState extends State<CabService> {
  OrderController orderController = Get.put(OrderController());
  @override
  Widget build(BuildContext context) {

    Future.delayed(const Duration(seconds: 1), () {
      print("order details");
      orderController.orderDetails(widget.order_id).then((value) {
        {
          if (value != null) {
            orderController.updateInitialPosition(LatLng(
                value.data?.deliveryAddress?.latitude,
                value.data?.deliveryAddress?.longitude));
            orderController.getPolyline();
          }
        }
      });
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cab Service"),
        centerTitle: true,
        backgroundColor: Constant.secondary,
      ),

      body: Stack(
        children: [
          GetBuilder(builder: (OrderController orderController) {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.6,
              child: GoogleMap(
                  tiltGesturesEnabled: true,
                  compassEnabled: true,
                  onMapCreated: orderController.onMapCreated,
                  mapType: MapType.normal,
                  zoomControlsEnabled: false,
                  myLocationEnabled: true,
                  scrollGesturesEnabled: true,
                  polylines: Set<Polyline>.of(orderController.polylines.values),
                  initialCameraPosition:
                  orderController.initialCameraPosition.value,
                  markers: Set<Marker>.of(orderController.markers.values)
              ),
            );
          }),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Material(
                elevation: 50,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  height: 300.0,
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical:
                    0, horizontal: 15),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 0.0, top: 20, right: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // (orderController.selectedOrder!.value.orderStatus!="PICKEDUP")?Column(
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              //   children:  [
                              //     Text("${orderController.selectedOrder!.value.user!.name}",
                              //       style: const TextStyle(
                              //       color: Colors.black,
                              //       fontWeight: FontWeight.bold,
                              //       fontSize: 16,
                              //     ),),
                              //      const SizedBox(height: 15,),
                              //      SizedBox(
                              //        width: 200,
                              //        child: Column(
                              //          crossAxisAlignment: CrossAxisAlignment.start,
                              //          children: [
                              //             const Text("Pick UP From",style: TextStyle(
                              //               color: Colors.black,
                              //               fontWeight: FontWeight.bold,
                              //               fontSize: 13,
                              //             ),),
                              //            Text("${orderController.selectedOrder!.value.pickupAddress!.address}"
                              //              ,style: const TextStyle(
                              //             color: Constant.secondary,
                              //             fontWeight: FontWeight.normal,
                              //             fontSize: 12,
                              //            ),
                              //            ),
                              //          ],
                              //        ),
                              //      )
                              //   ],
                              // ):
                              // Column(
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              //   children:  [
                              //     Text("${orderController.selectedOrder!.value.user!.name}",
                              //       style: const TextStyle(
                              //         color: Colors.black,
                              //         fontWeight: FontWeight.bold,
                              //         fontSize: 16,
                              //       ),),
                              //     const SizedBox(height: 15,),
                              //     SizedBox(
                              //       width: 200,
                              //       child: Column(
                              //         crossAxisAlignment: CrossAxisAlignment.start,
                              //         children: [
                              //           const Text("Drop Location",style: TextStyle(
                              //             color: Colors.black,
                              //             fontWeight: FontWeight.bold,
                              //             fontSize: 13,
                              //           ),),
                              //           Text("${orderController.selectedOrder!.value.deliveryAddress!.address}"
                              //             ,style: const TextStyle(
                              //               color: Constant.secondary,
                              //               fontWeight: FontWeight.normal,
                              //               fontSize: 12,
                              //             ),
                              //           ),
                              //         ],
                              //       ),
                              //     )
                              //   ],
                              // ),
                              // (orderController.selectedOrder!.value.orderStatus=="DELIVERED")?
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Column(
                                            children: [
                                              Image.asset(
                                                "lib/Images/circle.png",
                                                width: 22,
                                              ),
                                              Column(
                                                children: [
                                                  for (int i = 0; i < 35; i++)
                                                    Container(
                                                      width: 1,
                                                      height: 2,
                                                      decoration: BoxDecoration(
                                                        border: Border(
                                                          bottom: BorderSide(
                                                            width: 1,
                                                            color: i % 2 == 0
                                                                ? const Color
                                                                .fromRGBO(
                                                                214,
                                                                211,
                                                                211,
                                                                1)
                                                                : Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                              Image.asset(
                                                "lib/Images/pin.png",
                                                width: 22,
                                              )
                                            ],
                                          ),
                                          const SizedBox(width: 10,),
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  InkWell(
                                                    onTap: (){
                                                      print("agj");
                                                      orderController.mapController.moveCamera(CameraUpdate.newLatLngZoom(
                                                          LatLng( double.parse(orderController.selectedOrder!.value.pickupAddress!.latitude!.toString()),
                                                              double.parse(orderController.selectedOrder!.value.pickupAddress!.longitude!.toString())),15
                                                      ),
                                                      );
                                                      print("pickup");
                                                    },
                                                    child: Container(
                                                      width: 220,
                                                      child: Text(
                                                        (orderController.selectedOrder!.value
                                                            .pickupAddress !=
                                                            null)
                                                            ? orderController
                                                            .selectedOrder!
                                                            .value
                                                            .pickupAddress!
                                                            .address!
                                                            : "Address Not Found",
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 13,
                                                            fontWeight:
                                                            FontWeight.w500),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                width: 200,
                                                height: 1,
                                                color: Colors.grey,
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              InkWell(
                                                onTap: (){
                                                  orderController.mapController.moveCamera(CameraUpdate.newLatLngZoom(
                                                      LatLng( double.parse(orderController.selectedOrder!.value.deliveryAddress!.latitude!.toString()),
                                                          double.parse(orderController.selectedOrder!.value.deliveryAddress!.longitude!.toString())),15
                                                  ),
                                                  );
                                                },
                                                child: Container(
                                                  width: 220,
                                                  child: Text(
                                                    (orderController.selectedOrder!.value.deliveryAddress !=
                                                        null)
                                                        ? orderController.selectedOrder!.value.deliveryAddress!.address!
                                                        : "Address Not Found",
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 13,
                                                        fontWeight:
                                                        FontWeight.w500),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                        children: [
                                          AvatarView(
                                            radius: 20,
                                            borderColor: Colors.yellow,
                                            avatarType: AvatarType.CIRCLE,
                                            backgroundColor: Colors.red,
                                            imagePath:
                                            "https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg",
                                            placeHolder: Container(
                                              child: const Icon(
                                                Icons.person,
                                                size: 20,
                                              ),
                                            ),
                                            errorWidget: Container(
                                              child: const Icon(
                                                Icons.error,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${orderController.selectedOrder!.value.user!.name}",
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              const SizedBox(height: 10,),
                                              (orderController.selectedOrder!.value.orderStatus=="DELIVERED")?const Text(""):Text(
                                                "${orderController.selectedOrder!.value.user!.mobile}",
                                                style: const TextStyle(
                                                  color: Constant.secondary,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5.0),
                                child: Column(
                                  children: [
                                    InkWell(
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: 70,
                                        decoration: BoxDecoration(
                                          color: Constant.primaryTransparent,
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Row(
                                            children: const [
                                              Icon(
                                                Icons.directions,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                              SizedBox(
                                                width: 10.0,
                                              ),
                                              Text(
                                                "Map",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        if (orderController.selectedOrder!.value.orderStatus == "ASSIGNED") {
                                          openMap(
                                            orderController.selectedOrder!.value
                                                .pickupAddress!.latitude,
                                            orderController.selectedOrder!.value
                                                .pickupAddress!.longitude,
                                          );
                                        } else {
                                          openMap(
                                            orderController.selectedOrder!.value
                                                .deliveryAddress!.latitude,
                                            orderController.selectedOrder!.value
                                                .deliveryAddress!.longitude,
                                          );
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 140,
                                    ),
                                    (orderController
                                        .selectedOrder!.value.orderStatus ==
                                        "DELIVERED")
                                        ? Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: const BoxDecoration(
                                          color:
                                          Constant.secondaryTransparent,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0))),
                                      child: Row(
                                        children: [
                                          const Text(
                                            "₹",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Constant.primary,
                                              fontFamily: 'Source Sans Pro',
                                              fontSize: 15,
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            '${orderController.selectedOrder!.value.grandTotal}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Constant.primary,
                                              fontFamily: 'Source Sans Pro',
                                              fontSize: 15,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                        : Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            launch(
                                                'tel://${orderController.selectedOrder!.value.user!.mobile}');
                                            print(
                                                'store mobile number ${orderController.selectedOrder!.value.storeId != null ? orderController.selectedOrder!.value.store!.mobile! : orderController.selectedOrder!.value.pickupAddress!.mobile}');
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                                top: 5,
                                                bottom: 5),
                                            decoration: const BoxDecoration(
                                                color: Constant
                                                    .secondaryTransparent,
                                                borderRadius:
                                                BorderRadius.all(
                                                    Radius.circular(
                                                        5.0))),
                                            child: Row(
                                              children: const [
                                                Icon(
                                                  Icons.phone,
                                                  color: Constant.primary,
                                                  size: 15,
                                                ),
                                                SizedBox(width: 5),
                                                Text(
                                                  'Call',
                                                  style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    color: Constant.primary,
                                                    fontFamily:
                                                    'Source Sans Pro',
                                                    fontSize: 15,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 0, right: 0,bottom: 10),
                          child: Column(
                            children: [
                              Obx(() => (orderController
                                  .selectedOrder!.value.orderStatus ==
                                  "ASSIGNED")
                                  ? Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                children: [
                                  InkWell(
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 300,
                                      decoration: BoxDecoration(
                                        color: Constant.secondary,
                                        borderRadius:
                                        BorderRadius.circular(10),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(12.0),
                                        child: Text(
                                          "Mark As Reached",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                      ),
                                    ),
                                    onTap: () async {
                                      OrderStatusResponse?
                                      orderStatusResponse =
                                      await orderController
                                          .reachedOrder(
                                          orderController.selectedOrder!
                                              .value
                                              .id
                                              .toString(),
                                          orderController.comment!);
                                      if (orderStatusResponse != null) {
                                        if (orderStatusResponse.success!) {
                                          orderController
                                              .selectedOrder!
                                              .value
                                              .orderStatus = "REACHED";
                                          orderController
                                              .pagingControllerOrder
                                              .refresh();
                                          setState(() {});
                                          Fluttertoast.showToast(
                                              msg: "Reached",
                                              toastLength:
                                              Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.green,
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                        } else {
                                          Fluttertoast.showToast(
                                              msg: " Service Failed",
                                              toastLength:
                                              Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                        }
                                      }else{
                                        Fluttertoast.showToast(
                                            msg: " Service Failed",
                                            toastLength:
                                            Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                      }
                                      print('REACHED');
                                    },
                                  ),
                                ],
                              )
                                  : Container()),
                              Obx(() => (orderController
                                  .selectedOrder!.value.orderStatus ==
                                  "REACHED")
                                  ? Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                children: [
                                  InkWell(
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 300,
                                      decoration: BoxDecoration(
                                        color: Constant.secondary,
                                        borderRadius:
                                        BorderRadius.circular(10),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(12.0),
                                        child: Text(
                                          "Mark As Pick UP",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                      ),
                                    ),
                                    onTap: () async {
                                      showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                              title: const Text(
                                                'Start Ride',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                    FontWeight.bold),
                                              ),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const Text('Please Enter Otp',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                          FontWeight.bold)),
                                                  PinCodeTextField(
                                                    pinBoxRadius: 10,
                                                    pinBoxOuterPadding:
                                                    const EdgeInsets.all(5.0),
                                                    pinBoxColor: Constant
                                                        .secondaryTransparent,
                                                    autofocus: true,
                                                    hideCharacter: false,
                                                    controller: orderController
                                                        .pickUpOtpController,
                                                    hasTextBorderColor:
                                                    Colors.green,
                                                    highlight: true,
                                                    maxLength: 4,
                                                    onTextChanged: (text) {
                                                      print("Changed:" + text);
                                                      orderController.PickupPinn = text;
                                                      if (orderController.PickupPinn!.length == 4) {
                                                        setState(() {
                                                          orderController.isChecked.value = true;
                                                        });
                                                      }
                                                    },
                                                    onDone: (text) {
                                                      orderController.PickupPinn  = text;
                                                      print(
                                                          "Completed: " + text);
                                                    },
                                                    pinBoxWidth: 45,
                                                    pinBoxHeight: 45.0,
                                                    hasUnderline: false,
                                                    keyboardType:
                                                    TextInputType.number,
                                                    wrapAlignment: WrapAlignment
                                                        .spaceAround,
                                                    pinBoxDecoration:
                                                    ProvidedPinBoxDecoration
                                                        .defaultPinBoxDecoration,
                                                    pinTextStyle:
                                                    const TextStyle(
                                                        fontSize: 20.0),
                                                    pinTextAnimatedSwitcherTransition:
                                                    ProvidedPinBoxTextAnimation
                                                        .scalingTransition,
//                    pinBoxColor: Colors.green[100],
                                                    pinTextAnimatedSwitcherDuration:
                                                    const Duration(
                                                        milliseconds: 300),
//                    highlightAnimation: true,
                                                    highlightAnimationBeginColor:
                                                    Colors.black,
                                                    highlightAnimationEndColor:
                                                    Colors.white12,
                                                  ),
                                                  Text(
                                                      "${orderController.selectedOrder!.value.pickupOtp}")
                                                ],
                                              ),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () async {
                                                    Get.back();
                                                  },
                                                  child: const Text(
                                                    'No',
                                                    style: TextStyle(
                                                        color:
                                                        Constant.primary),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () async {
                                                    if (orderController.PickupPinn!.length < 4) {
                                                      Fluttertoast.showToast(
                                                          msg: "Wrong Otp",
                                                          toastLength: Toast
                                                              .LENGTH_SHORT,
                                                          gravity: ToastGravity
                                                              .CENTER,
                                                          timeInSecForIosWeb: 1,
                                                          backgroundColor:
                                                          Colors.green,
                                                          textColor:
                                                          Colors.white,
                                                          fontSize: 16.0);
                                                      return ;
                                                    }
                                                    if (orderController.selectedOrder!.value.pickupOtp == orderController.PickupPinn) {
                                                      print("OtpResponse");
                                                      OrderStatusResponse? orderStatusResponse = await orderController.cabConfrimOrder(orderController.selectedOrder!.value.id.toString());
                                                      orderController.pagingControllerOrder.refresh();
                                                      if (orderStatusResponse != null) {
                                                        if (orderStatusResponse.success!) {
                                                          orderController.pickUpOtpController.clear();
                                                          (orderController.selectedOrder!.value.orderStatus = "PICKEDUP");
                                                          setState(() {});
                                                          Fluttertoast.showToast(
                                                              msg: "Started",
                                                              toastLength: Toast
                                                                  .LENGTH_SHORT,
                                                              gravity:
                                                              ToastGravity
                                                                  .CENTER,
                                                              timeInSecForIosWeb:
                                                              1,
                                                              backgroundColor:
                                                              Colors.green,
                                                              textColor:
                                                              Colors.white,
                                                              fontSize: 16.0);
                                                        } else {
                                                          Fluttertoast.showToast(
                                                              msg:
                                                              "Service Error",
                                                              toastLength: Toast
                                                                  .LENGTH_SHORT,
                                                              gravity:
                                                              ToastGravity
                                                                  .CENTER,
                                                              timeInSecForIosWeb:
                                                              1,
                                                              backgroundColor:
                                                              Colors.green,
                                                              textColor:
                                                              Colors.white,
                                                              fontSize: 16.0);
                                                        }
                                                        Get.back();
                                                      } else {
                                                        Fluttertoast.showToast(
                                                            msg:
                                                            "Service Error 2",
                                                            toastLength: Toast
                                                                .LENGTH_SHORT,
                                                            gravity:
                                                            ToastGravity
                                                                .CENTER,
                                                            timeInSecForIosWeb:
                                                            1,
                                                            backgroundColor:
                                                            Colors.green,
                                                            textColor:
                                                            Colors.white,
                                                            fontSize: 16.0);
                                                      }
                                                    } else {
                                                      Fluttertoast.showToast(
                                                          msg:
                                                          "Please Enter Correct OTP",
                                                          toastLength: Toast
                                                              .LENGTH_SHORT,
                                                          gravity: ToastGravity
                                                              .CENTER,
                                                          timeInSecForIosWeb: 1,
                                                          backgroundColor:
                                                          Colors.red,
                                                          textColor:
                                                          Colors.white,
                                                          fontSize: 16.0);
                                                    }
                                                  },
                                                  child: const Text(
                                                    'Confirm',
                                                    style: TextStyle(
                                                        color:
                                                        Constant.primary),
                                                  ),
                                                ),
                                              ],
                                            ),
                                      );
                                    },
                                  ),
                                ],
                              )
                                  : Container()),
                              Obx(() => (orderController
                                  .selectedOrder!.value.orderStatus == "PICKEDUP")
                                  ? Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                children: [
                                  InkWell(
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 300,
                                      decoration: BoxDecoration(
                                        color: Constant.secondary,
                                        borderRadius:
                                        BorderRadius.circular(10),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(12.0),
                                        child: Text(
                                          "Mark As Completed",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                      ),
                                    ),
                                    onTap: () async {
                                      showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                              title: const Text(
                                                'Collect Money',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                    FontWeight.bold),
                                              ),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  (orderController
                                                      .selectedOrder!
                                                      .value
                                                      .paymentMethod ==
                                                      "COD")
                                                      ? Text(
                                                      'Please Collect ₹ ${orderController.selectedOrder!.value.grandTotal}',
                                                      style: const TextStyle(
                                                          color:
                                                          Colors.black,
                                                          fontWeight:
                                                          FontWeight
                                                              .bold))
                                                      : const Text(
                                                      "Amount is paid by Online"),
                                                ],
                                              ),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () async {
                                                    Get.back();
                                                  },
                                                  child: const Text(
                                                    'No',
                                                    style: TextStyle(
                                                        color:
                                                        Constant.primary),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () async {
                                                    OrderStatusResponse?
                                                    orderStatusResponse =
                                                    await orderController
                                                        .deliveredOrder(
                                                        orderController
                                                            .selectedOrder!
                                                            .value
                                                            .id
                                                            .toString(),
                                                        orderController
                                                            .comment!);
                                                    if (orderStatusResponse !=
                                                        null) {
                                                      if (orderStatusResponse
                                                          .success!) {
                                                        orderController
                                                            .selectedOrder!
                                                            .value
                                                            .orderStatus =
                                                        "COMPLETED";
                                                        orderController
                                                            .pagingControllerOrder
                                                            .refresh();
                                                        setState(() {});
                                                        Fluttertoast.showToast(
                                                            msg:
                                                            "Ride Completed Successfully",
                                                            toastLength: Toast
                                                                .LENGTH_SHORT,
                                                            gravity:
                                                            ToastGravity
                                                                .CENTER,
                                                            timeInSecForIosWeb:
                                                            1,
                                                            backgroundColor:
                                                            Colors.green,
                                                            textColor:
                                                            Colors.white,
                                                            fontSize: 16.0);
                                                        Get.offAll(
                                                            const BottomNavigation());
                                                      } else {
                                                        Fluttertoast.showToast(
                                                            msg:
                                                            " Service Failed",
                                                            toastLength: Toast
                                                                .LENGTH_SHORT,
                                                            gravity:
                                                            ToastGravity
                                                                .CENTER,
                                                            timeInSecForIosWeb:
                                                            1,
                                                            backgroundColor:
                                                            Colors.red,
                                                            textColor:
                                                            Colors.white,
                                                            fontSize: 16.0);
                                                      }
                                                    }
                                                  },
                                                  child: const Text(
                                                    'Confirm',
                                                    style: TextStyle(
                                                        color:
                                                        Constant.primary),
                                                  ),
                                                ),
                                              ],
                                            ),
                                      );

                                      print('Delivered');
                                    },
                                  ),
                                ],
                              )
                                  : Container()),
                              Obx(() => (orderController
                                  .selectedOrder!.value.orderStatus == "DELIVERED")
                                  ? Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    width: 300,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                      BorderRadius.circular(10),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(12.0),
                                      child: Text(
                                        " Task Completed",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                                  : Container()),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Future<void> openMap(dynamic latitude, dynamic longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl) != null) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}
//TODO  Text("₹200.45",style: TextStyle(
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 16,
//                                 ),),
