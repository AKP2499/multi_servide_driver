import 'dart:async';
import 'package:dunzodriver_copy1/constant/color.dart';
import 'package:dunzodriver_copy1/controller/order_controller.dart';
import 'package:dunzodriver_copy1/models/order_reject_response.dart';
import 'package:dunzodriver_copy1/models/ordermodels/order_details_accpect_response.dart';
import 'package:dunzodriver_copy1/service/push_notification.dart';
import 'package:dunzodriver_copy1/views/cab_service/cab_service.dart';
import 'package:dunzodriver_copy1/views/navigation_pages/bottomnavigation_dunzo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:slide_to_act/slide_to_act.dart';

class OrderAccpect extends StatefulWidget {
  String order_id;
  String type;

  OrderAccpect(this.order_id, this.type, {Key? key}) : super(key: key);

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<OrderAccpect> {
  OrderController orderController = Get.put(OrderController());
  String comment="";
  int orderId = 1;

  static const CameraPosition _kLake = CameraPosition(
    bearing: 192.8334901395799,
    target: LatLng(37.43296265331129, -122.08832357078792),
    tilt: 59.440717697143555,
    zoom: 19.151926040649414,
  );

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.white,
    primary: Colors.white,
    minimumSize: const Size(88, 36),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    shape: const CircleBorder(),
  );
  final Set<Polyline> _polylines =Set<Polyline>();

  List<LatLng> polylineCoordinates =[];
  PolylinePoints? polylinePoints;

  @override
  void initState() {
    polylinePoints=PolylinePoints();
    super.initState();
    orderId = int.parse(widget.order_id);
    Future.delayed(const Duration(seconds:30), () {
      if(!orderController.isAccept!.value){
        print("rejectOrder");
        orderController.rejectOrder(comment,orderId);
      }else{

      }
    });
    orderController.startTimer();
    // orderController.orderDetails(widget.order_id);
  }

  @override
  Widget build(BuildContext context) {
    // print("Selected Order");
    // print(orderController.selectedOrder?.value.serviceCategory?.toJson());

    Future.delayed(const Duration(seconds: 3), () {
      print("order details");
      orderController.orderDetails(widget.order_id).then((value) {
        {
          if(value != null){
            orderController.updateInitialPosition(
              LatLng(value.data?.deliveryAddress?.latitude,
                  value.data?.deliveryAddress?.longitude),
            );
          }
        }
      });
    });
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Constant.secondary,
        title: const Text("Order Details"),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            GetBuilder(builder: (OrderController orderController) {
              return Obx(()=> Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.7,
                child: GoogleMap(
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                  tiltGesturesEnabled: true,
                  zoomGesturesEnabled: true,
                  onMapCreated: orderController.onMapCreated,
                  myLocationEnabled: true,
                  polylines: Set<Polyline>.of(orderController.polylines.values),
                  mapType: MapType.normal,
                  initialCameraPosition:
                  orderController.initialCameraPosition.value,
                  markers: Set<Marker>.of(orderController.markers.values),
                ),
              ),
              );
            }),
            Obx(()=>(orderController.selectedOrder!.value.serviceCategory?.serviceTypeId==4)?
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                    height: MediaQuery.of(context).size.height*0.44,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 5,
                          )
                        ]),
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          textDirection: TextDirection.ltr,
                          children: [
                            Column(
                              children: [
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Image.asset(
                                  "lib/Images/rupee-symbol.png",
                                  width: 20,
                                  color: Colors.grey,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Obx(
                                      () => Text(
                                    orderController.isLoading!.value
                                        ? "..."
                                        : "${orderController.selectedOrder!= null ?
                                    orderController.selectedOrder!.value.grandTotal : 0}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                const Text(
                                  'Earnings',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const SizedBox(
                                  height: 5,
                                ),
                                const Icon(Icons.directions_rounded,
                                    color: Colors.grey),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Obx(
                                      () => Text(
                                    orderController.isLoading!.value
                                        ? "..."
                                        : "${orderController.selectedOrder!= null ?
                                    orderController.selectedOrder!.value.distanceTravelled : 0.0} Km",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0),
                                  ),
                                ),
                                const SizedBox(height: 5.0,),
                                const Text(
                                  ' Distance ',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const SizedBox(
                                  height: 5,
                                ),
                                const Icon(Icons.timer_sharp,
                                    color: Colors.grey),
                                const SizedBox(
                                  height: 8,
                                ),
                                Obx(
                                      () => Text(
                                    orderController.isLoading!.value
                                        ? "..."
                                        : "${(orderController.selectedOrder!= null &&
                                        orderController.selectedOrder!.value.travelTime!= null) ?
                                    orderController.selectedOrder!.value.travelTime : 0.0}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0),
                                  ),
                                ),
                                const SizedBox(height: 5.0,),
                                const Text('travel time',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Image.asset("lib/Images/circle.png",width: MediaQuery.of(context).size.height*.03,),
                                Column(
                                  children: [
                                    for (int i = 0; i < 30; i++)
                                      Container(
                                        width: 1,
                                        height: 2,
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              width: 1,
                                              color: i % 2 == 0
                                                  ? const Color.fromRGBO(214, 211, 211, 1)
                                                  : Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                Image.asset("lib/Images/pin.png",width: MediaQuery.of(context).size.height*.03,)
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:  [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:  [
                                    const SizedBox(height: 10,),
                                    InkWell(
                                      onTap: (){
                                        orderController.mapController.moveCamera(CameraUpdate.newLatLngZoom(
                                            LatLng( double.parse(orderController.selectedOrder!.value.pickupAddress!.latitude!.toString()),
                                                double.parse(orderController.selectedOrder!.value.pickupAddress!.longitude!.toString())),15
                                        ),
                                        );
                                        setState(() {

                                        });
                                      },
                                      child: Obx(()=> Container(
                                        width: 300,
                                        child: Text((orderController.selectedOrder!.value.pickupAddress!=null)?
                                        orderController.selectedOrder!.value.pickupAddress!.address!:"Address Not Found",
                                          style: const TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w500),),
                                      ),
                                      ),
                                    ),
                                    const SizedBox(height: 10,),
                                  ],
                                ),
                                Container(width: 300,height:1,color: Colors.grey,),
                                const SizedBox(height: 10,),
                                const SizedBox(height: 10,),
                                InkWell(
                                  onTap: (){
                                    orderController.mapController.moveCamera(CameraUpdate.newLatLngZoom(
                                        LatLng( double.parse(orderController.selectedOrder!.value.deliveryAddress!.latitude!.toString()),
                                            double.parse(orderController.selectedOrder!.value.deliveryAddress!.longitude!.toString())),15
                                    ),
                                    );
                                    setState(() {
                                    });
                                  },
                                  child: Obx(()=>
                                      Container(
                                        width: 300,
                                        child: Text((orderController.selectedOrder!.value.deliveryAddress!=null)?
                                        orderController.selectedOrder!.value.deliveryAddress!.address!:"Address Not Found",
                                          style: const TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w500),),
                                      ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 30,
                            ),
                            Expanded(
                              child: SlideAction(
                                sliderButtonYOffset: -5,
                                borderRadius: 50,
                                animationDuration: const Duration(seconds: 0),
                                alignment: Alignment.centerLeft,
                                sliderButtonIconSize: 15,
                                outerColor: Constant.primary,
                                innerColor: Colors.white,
                                height: 60,
                                sliderRotate: false,
                                onSubmit: () async {
                                  OrderDetails? accepctResponse =
                                  await orderController.acceptedOrder(
                                      orderController.storedOrderDetails.value.data!.id.toString());
                                  if (accepctResponse != null) {
                                    if (accepctResponse.success!) {
                                      orderController.isAccept!.value=true;
                                      PushNotificationService.clearAllNotification();
                                      orderController.orderStatistics();
                                      orderController.pagingControllerOrder.refresh();
                                      Fluttertoast.showToast(
                                          msg: "Order Accepted Successfully",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.green,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                      Get.offAll(
                                              () =>  CabService(widget.order_id));
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: "Order Accepted Failed",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.green,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    }
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      'Accept Task',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            ElevatedButton(
                                style: raisedButtonStyle,
                                onPressed: () async {
                                  // OrderDetails? cancelResponse=await orderController.cancelOrder(orderController.storedOrderDetails.value.data!.id.toString());
                                  RejectResponse rejectCancel=await orderController.rejectOrder(
                                      comment,
                                      orderId
                                  );
                                  if (rejectCancel != null) {
                                    if (rejectCancel.success!=null) {
                                      PushNotificationService.clearAllNotification();
                                      Fluttertoast.showToast(
                                          msg: "Order Cancel Successfully",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.green,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                      Get.to(() => const BottomNavigation());
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: "Order Canceled Failed",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.green,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    }
                                  }
                                },
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle,
                                          border:
                                          Border.all(color: Colors.grey)),
                                      width: 60,
                                      height: 60,
                                    ),
                                    const Positioned(
                                        bottom: 10,
                                        left: 10,
                                        child: Icon(
                                          Icons.cancel,
                                          size: 40,
                                          color: Colors.black,
                                        ))
                                  ],
                                )),
                            const SizedBox(
                              width: 15,
                            ),
                          ],
                        ),
                      ],
                    )),
              ],
            ):
            DraggableScrollableSheet(
              builder: (BuildContext context, ScrollController scrollController) {
                return Container(
                  // child: MapBottomSheet1(),
                  child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 5,
                            )
                          ]),
                      padding: const EdgeInsets.only(top: 10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            textDirection: TextDirection.ltr,
                            children: [
                              Column(
                                children: [
                                  const SizedBox(
                                    height: 15.0,
                                  ),
                                  Image.asset(
                                    "lib/Images/rupee-symbol.png",
                                    width: 20,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Obx(
                                        () => Text(
                                      orderController.isLoading!.value || orderController.selectedOrder!.value.grandTotal == null
                                          ? "..."
                                          : "${(orderController.selectedOrder != null)?
                                      orderController.selectedOrder!.value.grandTotal : 0}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  const Text(
                                    'Earnings',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  const Icon(Icons.directions_rounded,
                                      color: Colors.grey),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Obx(
                                        () => Text(
                                      orderController.isLoading!.value|| orderController.selectedOrder!.value.distanceTravelled==null
                                          ? "..."
                                          : "${orderController.selectedOrder != null ?
                                      orderController.selectedOrder!.value.distanceTravelled : 0.0}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  const Text(
                                    ' Distance ',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  const Icon(Icons.timer_sharp,
                                      color: Colors.grey),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Obx(
                                        () => Text(
                                      orderController.isLoading!.value||orderController.selectedOrder!.value.travelTime == null
                                          ? "..."
                                          : "${(orderController.selectedOrder != null) ?
                                      orderController.selectedOrder!.value.travelTime : 0.0}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  const Text(
                                    'travel time',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          // Row(
                          //   children: [
                          //     Column(
                          //       children: [
                          //         Image.asset("lib/Images/circle.png",width: 25,),
                          //         Column(
                          //           children: [
                          //             for (int i = 0; i < 25; i++)
                          //             Container(
                          //               width: 1,
                          //               height: 1,
                          //               decoration: BoxDecoration(
                          //                 border: Border(
                          //                   bottom: BorderSide(
                          //                     width: 1,
                          //                     color: i % 2 == 0
                          //                         ? const Color.fromRGBO(214, 211, 211, 1)
                          //                         : Colors.black,
                          //                   ),
                          //                 ),
                          //               ),
                          //             ),
                          //           ],
                          //         ),
                          //         Image.asset("lib/Images/pin.png",width: 25,)
                          //       ],
                          //     ),
                          //     Column(
                          //       crossAxisAlignment: CrossAxisAlignment.start,
                          //       children:  [
                          //         Column(
                          //           crossAxisAlignment: CrossAxisAlignment.start,
                          //           children: const [
                          //             Text("PickUP Point",style: TextStyle(color: Colors.grey,fontSize: 15),),
                          //             SizedBox(height: 10,),
                          //             Text("New Castle, Bachatle 3982",style: TextStyle(color: Colors.black,fontSize: 15),),
                          //             SizedBox(height: 10,),
                          //           ],
                          //         ),
                          //         Container(width: 300,height:1,color: Colors.grey,),
                          //         const Text("DropOut Point"),
                          //       ],
                          //     )
                          //   ],
                          // ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                width: 30,
                              ),
                              Expanded(
                                child: SlideAction(
                                  sliderButtonYOffset: -5,
                                  borderRadius: 40,
                                  animationDuration: const Duration(seconds: 0),
                                  alignment: Alignment.centerLeft,
                                  sliderButtonIconSize: 15,
                                  outerColor: Constant.primary,
                                  innerColor: Colors.white,
                                  height: 60,
                                  sliderRotate: false,
                                  onSubmit: () async {
                                    OrderDetails? accepctResponse =
                                    await orderController.acceptedOrder(
                                        orderController.storedOrderDetails.value.data!.id.toString());
                                    if (accepctResponse != null) {
                                      if (accepctResponse.success!) {
                                        orderController.isAccept!.value=true;PushNotificationService.clearAllNotification();
                                        orderController.orderStatistics();
                                        orderController.pagingControllerOrder.refresh();
                                        Fluttertoast.showToast(
                                            msg: "Order Accepted Successfully",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.green,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                        Get.offAll(() => const BottomNavigation());
                                      } else {
                                        Fluttertoast.showToast(
                                            msg: "Order Accepted Failed",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.green,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                      }
                                    }
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        'Accept Task',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                  style: raisedButtonStyle,
                                  onPressed: () async {
                                    // OrderDetails? cancelResponse=await orderController.cancelOrder(orderController.storedOrderDetails.value.data!.id.toString());
                                    RejectResponse rejectCancel=await orderController.rejectOrder(
                                        comment,
                                        orderId
                                    );
                                    if (rejectCancel != null && rejectCancel.success!=null) {
                                      if (rejectCancel.success!) {
                                        PushNotificationService.clearAllNotification();
                                        Fluttertoast.showToast(
                                            msg: "Order Cancel Successfully",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.green,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                        Get.to(() => const BottomNavigation());
                                      } else {
                                        Fluttertoast.showToast(
                                            msg: "Order Canceled Failed",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.green,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                      }
                                    }
                                  },
                                  child: Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            shape: BoxShape.circle,
                                            border:
                                            Border.all(color: Colors.grey)),
                                        width: 60,
                                        height: 60,
                                      ),
                                      const Positioned(
                                          bottom: 10,
                                          left: 10,
                                          child: Icon(
                                            Icons.cancel,
                                            size: 40,
                                            color: Colors.black,
                                          ))
                                    ],
                                  )),
                              const SizedBox(
                                width: 15,
                              ),
                            ],
                          ),
                        ],
                      )),
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent,
                );
              },
              initialChildSize: 0.3,
              maxChildSize: 0.4,
              minChildSize: 0.1,
              expand: true,
            )),
            Positioned(
              top: 10,
              right: 10,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Constant.secondary,
                              borderRadius: BorderRadius.circular(20)),
                          child: Obx(
                                () => Text(
                              "${orderController.counter.value}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 20),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text("Timer",
                            style: TextStyle(fontSize: 8, color: Colors.black)),
                      ],
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                  ],
                ),
              ),
            ),
            // Positioned(
            //   child: Container(
            //     child: MapBottomSheet1(),
            //     height: 200,
            //     width: MediaQuery.of(context).size.width,
            //     color: Colors.transparent,
            //   ),
            //   bottom: 20,
            // ),
          ],
        ),
      ),
    );
  }
}

