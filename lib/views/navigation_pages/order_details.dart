import 'package:dunzodriver_copy1/api/api_routes.dart';
import 'package:dunzodriver_copy1/constant/color.dart';
import 'package:dunzodriver_copy1/controller/order_controller.dart';
import 'package:dunzodriver_copy1/models/order_status_change_response.dart';
import 'package:dunzodriver_copy1/views/navigation_pages/bottomnavigation_dunzo.dart';
import 'package:dunzodriver_copy1/views/navigation_pages/pick_up.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetails extends StatefulWidget {
   OrderDetails({
    Key? key,
  }) : super(key: key);

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails>
    with WidgetsBindingObserver {
  OrderController orderController = Get.find();
  int customerMobileNumber = 8265914663;
  int storeMobileNumber = 7017038920;
  String? otpValue;
  final _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print("JSON Data");
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    // These are the callbacks
    switch (state) {
      case AppLifecycleState.resumed:
        orderController.update();
        // print(orderController.selectedOrder!.value.toJson().toString());
        // setState(() {});

        // widget is resumed
        break;
      case AppLifecycleState.inactive:
        // widget is inactive
        break;
      case AppLifecycleState.paused:
        // widget is paused
        break;
      case AppLifecycleState.detached:
        // widget is detached
        break;
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    // Remove the observer
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Order Id #${orderController.selectedOrder!.value.id}'),
        backgroundColor: Constant.primary,
      ),
      body: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child:  Icon(
                    Icons.home,
                    color: Colors.green,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    (orderController.selectedOrder!.value.orderStatus=="ASSIGNED"
                        ||orderController.selectedOrder!.value.orderStatus=="REACHED")?
                    Container(
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: Text(
                        orderController
                            .selectedOrder!.value.pickupAddress!.address!,
                        style: const TextStyle(
                            color: Constant.primary,
                            fontSize: 15,
                            fontFamily: 'Source Sans Pro',
                            fontWeight: FontWeight.bold),
                      ),
                    ):Container(
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: Text(
                        orderController
                            .selectedOrder!.value.deliveryAddress!.address!,
                        style: const TextStyle(
                            color: Constant.primary,
                            fontSize: 15,
                            fontFamily: 'Source Sans Pro',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      "${orderController.selectedOrder!.value.createdAt}",
                      style: const TextStyle(
                          color: Constant.gray,
                          fontSize: 13,
                          fontFamily: 'Source Sans Pro',
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),

              ],
            ),
                //call and Map
                const SizedBox(height: 20),
                (orderController.selectedOrder!.value.serviceCategory!.serviceTypeId==2)?Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        launch(
                            'tel://${orderController.selectedOrder!.value.user!.mobile!}');
                        print(
                            'Customer mobile number ${orderController.selectedOrder!.value.user!.mobile!}');
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                            color: Constant.secondaryTransparent,
                            borderRadius: BorderRadius.all(
                                Radius.circular(5.0))),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.phone,
                              color: Constant.primary,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Call',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Constant.primary,
                                fontFamily: 'Source Sans Pro',
                                fontSize: 17,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        openMap(
                            orderController.selectedOrder!.value
                                .deliveryAddress!.latitude!,
                            orderController.selectedOrder!.value
                                .deliveryAddress!.longitude!);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                            color: Constant.secondaryTransparent,
                            borderRadius: BorderRadius.all(
                                Radius.circular(5.0))),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.directions,
                              color: Constant.primary,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Map',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Constant.primary,
                                fontFamily: 'Source Sans Pro',
                                fontSize: 17,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],
                ):Container(),
                // customer details and phone number
                (orderController.selectedOrder!.value.serviceCategory!.serviceTypeId==2)?Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Customer details',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontFamily: 'Source Sans Pro',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.person,
                                size: 30,
                                color: Colors.grey,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Full Name',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Source Sans Pro',
                                      fontSize: 13,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                  Text(
                                    orderController.selectedOrder!.value.user
                                        ?.name ??
                                        "",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Source Sans Pro',
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.phone,
                                color: Colors.grey,
                                size: 30,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Phone',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Source Sans Pro',
                                      fontSize: 13,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                  Text(
                                    orderController
                                        .selectedOrder!.value.user!.mobile!,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Source Sans Pro',
                                      fontSize: 15,
                                      color: Constant.secondary,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 5),

                        // orderController.selectedOrder!.value.jsonData != null
                        //     ? Column(
                        //         children: [
                        //           const Padding(
                        //             padding: EdgeInsets.all(10.0),
                        //             child: Text(
                        //               'Order Instruction',
                        //               style: TextStyle(
                        //                 color: Colors.black,
                        //                 fontSize: 22.0,
                        //                 fontFamily: 'Source Sans Pro',
                        //                 fontWeight: FontWeight.bold,
                        //               ),
                        //             ),
                        //           ),
                        //           orderController.selectedOrder!.value.jsonData!.packageContentList != null&&
                        //               orderController.selectedOrder!.value.jsonData!.packageContentList!.isNotEmpty
                        //               ? Padding(
                        //                   padding: const EdgeInsets.all(8.0),
                        //                   child: Row(
                        //                     children: [
                        //                       const Icon(
                        //                         Icons.person,
                        //                         size: 30,
                        //                         color: Colors.grey,
                        //                       ),
                        //                       const SizedBox(
                        //                         width: 10,
                        //                       ),
                        //                       Column(
                        //                         crossAxisAlignment:
                        //                             CrossAxisAlignment.start,
                        //                         children: [
                        //                           const Text(
                        //                             'Content Type',
                        //                             style: TextStyle(
                        //                               color: Colors.grey,
                        //                               fontWeight:
                        //                                   FontWeight.bold,
                        //                               fontFamily:
                        //                                   'Source Sans Pro',
                        //                               fontSize: 13,
                        //                               letterSpacing: 1,
                        //                             ),
                        //                           ),
                        //                           Container(
                        //                             width: MediaQuery.of(context).size.width * 0.8,
                        //                             child: Text(
                        //                               orderController
                        //                                           .selectedOrder!
                        //                                           .value
                        //                                           .jsonData !=
                        //                                       null
                        //                                   ? orderController
                        //                                       .selectedOrder!
                        //                                       .value
                        //                                       .jsonData!
                        //                                       .packageContentList
                        //                                       .toString()
                        //                                   : "",
                        //                               style: const TextStyle(
                        //                                 fontWeight:
                        //                                     FontWeight.w600,
                        //                                 fontFamily:
                        //                                     'Source Sans Pro',
                        //                                 fontSize: 15,
                        //                               ),
                        //                             ),
                        //                           ),
                        //                         ],
                        //                       ),
                        //                       const SizedBox(
                        //                         width: 20,
                        //                       ),
                        //                     ],
                        //                   ),
                        //                 )
                        //               : Container(),
                        //           orderController.selectedOrder!.value.jsonData!.itemList != null&&
                        //               orderController.selectedOrder!.value.jsonData!.itemList!.isNotEmpty
                        //               ? Padding(
                        //                   padding: const EdgeInsets.all(8.0),
                        //                   child: Row(
                        //                     children: [
                        //                       const Icon(
                        //                         Icons.person,
                        //                         size: 30,
                        //                         color: Colors.grey,
                        //                       ),
                        //                       const SizedBox(
                        //                         width: 10,
                        //                       ),
                        //                       Column(
                        //                         crossAxisAlignment:
                        //                             CrossAxisAlignment.start,
                        //                         children: [
                        //                           const Text(
                        //                             'Item List',
                        //                             style: TextStyle(
                        //                               color: Colors.grey,
                        //                               fontWeight:
                        //                                   FontWeight.bold,
                        //                               fontFamily:
                        //                                   'Source Sans Pro',
                        //                               fontSize: 13,
                        //                               letterSpacing: 1,
                        //                             ),
                        //                           ),
                        //                           Text(
                        //                             orderController
                        //                                         .selectedOrder!
                        //                                         .value
                        //                                         .jsonData!
                        //                                         .itemList !=
                        //                                     null
                        //                                 ? orderController
                        //                                     .selectedOrder!
                        //                                     .value
                        //                                     .jsonData!
                        //                                     .itemList
                        //                                     .toString()
                        //                                 : "",
                        //                             style: const TextStyle(
                        //                               fontWeight:
                        //                                   FontWeight.w600,
                        //                               fontFamily:
                        //                                   'Source Sans Pro',
                        //                               fontSize: 15,
                        //                             ),
                        //                           ),
                        //                         ],
                        //                       ),
                        //                       const SizedBox(
                        //                         width: 20,
                        //                       ),
                        //                     ],
                        //                   ),
                        //                 )
                        //               : Container(),
                        //           orderController.selectedOrder!.value.jsonData!.anyInstruction != null &&
                        //                   orderController.selectedOrder!.value.jsonData!.anyInstruction!.isNotEmpty
                        //               ? Padding(
                        //                   padding: const EdgeInsets.all(8.0),
                        //                   child: Row(
                        //                     children: [
                        //                       const Icon(
                        //                         Icons.person,
                        //                         size: 30,
                        //                         color: Colors.grey,
                        //                       ),
                        //                       const SizedBox(
                        //                         width: 10,
                        //                       ),
                        //                       Column(
                        //                         crossAxisAlignment:
                        //                             CrossAxisAlignment.start,
                        //                         children: [
                        //                           const Text(
                        //                             'Any Instructions',
                        //                             style: TextStyle(
                        //                               color: Colors.grey,
                        //                               fontWeight:
                        //                                   FontWeight.bold,
                        //                               fontFamily:
                        //                                   'Source Sans Pro',
                        //                               fontSize: 13,
                        //                               letterSpacing: 1,
                        //                             ),
                        //                           ),
                        //                           Text(
                        //                             orderController
                        //                                     .selectedOrder!
                        //                                     .value
                        //                                     .jsonData!
                        //                                     .anyInstruction ??
                        //                                 "",
                        //                             style: const TextStyle(
                        //                               fontWeight:
                        //                                   FontWeight.w600,
                        //                               fontFamily:
                        //                                   'Source Sans Pro',
                        //                               fontSize: 15,
                        //                             ),
                        //                           ),
                        //                         ],
                        //                       ),
                        //                       const SizedBox(
                        //                         width: 20,
                        //                       ),
                        //                     ],
                        //                   ),
                        //                 )
                        //               : Container(),
                        //           orderController.selectedOrder!.value.jsonData!.orderedItems != null &&
                        //                   orderController.selectedOrder!.value.jsonData!.orderedItems!.isNotEmpty
                        //               ? Padding(
                        //                   padding: const EdgeInsets.all(8.0),
                        //                   child: Column(
                        //                     children: [
                        //                       Row(
                        //                         children: [
                        //                           const Icon(
                        //                             Icons.person,
                        //                             size: 30,
                        //                             color: Colors.grey,
                        //                           ),
                        //                           const SizedBox(
                        //                             width: 10,
                        //                           ),
                        //                           Column(
                        //                             crossAxisAlignment:
                        //                                 CrossAxisAlignment
                        //                                     .start,
                        //                             children: const [
                        //                               Text(
                        //                                 'Images',
                        //                                 style: TextStyle(
                        //                                   color: Colors.grey,
                        //                                   fontWeight:
                        //                                       FontWeight.bold,
                        //                                   fontFamily:
                        //                                       'Source Sans Pro',
                        //                                   fontSize: 13,
                        //                                   letterSpacing: 1,
                        //                                 ),
                        //                               ),
                        //                               SizedBox(
                        //                                 height: 20,
                        //                               ),
                        //                             ],
                        //                           ),
                        //                           const SizedBox(
                        //                             width: 20,
                        //                           ),
                        //                         ],
                        //                       ),
                        //                       Container(
                        //                         child: ListView.builder(
                        //                             scrollDirection:
                        //                                 Axis.vertical,
                        //                             shrinkWrap: true,
                        //                             physics:
                        //                                 NeverScrollableScrollPhysics(),
                        //                             itemCount: orderController
                        //                                 .selectedOrder!
                        //                                 .value
                        //                                 .jsonData!
                        //                                 .orderedItems!
                        //                                 .length,
                        //                             itemBuilder:
                        //                                 (BuildContext context,
                        //                                     int index) {
                        //                               return Image.network(
                        //                                 orderController.selectedOrder!.value.jsonData!
                        //                                         .orderedItems!
                        //                                         .elementAt(
                        //                                             index)
                        //                                         .contains(
                        //                                             "http")
                        //                                     ? orderController
                        //                                         .selectedOrder!
                        //                                         .value
                        //                                         .jsonData!
                        //                                         .orderedItems!
                        //                                         .elementAt(
                        //                                             index)
                        //                                     : ApiRoutes
                        //                                             .BASE_URL +
                        //                                         orderController
                        //                                             .selectedOrder!
                        //                                             .value
                        //                                             .jsonData!
                        //                                             .orderedItems!
                        //                                             .elementAt(
                        //                                                 index),
                        //                                 // width: 50,
                        //                                 // height:
                        //                                 //     50,
                        //                               );
                        //                             }),
                        //                       )
                        //                     ],
                        //                   ),
                        //                 )
                        //               : Container(),
                        //         ],
                        //       )
                        //     : Container(),
                      ],
                    ),

                  ],
                ):Container(),
            const SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Order Summary',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22.0,
                      fontFamily: 'Source Sans Pro',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount:
                            orderController.selectedOrder!.value.items!.length,
                        itemBuilder: (context, itemIndex) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    15.0, 8.0, 8.0, 8.0),
                                child: Text(
                                  orderController.selectedOrder!.value
                                      .items![itemIndex].productName!,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Source Sans Pro',
                                    fontSize: 15,
                                    letterSpacing: .3,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Text(
                                  "Quantity - " +
                                      orderController.selectedOrder!.value
                                          .items![itemIndex].quantity
                                          .toString(),
                                  style:const TextStyle(fontSize: 15),
                                ),
                              ),
                            ],
                          );
                        }),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  thickness: 1,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0,right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          (orderController.selectedOrder!.value.serviceCategory!.serviceTypeId==1)?Text(
                            'Order Total',
                            style: TextStyle(
                              color: Colors.grey.shade800,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Source Sans Pro',
                              fontSize: 15,
                              letterSpacing: 0,
                            ),
                          ):Container(),
                          Text(
                            'Delivery charge',
                            style: TextStyle(
                              color: Colors.grey.shade800,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Source Sans Pro',
                              fontSize: 15,
                              letterSpacing: 0,
                            ),
                          ),
                          Text(
                            'Tax',
                            style: TextStyle(
                              color: Colors.grey.shade800,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Source Sans Pro',
                              fontSize: 15,
                              letterSpacing: 0,
                            ),
                          ),
                          Text(
                            'Tip',
                            style: TextStyle(
                              color: Colors.grey.shade800,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Source Sans Pro',
                              fontSize: 15,
                              letterSpacing: 0,
                            ),
                          ),
                          Text(
                            'Discount',
                            style: TextStyle(
                              color: Colors.grey.shade800,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Source Sans Pro',
                              fontSize: 15,
                              letterSpacing: 0,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          (orderController.selectedOrder!.value.serviceCategory!.serviceTypeId==1)?Text(
                            '${Constant.currency}${orderController.selectedOrder!.value.totalPrice!}',
                            style: TextStyle(
                              color: Colors.grey.shade800,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Source Sans Pro',
                              fontSize: 15,
                              letterSpacing: 1,
                            ),
                          ):Container(),
                          Text(
                            '${Constant.currency}${orderController.selectedOrder!.value.deliveryFee}',
                            style: TextStyle(
                              color: Colors.grey.shade800,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Source Sans Pro',
                              fontSize: 15,
                              letterSpacing: 1,
                            ),
                          ),
                          Text(
                            '${Constant.currency}${orderController.selectedOrder!.value.tax!}',
                            style: TextStyle(
                              color: Colors.grey.shade800,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Source Sans Pro',
                              fontSize: 15,
                              letterSpacing: 1,
                            ),
                          ),
                          Text(
                            '${Constant.currency}${orderController.selectedOrder!.value.tip}',
                            style: TextStyle(
                              color: Colors.grey.shade800,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Source Sans Pro',
                              fontSize: 15,
                              letterSpacing: 1,
                            ),
                          ),
                          Text(
                            '${Constant.currency}${orderController.selectedOrder!.value.discountValue}',
                            style: TextStyle(
                              color: Colors.grey.shade800,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Source Sans Pro',
                              fontSize: 15,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Divider(thickness: 2,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Grand Total',
                        style: TextStyle(
                          color: Colors.grey.shade800,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Source Sans Pro',
                          fontSize: 17,
                          letterSpacing: 1,
                        ),
                      ),
                      Text(
                        '${Constant.currency}${orderController.selectedOrder!.value.grandTotal}',
                        style: const TextStyle(
                          color: Constant.secondary,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Source Sans Pro',
                          fontSize: 17,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                orderController.selectedOrder!.value.paymentMethod == "COD"
                    ? Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        color: Colors.red,
                        child: Text(
                          orderController.selectedOrder!.value.paymentMethod ==
                                  "COD"
                              ? "Collect Payment of ${Constant.currency} "
                                  "${orderController.selectedOrder!.value.grandTotal}"
                              : "",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Source Sans Pro',
                            fontSize: 17,
                            letterSpacing: 1,
                          ),
                        ),
                      )
                    : Container(),
                orderController.selectedOrder!.value.jsonData!=null?
                (orderController.selectedOrder!.value.jsonData!.ncd == true)
                    ? Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        color: Colors.yellowAccent,
                        child: const Text(
                          "Contact Less delivery",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Source Sans Pro',
                            fontSize: 17,
                            letterSpacing: 1,
                          ),
                        ),
                      )
                    : Container():Container(),
                (orderController.selectedOrder!.value.orderStatus == "PICKEDUP")
                    ? (orderController.selectedOrder!.value.serviceCategory!.serviceTypeId!=2)?Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              'Customer details',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 22.0,
                                fontFamily: 'Source Sans Pro',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.person,
                                  size: 30,
                                  color: Colors.grey,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Full Name',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Source Sans Pro',
                                        fontSize: 13,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                    Text(
                                      orderController.selectedOrder!.value.user
                                              ?.name ??
                                          "",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Source Sans Pro',
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.phone,
                                  color: Colors.grey,
                                  size: 30,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Phone',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Source Sans Pro',
                                        fontSize: 13,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                    Text(
                                      orderController
                                          .selectedOrder!.value.user!.mobile!,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Source Sans Pro',
                                        fontSize: 15,
                                        color: Constant.secondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.home,
                                  color: Colors.grey,
                                  size: 30,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Address',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Source Sans Pro',
                                        fontSize: 15,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: Text(
                                        orderController.selectedOrder!.value
                                            .deliveryAddress!.address!,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Source Sans Pro',
                                          fontSize: 15,
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  launch(
                                      'tel://${orderController.selectedOrder!.value.user!.mobile!}');
                                  print(
                                      'Customer mobile number ${orderController.selectedOrder!.value.user!.mobile!}');
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                      color: Constant.secondaryTransparent,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0))),
                                  child: Row(
                                    children: const [
                                      Icon(
                                        Icons.phone,
                                        color: Constant.primary,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        'Call',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Constant.primary,
                                          fontFamily: 'Source Sans Pro',
                                          fontSize: 17,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  openMap(
                                      orderController.selectedOrder!.value
                                          .deliveryAddress!.latitude!,
                                      orderController.selectedOrder!.value
                                          .deliveryAddress!.longitude!);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                      color: Constant.secondaryTransparent,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0))),
                                  child: Row(
                                    children: const [
                                      Icon(
                                        Icons.directions,
                                        color: Constant.primary,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        'Map',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Constant.primary,
                                          fontFamily: 'Source Sans Pro',
                                          fontSize: 17,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                            ],
                          ),
                          // orderController.selectedOrder!.value.jsonData != null
                          //     ? Column(
                          //         children: [
                          //           const Padding(
                          //             padding: EdgeInsets.all(10.0),
                          //             child: Text(
                          //               'Order Instruction',
                          //               style: TextStyle(
                          //                 color: Colors.black,
                          //                 fontSize: 22.0,
                          //                 fontFamily: 'Source Sans Pro',
                          //                 fontWeight: FontWeight.bold,
                          //               ),
                          //             ),
                          //           ),
                          //           orderController.selectedOrder!.value.jsonData!.packageContentList != null&&
                          //               orderController.selectedOrder!.value.jsonData!.packageContentList!.isNotEmpty
                          //               ? Padding(
                          //                   padding: const EdgeInsets.all(8.0),
                          //                   child: Row(
                          //                     children: [
                          //                       const Icon(
                          //                         Icons.person,
                          //                         size: 30,
                          //                         color: Colors.grey,
                          //                       ),
                          //                       const SizedBox(
                          //                         width: 10,
                          //                       ),
                          //                       Column(
                          //                         crossAxisAlignment:
                          //                             CrossAxisAlignment.start,
                          //                         children: [
                          //                           const Text(
                          //                             'Content Type',
                          //                             style: TextStyle(
                          //                               color: Colors.grey,
                          //                               fontWeight:
                          //                                   FontWeight.bold,
                          //                               fontFamily:
                          //                                   'Source Sans Pro',
                          //                               fontSize: 13,
                          //                               letterSpacing: 1,
                          //                             ),
                          //                           ),
                          //                           Container(
                          //                             width: MediaQuery.of(context).size.width * 0.8,
                          //                             child: Text(
                          //                               orderController
                          //                                           .selectedOrder!
                          //                                           .value
                          //                                           .jsonData !=
                          //                                       null
                          //                                   ? orderController
                          //                                       .selectedOrder!
                          //                                       .value
                          //                                       .jsonData!
                          //                                       .packageContentList
                          //                                       .toString()
                          //                                   : "",
                          //                               style: const TextStyle(
                          //                                 fontWeight:
                          //                                     FontWeight.w600,
                          //                                 fontFamily:
                          //                                     'Source Sans Pro',
                          //                                 fontSize: 15,
                          //                               ),
                          //                             ),
                          //                           ),
                          //                         ],
                          //                       ),
                          //                       const SizedBox(
                          //                         width: 20,
                          //                       ),
                          //                     ],
                          //                   ),
                          //                 )
                          //               : Container(),
                          //           orderController.selectedOrder!.value.jsonData!.itemList != null&&
                          //               orderController.selectedOrder!.value.jsonData!.itemList!.isNotEmpty
                          //               ? Padding(
                          //                   padding: const EdgeInsets.all(8.0),
                          //                   child: Row(
                          //                     children: [
                          //                       const Icon(
                          //                         Icons.person,
                          //                         size: 30,
                          //                         color: Colors.grey,
                          //                       ),
                          //                       const SizedBox(
                          //                         width: 10,
                          //                       ),
                          //                       Column(
                          //                         crossAxisAlignment:
                          //                             CrossAxisAlignment.start,
                          //                         children: [
                          //                           const Text(
                          //                             'Item List',
                          //                             style: TextStyle(
                          //                               color: Colors.grey,
                          //                               fontWeight:
                          //                                   FontWeight.bold,
                          //                               fontFamily:
                          //                                   'Source Sans Pro',
                          //                               fontSize: 13,
                          //                               letterSpacing: 1,
                          //                             ),
                          //                           ),
                          //                           Text(
                          //                             orderController
                          //                                         .selectedOrder!
                          //                                         .value
                          //                                         .jsonData!
                          //                                         .itemList !=
                          //                                     null
                          //                                 ? orderController
                          //                                     .selectedOrder!
                          //                                     .value
                          //                                     .jsonData!
                          //                                     .itemList
                          //                                     .toString()
                          //                                 : "",
                          //                             style: const TextStyle(
                          //                               fontWeight:
                          //                                   FontWeight.w600,
                          //                               fontFamily:
                          //                                   'Source Sans Pro',
                          //                               fontSize: 15,
                          //                             ),
                          //                           ),
                          //                         ],
                          //                       ),
                          //                       const SizedBox(
                          //                         width: 20,
                          //                       ),
                          //                     ],
                          //                   ),
                          //                 )
                          //               : Container(),
                          //           orderController.selectedOrder!.value.jsonData!.anyInstruction != null &&
                          //                   orderController.selectedOrder!.value.jsonData!.anyInstruction!.isNotEmpty
                          //               ? Padding(
                          //                   padding: const EdgeInsets.all(8.0),
                          //                   child: Row(
                          //                     children: [
                          //                       const Icon(
                          //                         Icons.person,
                          //                         size: 30,
                          //                         color: Colors.grey,
                          //                       ),
                          //                       const SizedBox(
                          //                         width: 10,
                          //                       ),
                          //                       Column(
                          //                         crossAxisAlignment:
                          //                             CrossAxisAlignment.start,
                          //                         children: [
                          //                           const Text(
                          //                             'Any Instructions',
                          //                             style: TextStyle(
                          //                               color: Colors.grey,
                          //                               fontWeight:
                          //                                   FontWeight.bold,
                          //                               fontFamily:
                          //                                   'Source Sans Pro',
                          //                               fontSize: 13,
                          //                               letterSpacing: 1,
                          //                             ),
                          //                           ),
                          //                           Text(
                          //                             orderController
                          //                                     .selectedOrder!
                          //                                     .value
                          //                                     .jsonData!
                          //                                     .anyInstruction ??
                          //                                 "",
                          //                             style: const TextStyle(
                          //                               fontWeight:
                          //                                   FontWeight.w600,
                          //                               fontFamily:
                          //                                   'Source Sans Pro',
                          //                               fontSize: 15,
                          //                             ),
                          //                           ),
                          //                         ],
                          //                       ),
                          //                       const SizedBox(
                          //                         width: 20,
                          //                       ),
                          //                     ],
                          //                   ),
                          //                 )
                          //               : Container(),
                          //           orderController.selectedOrder!.value.jsonData!.orderedItems != null &&
                          //                   orderController.selectedOrder!.value.jsonData!.orderedItems!.isNotEmpty
                          //               ? Padding(
                          //                   padding: const EdgeInsets.all(8.0),
                          //                   child: Column(
                          //                     children: [
                          //                       Row(
                          //                         children: [
                          //                           const Icon(
                          //                             Icons.person,
                          //                             size: 30,
                          //                             color: Colors.grey,
                          //                           ),
                          //                           const SizedBox(
                          //                             width: 10,
                          //                           ),
                          //                           Column(
                          //                             crossAxisAlignment:
                          //                                 CrossAxisAlignment
                          //                                     .start,
                          //                             children: const [
                          //                               Text(
                          //                                 'Images',
                          //                                 style: TextStyle(
                          //                                   color: Colors.grey,
                          //                                   fontWeight:
                          //                                       FontWeight.bold,
                          //                                   fontFamily:
                          //                                       'Source Sans Pro',
                          //                                   fontSize: 13,
                          //                                   letterSpacing: 1,
                          //                                 ),
                          //                               ),
                          //                               SizedBox(
                          //                                 height: 20,
                          //                               ),
                          //                             ],
                          //                           ),
                          //                           const SizedBox(
                          //                             width: 20,
                          //                           ),
                          //                         ],
                          //                       ),
                          //                       Container(
                          //                         child: ListView.builder(
                          //                             scrollDirection:
                          //                                 Axis.vertical,
                          //                             shrinkWrap: true,
                          //                             physics:
                          //                                 NeverScrollableScrollPhysics(),
                          //                             itemCount: orderController
                          //                                 .selectedOrder!
                          //                                 .value
                          //                                 .jsonData!
                          //                                 .orderedItems!
                          //                                 .length,
                          //                             itemBuilder:
                          //                                 (BuildContext context,
                          //                                     int index) {
                          //                               return Image.network(
                          //                                 orderController.selectedOrder!.value.jsonData!
                          //                                         .orderedItems!
                          //                                         .elementAt(
                          //                                             index)
                          //                                         .contains(
                          //                                             "http")
                          //                                     ? orderController
                          //                                         .selectedOrder!
                          //                                         .value
                          //                                         .jsonData!
                          //                                         .orderedItems!
                          //                                         .elementAt(
                          //                                             index)
                          //                                     : ApiRoutes
                          //                                             .BASE_URL +
                          //                                         orderController
                          //                                             .selectedOrder!
                          //                                             .value
                          //                                             .jsonData!
                          //                                             .orderedItems!
                          //                                             .elementAt(
                          //                                                 index),
                          //                                 // width: 50,
                          //                                 // height:
                          //                                 //     50,
                          //                               );
                          //                             }),
                          //                       )
                          //                     ],
                          //                   ),
                          //                 )
                          //               : Container(),
                          //         ],
                          //       )
                          //     : Container(),
                        ],
                      )
                    : Container():Container(),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(
              thickness: 1,
            ),
                orderController.selectedOrder!.value.jsonData!= null
                    ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ( orderController.selectedOrder!.value.jsonData!.anyInstruction!=null
                      )?const Text(
                        'Order Instruction',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22.0,
                          fontFamily: 'Source Sans Pro',
                          fontWeight: FontWeight.bold,
                        ),
                      ):Container(),
                    ),
                    orderController.selectedOrder!.value.serviceCategory!.serviceTypeId != 1 &&
                        orderController.selectedOrder!.value.jsonData!.packageContentList != null &&
                        orderController.selectedOrder!.value.jsonData!.packageContentList!.isNotEmpty
                        ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.person,
                            size: 30,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Content Type',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontFamily:
                                  'Source Sans Pro',
                                  fontSize: 13,
                                  letterSpacing: 1,
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context)
                                    .size
                                    .width *
                                    0.8,
                                child: Text(
                                  orderController
                                      .selectedOrder!
                                      .value
                                      .jsonData !=
                                      null
                                      ? orderController
                                      .selectedOrder!
                                      .value
                                      .jsonData!
                                      .packageContentList
                                      .toString()
                                      : "",
                                  style: const TextStyle(
                                    fontWeight:
                                    FontWeight.w600,
                                    fontFamily:
                                    'Source Sans Pro',
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                    ): Container(),
                    orderController.selectedOrder!.value.serviceCategory!.serviceTypeId != 1 &&
                        orderController.selectedOrder!.value.jsonData!.itemList !=
                            null &&
                        orderController.selectedOrder!.value.jsonData!.itemList!.isNotEmpty
                        ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.person,
                            size: 30,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Item List',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontFamily:
                                  'Source Sans Pro',
                                  fontSize: 13,
                                  letterSpacing: 1,
                                ),
                              ),
                              Text(
                                orderController
                                    .selectedOrder!
                                    .value
                                    .jsonData!
                                    .itemList !=
                                    null
                                    ? orderController
                                    .selectedOrder!
                                    .value
                                    .jsonData!
                                    .itemList
                                    .toString()
                                    : "",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontFamily:
                                  'Source Sans Pro',
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                    )
                        : Container(),
                    orderController.selectedOrder!.value.jsonData!.anyInstruction !=
                        null &&
                        orderController.selectedOrder!.value.jsonData!.anyInstruction!.isNotEmpty
                        ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.person,
                            size: 30,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Any Instructions',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontFamily:
                                  'Source Sans Pro',
                                  fontSize: 13,
                                  letterSpacing: 1,
                                ),
                              ),
                              Text(
                                orderController
                                    .selectedOrder!
                                    .value
                                    .jsonData!
                                    .anyInstruction ??
                                    "",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontFamily:
                                  'Source Sans Pro',
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                    )
                        : Container(),
                    orderController.selectedOrder!.value.jsonData!.orderedItems !=
                        null &&
                        orderController.selectedOrder!.value.jsonData!.orderedItems!.isNotEmpty
                        ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.person,
                                size: 30,
                                color: Colors.grey,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Images',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight:
                                      FontWeight.bold,
                                      fontFamily:
                                      'Source Sans Pro',
                                      fontSize: 13,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                            ],
                          ),
                          Container(
                            child: ListView.builder(
                                scrollDirection:
                                Axis.vertical,
                                shrinkWrap: true,
                                physics:
                                NeverScrollableScrollPhysics(),
                                itemCount: orderController.selectedOrder!.value.jsonData!.orderedItems!.length,
                                itemBuilder:
                                    (BuildContext context,
                                    int index) {
                                  return Image.network(
                                    orderController.selectedOrder!.value.jsonData!.orderedItems!.elementAt(index).contains("http")
                                        ? orderController
                                        .selectedOrder!
                                        .value
                                        .jsonData!
                                        .orderedItems!
                                        .elementAt(index)
                                        : ApiRoutes.BASE_URL +
                                        orderController
                                            .selectedOrder!
                                            .value
                                            .jsonData!
                                            .orderedItems!
                                            .elementAt(
                                            index),
                                    // width: 50,
                                    // height:
                                    //     50,
                                  );
                                }),
                          )
                        ],
                      ),
                    )
                        : Container(),
                  ],
                )
                    : Container(),
                const Divider(
                  thickness: 1,
                ),
            (orderController.selectedOrder!.value.orderStatus != "PICKEDUP")
                && orderController.selectedOrder!.value.orderStatus != "DELIVERED"
                ? (orderController.selectedOrder!.value.serviceCategory!.serviceTypeId!=2)?Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          'Pick Up information',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 22.0,
                            fontFamily: 'Source Sans Pro',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.person,
                              size: 30,
                              color: Colors.grey,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Name',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Source Sans Pro',
                                    fontSize: 13,
                                    letterSpacing: 1,
                                  ),
                                ),
                                Text(
                                  "${(orderController.selectedOrder!.value.store != null) ?
                                  (orderController.selectedOrder!.value.pickupAddress!.name != null &&
                                      orderController.selectedOrder!.value.pickupAddress!.name != "null") ?
                                  orderController.selectedOrder!.value.pickupAddress!.name : "-" : "-"}",

                                  // "${(orderController.selectedOrder!.value.store != null
                                  //     && orderController.selectedOrder!.value.pickupAddress!.name != "null")
                                  //     ? orderController.selectedOrder!.value.store!.name
                                  //     : (orderController.selectedOrder!.value.pickupAddress!.name != null)
                                  //     ? orderController.selectedOrder!.value.pickupAddress!.name! : ""}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Source Sans Pro',
                                    fontSize: 15,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.phone,
                              color: Colors.grey,
                              size: 30,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Phone',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Source Sans Pro',
                                    fontSize: 13,
                                    letterSpacing: 1,
                                  ),
                                ),
                                Text(
                                  "${(orderController.selectedOrder!.value.pickupAddress!.mobile != null && orderController.selectedOrder!.value.pickupAddress!.mobile != "null") ? orderController.selectedOrder!.value.pickupAddress!.mobile : (orderController.selectedOrder!.value.pickupAddress!.phone != null) ? orderController.selectedOrder!.value.pickupAddress!.phone : "-"}",
                                  style: const TextStyle(
                                    color: Constant.secondary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.home,
                              color: Colors.grey,
                              size: 30,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Address',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Source Sans Pro',
                                    fontSize: 15,
                                    letterSpacing: 1,
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.78,
                                  child: Text(
                                    orderController.selectedOrder!.value
                                                .pickupAddress !=
                                            null
                                        ? orderController.selectedOrder!.value
                                            .pickupAddress!.address!
                                        : "",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Source Sans Pro',
                                      fontSize: 15,
                                      letterSpacing: 0,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      //   children: [
                      //     InkWell(
                      //       onTap: () {
                      //         launch(
                      //             'tel://${orderController.selectedOrder!.value.storeId != null ? orderController.selectedOrder!.value.store!.mobile! : orderController.selectedOrder!.value.pickupAddress!.mobile}');
                      //         print(
                      //             'store mobile number ${orderController.selectedOrder!.value.storeId != null ? orderController.selectedOrder!.value.store!.mobile! : orderController.selectedOrder!.value.pickupAddress!.mobile}');
                      //       },
                      //       child: Container(
                      //         padding: const EdgeInsets.all(10),
                      //         decoration: const BoxDecoration(
                      //             color: Constant.secondaryTransparent,
                      //             borderRadius:
                      //                 BorderRadius.all(Radius.circular(5.0))),
                      //         child: Row(
                      //           children: const [
                      //             Icon(
                      //               Icons.phone,
                      //               color: Constant.primary,
                      //             ),
                      //             SizedBox(width: 10),
                      //             Text(
                      //               'Call',
                      //               style: TextStyle(
                      //                 fontWeight: FontWeight.bold,
                      //                 color: Constant.primary,
                      //                 fontFamily: 'Source Sans Pro',
                      //                 fontSize: 17,
                      //               ),
                      //             )
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //     const SizedBox(
                      //       width: 20,
                      //     ),
                      //     InkWell(
                      //       onTap: () {
                      //         openMap(
                      //             orderController.selectedOrder!.value
                      //                 .pickupAddress!.latitude!
                      //                 .toString(),
                      //             orderController.selectedOrder!.value
                      //                 .pickupAddress!.longitude!);
                      //       },
                      //       child: Container(
                      //         padding: const EdgeInsets.all(10),
                      //         decoration: const BoxDecoration(
                      //             color: Constant.secondaryTransparent,
                      //             borderRadius:
                      //                 BorderRadius.all(Radius.circular(5.0))),
                      //         child: Row(
                      //           children: const [
                      //             Icon(
                      //               Icons.directions,
                      //               color: Constant.primary,
                      //             ),
                      //             SizedBox(width: 10),
                      //             Text(
                      //               'Map',
                      //               style: TextStyle(
                      //                 fontWeight: FontWeight.bold,
                      //                 color: Constant.primary,
                      //                 fontFamily: 'Source Sans Pro',
                      //                 fontSize: 17,
                      //               ),
                      //             )
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //     const SizedBox(
                      //       width: 10,
                      //     ),
                      //   ],
                      // ),
                      const SizedBox(height: 20),
                    ],
                  )
                : Container():Container(),
            Obx(() => (orderController.selectedOrder!.value.orderStatus == "ASSIGNED")
                ? Container(
                    width: 400,
                    color: Colors.white,
                    margin: const EdgeInsets.all(20),
                    child: Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 10,
                      color: Constant.primary,
                      child: TextButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return SingleChildScrollView(
                                  child: Padding(
                                    padding: MediaQuery.of(context).viewInsets,
                                    child: Form(
                                      key: _formKey,
                                      child: Container(
                                        height: 140,
                                        margin: const EdgeInsets.all(10),
                                        alignment: Alignment.topLeft,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Column(
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 5,
                                                      horizontal: 10),
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10, bottom: 5),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.grey),
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  10))),
                                                  child: TextFormField(
                                                    onChanged: (value) {
                                                      orderController.comment = value;
                                                      if (value.isNotEmpty) {
                                                        orderController.isCompleted = true;
                                                      } else {
                                                        orderController.isCompleted = false;
                                                      }
                                                    },
                                                    keyboardType:
                                                        TextInputType.text,
                                                    controller: orderController
                                                        .myControllerComment,
                                                    onFieldSubmitted: (value) {
                                                      print(
                                                          'Second text field : $value');
                                                    },
                                                    decoration:
                                                        const InputDecoration(
                                                      border: InputBorder.none,
                                                      hintText: ('Comment'),
                                                      hintStyle: TextStyle(
                                                          color: Colors.grey),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: MaterialButton(
                                                    height: 40,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                    textColor: Colors.white,
                                                    color: Constant.secondary,
                                                    child: const Center(
                                                      child: Text(
                                                        'Reached',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20.0,
                                                        ),
                                                      ),
                                                    ),
                                                    onPressed: () async {
                                                      orderController.isCompleted ==true;
                                                      OrderStatusResponse? orderStatusResponse =
                                                          await orderController.reachedOrder(
                                                                  orderController.selectedOrder!.value.id.toString(),
                                                                  orderController.comment!);
                                                      if (orderStatusResponse != null) {
                                                        if (orderStatusResponse.success!) {
                                                          orderController.selectedOrder!.value.orderStatus = "REACHED";
                                                          setState(() {});
                                                          Fluttertoast.showToast(
                                                              msg: "Reached",
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
                                                                  "Order delivery Failed",
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
                                                      } else {
                                                        Fluttertoast.showToast(
                                                            msg:
                                                                "Order delivery Failed",
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

                                                      print('REACHED');
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: const Text(
                            'Mark as Reached',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontStyle: FontStyle.normal),
                          )),
                    ),
                  )
                : Container()),
            Obx(() => (orderController.selectedOrder!.value.orderStatus == "PREPARED")
                ? Container(
                    width: 400,
                    color: Colors.white,
                    margin: const EdgeInsets.all(20),
                    child: Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 10,
                      color: Constant.primary,
                      child: TextButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return SingleChildScrollView(
                                  child: Padding(
                                    padding: MediaQuery.of(context).viewInsets,
                                    child: Form(
                                      key: _formKey,
                                      child: Container(
                                        height: 140,
                                        margin: const EdgeInsets.all(10),
                                        alignment: Alignment.topLeft,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Column(
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 5,
                                                      horizontal: 10),
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10, bottom: 5),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.grey),
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  10))),
                                                  child: TextFormField(
                                                    onChanged: (value) {
                                                      orderController.comment =
                                                          value;
                                                      if (value.isNotEmpty) {
                                                        orderController
                                                            .isCompleted = true;
                                                      } else {
                                                        orderController
                                                                .isCompleted =
                                                            false;
                                                      }
                                                    },
                                                    keyboardType:
                                                        TextInputType.text,
                                                    controller: orderController
                                                        .myControllerComment,
                                                    onFieldSubmitted: (value) {
                                                      print(
                                                          'Second text field : $value');
                                                    },
                                                    decoration:
                                                        const InputDecoration(
                                                      border: InputBorder.none,
                                                      hintText: ('Comment'),
                                                      hintStyle: TextStyle(
                                                          color: Colors.grey),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: MaterialButton(
                                                    height: 40,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                    textColor: Colors.white,
                                                    color: Constant.secondary,
                                                    child: const Center(
                                                      child: Text(
                                                        'Reached',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20.0,
                                                        ),
                                                      ),
                                                    ),
                                                    onPressed: () async {
                                                      orderController
                                                              .isCompleted ==
                                                          true;
                                                      OrderStatusResponse?
                                                          orderStatusResponse = await orderController.reachedOrder(
                                                                  orderController.selectedOrder!.value.id.toString(),
                                                                  orderController.comment!);
                                                      if (orderStatusResponse != null) {
                                                        if (orderStatusResponse.success!) {
                                                          orderController.selectedOrder!.value.orderStatus = "REACHED";
                                                          setState(() {});
                                                          Fluttertoast.showToast(
                                                              msg: "Reached",
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
                                                                  "Order delivery Failed",
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
                                                      } else {
                                                        Fluttertoast.showToast(
                                                            msg:
                                                                "Order delivery Failed", toastLength: Toast
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
                                                      print('REACHED');
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: const Text(
                            'Mark as Reached',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontStyle: FontStyle.normal),
                          )),
                    ),
                  )
                : Container()),
            Obx(() =>
                (orderController.selectedOrder!.value.orderStatus == "REACHED")
                    ? Container(
                  width: 400,
                        color: Colors.white,
                        margin: const EdgeInsets.all(20),
                        child: Card(
                          margin: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 10,
                          color: Constant.primary,
                          child: TextButton(
                              onPressed: () {
                                Get.off(const PickedUp());
                                // if (_formKey.currentState!.validate()) {
                                //   print(myControllerVehicleModel);
                                //   print(myControllerVehicleNumber);
                                // }
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (_) => const PickedUp()));
                              },
                              child: const Text(
                                'Mark as pickup',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontStyle: FontStyle.normal),
                              )),
                        ),
                      )
                    : Container()),
            Obx(() => (orderController.selectedOrder!.value.orderStatus == "PICKEDUP")
                ? Container(
                    width: 400,
                    color: Colors.white,
                    margin: const EdgeInsets.all(20),
                    child: Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 10,
                      color: Constant.primary,
                      child: TextButton(
                          onPressed: () {
                            orderController.myControllerComment.text = "";
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return SingleChildScrollView(
                                  child: Padding(
                                    padding: MediaQuery.of(context).viewInsets,
                                    child: Form(
                                      key: _formKey,
                                      child: Container(
                                        height: 140,
                                        margin: const EdgeInsets.all(10),
                                        alignment: Alignment.topLeft,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            //Otp Text filed
                                            // (orderController.selectedOrder!.value.serviceCategory!.serviceTypeId==1)
                                            //     ?const
                                            // Text(
                                            //   'Enter OTP',
                                            //   style: TextStyle(
                                            //     fontSize: 20,
                                            //     fontWeight: FontWeight.bold,
                                            //     fontFamily: 'Source Sans Pro',
                                            //   ),
                                            // ):Container(),
                                            //Text("DeliveredOtp${orderController.selectedOrder!.value.deliveryOtp}"),
                                            // const SizedBox(
                                            //   height: 10,
                                            // ),
                                            // (orderController.selectedOrder!.value.serviceCategory!.serviceTypeId==1)?Expanded(
                                            //   child:
                                            //   OTPTextField(
                                            //     width: 375,
                                            //     length: 4,
                                            //     // width: MediaQuery.of(context).size.width,
                                            //     textFieldAlignment:
                                            //         MainAxisAlignment
                                            //             .spaceAround,
                                            //     fieldWidth: 50,
                                            //     fieldStyle: FieldStyle.box,
                                            //     outlineBorderRadius: 10,
                                            //     style: const TextStyle(
                                            //         fontSize: 10),
                                            //     onChanged: (pin) {
                                            //       print("Changed: " + pin);
                                            //       otpValue = pin;
                                            //       if (otpValue!.length == 4) {}
                                            //     },
                                            //     onCompleted: (pin) {
                                            //       print("Completed: " + pin);
                                            //       otpValue = pin;
                                            //       setState(() {});
                                            //     },
                                            //   ),
                                            // ):Container(),
                                            Column(
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 5,
                                                      horizontal: 10),
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10, bottom: 5),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.grey),
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  10))),
                                                  child: TextFormField(
                                                    onChanged: (value) {
                                                      orderController.comment = value;
                                                      if (value.isNotEmpty) {
                                                        orderController.isCompleted = true;
                                                      } else {
                                                        orderController
                                                                .isCompleted =
                                                            false;
                                                      }
                                                    },
                                                    keyboardType:
                                                        TextInputType.text,
                                                    controller: orderController.myControllerComment,
                                                    onFieldSubmitted: (value) {
                                                      print(
                                                          'Second text field : $value');
                                                    },
                                                    decoration:
                                                        const InputDecoration(
                                                      border: InputBorder.none,
                                                      hintText: ('Comment'),
                                                      hintStyle: TextStyle(
                                                          color: Colors.grey),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: MaterialButton(
                                                    height: 40,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                    textColor: Colors.white,
                                                    color: Constant.secondary,
                                                    child: const Center(
                                                      child: Text(
                                                        'Delivered',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20.0,
                                                        ),
                                                      ),
                                                    ),
                                                    onPressed: () async {
                                                      //OTP Field conditions
                                                      // WithOTP
                                                      // if(orderController.selectedOrder!.value.serviceCategory!.serviceTypeId==1){
                                                      //   if (otpValue!.length > 4) {
                                                      //     Fluttertoast.showToast(msg:
                                                      //     "Order Delivered Successfully",
                                                      //         toastLength: Toast.LENGTH_SHORT,
                                                      //         gravity: ToastGravity.CENTER,
                                                      //         timeInSecForIosWeb: 1,
                                                      //         backgroundColor: Colors.red,
                                                      //         textColor: Colors.white,
                                                      //         fontSize: 16.0);
                                                      //     return;
                                                      //   }
                                                      //   if (orderController.selectedOrder!.value.deliveryOtp == otpValue)
                                                      //   {
                                                      //     orderController.isCompleted==true;
                                                      //     OrderStatusResponse?orderStatusResponse
                                                      //     =await orderController.deliveredOrder(orderController.selectedOrder!.value.id.toString(), orderController.comment!);
                                                      //     if (orderStatusResponse != null) {
                                                      //       if (orderStatusResponse.success!) {
                                                      //         orderController.selectedOrder!.value.orderStatus = "DELIVERED";
                                                      //         setState(() {});
                                                      //         Fluttertoast.showToast(
                                                      //             msg:"Order delivered Successfully",
                                                      //             toastLength: Toast
                                                      //                 .LENGTH_SHORT,
                                                      //             gravity:
                                                      //             ToastGravity
                                                      //                 .CENTER,
                                                      //             timeInSecForIosWeb:
                                                      //             1,
                                                      //             backgroundColor:
                                                      //             Colors
                                                      //                 .green,
                                                      //             textColor:
                                                      //             Colors
                                                      //                 .white,
                                                      //             fontSize: 16.0);
                                                      //         Get.offAll(
                                                      //             const BottomNavigation());
                                                      //       } else {
                                                      //         Fluttertoast.showToast(
                                                      //             msg:
                                                      //             "Order delivery Failed",
                                                      //             toastLength: Toast
                                                      //                 .LENGTH_SHORT,
                                                      //             gravity:
                                                      //             ToastGravity
                                                      //                 .CENTER,
                                                      //             timeInSecForIosWeb:
                                                      //             1,
                                                      //             backgroundColor:
                                                      //             Colors.red,
                                                      //             textColor:
                                                      //             Colors
                                                      //                 .white,
                                                      //             fontSize: 16.0);
                                                      //       }
                                                      //     } else {
                                                      //       Fluttertoast.showToast(
                                                      //           msg:
                                                      //           "Order delivery Failed",
                                                      //           toastLength: Toast
                                                      //               .LENGTH_SHORT,
                                                      //           gravity:
                                                      //           ToastGravity
                                                      //               .CENTER,
                                                      //           timeInSecForIosWeb:
                                                      //           1,
                                                      //           backgroundColor:
                                                      //           Colors.red,
                                                      //           textColor:
                                                      //           Colors.white,
                                                      //           fontSize: 16.0);
                                                      //     }
                                                      //   }
                                                      // }else{
                                                      //   orderController.isCompleted==true;
                                                      //   OrderStatusResponse?orderStatusResponse =await orderController.deliveredOrder(orderController.selectedOrder!.value.id.toString(),
                                                      //       orderController.comment!);
                                                      //   if (orderStatusResponse != null) {
                                                      //     if (orderStatusResponse.success!) {
                                                      //       orderController.selectedOrder!.value.orderStatus = "DELIVERED";
                                                      //       setState(() {});
                                                      //       Fluttertoast.showToast(
                                                      //           msg:"Order delivered Successfully",
                                                      //           toastLength: Toast
                                                      //               .LENGTH_SHORT,
                                                      //           gravity:
                                                      //           ToastGravity
                                                      //               .CENTER,
                                                      //           timeInSecForIosWeb:
                                                      //           1,
                                                      //           backgroundColor:
                                                      //           Colors
                                                      //               .green,
                                                      //           textColor:
                                                      //           Colors
                                                      //               .white,
                                                      //           fontSize: 16.0);
                                                      //       Get.offAll(
                                                      //           const BottomNavigation());
                                                      //     } else {
                                                      //       Fluttertoast.showToast(
                                                      //           msg:
                                                      //           "Order delivery Failed",
                                                      //           toastLength: Toast
                                                      //               .LENGTH_SHORT,
                                                      //           gravity:
                                                      //           ToastGravity
                                                      //               .CENTER,
                                                      //           timeInSecForIosWeb:
                                                      //           1,
                                                      //           backgroundColor:
                                                      //           Colors.red,
                                                      //           textColor:
                                                      //           Colors
                                                      //               .white,
                                                      //           fontSize: 16.0);
                                                      //     }
                                                      //   } else {
                                                      //     Fluttertoast.showToast(
                                                      //         msg:
                                                      //         "Order delivery Failed",
                                                      //         toastLength: Toast
                                                      //             .LENGTH_SHORT,
                                                      //         gravity:
                                                      //         ToastGravity
                                                      //             .CENTER,
                                                      //         timeInSecForIosWeb:
                                                      //         1,
                                                      //         backgroundColor:
                                                      //         Colors.red,
                                                      //         textColor:
                                                      //         Colors.white,
                                                      //         fontSize: 16.0);
                                                      //   }
                                                      // }
                                                      // if (orderController.selectedOrder!.value.deliveryOtp == otpValue)
                                                      // {
                                                      //   orderController.isCompleted==true;
                                                      //   OrderStatusResponse?orderStatusResponse =
                                                      //   await orderController.deliveredOrder(orderController.selectedOrder!.value.id.toString(),
                                                      //       orderController.comment!);
                                                      //   if (orderStatusResponse != null) {
                                                      //     if (orderStatusResponse.success!) {
                                                      //       orderController.selectedOrder!.value.orderStatus = "DELIVERED";
                                                      //       setState(() {});
                                                      //       Fluttertoast.showToast(
                                                      //           msg:"Order delivered Successfully",
                                                      //           toastLength: Toast
                                                      //               .LENGTH_SHORT,
                                                      //           gravity:
                                                      //           ToastGravity
                                                      //               .CENTER,
                                                      //           timeInSecForIosWeb:
                                                      //           1,
                                                      //           backgroundColor:
                                                      //           Colors
                                                      //               .green,
                                                      //           textColor:
                                                      //           Colors
                                                      //               .white,
                                                      //           fontSize: 16.0);
                                                      //       Get.offAll(
                                                      //           const BottomNavigation());
                                                      //     } else {
                                                      //       Fluttertoast.showToast(
                                                      //           msg:
                                                      //           "Order delivery Failed",
                                                      //           toastLength: Toast
                                                      //               .LENGTH_SHORT,
                                                      //           gravity:
                                                      //           ToastGravity
                                                      //               .CENTER,
                                                      //           timeInSecForIosWeb:
                                                      //           1,
                                                      //           backgroundColor:
                                                      //           Colors.red,
                                                      //           textColor:
                                                      //           Colors
                                                      //               .white,
                                                      //           fontSize: 16.0);
                                                      //     }
                                                      //   } else {
                                                      //     Fluttertoast.showToast(
                                                      //         msg:
                                                      //         "Order delivery Failed",
                                                      //         toastLength: Toast
                                                      //             .LENGTH_SHORT,
                                                      //         gravity:
                                                      //         ToastGravity
                                                      //             .CENTER,
                                                      //         timeInSecForIosWeb:
                                                      //         1,
                                                      //         backgroundColor:
                                                      //         Colors.red,
                                                      //         textColor:
                                                      //         Colors.white,
                                                      //         fontSize: 16.0);
                                                      //   }
                                                      // }
                                                      // else {
                                                      //   Fluttertoast.showToast(
                                                      //       msg:
                                                      //           "Please Enter Correct OTP",
                                                      //       toastLength: Toast
                                                      //           .LENGTH_SHORT,
                                                      //       gravity: ToastGravity
                                                      //           .CENTER,
                                                      //       timeInSecForIosWeb: 1,
                                                      //       backgroundColor:
                                                      //           Colors.red,
                                                      //       textColor:
                                                      //           Colors.white,
                                                      //       fontSize: 16.0);
                                                      // }
                                                      //Without OTP

                                                      orderController.isCompleted == true;
                                                      OrderStatusResponse?
                                                          orderStatusResponse =
                                                          await orderController
                                                              .deliveredOrder(orderController.selectedOrder!.value.id.toString(),orderController.comment!);
                                                      if (orderStatusResponse != null) {
                                                        if (orderStatusResponse.success!) {
                                                          orderController.selectedOrder!.value.orderStatus = "DELIVERED";
                                                          setState(() {});
                                                          orderController.myControllerComment.clear();
                                                          Fluttertoast.showToast(
                                                              msg:
                                                                  "Order delivered Successfully",
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
                                                                  "Order delivery Failed",
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
                                                      } else {
                                                        Fluttertoast.showToast(
                                                            msg:
                                                                "Order delivery Failed",
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

                                                      print('Verify');
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: const Text(
                            'Mark as delivered',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontStyle: FontStyle.normal
                            ),
                          )),
                    ),
                  )
                : Container()),
          ])),
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
