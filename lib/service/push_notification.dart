import 'package:dunzodriver_copy1/constant/constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  static FlutterLocalNotificationsPlugin? _flutterLocalNotificationsPlugin;
  SharedPreferences? pref;
  static const String _appName = "WedunPartner";

  Future initialise() async {
    pref = await SharedPreferences.getInstance();
    // if (Platform.isIOS) {
    //   // _fcm.requestNotificationPermissions(IosNotificationSettings());
    // }

    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    _fcm.getToken().then((value) {
        // final box = GetStorage();
      // box.write('fcm_token', value);
      ConstantVariable.FCM_TOKEN = value!;
      pref!.setString("fcm_token", value);
      print("FCM Token: $value");
    });

    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var initializationSettings = const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    );
    await _flutterLocalNotificationsPlugin!.initialize(initializationSettings);
    // await _flutterLocalNotificationsPlugin!.show(
    //     0,
    //     "Wedun Location Notification",
    //     "We are getting your location in background ",
    //     notificationDetails,payload: "@mipmap/ic_launcher"
    // );
    // FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
    //   print('Got a message whilst in the background!');
    //   print('Message data: ${message.data}');
    //
    //   if (message != null) {
    //     if (message.notification!.android != null) {
    //       print(message.notification!.android!.imageUrl!);
    //       print(
    //           'Message also contained a notification: ${message.notification}');
    //     }
    //   }
    //
    //   // PushNotificationService.notificationHandler(
    //   //     message.data,message.notification!.title!, message.notification!.body!);
    // });
  }

  static void clearAllNotification() {
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _flutterLocalNotificationsPlugin!.cancelAll();

  }

  static Future notificationHandler(
      Map<String, dynamic> message, String title, String body) async {
    print("******");
    print(message);
    print("******");
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var initializationSettings = const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    );
    await _flutterLocalNotificationsPlugin!.initialize(initializationSettings);

    AndroidNotificationDetails _androidSpecifics =
        const AndroidNotificationDetails(
            _appName,
            _appName,
            importance: Importance.max,
            priority: Priority.high,
            groupKey: _appName,
            sound: RawResourceAndroidNotificationSound('notification'),
            playSound: true,
            enableLights: true,
            enableVibration: true,
            channelDescription: _appName
        );

    // Get.to()

    NotificationDetails notificationPlatformSpecifics = NotificationDetails(
      android: _androidSpecifics,
      iOS: const IOSNotificationDetails(),
    );

    await _flutterLocalNotificationsPlugin!.show(
      0,
      title,
      body,
      // message['notification']['title'],
      // message['notification']['body'],
      notificationPlatformSpecifics,
    );
  }

  static Future notificationHandler2(
      Map<String, dynamic> message, String title, String body) async {
    print("***kjuhkj***");
    print(message);
    print("******");
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var initializationSettings = const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    );
    await _flutterLocalNotificationsPlugin!.initialize(initializationSettings);

    AndroidNotificationDetails _androidSpecifics =
        const AndroidNotificationDetails("Earning", "Earning",
            importance: Importance.max,
            priority: Priority.high,
            groupKey: _appName,
            sound: RawResourceAndroidNotificationSound('sounds'),
            playSound: true,
            enableLights: true,
            enableVibration: true,
            channelDescription: _appName
        );

    // Get.to()

    NotificationDetails notificationPlatformSpecifics = NotificationDetails(
      android: _androidSpecifics,
      iOS: const IOSNotificationDetails(),
    );

    await _flutterLocalNotificationsPlugin!.show(
      0,
      title,
      body,
      // message['notification']['title'],
      // message['notification']['body'],
      notificationPlatformSpecifics,
    );
  }

  // Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
  //   if (message.containsKey('data')) {
  //     // Handle data message
  //     final dynamic data = message['data'];
  //   }
  //
  //   if (message.containsKey('notification')) {
  //     // Handle notification message
  //     final dynamic notification = message['notification'];
  //   }
  //   return "";
  //
  //   // Or do other work.
  // }

  void _serialiseAndNavigate(Map<String, dynamic> message) {
    var notificationData = message['data'];
    var view = notificationData['view'];

    if (view != null) {
      // Navigate to the create post view
      if (view == 'create_post') {
        //_navigationService.navigateTo(CreatePostViewRoute);
        //Get.to(); Go to some page
      }
      // If there's no view it'll just open the app on the first view
    }
  }
}
