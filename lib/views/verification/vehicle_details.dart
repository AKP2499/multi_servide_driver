import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:dunzodriver_copy1/constant/color.dart';
import 'package:dunzodriver_copy1/controller/auth_controller.dart';
import 'package:dunzodriver_copy1/models/vehicle_response.dart';
import 'package:dunzodriver_copy1/views/verification/panding_document_verification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class VehicleDetails extends StatefulWidget {
  const VehicleDetails({Key? key}) : super(key: key);

  @override
  _VehicleDetailsState createState() => _VehicleDetailsState();
}

class _VehicleDetailsState extends State<VehicleDetails> {
  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            child: Form(
              key: authController.vehicleTypeformKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Vehicle details',
                    style: TextStyle(
                        decorationThickness: 2,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Source Sans Pro'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                   Text(
                    'Vehicle Type',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(1, 10, 0, 4.0),
                    child: Container(
                      padding: const EdgeInsets.only(top: 4, left: 10),
                      height: 60,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey)),
                      child: DropdownButton<dynamic>(
                        value: (authController.vehicleType!.value == "")?authController.vehicleList[0].name
                            :authController.vehicleType!.value,
                        underline: const Padding(
                          padding: EdgeInsets.all(5),
                        ),
                        isExpanded: true,
                        hint: const Text(
                          "Vehicle Type",
                          style: TextStyle(color: Colors.grey),
                        ),
                        style: const TextStyle(color: Colors.black),
                        items:
                            authController.vehicleList.map((VehicleData value) {
                          print('ssssssssss');
                          print(value.name);
                          return DropdownMenuItem(
                            value: value.name.toString(),
                            child: SizedBox(
                              width: 100,
                              child: Text(
                                value.name!,
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            authController.isCompleted = true;
                            authController.vehicleType!.value = value.toString();
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                   Text(
                    'Vehicle Registration Number',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade700
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: TextFormField(
                      controller: authController.myControllerVehicleRegistrationNumber,
                      onFieldSubmitted: (value) {
                        print(' Vehicle Model : $value');
                      },
                      onChanged: (value) {
                        authController.isCompleted=true;
                        authController.vehicleRegistrationNumber = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Vehicle Registration';

                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: (' e.g.MH02RS9876'),
                          hintStyle: TextStyle(color: Colors.grey)),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                   Text(
                    'Vehicle Color',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade700,
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: TextFormField(
                      controller: authController.myControllerVehicleColors,
                      onChanged: (value){
                        authController.vehicleColor= value;
                        authController.isCompleted=true;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Vehicle Color';
                        }
                        return null;
                      },
                      // controller: myControllerRelation,
                      onFieldSubmitted: (value) {
                        print('Vehicle Number : $value');
                      },
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: (''),
                          hintStyle: TextStyle(color: Colors.grey)),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(()=>
                     Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Text(
                          'Vehicle Image',
                       style: TextStyle(
                           fontWeight: FontWeight.w600,
                           color: Colors.grey.shade700
                       ),
                         ),
                        const SizedBox(
                          height: 10,
                        ),
                        DottedBorder(
                          radius: const Radius.circular(20),
                          color: Colors.grey,
                          strokeWidth: 3,
                          child: Container(
                            padding: const EdgeInsets.only(right: 10),
                            margin: const EdgeInsets.only(left: 10),
                            height: 250,
                            width: 360,
                            child:authController.imagevehicle!=null && authController.imagevehicle!.value.path != ""
                                ? Stack(
                              children: [
                                Positioned(
                                  child:
                                  Image.file(File(authController.imagevehicle!.value.path)),
                                  right: 0,
                                  left: 0,
                                  bottom: 0,
                                  top: 0,
                                ),
                                authController.imagevehicle!.value.path!=null
                                    ? Positioned(
                                  top: 5,
                                      left: 5,

                                      child: InkWell(
                                  onTap: () {
                                      print("vichel image");
                                      authController.imagevehicle!.value= XFile("");
                                      // authController.isImageSelected!.value = false;
                                      // authController.isCompleted=false;
                                      setState(() {});
                                      print("vechil image");
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
                                ),
                                    ) : Container()
                              ],
                            ) : Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Upload Vehicle Image',
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
                                    onPressed: authController.getImageVehicle,
                                    child: const Text(
                                      'Upload Photo',
                                      style: TextStyle(
                                          color: Constant.primary,
                                          fontSize: 20),
                                    )),
                                // const Text('Upload focused photos of below documents'),
                                // const Text('for faster verification'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Column(
                    children: [
                      Container(
                        width: 500,
                        child: Card(
                          margin: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 10,
                          color: Constant.primary,
                          child: Container(
                            decoration: BoxDecoration(
                                color: (authController.isCompleted)?Constant.primary:Colors.grey,
                                borderRadius: BorderRadius.circular(10)),
                            child: TextButton(
                                onPressed: () {
                                  if(authController. vehicleTypeformKey.currentState!.validate()){
                                    if(authController.isCompleted){
                                      authController.vehicleVerfiy().then((value){
                                        if(value){
                                          Navigator.pop(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) => const PendingDocument()));
                                          AlertDialog alert =  AlertDialog(

                                            title: const Text("Upload Vehicle Details"),
                                            content: const Text(" Successfully "),
                                            actions: [
                                              TextButton(
                                                child: const Text('Ok'),
                                                onPressed: () {
                                                  // Get.back();
                                                  Get.back();
                                                },
                                              ),
                                            ],
                                          );
                                          // show the dialog
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return alert;
                                            },
                                          );
                                        }else{
                                          AlertDialog alert =  AlertDialog(

                                            title: const Text("Upload Vehicle Documents"),
                                            content: const Text(" Unsuccessfully "),
                                            actions: [
                                              TextButton(
                                                child: const Text('Ok'),
                                                onPressed: () {
                                                  Get.back();
                                                },
                                              ),
                                            ],
                                          );
                                          // show the dialog
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return alert;
                                            },
                                          );
                                        }
                                      });
                                    }
                                  }else {
                                    // showDialog(
                                    //   context: context,
                                    //   builder: (BuildContext context) {
                                    //     return Center(
                                    //       child: Container(
                                    //         height: 30,
                                    //         width: 30,
                                    //         child: const CircularProgressIndicator(
                                    //           color: Constant.primary,
                                    //         ),
                                    //       ),
                                    //     );
                                    //   },
                                    // );
                                  }

                                  // Navigator.pop(context,
                                  //     MaterialPageRoute(
                                  //         builder: (_) => const PendingDocument()));
                                  },

                                child: const Text(
                                  'Submit and Next',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontStyle: FontStyle.normal),
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
