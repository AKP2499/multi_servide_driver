import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:dunzodriver_copy1/api/repositiory.dart';
import 'package:dunzodriver_copy1/constant/color.dart';
import 'package:dunzodriver_copy1/constant/constants.dart';
import 'package:dunzodriver_copy1/controller/auth_controller.dart';
import 'package:dunzodriver_copy1/controller/profile_controller.dart';
import 'package:dunzodriver_copy1/models/otpverification_response.dart';
import 'package:dunzodriver_copy1/models/profile_data.dart';
import 'package:dunzodriver_copy1/service/push_notification.dart';
import 'package:dunzodriver_copy1/views/pending_document_page.dart';
import 'package:dunzodriver_copy1/views/verification/login.dart';
import 'package:dunzodriver_copy1/views/verification/panding_document_verification.dart';
import 'package:dunzodriver_copy1/views/verification/personal_information.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'maintenance_mode.dart';
import 'navigation_pages/bottomnavigation_dunzo.dart';
import 'navigation_pages/order_accept.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreenPage> with SingleTickerProviderStateMixin {
  ProfileController profileController = Get.put(ProfileController());
  Rx<ProfileData> storedProfileData = ProfileData().obs;
  AuthController authController = Get.put(AuthController());



  Future<String?> getAccessToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString("access_token");
    return prefs.getString("access_token");
  }

  Future<void> saveAccessToken(String tokenData) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("access_token", tokenData);
    print(tokenData);
  }

  Future<bool?> getProfileData() async {
    authController.isDocumentLoading.value=true;
    String? accessToken = await getAccessToken();

    OTPResponse result = (await Repository.getProfile(accessToken));
    if (result.data != null) {
      if (result.data!.name == null) {
        authController.step1Completed.value = false;
        authController.myControllerName.text = "";
      } else {
        authController.step1Completed.value = true;
        authController.myControllerName.text = result.data!.name!;
      }
      if (result.data!.mobile == null) {
        authController.step1Completed.value = false;
        authController.myControllerPhone.text = "";
      } else {
        authController.step1Completed.value = true;
        authController.myControllerPhone.text = result.data!.mobile!;
      }
      if(result.data!.email==null){
        authController.step1Completed.value=false;
        authController.myControllerEmail.text ="";
      }else{
        authController.step1Completed.value=true;
        authController.myControllerEmail.text=result.data!.email!;
      }
      if (result.data!.secondaryMobile == null) {
        authController.step1Completed.value = false;
        authController.myControllerSecondPhone.text = "";
      } else {
        authController.step1Completed.value = true;
        authController.myControllerSecondPhone.text =
            result.data!.secondaryMobile!;
      }
      if (result.data!.dob == null) {
        authController.step1Completed.value = false;
        authController.selectedDate.value =
            DateTime.now().subtract(const Duration(days: 365 * 18));
        authController.myControllerDOB.text = DateFormat('yyyy-MM-dd')
            .format(DateTime.now().subtract(const Duration(days: 365 * 18)));
      } else {
        authController.step1Completed.value = true;
        authController.myControllerDOB.text = result.data!.dob!;
      }
      if (result.data!.languages == null) {
        authController.step1Completed.value = false;
        authController.myControllerLanguage.text = "";
      } else {
        authController.step1Completed.value = true;
        authController.myControllerLanguage.text = result.data!.languages!;
      }
      if (result.data!.profileImg == null) {
        authController.step1Completed.value = false;
        authController.myControllerProfile.text = "";
      } else {
        authController.step1Completed.value = true;
        authController.myControllerProfile.text = result.data!.profileImg!;
      }

      if (authController.step1Completed.value) {

        authController.CompleteddocumentList!.add("Personal Info");
        authController.documentList.remove("Personal Info");
        bool aadhar = false;
        bool backAadhar = false;
        bool dl = false;
        bool vehicleImg = false;
        for (int i = 0; i < result.data!.kycs!.length; i++) {
          String doctype = result.data!.kycs!.elementAt(i).docType!;
          String status = result.data!.kycs!.elementAt(i).status!;
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
        }
        if (result.data!.aadharPhoto != null &&
            result.data!.aadharPhotoBack != null &&
            result.data!.dlPhoto != null
        ) {
          if (aadhar == true &&
              backAadhar == true && dl == true) {
            authController.step2Completed.value = true;
          } else {
            authController.step2Completed.value = false;
          }
        } else {
          authController.step2Completed.value = false;
        }
        if (authController.step2Completed.value) {
          authController.CompleteddocumentList!
              .add("Personal documents");
          authController.documentList
              .remove("Personal documents");
        }
        if (result.data!.emergencyContactNo != null &&
              result.data!.emergencyContactName != null &&
              result.data!.emergencyContactRelation != null) {
            authController.step3Completed.value = true;
          } else {
            authController.step3Completed.value = false;
          }
          if (authController.step3Completed.value) {
            authController.CompleteddocumentList!
                .add("Emergency contact");
            authController.documentList
                .remove("Emergency contact");
          }
            if (result.data!.vehicleType != null &&
                result.data!.vehicleRegNo != null &&
                result.data!.vehicleColor != null &&
                result.data!.vehicleImg != null) {
              if (vehicleImg == true) {
                authController.step4Completed.value = true;
              } else {
                authController.step4Completed.value = false;
              }
            } else {
              authController.step4Completed.value = false;
              // print("yaya se jaa rh");
              // if (result.data!.active == true &&
              //     result.data!.isVerified == true) {
              //   Get.offAll(() => const BottomNavigation());
              // } else {
              //   Get.offAll(() => const VerifyingPage());
              // }
              // Get.to(() => const PendingDocument());

            }
            if (authController.step4Completed.value) {
              authController.CompleteddocumentList!.
              add("vehicle details");
              authController.documentList.
              remove("vehicle details");
            }
              if (result.data!.bankName != null &&
                  result.data!.ifscCode != null &&
                  result.data!.accountNo != null &&
                  result.data!.branchName != null) {
                authController.step5Completed.value = true;
                authController.phone.clear();
                // if (result.data!.active == true &&
                //     result.data!.isVerified == true) {
                //   Get.offAll(() => const BottomNavigation());
                // } else {
                //   Get.offAll(() => const VerifyingPage());
                // }
                // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>const BottomNavigation()));
              } else {
                authController.step5Completed.value = false;
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
          if(result.data!.active == true && result.data!.isVerified == true){
            Get.offAll(() => const BottomNavigation());
          }else{
            Get.offAll(() => const VerifyingPage());
          }
        }
      } else {
        Get.offAll(() => const PersonalInformation());
      }

      // if (result.success!) {
      //   print("profileDataSuccessfully");
      //   storedProfileData.value = result.data!;
      //   print(storedProfileData.value);
      //   if (storedProfileData.value.isVerified! && storedProfileData.value.active!) {
      //     Timer(
      //         const Duration(seconds: 2),
      //         () => Navigator.pushReplacement(
      //             context,
      //             MaterialPageRoute(
      //                 builder: (context) => const BottomNavigation())));
      //   } else {
      //     Fluttertoast.showToast(
      //         msg: "Document Verification Pending",
      //         toastLength: Toast.LENGTH_SHORT,
      //         gravity: ToastGravity.TOP,
      //         timeInSecForIosWeb: 1,
      //         backgroundColor: Colors.red,
      //         textColor: Colors.white,
      //         fontSize: 16.0);
      //     saveAccessToken("");
      //     Timer(
      //         const Duration(seconds: 2),
      //         () => Navigator.pushReplacement(
      //             context,
      //             MaterialPageRoute(
      //                 builder: (context) => const DunzoPartner())));
      //   }
      //   return true;
      // } else {
      //   return false;
      // }
    } else {
      Get.offAll(const DunzoPartner());
    }
  }

  void getToken() async {
    print("get token");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? accessToken = await sharedPreferences.getString("access_token");
    print(accessToken);
    if (accessToken != null && accessToken != "") {
      print("accessTokenFrom splash screen");
      ConstantVariable.TOKEN = accessToken;
      getProfileData();
    } else {
      print("else of get token");
      Timer(
          const Duration(seconds: 2),
          () => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const DunzoPartner())));
    }
  }

  Future<void> maintainanceMode() async {
    print("maintanacae");
    final value = await profileController.settingData();
    if (value!.data!.maintainenceMode == "1") {
      print("maintanacae if mai aaya");
      Get.off(const MaintenancePage());
    } else {
      print("maintainable else main aaya");
      getToken();
    }
  }


  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    // make sure you call `initializeApp` before using other Firebase services.

    print("Handling a background message: ${message.messageId}");
    // print(message.notification!.body);
    print("background notification");
    print("splash background notification");
    /* print(message.notification!.android!.imageUrl);*/
    print(message.data);

    if (message.notification != null &&
        message.data != null &&
        message.data.containsKey("id") &&
        (message.data["is_auto_assigned"] == true ||
            message.data["is_auto_assigned"] == "true")) {
      Get.to(OrderAccpect(message.data["id"], message.data["type"]));
      PushNotificationService.notificationHandler(message.data,
          message.notification!.title!, message.notification!.body!);
    } else if (message.data.containsKey("data")) {
    } else {

    }
  }
  @override
  void initState() {
    print("MAintenance Mode");
    super.initState();
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    messaging.getInitialMessage().then((value) {
      print("Initial Message");
      print(value);
      // firebaseMessagingBackgroundHandler(value!);
    });
    // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    // getToken();
    maintainanceMode();

    //TODO Animation
    controller=AnimationController(
      duration: Duration(seconds: 1),
        vsync: this,);
    animation=CurvedAnimation(parent:controller!, curve:Curves.decelerate);
    controller!.forward();
    controller!.addListener(() {
      setState(() {
        print(animation!.value);
      });
    });

  }
  AnimationController? controller;
  Animation? animation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: animation!.value*400,
              child: Image.asset("lib/Images/ssmulti.png")
        ),
         // AnimatedTextKit(animatedTexts: [
         //   TypewriterAnimatedText("Welcome Partner",textStyle:
         //   const TextStyle(
         //     fontWeight: FontWeight.bold,
         //     fontSize: 30,
         //     color: Constant.secondary
         //   ))
         // ])
        ],
      ),
    ));
  }
}
// AssetImage("lin/Images/wedun.png"),
// Container(
// width: MediaQuery.of(context).size.width,
// height: MediaQuery.of(context).size.height,
// child: Column(
// children: [
// Image.asset("lin/Images/wedun.png")
// ],
// ),
//
//
// ),
