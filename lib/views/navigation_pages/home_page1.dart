import 'package:avatar_view/avatar_view.dart';
import 'package:dunzodriver_copy1/constant/color.dart';
import 'package:dunzodriver_copy1/controller/order_controller.dart';
import 'package:dunzodriver_copy1/controller/profile_controller.dart';
import 'package:dunzodriver_copy1/controller/service_controller.dart';
import 'package:dunzodriver_copy1/models/Service_order_model/service_order.dart';
import 'package:dunzodriver_copy1/models/Service_order_model/service_status_model.dart';
import 'package:dunzodriver_copy1/models/order_data.dart';
import 'package:dunzodriver_copy1/views/cab_service/cab_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:url_launcher/url_launcher.dart';

import 'order_accept.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  // AuthController authController= Get.find();
  TabController? _tabController;
  ProfileController profileController = Get.put(ProfileController());
  OrderController orderController = Get.put(OrderController());
  ServiceController serviceController = Get.put(ServiceController());
  String startOtpValue = "";
  String completedOtpValue = "";

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = MaterialButton(
      child: const Text("Cancel"),
      onPressed: () {
        SystemNavigator.pop();
      },
    );
    Widget continueButton = MaterialButton(
      child: const Text("Continue"),
      onPressed: () async {
        // await profileController.requestPermission();
        // Get.back();
        bool done = await profileController.requestPermission();
        if (done) {
          Get.back();
        }
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
        title: const Text(" Location Access"),
        content: const Text(
            "WEDUN-Logistic Partner wants to collects location data in background for showing driver tracking to admin, when the app is opened or app is closed."),
        actions: [
          cancelButton,
          continueButton,
        ]
    );
    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      useRootNavigator: true,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void initState() {
    print("Home ${profileController.storedSettingData.value.data!.homeServiceBooking}");
    _tabController =
    ((profileController.storedSettingData.value.data!.homeServiceBooking ==
        true) ?
    TabController(length: 2, vsync: this) : TabController(length: 1, vsync: this));
    super.initState();
    profileController.profileData();
    orderController.orderStatistics();
    profileController.updateLatLang();
    serviceController.serviceData();
    delay();
  }

  get prefixIcon => null;
  List<String> testItem = ["Test 93", "Test 94", "Test 95", "Test 96"];
  List<String> testItem2 = [
    'Adidas Shoes',
    'Nike Shoes',
    'Woodland Shoes',
    'RedChief Shoes',
  ];

  Future<Null> refresh() async {
    profileController.profileData();
    orderController.orderStatistics();
    profileController.updateLatLang();
    orderController.pagingControllerOrder.refresh();
    serviceController.pagingControllerOrder.refresh();
    serviceController.serviceData();
  }

  Widget myContainer(OrderData orderData) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          print("${orderData.serviceCategory!.serviceTypeId}");
          if (orderData.serviceCategory!.serviceTypeId == 4) {
            // orderController.selectedOrder!.value = orderData;
            // Get.to(OrderAccpect(orderData.id.toString(), "type"));
            orderController.selectedOrder!.value = orderData;
            Get.to(CabService(orderData.id.toString()));
          } else {
            orderController.selectedOrder!.value = orderData;
            Get.toNamed("orderdetails", preventDuplicates: false);
            // Get.to(OrderAccpect(orderData.id.toString(), "type"));
          }
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade500,
                  blurRadius: 20.0,
                )
              ]),
          margin: const EdgeInsets.only(top: 20),
          // padding: const EdgeInsets.only(left: 10),
          alignment: Alignment.center,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(children: [
                    Column(
                      children: [
                        const CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.local_shipping,
                            size: 30,
                            color: Constant.secondary,
                          ),
                        ),
                        Text(
                          "#${orderData.id}",
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.45,
                          child: Text(
                            (orderData.pickupAddress == null)
                                ? ""
                                : orderData.pickupAddress!.address!,
                            style: const TextStyle(
                                color: Constant.primary,
                                fontSize: 16,
                                fontFamily: 'Source Sans Pro',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          "${orderData.createdAt}",
                          style: const TextStyle(
                              color: Constant.gray,
                              fontSize: 12,
                              fontFamily: 'Source Sans Pro',
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Text(
                            (orderData.totalPrice != null)
                                ? "${Constant.currency} ${orderData.grandTotal!
                                .toString()}"
                                : "",
                            style: const TextStyle(
                                color: Constant.primary,
                                fontSize: 20,
                                fontFamily: 'Source Sans Pro',
                                fontWeight: FontWeight.w600),
                          ))
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(thickness: 2),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  (orderData.orderStatus == "PICKEDUP")
                      ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      (orderData.serviceCategory!.serviceTypeId != 4) ? Row(
                        children: [
                          const Icon(
                            Icons.description,
                            color: Constant.secondary,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            width:
                            MediaQuery
                                .of(context)
                                .size
                                .width * 0.45,
                            child: Text(
                              getItemList(orderData).join(",").toString(),
                              style: TextStyle(
                                color: Colors.grey.shade800,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Source Sans Pro',
                                fontSize: 15,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ],
                      ) : Container(),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const Icon(
                            Icons.people,
                            color: Constant.secondary,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            orderData.userId != null
                                ? orderData.user!.name != null
                                ? orderData.user!.name!
                                : orderData.deliveryAddress!.name !=
                                null &&
                                orderData.deliveryAddress!
                                    .name !=
                                    null &&
                                orderData.deliveryAddress!
                                    .name !=
                                    "null"
                                ? orderData.deliveryAddress!.name!
                                : ""
                                : "",
                            style: TextStyle(
                              color: Colors.grey.shade800,
                              fontFamily: 'Source Sans Pro',
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const Icon(
                            Icons.phone,
                            color: Constant.secondary,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            orderData.userId != null
                                ? orderData.user!.mobile!
                                : orderData.deliveryAddress!.phone !=
                                null &&
                                orderData
                                    .deliveryAddress!.phone !=
                                    null
                                ? orderData.deliveryAddress!.phone!
                                : "",
                            style: TextStyle(
                              color: Colors.grey.shade800,
                              fontFamily: 'Source Sans Pro',
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 5),
                    ],
                  )
                      : Container(),
                  (orderData.orderStatus == "ASSIGNED")
                      ? (orderData.serviceCategory!.serviceTypeId != 4)
                      ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const Icon(
                            Icons.people,
                            color: Constant.secondary,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            width:
                            MediaQuery
                                .of(context)
                                .size
                                .width * .55,
                            child: Text(
                              (orderData.pickupAddress!.name != null &&
                                  orderData.pickupAddress!.name != "null")
                                  ? orderData.pickupAddress!.name!
                                  : orderController
                                  .selectedOrder!.value.user!.name!,
                              style: TextStyle(
                                color: Colors.grey.shade800,
                                fontFamily: 'Source Sans Pro',
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const Icon(
                            Icons.phone,
                            color: Constant.secondary,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text((orderData.pickupAddress!.mobile != null &&
                              orderData.pickupAddress!.mobile != "null")
                              ? orderData.pickupAddress!.mobile!
                              : (orderData.pickupAddress!.phone != null &&
                              orderData.pickupAddress!.phone != "null")
                              ? orderData.pickupAddress!.phone!:orderData.user!.mobile!,
                            style: TextStyle(
                              color: Colors.grey.shade800,
                              fontFamily: 'Source Sans Pro',
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                    ],
                  )
                      : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Container(
                            width:
                            MediaQuery
                                .of(context)
                                .size
                                .width * .55,
                            child: Text("Cab Service",
                              style: TextStyle(
                                color: Colors.grey.shade800,
                                fontFamily: 'Source Sans Pro',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                    ],
                  ) : Container(),
                  InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                            color: Constant.secondaryTransparent,
                            borderRadius: BorderRadius.all(Radius.circular(
                                5.0))),
                        child: Row(
                          children: [
                            Text(
                              orderData.orderStatus.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Constant.primary,
                                fontFamily: 'Source Sans Pro',
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  // Image.network(
                  //     '${ApiRoutes.BASE_URL}/${orderData.store != null ? orderData.store!.image ?? orderData.serviceCategory!.icon : orderData.serviceCategory!.icon}',
                  //   width: 80,height: 80,),
                ],
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Expanded(
              //         child: Padding(
              //       padding: const EdgeInsets.only(left: 20),
              //       child: Text(
              //         orderData.deliveryAddress!.address!,
              //         style: TextStyle(
              //             color: Colors.grey.shade800,
              //             letterSpacing: 0,
              //             fontWeight: FontWeight.bold,
              //             fontSize: 12),
              //       ),
              //     )),
              //     // Row(
              //     //   children: [
              //     //     Container(
              //     //       padding: const EdgeInsets.all(10),
              //     //       decoration: const BoxDecoration(
              //     //           color: Constant.greenTransprant,
              //     //           borderRadius: BorderRadius.all(Radius.circular(2))),
              //     //       child: Row(
              //     //         children: [
              //     //           const Icon(
              //     //             Icons.near_me,
              //     //             color: Constant.secondary,
              //     //           ),
              //     //           const SizedBox(width: 10),
              //     //           Text(
              //     //             'Map',
              //     //             style: TextStyle(
              //     //               color: Colors.grey.shade900,
              //     //               fontFamily: 'Source Sans Pro',
              //     //               fontSize: 17,
              //     //             ),
              //     //           )
              //     //         ],
              //     //       ),
              //     //     ),
              //     //     const SizedBox(width: 10),
              //     //   ],
              //     // ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }


  //TODO home_service_booking
  Widget serviceContainer(index, ServiceData serviceData) {
    return InkWell(
      child: Card(
        margin: const EdgeInsets.all(15.0),
        elevation: 10,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      width: 100,
                      child: Text(
                        "#${serviceData.id}"
                            " ${serviceData.serviceCategory!.name}",
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      )),
                  Text("${serviceData.createdAt}"),
                ],
              ),
            ),
            const Divider(
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      width: 110,
                      child: (serviceData.distanceTravelled == null)
                          ? Text(
                        "${serviceData.distanceTravelled} "
                            "KM Away Requirements:",
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      )
                          : Container(
                        child: const Text(
                          "0 KM",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      )),
                  (serviceData.paymentMethod == "COD")
                      ? Container(
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    height: 40.0,
                    width: 110,
                    child: Center(
                        child: Text(
                          "₹${serviceData.totalPrice}",
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        )),
                  )
                      : Container(
                    decoration: BoxDecoration(
                      color: Constant.primary,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    height: 40.0,
                    width: 110,
                    child: Center(
                        child: Text(
                          "₹${serviceData.totalPrice}",
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        )),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    "Service on :",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 200,
                    child: Text(
                        "${serviceData.serviceDate}"
                            "/${serviceData.serviceTime}",
                        style: const TextStyle(
                            color: Constant.secondary,
                            fontSize: 16,
                            fontWeight: FontWeight.w500)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${serviceData.user!.name}",
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Container(
                            height: 50,
                            width: 280,
                            child: (serviceData.serviceAddress != null)
                                ? Text("${serviceData.serviceAddress!.address}")
                                : Container(
                                child: const Text(
                                  "Address Not Found",
                                  style: TextStyle(color: Colors.redAccent),
                                ))),
                        //227,near Bansal sweets,padpad ganj,Mayur Vihar ,delhi,110091,india
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 2,
            ),
            (serviceData.orderStatus == "ASSIGNED")
                ? Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () async {
                      ServiceStatusResponse? serviceStatusResponse =
                      await serviceController.acceptServiceOrder(
                          serviceData.id.toString());
                      if (serviceStatusResponse != null) {
                        if (serviceStatusResponse.success!) {
                          (serviceData.orderStatus = "ACCEPTED");
                          setState(() {});
                          Fluttertoast.showToast(
                              msg: "Accepted",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Constant.secondary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          "Accept",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () async {
                      ServiceStatusResponse? serviceStatusResponse =
                      await serviceController.cancelService(
                          serviceData.id.toString());
                      if (serviceStatusResponse != null) {
                        if (serviceStatusResponse.success!) {
                          (serviceData.orderStatus = "CANCELLED");
                          setState(() {});
                          Fluttertoast.showToast(
                              msg: "Order Cancelled",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          "Reject",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
                : Container(),
            (serviceData.orderStatus == "ACCEPTED")
                ? Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          child: Container(
                            alignment: Alignment.center,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Constant.secondary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.phone,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Call",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          onTap: () {
                            launch('tel://${serviceData.user!.mobile}');
                            print(
                                'Customer mobile number ${serviceData.user!
                                    .mobile}');
                          },
                        ),
                        InkWell(
                          child: Container(
                            alignment: Alignment.center,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Constant.secondary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.directions,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Map",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          onTap: () {
                            openMap(
                              serviceData.serviceAddress!.latitude,
                              serviceData.serviceAddress!.longitude,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        child: Container(
                          alignment: Alignment.center,
                          width: 350,
                          decoration: BoxDecoration(
                            color: Constant.secondary,
                            borderRadius: BorderRadius.circular(10),
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
                          ServiceStatusResponse? serviceStatusResponse =
                          await serviceController.reachedService(
                              serviceData.id.toString());
                          if (serviceStatusResponse != null) {
                            if (serviceStatusResponse.success!) {
                              (serviceData.orderStatus = "REACHED");
                              setState(() {});
                              Fluttertoast.showToast(
                                  msg: "Reached",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          }
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ],
              ),
            )
                : Container(),
            //OrderAccept
            (serviceData.orderStatus == "REACHED")
                ? Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          child: Container(
                            alignment: Alignment.center,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Constant.secondary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.phone,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Call",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          onTap: () {
                            launch('tel://${serviceData.user!.mobile}');
                            print(
                                'Customer mobile number ${serviceData.user!
                                    .mobile}');
                          },
                        ),
                        InkWell(
                          child: Container(
                            alignment: Alignment.center,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Constant.secondary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.directions,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Map",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          onTap: () {
                            openMap(
                              serviceData.user!.lat,
                              serviceData.user!.long,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        child: Container(
                          alignment: Alignment.center,
                          width: 150,
                          decoration: BoxDecoration(
                            color: Constant.secondary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text(
                              "Start",
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
                                    'Start Service',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text('Are you sure',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold)),
                                      (serviceData.startOtp == null)
                                          ? Container()
                                          : PinCodeTextField(
                                        pinBoxRadius: 10,
                                        pinBoxOuterPadding: const EdgeInsets
                                            .all(5.0),
                                        pinBoxColor: Constant
                                            .secondaryTransparent,
                                        autofocus: true,
                                        hideCharacter: false,
                                        controller: serviceController
                                            .startServiceController,
                                        hasTextBorderColor: Colors.green,
                                        highlight: true,
                                        maxLength: 4,
                                        onTextChanged: (text) {
                                          print("Changed:" + text);
                                          serviceController.pinn = text;
                                          if (serviceController.pinn.length ==
                                              4) {
                                            setState(() {
                                              serviceController.isChecked
                                                  .value = true;
                                            });
                                          }
                                        },
                                        onDone: (text) {
                                          startOtpValue = text;
                                          print("Completed: " + text);
                                        },
                                        pinBoxWidth: 45,
                                        pinBoxHeight: 45.0,
                                        hasUnderline: false,
                                        keyboardType: TextInputType.number,
                                        wrapAlignment: WrapAlignment
                                            .spaceAround,
                                        pinBoxDecoration:
                                        ProvidedPinBoxDecoration
                                            .defaultPinBoxDecoration,
                                        pinTextStyle: const TextStyle(
                                            fontSize: 20.0),
                                        pinTextAnimatedSwitcherTransition:
                                        ProvidedPinBoxTextAnimation
                                            .scalingTransition,
//                    pinBoxColor: Colors.green[100],
                                        pinTextAnimatedSwitcherDuration:
                                        const Duration(milliseconds: 300),
//                    highlightAnimation: true,
                                        highlightAnimationBeginColor: Colors
                                            .black,
                                        highlightAnimationEndColor: Colors
                                            .white12,
                                      ),
                                      Text("StartOtp${serviceData.startOtp}")
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
                                            color: Constant.primary),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        if (startOtpValue.length > 4) {
                                          Fluttertoast.showToast(
                                              msg: "Wrong Otp",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.green,
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                        }
                                        if (serviceData.startOtp ==
                                            startOtpValue) {
                                          ServiceStatusResponse? serviceStatusResponse = await serviceController
                                              .startedService(
                                              serviceData.id.toString());
                                          if (serviceStatusResponse != null) {
                                            if (serviceStatusResponse
                                                .success!) {
                                              (serviceData.orderStatus =
                                              "STARTED");
                                              setState(() {});
                                              Fluttertoast.showToast(
                                                  msg: "Started",
                                                  toastLength:
                                                  Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.CENTER,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.green,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                            } else {
                                              Fluttertoast.showToast(
                                                  msg: "Service Error",
                                                  toastLength:
                                                  Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.CENTER,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.green,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                            }
                                            Get.back();
                                          } else {
                                            Fluttertoast.showToast(
                                                msg: "Service Error 2",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.CENTER,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.green,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                            print(
                                                "$serviceStatusResponse service status");
                                          }
                                        } else {
                                          Fluttertoast.showToast(
                                              msg: "Please Enter Correct OTP",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                        }
                                      },
                                      child: const Text(
                                        'Yes',
                                        style: TextStyle(
                                            color: Constant.primary),
                                      ),
                                    ),
                                  ],
                                ),
                          );
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        child: Container(
                          alignment: Alignment.center,
                          width: 150,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text(
                              "Reject",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          ),
                        ),
                        onTap: () async {
                          ServiceStatusResponse? serviceStatusResponse =
                          await serviceController.cancelService(
                              serviceData.id.toString());
                          if (serviceStatusResponse != null) {
                            if (serviceStatusResponse.success!) {
                              (serviceData.orderStatus = "CANCELLED");
                              setState(() {});
                              Fluttertoast.showToast(
                                  msg: "Service Cancelled Successfully",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            )
                : Container(),
            //After Accepted
            (serviceData.orderStatus == "STARTED")
                ? Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    child: Container(
                      alignment: Alignment.center,
                      width: 350,
                      decoration: BoxDecoration(
                        color: Constant.secondary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          "Mark As Finished",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),
                    ),
                    onTap: () async {
                      ServiceStatusResponse? serviceStatusResponse =
                      await serviceController
                          .finishedService(serviceData.id.toString());
                      if (serviceStatusResponse != null) {
                        if (serviceStatusResponse.success!) {
                          (serviceData.orderStatus = "FINISHED");
                          setState(() {});
                          Fluttertoast.showToast(
                              msg: " Service Finished",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      }
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            )
                : Container(),
            //Started//
            (serviceData.orderStatus == "FINISHED")
                ? Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    child: Container(
                      alignment: Alignment.center,
                      width: 300,
                      decoration: BoxDecoration(
                        color: Constant.secondary,
                        borderRadius: BorderRadius.circular(10),
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
                    onTap: () {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) =>
                            AlertDialog(
                              title: const Text(
                                'Payment Status',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              content: (serviceData.paymentMethod == "COD")
                                  ? Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Please Collect -- ₹ ${serviceData
                                        .totalPrice}',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  PinCodeTextField(
                                    pinBoxRadius: 10,
                                    pinBoxOuterPadding: const EdgeInsets.all(
                                        5.0),
                                    pinBoxColor: Constant.secondaryTransparent,
                                    autofocus: true,
                                    hideCharacter: false,
                                    controller: serviceController
                                        .completedServiceController,
                                    hasTextBorderColor: Colors.green,
                                    highlight: true,
                                    maxLength: 4,
                                    onTextChanged: (text) {
                                      print("Changed:" + text);
                                      serviceController.comPinn = text;
                                      if (serviceController.comPinn.length ==
                                          4) {
                                        setState(() {
                                          serviceController.isChecked.value =
                                          true;
                                        });
                                      }
                                    },
                                    onDone: (text) {
                                      completedOtpValue = text;
                                      print("Completed: " + text);
                                    },
                                    pinBoxWidth: 45,
                                    pinBoxHeight: 45.0,
                                    hasUnderline: false,
                                    keyboardType: TextInputType.number,
                                    wrapAlignment: WrapAlignment.spaceAround,
                                    pinBoxDecoration:
                                    ProvidedPinBoxDecoration
                                        .defaultPinBoxDecoration,
                                    pinTextStyle: const TextStyle(
                                        fontSize: 20.0),
                                    pinTextAnimatedSwitcherTransition:
                                    ProvidedPinBoxTextAnimation
                                        .scalingTransition,
//                    pinBoxColor: Colors.green[100],
                                    pinTextAnimatedSwitcherDuration:
                                    const Duration(milliseconds: 300),
//                    highlightAnimation: true,
                                    highlightAnimationBeginColor: Colors.black,
                                    highlightAnimationEndColor: Colors.white12,
                                  ),
                                  Text("${serviceData.deliveryOtp}")
                                ],
                              )
                                  : const Text("Amount is Paid"),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancel'),
                                  child: const Text(
                                    'Cancel',
                                    style: TextStyle(color: Constant.primary),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    ServiceStatusResponse?
                                    serviceStatusResponse =
                                    await serviceController.completedService(
                                        serviceData.id.toString());
                                    if (serviceStatusResponse != null) {
                                      if (serviceData.deliveryOtp ==
                                          completedOtpValue) {
                                        if (serviceStatusResponse.success!) {
                                          (serviceData.orderStatus =
                                          "COMPLETED");
                                          setState(() {});
                                          Fluttertoast.showToast(
                                              msg: "Work Completed",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.green,
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                          Get.back();
                                        }
                                      } else {
                                        Fluttertoast.showToast(
                                            msg: "Wrong Otp",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.green,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                      }
                                    }
                                  },
                                  child: const Text(
                                    'OK',
                                    style: TextStyle(color: Constant.primary),
                                  ),
                                ),
                              ],
                            ),
                      );
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            )
                : Container(),
            (serviceData.orderStatus == "COMPLETED")
                ? Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    child: Container(
                      alignment: Alignment.center,
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          "Completed Task",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),
                    ),
                    onTap: () {

                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            )
                : Container(),
          ],
        ),
      ),
      onTap: () {},
    );
  }

  List<String> getItemList(OrderData orderData) {
    List<String> temp = [''];
    temp.clear();
    for (int j = 0; j < orderData.items!.length; j++) {
      temp.add(orderData.items!.elementAt(j).productName! +
          "X" +
          orderData.items!.elementAt(j).quantity!.toString());
    }
    return temp;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    orderController.orderStatistics();
    orderController.pagingControllerOrder.refresh();
    serviceController.pagingControllerOrder.refresh();
  }

  Future delay() async {
    final check = await profileController.checkPermission();
    // Fluttertoast.showToast(msg: "$check");
    if (!check) {
      await Future.delayed(const Duration(seconds: 3), () {
        showAlertDialog(context);
      });
    } else {

    }
  }

  @override
  Widget build(BuildContext context) {
    bool isSelected = false;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Constant.secondary,
        toolbarHeight: 130,
        automaticallyImplyLeading: false,
        actions: [
          Obx(() =>
              FlutterSwitch(
                activeColor: Constant.secondary,
                inactiveColor: Constant.secondary,
                activeSwitchBorder: Border.all(color: Colors.white),
                inactiveSwitchBorder: Border.all(color: Colors.red.shade300),
                toggleColor: Colors.red.shade300,
                inactiveTextColor: Colors.red.shade300,
                activeTextColor: Colors.white,
                activeToggleColor: Colors.white,
                width: 75.0,
                height: 40.0,
                valueFontSize: 20.0,
                toggleSize: 15.0,
                value: profileController.statusDuty.value,
                borderRadius: 30.0,
                padding: 8.0,
                showOnOff: true,
                onToggle: (value) async {
                  orderController.orderStatistics();
                  String type = "";
                  if (value) {
                    type = "on";
                  } else {
                    type = "off";
                  }
                  if (value == true) {
                    bool permission = await profileController.checkPermission();
                    if (permission) {
                      final data = await profileController.driverDuty(
                          profileController.getAccessToken().toString(), "on");
                      profileController.initLocationService();
                      profileController.startDateTime = data?.data?.createdAt ?? DateTime.now();
                      profileController.startTimer();
                      setState(() {
                        profileController.statusDuty.value = true;
                      });
                      profileController.getCurrentLocation();
                    } else {
                      // profileController.checkPermission();
                      profileController.driverDuty(
                          profileController.getAccessToken().toString(), "off");
                      profileController.stopTimer();
                      profileController.stopService();
                      setState(() {
                        profileController.statusDuty.value = false;
                      });
                      Fluttertoast.showToast(
                          msg: "Location Denied",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  } else {
                    profileController.reset();
                    profileController.driverDuty(
                        profileController.getAccessToken().toString(), "off");
                    setState(() {
                      profileController.statusDuty.value = false;
                    });
                    Fluttertoast.showToast(
                        msg: "Location off",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }
                },
              )),
          const SizedBox(
            width: 10,
          ),
        ],
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Obx(
                  () =>
                  Text(
                    (profileController.profileDataHome.value.name == null)
                        ? ""
                        : 'Welcome! ${profileController.profileDataHome.value
                        .name}',
                    style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'Source Sans Pro',
                      fontWeight: FontWeight.bold,
                      color: Colors.teal.shade50,
                      letterSpacing: 2,
                    ),
                  ),
            ),
            Obx(
                  () =>
                  Text(
                    '${orderController.orderStatisticsDetails.value.data != null
                        ? orderController.orderStatisticsDetails.value.data!
                        .pending
                        : 0} Pending order',
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.normal,
                        color: Colors.white),
                  ),
            ),
            // Text(
            //   'Active Time - ${orderController.orderStatisticsDetails.value.data!=null?
            //   orderController.orderStatisticsDetails.value.data!.activeTime:0} ',
            //   style: const TextStyle(
            //       fontSize: 13,
            //       fontWeight: FontWeight.normal,
            //       color: Colors.white),
            // ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
        bottom: PreferredSize(preferredSize: (profileController
            .storedSettingData.value.data!.homeServiceBooking == true) ?
        const Size.fromHeight(50.0) : const Size.fromHeight(30.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * .9,
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                          color: Constant.secondaryTransparent,
                          borderRadius:
                          BorderRadius.all(Radius.circular(10.0))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // Obx(() =>
                          const Text(
                            "On Duty Since",
                            // 'On Duty Since ${orderController.orderStatisticsDetails.value.data != null ? orderController.orderStatisticsDetails.value.data!.activeTime : 0.0}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'Source Sans Pro', fontSize: 17,
                              // ),
                            ),
                          ),
                          // ),
                          // ),
                          Obx(() =>
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: buildTime(),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5.0,),
              (profileController.storedSettingData.value.data!
                  .homeServiceBooking == true) ? TabBar(
                unselectedLabelColor: Constant.primary,
                labelColor: Colors.white,
                labelStyle: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 18.0),
                tabs: const [
                  Tab(
                    text: "Delivery Order",
                  ),
                  Tab(
                    text: "Service Order",
                  ),
                ],
                controller: _tabController,
                indicatorSize: TabBarIndicatorSize.tab,
                onTap: (value) {},
                indicatorColor: Colors.white,
              ) :
              Container(),
            ],
          ),
        ),
      ),
      // body:
      // PagedListView<int, OrderData>(
      //   pagingController: orderController.pagingControllerOrder,
      //
      //   builderDelegate: PagedChildBuilderDelegate<OrderData>(
      //     itemBuilder: (context, item, index) => myContainer(item),
      //   ),
      //   shrinkWrap: true,
      //   physics: const BouncingScrollPhysics(),
      // ),
      body: (profileController.storedSettingData.value.data!
          .homeServiceBooking == true) ? TabBarView(
        children: [
          DeliverOrder(),
          ServiceOrder()
        ],
        controller: _tabController,
      ) : TabBarView(
        children: [
          DeliverOrder(),
        ],
        controller: _tabController,
      ),
      // body: RefreshIndicator(
      //   color: Constant.secondary,
      //   onRefresh: () {
      //     return refresh();
      //   },
      //   child: SingleChildScrollView(
      //     child: TabBarView(children: [
      //       DeliverOrder(),
      //       ServiceOrder(),
      //     ],
      //       controller: _tabController,
      //     ),
      //   ),
      // ),
    );
  }

  Widget DeliverOrder() {
    bool isSelected = false;
    return RefreshIndicator(
      color: Constant.secondary,
      onRefresh: () {
        return refresh();
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        orderController.selectedOrderType.value = "ASSIGNED";
                        orderController.orderStatistics();
                        orderController.update();
                        orderController.pagingControllerOrder.refresh();
                      },
                      child: Obx(() =>
                          Container(
                              margin: const EdgeInsets.only(
                                  left: 20, right: 10),
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                shape: BoxShape.rectangle,
                                border: (orderController.selectedOrderType
                                    .value ==
                                    "ASSIGNED")
                                    ? Border.all(color: Colors.grey, width: 4)
                                    : Border.all(color: Colors.grey, width: 0),
                                color: (isSelected)
                                    ? Colors.tealAccent.shade700
                                    : Colors.orangeAccent,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Obx(
                                        () =>
                                        Text(
                                          orderController.isLoading!.value
                                              ? "...."
                                              : "${orderController
                                              .orderStatisticsDetails.value
                                              .data != null ? orderController
                                              .orderStatisticsDetails.value
                                              .data!.pending : 0}",
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 40,
                                              fontWeight: FontWeight.bold),
                                        ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(Icons.schedule),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text('Pending')
                                    ],
                                  )
                                ],
                              ))),
                    ),
                  ),
                  Expanded(
                      child: Obx(
                            () =>
                            Container(
                              margin: const EdgeInsets.only(
                                  right: 20, left: 10),
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                shape: BoxShape.rectangle,
                                border: orderController.selectedOrderType
                                    .value ==
                                    "DELIVERED"
                                    ? Border.all(
                                    color: Colors.grey.shade700, width: 4)
                                    : Border.all(
                                    color: Colors.grey.shade700, width: 0),
                                color: (isSelected)
                                    ? Colors.amber.shade700
                                    : Constant.secondary,
                              ),
                              child: InkWell(
                                onTap: () {
                                  orderController.selectedOrderType.value =
                                  "DELIVERED";
                                  orderController.update();
                                  orderController.pagingControllerOrder
                                      .refresh();
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      child: Obx(
                                            () =>
                                            Text(
                                              orderController.isLoading!.value
                                                  ? "..."
                                                  : "${orderController
                                                  .orderStatisticsDetails.value
                                                  .data != null
                                                  ? orderController
                                                  .orderStatisticsDetails.value
                                                  .data!.completed
                                                  : 0}",
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 40),
                                            ),
                                      ),
                                      padding: const EdgeInsets.all(0),
                                    ),
                                    Padding(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: const [
                                          Icon(Icons.local_shipping),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            'Delivered',
                                            style: TextStyle(
                                                color: Colors.black),
                                          )
                                        ],
                                      ),
                                      padding: const EdgeInsets.all(0),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                      )),
                ],
              ),
            ),
            const Divider(
              thickness: 10,
            ),
            PagedListView<int, OrderData>(
              reverse: false,
              pagingController: orderController.pagingControllerOrder,
              builderDelegate: PagedChildBuilderDelegate<OrderData>(
                itemBuilder: (context, item, index) => myContainer(item),
              ),
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
            ),
          ],
        ),
      ),
    );
  }

  Widget ServiceOrder() {
    bool isSelected = false;
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
            child: Row(
              children: [
                Expanded(
                  child: Obx(
                        () =>
                        InkWell(
                          onTap: () {
                            serviceController.selectedOrderTab.value =
                            "UPCOMING";
                            serviceController.update();
                            orderController.orderStatistics();
                            serviceController.pagingControllerOrder.refresh();
                          },
                          child: Container(
                              margin: const EdgeInsets.only(
                                  left: 20, right: 10),
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                shape: BoxShape.rectangle,
                                border: (serviceController.selectedOrderTab
                                    .value ==
                                    "UPCOMING")
                                    ? Border.all(
                                    color: Colors.grey.shade700, width: 4)
                                    : Border.all(
                                    color: Colors.grey.shade700, width: 0),
                                color: (isSelected)
                                    ? Colors.tealAccent.shade700
                                    : Colors.orangeAccent,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    orderController.isLoading!.value
                                        ? "...."
                                        : "${orderController
                                        .orderStatisticsDetails.value.data !=
                                        null ? orderController
                                        .orderStatisticsDetails.value.data!
                                        .upcomingServiceOrder : 0}",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(Icons.design_services),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text('Upcoming')
                                    ],
                                  )
                                ],
                              )),
                        ),
                  ),
                ),
                Expanded(
                  child: Obx(
                        () =>
                        InkWell(
                          onTap: () {
                            serviceController.selectedOrderTab.value =
                            "COMPLETED";
                            serviceController.update();
                            orderController.orderStatistics();
                            serviceController.pagingControllerOrder.refresh();
                          },
                          child: Container(
                              margin: const EdgeInsets.only(
                                  left: 20, right: 10),
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                shape: BoxShape.rectangle,
                                border: (serviceController.selectedOrderTab
                                    .value ==
                                    "COMPLETED")
                                    ? Border.all(
                                    color: Colors.grey.shade700, width: 4)
                                    : Border.all(
                                    color: Colors.grey.shade700, width: 0),
                                color: (isSelected)
                                    ? Colors.tealAccent.shade700
                                    : Constant.secondary,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    orderController.isLoading!.value
                                        ? "...."
                                        : "${orderController
                                        .orderStatisticsDetails.value.data !=
                                        null ? orderController
                                        .orderStatisticsDetails.value.data!
                                        .completedServiceOrder : 0}",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(Icons.done),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text('Completed'),
                                    ],
                                  )
                                ],
                              )),
                        ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            thickness: 5,
          ),
          PagedListView<int, ServiceData>(
            pagingController: serviceController.pagingControllerOrder,
            builderDelegate: PagedChildBuilderDelegate<ServiceData>(
                itemBuilder: (context, item, index) {
                  return (profileController.storedSettingData.value.data!
                      .homeServiceBooking == true) ? serviceContainer(
                      index, item) : Container();
                }),
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
          ),
          // PagedListView<int, OrderData>(
          //   reverse: false,
          //   pagingController: orderController.pagingControllerOrder,
          //   builderDelegate: PagedChildBuilderDelegate<OrderData>(
          //     itemBuilder: (context, item, index) => serviceContainer(),
          //   ),
          //   shrinkWrap: true,
          //   physics: const BouncingScrollPhysics(),
          // ),
        ],
      ),
    );
  }

  Widget buildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(profileController.duration.value.inHours);
    final minutes =
    twoDigits(profileController.duration.value.inMinutes.remainder(60));
    final seconds =
    twoDigits(profileController.duration.value.inSeconds.remainder(60));
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      buildTimeCard(time: hours, header: 'HOURS'),
      const SizedBox(
        width: 2,
      ),
      buildTimeCard(time: minutes, header: 'MINUTES'),
      const SizedBox(
        width: 2,
      ),
      buildTimeCard(time: seconds, header: 'SECONDS'),
    ]);
  }

  Widget buildTimeCard({required String time, required String header}) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              time,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 8),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(header,
              style: const TextStyle(fontSize: 8, color: Colors.white)),
        ],
      );

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
