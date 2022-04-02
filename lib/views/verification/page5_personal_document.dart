import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:dunzodriver_copy1/constant/color.dart';
import 'package:dunzodriver_copy1/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PersonalDocuments extends StatelessWidget {
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
        child: Form(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 19, top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Personal Documents',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                  ),
                  // const Text('Upload focused photos of below documents'),
                  // const Text('for faster verification'),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Aadhaar card details',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                        'Upload upload a focused photo of your aadhaar',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      const Text(
                        'card for faster verification',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DottedBorder(
                          color: Colors.grey,
                          strokeWidth: 1,
                          child: Container(
                            padding: const EdgeInsets.only(right: 20),
                            // margin: const EdgeInsets.only(left: 5),
                            height: 250,
                            width: 360,
                            child: Obx(
                              () => authController.imageAadhaarFront != null &&
                                      authController.imageAadhaarFront!.value.path !=
                                          ""
                                  ? Stack(
                                      children: [
                                        Positioned(
                                          top: 5,
                                          left: 5,
                                          right: 5,
                                          bottom: 5,
                                          child: Image.file(File(authController
                                              .imageAadhaarFront!.value.path)),
                                        ),
                                        authController.imageAadhaarFront != null
                                            ? Positioned(
                                                top: 5,
                                                left: 5,
                                                child: InkWell(
                                                  onTap: () {
                                                    authController
                                                        .imageAadhaarFront!
                                                        .value = XFile("");
                                                  },
                                                  child: const CircleAvatar(
                                                    child: Icon(
                                                      Icons.remove,
                                                      color: Colors.white,
                                                      size: 24,
                                                    ),
                                                    backgroundColor:
                                                        Colors.red,
                                                    radius: 15.0,
                                                  ),
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
                                          'Front side photo of your Aadhaar card with ',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        const Text(
                                          'your clear name and photo',
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
                                            onPressed: authController
                                                .getImageFrontAadhaar,
                                            child: const Text(
                                              'Upload Photo',
                                              style: TextStyle(
                                                  color: Constant.primary,
                                                  fontSize: 20),
                                            ))
                                      ],
                                    ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DottedBorder(
                            color: Colors.grey,
                            strokeWidth: 1,
                            child: Container(
                              padding: const EdgeInsets.only(right: 20),
                              // margin: const EdgeInsets.only(left: 5),
                              height: 250,
                              width: 360,
                              child: Obx(
                                () => (authController.imageAadhaarBack != null) &&
                                        authController.imageAadhaarBack!.value.path != ""
                                    ? Stack(
                                        children: [
                                          Positioned(
                                            top: 5,
                                            left: 5,
                                            right: 5,
                                            bottom: 5,
                                            child: Image.file(File(
                                                authController.imageAadhaarBack!.value.path)),
                                          ),
                                          authController.imageAadhaarBack !=
                                                  null
                                              ? Positioned(
                                                  top: 5,
                                                  left: 5,
                                                  child: InkWell(
                                                    onTap: () {
                                                      authController
                                                          .imageAadhaarBack!
                                                          .value = XFile("");
                                                    },
                                                    child: const CircleAvatar(
                                                      child: Icon(
                                                        Icons.remove,
                                                        color: Colors.white,
                                                        size: 24,
                                                      ),
                                                      backgroundColor:
                                                          Colors.red,
                                                      radius: 15.0,
                                                    ),
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
                                            'Back Side photo of your Aadhaar with ',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          const Text(
                                            'your clear name and photo',
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
                                              onPressed: authController
                                                  .getImageBackAadhaar,
                                              child: const Text(
                                                'Upload Photo',
                                                style: TextStyle(
                                                    color: Constant.primary,
                                                    fontSize: 20),
                                              ))
                                        ],
                                      ),
                              ),
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Driving license details',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                        'Please Upload a focused photo of driving',
                        style: TextStyle(color: Colors.grey),
                      ),
                      const Text(
                        'licence for faster verification',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DottedBorder(
                          color: Colors.grey,
                          strokeWidth: 1,
                          child: Container(
                              padding: const EdgeInsets.only(right: 20),
                              // margin: const EdgeInsets.only(left: 5),
                              height: 250,
                              width: 360,
                              child: Obx(
                                () => authController.imageDrivingLicense != null &&
                                        authController.imageDrivingLicense!.value.path != ""
                                    ? Stack(
                                        children: [
                                          Positioned(
                                            top: 5,
                                            left: 5,
                                            right: 5,
                                            bottom: 5,
                                            child: Image.file(File(
                                                authController.imageDrivingLicense!.value.path)),
                                          ),
                                          authController.imageDrivingLicense != null
                                              ? Positioned(
                                                  top: 5,
                                                  left: 5,
                                                  child: InkWell(
                                                    onTap: () {
                                                      authController.imageDrivingLicense!.value = XFile("");
                                                      authController.isCompleted=true;
                                                    },
                                                    child: const CircleAvatar(
                                                      child: Icon(
                                                        Icons.remove,
                                                        color: Colors.white,
                                                        size: 24,
                                                      ),
                                                      backgroundColor:
                                                          Colors.red,
                                                      radius: 15.0,
                                                    ),
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
                                            'Fornt side photo of your driving license with ',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          const Text(
                                            'your clear name and photo',
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
                                              onPressed: authController
                                                  .getImageDrivingLicense,
                                              child: const Text(
                                                'Upload Photo',
                                                style: TextStyle(
                                                    color: Constant.primary,
                                                    fontSize: 20),
                                              ))
                                          // const Text('Upload focused photos of below documents'),
                                          // const Text('for faster verification'),
                                        ],
                                      ),
                              )),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () async {
                      // if (authController.imagePanCard!.value.path == "") {
                      //   ScaffoldMessenger.of(context)
                      //       .showSnackBar(const SnackBar(
                      //     content: Text("Please Enter full Details "),
                      //   ));
                      //   // return;
                      // }
                      if (authController.imageAadhaarFront!.value.path == "") {
                        ScaffoldMessenger.of(context).showSnackBar(
                            (const SnackBar(
                                content: Text(
                                    'Please Add Aadhaar Card Front Image'))));
                        // return;
                      }
                      if (authController.imageAadhaarBack!.value.path == "") {
                        ScaffoldMessenger.of(context).showSnackBar(
                            (const SnackBar(
                                content: Text(
                                    'Please Add Aadhaar Card Back Image'))));
                        // return;
                      }
                      if (authController.imageDrivingLicense!.value.path =="") {
                        ScaffoldMessenger.of(context).showSnackBar(
                            (const SnackBar(
                                content: Text(
                                    'Please Add Image Driving license '))));
                        // return;
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const Center(
                              child: SizedBox(
                                height: 30,
                                width: 30,
                                child: CircularProgressIndicator(
                                  color: Constant.primary,
                                ),
                              ),
                            );
                          },
                        );
                        String? aceessToken =
                            await authController.getAccessToken();
                        final response = await authController.uploadDocuments(
                          File(authController.imageAadhaarFront!.value.path),
                          File(authController.imageAadhaarBack!.value.path),
                          File(authController.imageDrivingLicense!.value.path),
                          aceessToken!,
                        );
                        if (response) {
                          Get.back();
                          Get.back();
                          AlertDialog alert = AlertDialog(
                            title: const Text("Upload Documents"),
                            content: const Text(" Successfully "),
                            actions: [
                              TextButton(
                                child: const Text('OK'),
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
                        } else {
                          Get.back();
                          AlertDialog alert = AlertDialog(
                            title: const Text("Upload Documents"),
                            content: const Text(" Unsuccessfully "),
                            actions: [
                              TextButton(
                                child: const Text('OK'),
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
                      }
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 10,
                      color: Constant.primary,
                      child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          width: 360,
                          child: const Text(
                            'Submit and Next',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontStyle: FontStyle.normal),
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
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

// class PersonalDocuments extends StatefulWidget {
//   const PersonalDocuments({Key? key}) : super(key: key);
//
//   @override
//   _PersonalDocumentsState createState() => _PersonalDocumentsState();
// }
//
// class _PersonalDocumentsState extends State<PersonalDocuments> {
//
//   AuthController authController= Get.put(AuthController());
//   @override
//   Widget build(BuildContext context) {
//     return
//   }
// }
