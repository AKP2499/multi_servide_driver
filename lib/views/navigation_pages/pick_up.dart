import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:dunzodriver_copy1/constant/color.dart';
import 'package:dunzodriver_copy1/controller/order_controller.dart';
import 'package:dunzodriver_copy1/models/select_Item_model.dart';
import 'package:dunzodriver_copy1/views/navigation_pages/bottomnavigation_dunzo.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';


class PickedUp extends StatefulWidget {
  const PickedUp({Key? key, index}) : super(key: key);

  @override
  _PickedUpState createState() => _PickedUpState();
}

class _PickedUpState extends State<PickedUp> {

  OrderController orderController = Get.find();
  TextEditingController pickupOtpController = TextEditingController(text: "");
  var isSelected;
  String otpValue="";
  final myControllerOtpVerifyField = TextEditingController();
  List<String>? selectedFoodItem = [""];
  List<String> foodList = [
    'Dal Makhani',
    'Paneer butter masala',
    'Boondi raita',
    '4 Butter Naan',
    '2 Gulab jamun'
  ];

  @override
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.white;
    }
    return Constant.secondary;
  }
  @override
  void initState() {
    // TODO: implement initState
    selectedFoodItem!.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pickup Details',
          style: TextStyle(
              color: Constant.primary,
              fontSize: 20,
              fontWeight: FontWeight.w600),
        ),
        elevation: 4,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    (orderController.selectedOrder!.value.serviceCategory!.serviceTypeId==1)?
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children:  [
                        const Text(
                          'Enter OTP',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Source Sans Pro',
                          ),
                        ),
                        Center(
                          child: PinCodeTextField(
                            pinBoxRadius: 10,
                            pinBoxOuterPadding: const EdgeInsets.all(10),
                            pinBoxColor: Constant.secondaryTransparent,
                            autofocus: true,
                            hideCharacter: false,
                            controller: pickupOtpController,
                            hasTextBorderColor: Colors.green,
                            highlight: true,
                            maxLength: 4,
                            onTextChanged: (text){
                              print("Changed:"+ text);
                              orderController.pinn=text;
                              if(orderController.pinn.length==4){
                                setState(() {
                                  orderController.isChecked.value=true;
                                });
                              }
                            },
                            onDone:(text){
                              otpValue = text;
                              print("Completed: " + text);
                            },
                            pinBoxWidth: 60,
                            pinBoxHeight: 60,
                            hasUnderline: false,
                            keyboardType: TextInputType.number,
                            wrapAlignment: WrapAlignment.spaceAround,
                            pinBoxDecoration:
                            ProvidedPinBoxDecoration.defaultPinBoxDecoration,
                            pinTextStyle: const TextStyle(fontSize: 22.0),
                            pinTextAnimatedSwitcherTransition:
                            ProvidedPinBoxTextAnimation.scalingTransition,
//                    pinBoxColor: Colors.green[100],
                            pinTextAnimatedSwitcherDuration:
                            const Duration(milliseconds: 300),
//                    highlightAnimation: true,
                            highlightAnimationBeginColor: Colors.black,
                            highlightAnimationEndColor: Colors.white12,
                          ),
                        ),
                        // OTPTextField(
                        //   length: 4,
                        //   width: MediaQuery.of(context).size.width * .9,
                        //   textFieldAlignment: MainAxisAlignment.spaceAround,
                        //   fieldWidth: 50,
                        //   fieldStyle: FieldStyle.box,
                        //   outlineBorderRadius: 20,
                        //   style: const TextStyle(fontSize: 10.0),
                        //   onChanged: (pin) {
                        //     print("Changed: " + pin);
                        //     otpValue=pin;
                        //
                        //   },
                        //   onCompleted: (pin) {
                        //     print("Completed: " + pin);
                        //     otpValue=pin;
                        //     setState(() {
                        //
                        //     });
                        //   },
                        // ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Divider(
                          thickness: 10,
                        ),
                      ],
                    ):Container(),
                    const SizedBox(
                      height: 10,
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Package Image',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DottedBorder(
                        color: Colors.grey,
                        strokeWidth: 4,
                        child: Container(
                          margin: const EdgeInsets.only(left: 11),
                          padding: const EdgeInsets.only(right: 20),
                          // margin: const EdgeInsets.only(left: 5),
                          height: 250,
                          width: 360,
                          child: orderController.foodImage != null
                              ? orderController.foodImage.value.path != ""
                                  ? Stack(
                                      children: [
                                        Positioned(
                                          child: Image.file(File(orderController
                                              .foodImage.value.path
                                          )),
                                          right: 0,
                                          left: 0,
                                          bottom: 0,
                                          top: 0,
                                        ),
                                        orderController.foodImage != null
                                            ? InkWell(
                                                onTap: () {
                                                  orderController.foodImage.value = XFile("");
                                                  setState(() {});
                                                },
                                                child: const CircleAvatar(
                                                  child: Icon(
                                                    Icons.remove,
                                                    color: Colors.white,
                                                    size: 24,
                                                  ),
                                                  backgroundColor: Colors.red,
                                                  radius: 15.0,
                                                ),
                                              )
                                            : Container()
                                      ],
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          '',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        const Text(
                                          '',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Icon(
                                          Icons.photo_camera,
                                          size: 30,
                                          color: Constant.primary,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        TextButton(
                                            onPressed:
                                                orderController.getFoodImage,
                                            child: const Text(
                                              'Upload Photos',
                                              style: TextStyle(
                                                  color: Constant.primary,
                                                  fontSize: 20),
                                            )),
                                        // const Text('Upload focused photos of below documents'),
                                        // const Text('for faster verification'),
                                      ],
                                    )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      '',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const Text(
                                      '',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Icon(
                                      Icons.photo_camera,
                                      size: 30,
                                      color: Constant.primary,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    TextButton(
                                        onPressed: orderController.getFoodImage,
                                        child: const Text(
                                          'Upload Photos',
                                          style: TextStyle(
                                              color: Constant.primary,
                                              fontSize: 20),
                                        )),
                                  ],
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    orderController.selectedOrder!.value.items!.isNotEmpty?
                    Column(
                      children: const [
                        Text('Package Item List',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Source Sans Pro',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ):Container(),
                    orderController.selectedOrder!.value.items!.isNotEmpty?
                    const SizedBox(
                      height: 20,
                    ):Container(),
                    (orderController.selectedOrder!.value.items!.isEmpty)
                        ? Container()
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: orderController
                                .selectedOrder!.value.items!.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Card(
                                  elevation: 5,
                                  shape: selectedFoodItem!.contains(
                                          orderController.selectedOrder!.value
                                              .items![index].productName!)
                                      ? RoundedRectangleBorder(
                                          side: const BorderSide(
                                              color: Constant.primary,
                                              width: 2.0),
                                          borderRadius:
                                              BorderRadius.circular(4.0))
                                      : RoundedRectangleBorder(
                                          side: const BorderSide(
                                              color: Colors.white, width: 2.0),
                                          borderRadius:
                                              BorderRadius.circular(4.0)),
                                  child: ListTile(
                                    // leading: Row(
                                    //     mainAxisSize: MainAxisSize.min,
                                    //     children: <Widget>[
                                    //       Container(
                                    //         width: 40.0,
                                    //         height: 40.0,
                                    //         decoration:  BoxDecoration(
                                    //           color: Color(0xff7c94b6),
                                    //           image: DecorationImage(
                                    //             image: NetworkImage(
                                    //                 '${ApiRoutes.BASE_URL}/${ orderController.selectedOrder!.value
                                    //                     .items![index].image!}'),
                                    //             fit: BoxFit.cover,
                                    //           ),
                                    //           borderRadius: BorderRadius.all(
                                    //               Radius.circular(50.0)),
                                    //         ),
                                    //       ),
                                    //     ]),
                                    title: Text(
                                      orderController.selectedOrder!.value
                                          .items![index].productName!+" X "+orderController.selectedOrder!.value
                                          .items![index].quantity.toString(),
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Source Sans Pro',
                                          letterSpacing: .5),
                                    ),
                                    trailing: Checkbox(
                                      checkColor: Colors.white,
                                      fillColor:
                                          MaterialStateProperty.resolveWith(
                                              getColor),
                                      onChanged: (bool? value) {
                                        setState(() {
                                          isSelected = value!;
                                          if (value == false) {
                                            orderController.selectedItemList.remove(SelectItem(id: orderController.selectedOrder!
                                                        .value
                                                        .items![index]
                                                        .id,
                                                    name: orderController
                                                        .selectedOrder!
                                                        .value
                                                        .items![index]
                                                        .productName));
                                            selectedFoodItem!.remove(orderController.selectedOrder!.value.items![index].productName!);
                                          } else {
                                            orderController.selectedItemList
                                                .add(SelectItem(
                                                    id: orderController.selectedOrder!.value.items![index].id,
                                                    name: orderController.selectedOrder!.value.items![index].productName));
                                            selectedFoodItem!.add(orderController.selectedOrder!.value.items![index].productName!);
                                          }
                                        });
                                      },
                                      value: selectedFoodItem!.contains(
                                              orderController
                                                  .selectedOrder!
                                                  .value
                                                  .items![index]
                                                  .productName!)
                                          ? true
                                          : false,
                                    ),
                                  ));
                            },
                          ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 12),
                      padding: const EdgeInsets.only(left: 10, bottom: 10),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: TextFormField(
                        onChanged: (value) {
                          orderController.comment = value;
                          orderController.isCompleted = true;
                        },
                        keyboardType: TextInputType.text,
                        controller: orderController.myControllerComment,
                        onFieldSubmitted: (value) {
                          print('Second text field : $value');
                        },
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: ('Comment'),
                            hintStyle: TextStyle(color: Colors.grey)),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        if(orderController.selectedOrder!.value.serviceCategory!.serviceTypeId==1){
                          if (otpValue.length<4) {
                            Fluttertoast.showToast(
                                msg: "Please Enter Correct OTP",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                            return;
                          }
                          if (orderController.selectedOrder!.value.pickupOtp == otpValue) {
                            if(orderController.foodImage!=null&&orderController.foodImage.value.path!=""){
                              if( orderController.selectedOrder!.value.items!.length>0) {
                                if (selectedFoodItem != null && selectedFoodItem!.isNotEmpty) {
                                  orderController.confrimOrder
                                    (orderController.selectedOrder!.value.id
                                      .toString()).then((value) {
                                    if (value != null) {
                                      if (value.success!) {
                                        orderController.selectedOrder!.value
                                            .orderStatus = "PICKEDUP";
                                        orderController.update();
                                        orderController.myControllerComment.clear();
                                        setState(() {});
                                      }
                                      orderController.selectedOrder!.value.orderStatus ="PICKEDUP";
                                      orderController.update();
                                      print(value.message);
                                      Fluttertoast.showToast(
                                          msg: "${value.message}",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.green,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                      Get.off(BottomNavigation());
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: "Order Confirmation Failed",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    }
                                  });
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "Please Select Item",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }
                              }else {
                                orderController.confrimOrder
                                  (orderController.selectedOrder!.value.id.toString()).then((value) {
                                  if (value != null) {
                                    if (value.success!) {
                                      orderController.selectedOrder!.value.orderStatus ="PICKEDUP";
                                      // orderController.foodImage.value=File("");
                                      orderController.update();

                                      setState(() {

                                      });
                                    }
                                    orderController.selectedOrder!.value.orderStatus = "PICKEDUP";
                                    print("aaa");
                                    Get.off(BottomNavigation());
                                    orderController.update();
                                    print(value.message);
                                    Fluttertoast.showToast(
                                        msg: "${value.message}",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.green,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "Order Confirmation Failed",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  }
                                });
                              }
                            }else{
                              Fluttertoast.showToast(
                                  msg: "Please Add Item Package Image ",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                            }
                          }else{
                            Fluttertoast.showToast(
                                msg: "Please Enter Correct OTP",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        }else{
                          if(orderController.foodImage.value.path!=""&&orderController.foodImage!=null){
                            if( orderController.selectedOrder!.value.items!.length>0) {
                              print("tarun2");
                              if (selectedFoodItem != null && selectedFoodItem!.isNotEmpty) {
                                orderController.confrimOrder
                                  (orderController.selectedOrder!.value.id.toString()).then((value) {
                                  if (value != null) {
                                    if (value.success!) {
                                      orderController.selectedOrder!.value.orderStatus = "PICKEDUP";
                                      orderController.update();
                                      setState(() {
                                      });
                                    }
                                    orderController.selectedOrder!.value.orderStatus ="PICKEDUP";
                                    orderController.update();
                                    print(value.message);
                                    Fluttertoast.showToast(
                                        msg: "${value.message}",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.green,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                    Get.off(BottomNavigation());
                                  }
                                  else {
                                    Fluttertoast.showToast(
                                        msg: "Order Confirmation Failed",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  }
                                }
                                );
                              } else {
                                Fluttertoast.showToast(
                                    msg: "Please Select Item",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              }
                            }else {
                              print("tarun3");
                              orderController.confrimOrder
                                (orderController.selectedOrder!.value.id
                                  .toString()).then((value) {
                                if (value != null) {
                                  if (value.success!) {
                                    orderController.selectedOrder!.value.orderStatus ="PICKEDUP";
                                    orderController.update();
                                    setState(() {

                                    });
                                  }
                                  orderController.selectedOrder!.value.orderStatus = "PICKEDUP";
                                  print("tarun");
                                  Get.off(BottomNavigation());
                                  orderController.update();
                                  print(value.message);
                                  Fluttertoast.showToast(
                                      msg: "${value.message}",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.green,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                 // Navigator.pop(context);
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "Order Confirmation Failed",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }
                              });
                            }
                          }else{
                            Fluttertoast.showToast(
                                msg: "Please Add Item Package Image ",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        }
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 5,
                        color: Constant.primary,
                        child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            width: 360,
                            child: const Text(
                              'Confirm order',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontStyle: FontStyle.normal),
                            )),
                      ),
                    ),
                    // Text("pickupOtp${orderController.selectedOrder!.value.pickupOtp}")
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
