import 'package:dunzodriver_copy1/constant/color.dart';
import 'package:dunzodriver_copy1/controller/auth_controller.dart';
import 'package:dunzodriver_copy1/controller/order_controller.dart';
import 'package:dunzodriver_copy1/controller/profile_controller.dart';
import 'package:dunzodriver_copy1/service/push_notification.dart';
import 'package:dunzodriver_copy1/views/cab_service/cab_service.dart';
import 'package:dunzodriver_copy1/views/navigation_pages/order_accept.dart';
import 'package:dunzodriver_copy1/views/navigation_pages/order_details.dart';
import 'package:dunzodriver_copy1/views/pending_document_page.dart';
import 'package:dunzodriver_copy1/views/splash_screen.dart';
import 'package:dunzodriver_copy1/views/unknown_route.dart';
import 'package:dunzodriver_copy1/views/verification/login.dart';
import 'package:dunzodriver_copy1/views/verification/panding_document_verification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constant/constants.dart';

// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // make sure you call `initializeApp` before using other Firebase services.
//   await Firebase.initializeApp();
//   print("Handling a background message: ${message.messageId}");
//   print(message.notification!.body);
//   print("background notification");
//   print(message.notification!.android!.imageUrl);
//   print(message.data);
//
//   if (message.notification != null &&
//       message.data != null &&
//       message.data.containsKey("id")
//       &&(message.data["is_auto_assigned"] == true||message.data["is_auto_assigned"]=="true")) {
//     Get.to(OrderAccpect(message.data["id"], message.data["type"]));
//     PushNotificationService.notificationHandler(message.data,
//         message.notification!.title!, message.notification!.body!);
//   } else if (message.data.containsKey("data")) {
//
//   } else {
//
//
//   }
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  PushNotificationService pushNotificationService = PushNotificationService();
  pushNotificationService.initialise();
  // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  messaging.setAutoInitEnabled(true);
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
    print("Message data : ${message.data}");
    if (message.notification != null) {
      if (message.data != null) {
        if (message.data.containsKey("id")) {
           if (message.data["is_auto_assigned"] == true ||
              message.data["is_auto_assigned"] == "true") {
             print("message1");
            Get.to(OrderAccpect(message.data["id"], message.data["type"]));
          }
        } else if (message.data.containsKey("data")&& (message.data["screen"]=="kyc_rejected")) {
          print("Got a messageOpenedApp whilst in2 ");
          print("message2");
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("access_token", "");
          Get.offAll(() => const DunzoPartner());
          PushNotificationService.notificationHandler2(message.data,
              message.notification!.title!, message.notification!.body!);
        } else{
          print("mesaage3");
          print("Got a messageOpenedApp whilst in ");
          PushNotificationService.notificationHandler2(message.data,
              message.notification!.title!, message.notification!.body!);
        }
      }
    }else{
      print("Got a messageOpenedApp whilst in 4");
    }
    // if (message.notification != null && message.data != null && message.data.containsKey("id")) {
    //   print("Message also contained a notification : jajajna");
    //   if (message.data.containsKey("is_auto_assigned") == true) {
    //     if (message.data["is_auto_assigned"] == true) {
    //       Get.to(OrderAccpect(message.data["id"], message.data["type"]));
    //       PushNotificationService.notificationHandler(message.data,
    //           message.notification!.title!, message.notification!.body!);
    //     }
    //   } else {
    //
    //   }
    // } else {
    //   PushNotificationService.notificationHandler(message.data,
    //       message.notification!.title!, message.notification!.body!);
    // }
  });
  //
  // FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
  //   print('Got a message whilst in the background!');
  //   print('Message data: ${message.data}');
  //   if (message != null) {
  //     if (message.notification!.android != null) {
  //       print(message.notification!.android!.imageUrl!);
  //       print('Message also contained a notification: ${message.notification}');
  //     }
  //   }
  //
  //   // PushNotificationService.notificationHandler(
  //   //     message.data,message.notification!.title!, message.notification!.body!);
  // });
  //
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data["id"]}');
    print("Message type:${message.data["type"]}");
    print("Message type:${message.data["is_auto_assigned"]}");
    print(message.notification);
    if (message.notification != null &&
        message.data != null &&
        message.data.containsKey("id")) {
      if (message.data["is_auto_assigned"] == "true" ||
          message.data["is_auto_assigned"] == true) {
        PushNotificationService.notificationHandler(message.data,
            message.notification!.title!, message.notification!.body!);
        Get.to(OrderAccpect(message.data["id"], message.data["type"]));
      } else {
        if (Get.find<OrderController>().initialized) {
          Get.find<OrderController>().pagingControllerOrder.refresh();
          print("order stat");
          Get.find<OrderController>().orderStatistics();
          PushNotificationService.notificationHandler(message.data,
              message.notification!.title!, message.notification!.body!);
        } else {}
      }
    } else if (message.notification != null &&message.data != null && message.data.containsKey("data")) {
      if(message.data["screen"]=="kyc_rejected"){
        Get.find<ProfileController>().profileData();
        //Get.offAll(const VerifyingPage());
      }
      print("OrderAccpect forground2");
      PushNotificationService.notificationHandler2(message.data,
          message.notification!.title!, message.notification!.body!);
    } else {
      print("OrderAccpect forground3");
      PushNotificationService.notificationHandler2(message.data,
          message.notification!.title!, message.notification!.body!);
    }
  });
  FirebaseMessaging.instance.getToken().then((value) {
    print("FCM_TOKEN");
    print(value);
    ConstantVariable.FCM_TOKEN = value!;
  });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  String messageTitle = "Empty";
  String notificationAlert = "alert";

  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // theme:
      // ThemeData(primarySwatch: Colors.lightBlue, brightness: Brightness.light),
      // themeMode: ThemeMode.dark,
      // darkTheme: ThemeData(brightness: Brightness.dark),
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Constant.primary,
        ),
        getPages: [
          GetPage(
              name: "/",
              page: () => SplashScreenPage(),
              transition: Transition.leftToRight),
          GetPage(
            name: "/orderdetails",
            page: () =>  OrderDetails(),
            transition: Transition.leftToRight,
            // binding:HomeBinding()
          ),
        ],
        defaultTransition: Transition.leftToRight,
        debugShowCheckedModeBanner: false,
        unknownRoute: GetPage(
            name: "/UnknownRoute",
            page: () => const UnknownRoute(),
            transition: Transition.leftToRight),
        home: SplashScreenPage()
      // home: (accessToken==""||accessToken=="accessToken")?  SplashScreen():const BottomNavigation()
    );
  }
}
