import 'package:dunzodriver_copy1/components/rounded_button.dart';
import 'package:dunzodriver_copy1/constant/color.dart';
import 'package:dunzodriver_copy1/controller/auth_controller.dart';
import 'package:dunzodriver_copy1/controller/profile_controller.dart';
import 'package:dunzodriver_copy1/views/navigation_pages/bottomnavigation_dunzo.dart';
import 'package:dunzodriver_copy1/views/pending_document_page.dart';
import 'package:dunzodriver_copy1/views/verification/panding_document_verification.dart';
import 'package:dunzodriver_copy1/views/verification/personal_information.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'login.dart';

class OTPVerify extends StatefulWidget {
  const OTPVerify({Key? key}) : super(key: key);

  @override
  _OTPVerifyState createState() => _OTPVerifyState();
}

class _OTPVerifyState extends State<OTPVerify> {
  TextEditingController controller = TextEditingController(text: "");
  AuthController authController = Get.find();
  ProfileController profileController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    authController.otpFormKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    if (authController.otpFormKey!.currentState != null) {
      authController.otpFormKey!.currentState!.reset();
    }
    (authController.otpFormKey!.currentState != null)
        ? authController.otpFormKey!.currentState!.dispose()
        : "";
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: authController.otpFormKey,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.grey.shade50,
          elevation: 0,
        ),
        body: Container(
          margin: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text(
                    'Enter OTP to verify',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        fontFamily: 'Source Sans Pro'),
                  )
                ],
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('A 4 digit OTP has been send to your phone '),
                      Row(
                        children: [
                          Text('number ${authController.mobile}'),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const DunzoPartner()));
                            },
                            child: const SizedBox(
                              child: Text(
                                ' Change',
                                style: TextStyle(color: Constant.secondary),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              // 'A 6 digit OTP has been send to your phone '
              //   (text: 'number ${widget.phone}'),
              Row(
                children: const [
                  Text(
                    'Enter OTP text',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PinCodeTextField(
                    pinBoxRadius: 10,
                    pinBoxOuterPadding: const EdgeInsets.all(10),
                    pinBoxColor: Constant.secondaryTransparent,
                    autofocus: true,
                    hideCharacter: false,
                    controller: controller,
                    hasTextBorderColor: Colors.green,
                    highlight: true,
                    maxLength: 4,
                    onTextChanged: (text) {
                      print("Changed:" + text);
                      authController.pinn = text;
                      if (authController.pinn.length == 4) {
                        setState(() {
                          authController.isChecked.value = true;
                        });
                      }
                    },
                    onDone: (text) {
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
                        Duration(milliseconds: 300),
//                    highlightAnimation: true,
                    highlightAnimationBeginColor: Colors.black,
                    highlightAnimationEndColor: Colors.white12,
                  )
                  // OTPTextField(
                  //   length: 4,
                  //   width: MediaQuery.of(context).size.width * 0.8,
                  //   textFieldAlignment: MainAxisAlignment.spaceAround,
                  //   fieldWidth: 50,
                  //   fieldStyle: FieldStyle.box,
                  //   outlineBorderRadius: 10,
                  //   style: const TextStyle(fontSize: 10),
                  //   onChanged: (pin) {
                  //     print("Changed: " + pin);
                  //     authController.pinn = pin;
                  //     if (authController.pinn.length == 4) {
                  //       setState(() {
                  //         authController.isChecked.value = true;
                  //       });
                  //     }
                  //   },
                  //   onCompleted: (pin) {
                  //     print("Completed: " + pin);
                  //   },
                  // ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: ()async{
                  print("sssssss");
                  profileController.updateLatLang();
                  (authController.isChecked.value)
                      ? authController.otpVerify().then(  (value) async {
                    if (value != null) {
                      if (value.message == "The given data was invalid.") {
                        Fluttertoast.showToast(
                            msg: "Incorrect OTP",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      } else {
                        Fluttertoast.showToast(
                            msg: "Login Successfully",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        if (value.data!.name == null) {
                          authController.step1Completed.value = false;
                          authController.myControllerName.text = "";
                        } else {
                          authController.step1Completed.value = true;
                          authController.myControllerName.text =
                          value.data!.name!;
                        }
                        if(value.data!.email==null){
                          authController.step1Completed.value=false;
                          authController.myControllerEmail.text ="";
                        }else{
                          authController.step1Completed.value=true;
                          authController.myControllerEmail.text=value.data!.email!;
                        }
                        if (value.data!.mobile == null) {
                          authController.step1Completed.value = false;
                          authController.myControllerPhone.text = "";
                        } else {
                          authController.step1Completed.value = true;
                          authController.myControllerPhone.text =
                          value.data!.mobile!;
                        }
                        if (value.data!.secondaryMobile == null) {
                          authController.step1Completed.value = false;
                          authController.myControllerSecondPhone.text =
                          "";
                        } else {
                          authController.step1Completed.value = true;
                          authController.myControllerSecondPhone.text =
                          value.data!.secondaryMobile!;
                        }
                        if (value.data!.dob == null) {
                          authController.step1Completed.value = false;
                          authController.selectedDate.value =
                              DateTime.now().subtract(
                                  const Duration(days: 365 * 18));
                          authController.myControllerDOB.text =
                              DateFormat('yyyy-MM-dd').format(
                                  DateTime.now().subtract(
                                      const Duration(days: 365 * 18)));
                        } else {
                          authController.step1Completed.value = true;
                          authController.myControllerDOB.text =
                          value.data!.dob!;
                        }
                        if (value.data!.languages == null) {
                          authController.step1Completed.value = false;
                          authController.myControllerLanguage.text = "";
                        } else {
                          authController.step1Completed.value = true;
                          authController.myControllerLanguage.text =
                          value.data!.languages!;
                        }
                        if (value.data!.profileImg == null) {
                          authController.step1Completed.value = false;
                          authController.myControllerProfile.text = "";
                        } else {
                          authController.step1Completed.value = true;
                          authController.myControllerProfile.text = value.data!.profileImg!;
                        }
                        if (authController.step1Completed.value) {
                          authController.CompleteddocumentList!
                              .add("Personal Info");
                          authController.documentList
                              .remove("Personal Info");
                          bool aadhar = false;
                          bool backAadhar = false;
                          bool dl = false;
                          bool vehicleImg = false;
                          for (int i = 0; i < value.data!.kycs!.length; i++) {
                            String doctype =
                            value.data!.kycs!.elementAt(i).docType!;
                            String status =
                            value.data!.kycs!.elementAt(i).status!;
                            if (doctype == "AADHAR") {
                              if (status != "REJECTED") {
                                aadhar = true;
                              } else {
                                aadhar = false;
                              }
                            } else if (doctype == "AADHARBACK") {
                              if (status != "REJECTED") {
                                backAadhar = true;
                              } else {
                                backAadhar = false;
                              }
                            } else if (doctype == "DL") {
                              if (status != "REJECTED") {
                                dl = true;
                              } else {
                                dl = false;
                              }
                            } else if (doctype == "VEHICLEIMG") {
                              if (status != "REJECTED") {
                                vehicleImg = true;
                              } else {
                                vehicleImg = false;
                              }
                            }
                            // if(doctype=="AADHAR"||doctype=="AADHARBACK"||doctype=="DL"){
                            //   if(status!="REJECTED"){
                            //     authController.step2Completed.value = true;
                            //   }else{
                            //     authController.step2Completed.value = false;
                            //   }
                            // }
                          }

                          if (value.data!.aadharPhoto != null &&
                              value.data!.aadharPhotoBack != null &&
                              value.data!.dlPhoto != null) {
                            if (aadhar == true &&
                                backAadhar == true &&
                                dl == true) {
                              authController.step2Completed.value = true;
                            } else {
                              authController.step2Completed.value = false;
                            }
                          } else {
                            authController.step2Completed.value = false;
                            // Get.to(const PendingDocument());
                          }
                          if (authController.step2Completed.value) {
                            authController.CompleteddocumentList!
                                .add("Personal documents");
                            authController.documentList
                                .remove("Personal documents");

                          }
                          if (value.data!.emergencyContactNo != null &&
                              value.data!.emergencyContactName != null &&
                              value.data!.emergencyContactRelation != null) {
                            authController.step3Completed.value = true;
                          } else {
                            authController.step3Completed.value = false;
                            // Get.to( const PendingDocument());
                          }
                          if (authController.step3Completed.value) {
                            authController.CompleteddocumentList!.add("Emergency contact");
                            authController.documentList.remove("Emergency contact");

                          }
                          if (value.data!.vehicleType != null &&
                              value.data!.vehicleRegNo != null &&
                              value.data!.vehicleColor != null &&
                              value.data!.vehicleImg != null) {
                            if (vehicleImg == true) {
                              authController.step4Completed.value =
                              true;
                            } else {
                              authController.step4Completed.value =
                              false;
                            }
                          } else {
                            authController.step4Completed.value = false;
                          }
                          if (authController.step4Completed.value) {
                            authController.CompleteddocumentList!
                                .add("vehicle details");
                            authController.documentList
                                .remove("vehicle details");
                          }
                          if (value.data!.bankName != null &&
                              value.data!.ifscCode != null &&
                              value.data!.accountNo != null &&
                              value.data!.branchName != null) {
                            authController.step5Completed.value = true;
                            authController.phone.clear();
                            // if (value.data!.active == true &&
                            //     value.data!.isVerified == true) {
                            //   Get.offAll(
                            //       () => const BottomNavigation());
                            // } else {
                            //   Get.offAll(
                            //       () => const VerifyingPage());
                            // }
                            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>const BottomNavigation()));
                          } else {
                            authController.step5Completed.value =
                            false;
                          }
                          if (authController.step5Completed.value) {
                            authController.CompleteddocumentList!
                                .add("Bank account details");
                            authController.documentList
                                .remove("Bank account details");
                          }
                          bool allStepCompleted = authController.step1Completed.isTrue
                              &&authController.step2Completed.isTrue&&
                              authController.step3Completed.isTrue&&authController.step4Completed.isTrue&&
                              authController.step5Completed.isTrue;
                          if(allStepCompleted==false){
                            await authController.getProfileData();
                            Get.offAll(() => const PendingDocument());
                          }else {
                            if(value.data!.active == true && value.data!.isVerified == true){
                              Get.offAll(() => const BottomNavigation());
                            }else{
                              Get.offAll(() => const VerifyingPage());
                            }
                            // Get.offAll(()=>const BottomNavigation());
                          }
                        } else {
                          Get.offAll(() => const PersonalInformation());
                        }
                      }
                    } else {
                      Fluttertoast.showToast(
                          msg: "Incorrect OTP",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      // Fluttertoast.showToast(
                      //     msg: "Enter OTP",
                      //     toastLength: Toast.LENGTH_SHORT,
                      //     gravity: ToastGravity.CENTER,
                      //     timeInSecForIosWeb: 1,
                      //     backgroundColor: Colors.red,
                      //     textColor: Colors.white,
                      //     fontSize: 16.0);
                    }
                  })
                      : null;
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  alignment: Alignment.center,
                  height: 50,
                  width: 380,
                  decoration: BoxDecoration(
                      color: (authController.isChecked.value)
                          ? Constant.secondary
                          : Colors.grey,
                      borderRadius: BorderRadius.circular(10)),
                    child: const Text(
                      'Verify OTP',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20),
                    ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      print("click On OTP Button");
                      authController.phoneLogin();
                      authController.otpFormKey!.currentState!.reset();
                    },
                    child: const Text(
                      'Request Again ',
                      style: TextStyle(
                          color: Constant.primary,
                          fontSize: 17,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  // const Text(
                  //   ' | ',
                  //   style: TextStyle(fontSize: 17),
                  // ),
                  //  InkWell(
                  //   onTap: (){
                  //     authController.makingPhoneCall();
                  //   },
                  //   child:  const Text(
                  //     '  Get OTP via call',
                  //     style: TextStyle(
                  //         color: Constant.primary,
                  //         fontSize: 17,
                  //         fontWeight: FontWeight.w600),
                  //   ),
                  // ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
