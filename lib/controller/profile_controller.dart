import 'dart:async';
import 'dart:io';
import 'package:dunzodriver_copy1/api/api_routes.dart';
import 'package:dunzodriver_copy1/api/repositiory.dart';
import 'package:dunzodriver_copy1/constant/constants.dart';
import 'package:dunzodriver_copy1/models/duty_response.dart';
import 'package:dunzodriver_copy1/models/infomatiion_response.dart';
import 'package:dunzodriver_copy1/models/profile_data.dart';
import 'package:dunzodriver_copy1/models/profile_data_response.dart';
import 'package:dunzodriver_copy1/models/settingmodels/setting_response.dart';
import 'package:dunzodriver_copy1/models/sync_driver_response.dart';
import 'package:dunzodriver_copy1/views/verification/panding_document_verification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart' as location;
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart' as di;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:timezone/timezone.dart' as tz;

import 'auth_controller.dart';
import 'order_controller.dart';

class ProfileController extends GetxController {
  final myControllerPhone = TextEditingController();
  final myControllerSecondPhone = TextEditingController();
  final myControllerName = TextEditingController();
  final myControllerLanguageEdit = TextEditingController();
  final myControllerProfile = TextEditingController();
  final myControllerLastName = TextEditingController();
  final myControllerEmail=TextEditingController();
  final myControllerVehicleModel = TextEditingController();
  final myControllerVehicleNumber = TextEditingController();
  final myControllerVehicleType = TextEditingController();
  final myControllerDOB = TextEditingController();
  final personalInfoEditFormKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  Rx<XFile>? image = XFile("").obs;
  RxString? selectedCity = "Noida".obs;
  RxString? selectedLanguageEdit = "Hindi".obs;
  RxString? vehicleType = "Bike".obs;
  RxBool? isImageSelected = false.obs;
  RxBool? isCompleted = false.obs;
  RxString? syncLat = "".obs;
  RxString? syncLong = "".obs;
  RxString? bearing = "".obs;
  Rx<Duration> duration = Duration().obs;
  Timer? timer;
  static var countdownDuration = const Duration(seconds: 0);
  bool countDown = true;
  String? languages;
  String? name;
  String? secondPhone;
  OrderController orderController = Get.put(OrderController());
  static FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
  static const String _appName = "WedunPartner";

  //Duty time
  DateTime startDateTime = DateTime.now();

  Rx<DateTime> selectedDate =
      DateTime.now().subtract(const Duration(hours: 50)).obs;
  Rx<SettingResponse> storedSettingData = SettingResponse().obs;

  void getImage() async {
    image!.value = (await _picker.pickImage(source: ImageSource.gallery))!;
    isImageSelected!.value = true;
  }

  Future<bool?> editProfileData() async {
    myControllerLanguageEdit.text = selectedLanguageEdit!.value;
    print("editprofile before");
    print(image!.value.path);
    print(myControllerLanguageEdit.value.text);

    PersonalInformationResponse result = await Repository.informationVerify(
      myControllerSecondPhone.text,
      myControllerName.text,
      myControllerDOB.text,
      myControllerLanguageEdit.value.text,
      myControllerEmail.value.text,
      image!.value,
      (await getAccessToken()),
    );
    // print(result.toJson());
    if (result.data != null) {
      if (result.success!) {
        await profileData();
        return true;
      } else {
        return false;
      }
    }
  }

  RxBool statusDuty = false.obs;

  Future<bool> requestPermission() async {
    final status = await Permission.location.request();
    //return status == PermissionStatus.granted;
    if (status == PermissionStatus.granted) {
      print('Permission granted');
      return true;
    } else if (status == PermissionStatus.denied) {
      openAppSettings();
      print('Permission denied. Show a dialog and again ask for the permission');

      return false;
    } else if (status == PermissionStatus.permanentlyDenied) {
      print('Take the user to the settings page.');
      openAppSettings();
      return false;
    }
    return false;
  }

  Future<bool> checkPermission() async {
    final serviceStatus = await Permission.location.status;
    print("Permission status: $serviceStatus");
    return serviceStatus.isGranted;
  }

  updateLatLang() {
    print("Update lat lang");
    Timer.periodic(const Duration(seconds: kDebugMode ? 60 * 10 : 20),
        (Timer t) => getCurrentLocation());
  }

  void getCurrentLocation() async {
    SharedPreferences prefe = await SharedPreferences.getInstance();
    String? tempAccessToken = prefe.getString("access_token");
    if (statusDuty.isTrue) {
      syncDriver(
        tempAccessToken!,
        syncLat!.value,
        syncLong!.value,
        ConstantVariable.FCM_TOKEN,
        bearing!.value,
      );
    }

    //TODO   // await BackgroundLocation.getLocationUpdates((location) async {

    //   print(location.latitude);
    //   String? tempAccessToken = await getAccessToken();
    //   await syncDriver(
    //     tempAccessToken!,
    //     location.latitude.toString(),
    //     location.longitude.toString(),
    //     ConstantVariable.FCM_TOKEN,
    //   );
    // });
    // BackgroundLocation.getLocationUpdates((p0) {
    //   print("Location update");
    //   print(p0);
    // });
    // BackgroundLocation().getCurrentLocation().then((location) async {
    //   print("after get current locaiton");
    //
    //   String? tempAccessToken = await getAccessToken();
    //   syncDriver(
    //     tempAccessToken!,
    //     location.latitude.toString(),
    //     location.longitude.toString(),
    //     ConstantVariable.FCM_TOKEN,
    //   );
    //   print('This is current Location ' + location.toMap().toString());
    // });TODO
  }

  Future<void> stopService() async {
    location.Location locate = location.Location();
    bool _serviceEnable;
    location.PermissionStatus _permissionGranted;
    location.LocationData _locationData;
    _serviceEnable = await locate.serviceEnabled();
    if (_serviceEnable) {
      locate.enableBackgroundMode(enable: false);
    }
  }

  void initLocationService() async {
    print("location on Duty");
    location.Location locate = location.Location();

    bool _serviceEnabled;
    location.PermissionStatus _permissionGranted;
    location.LocationData _locationData;
    _serviceEnabled = await locate.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await locate.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    locate.enableBackgroundMode(enable: true);
    locate.changeNotificationOptions(
      channelName: "SSMultiService Location",
      title: "SSMultiService Partner",
      subtitle:
          "SSMultiService Partner wants to collects location data in background for showing driver tracking to admin",
      description: "SSMultiService Partner running in background",
      iconName: "logo",
    );
    _permissionGranted = await locate.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      print("background Locations");
      _permissionGranted = await locate.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await locate.getLocation();
    print("Location data ${_locationData}");
    locate.onLocationChanged.listen((location.LocationData currentLocation) {
      if (statusDuty.isTrue) {
        print(currentLocation.latitude.toString());
        print("current location");
        // print("Current location fetched");
        syncLat!.value = currentLocation.latitude.toString();
        syncLong!.value = currentLocation.longitude.toString();
        if (currentLocation.heading.toString().isNotEmpty) {
          bearing!.value = currentLocation.heading.toString();
        } else {
          if (currentLocation.headingAccuracy.toString().isNotEmpty) {
            bearing!.value = currentLocation.headingAccuracy.toString();
          } else {
            bearing!.value = "0";
          }
        }

        print(currentLocation);
      }
    });
  }

  @override
  void dispose() {
    //BackgroundLocation.stopLocationService();
    // TODO: implement onInit
    super.dispose();
  }

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Rx<ProfileData> profileDataHome = ProfileData().obs;

  Future<File> getImageFromURL({required String url}) async {
    /// Get Image from server
    try {
      final di.Response<List<int>> res = await di.Dio().get<List<int>>(
        url,
        options: di.Options(
          responseType: di.ResponseType.bytes,
        ),
      );
      /// Get App local storage
      final Directory appDir = await getApplicationDocumentsDirectory();

      /// Generate Image Name
      final String imageName = url.split('/').last;

      /// Create Empty File in app dir & fill with new image
      final File file = File(join(appDir.path, imageName));

      file.writeAsBytesSync(res.data as List<int>);

      return file;
    } catch (e) {
      return File("");
    }
  }

  // void addTime() {
  //   const addSeconds = 1;
  //     final seconds = duration.value.inSeconds + addSeconds;
  //     // final seconds= orderController.orderStatisticsDetails.value.data!.activeTime!+addSeconds!;
  //     if (seconds < 0) {
  //       timer?.cancel();
  //     } else {
  //       duration.value = Duration(seconds: seconds);
  //     }
  // }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
  }

  void addTime() {
    final addSeconds = countDown ? 1 : 1;
    final seconds = DateTime.now().difference(startDateTime).inSeconds + 1;
    if (seconds < 0) {
      timer?.cancel();
    } else {
      // print("belwo is second");
      duration.value = Duration(seconds: seconds);
    }
  }

  void stopTimer({bool resets = true}) {
    if (resets) {
      reset();
    }
    if (timer != null) {
      timer?.cancel();
    }
  }

  void reset() {
    if (countDown && timer != null) {
      timer!.cancel();
      duration.value = countdownDuration;
    } else {
      duration.value = const Duration();
    }
  }


  Future<ProfileDataResponse?> profileData() async {
    String? accessToken = await getAccessToken();
    ProfileDataResponse result = (await Repository.getProfileHome(accessToken));
    if (result.data != null) {
      if (result.success!) {
        print("profileDataSuccessfully");
        profileDataHome.value = result.data!;
        if (profileDataHome.value.onDuty == 0) {
          var hours;
          var mints;
          var secs;
          hours = int.parse("00");
          mints = int.parse("00");
          secs = int.parse("00");
          countdownDuration =
              Duration(hours: hours, minutes: mints, seconds: secs);
          reset();
        } else {
          statusDuty.value = result.data?.onDuty == 1 ? true : false;

          //DateTime tempDate =  DateFormat("hh:mm:ss").parse(orderController.orderStatisticsDetails.value.data!.activeTime!);
          // Duration startTime =
          //duration.value= Duration(hours: tempDate.hour, minutes: tempDate.minute,seconds:tempDate.second);
          // Duration startTime = Duration(days:int.parse(profileDataHome.value.activeTime!.split(":")[0]),minutes: int.parse(profileDataHome.value.activeTime!.split(":")[1]));
          // if(duration.value.inHours.minutes.inSeconds>=orderController.orderStatisticsDetails.value.data!.activeTime!){
          //
          // }
          // if(duration.value.inHours.minutes.inSeconds>=int.parse(orderController.orderStatisticsDetails.value.data!.activeTime!)){
          //
          // }

          print("check");
          if (timer != null) {
            timer!.cancel();
            startTimer();
          }
          if (statusDuty.value) {
            initLocationService();
          } else {
            stopService();
          }
        }
        update();
        myControllerPhone.text = profileDataHome.value.mobile!;
        myControllerSecondPhone.text = profileDataHome.value.secondaryMobile!;
        myControllerName.text = profileDataHome.value.name!;
        myControllerDOB.text = profileDataHome.value.dob!;
        myControllerEmail.text=profileDataHome.value.email!;
        myControllerLanguageEdit.text = profileDataHome.value.languages!;
        selectedDate.value = DateTime.parse(profileDataHome.value.dob!);
        selectedLanguageEdit!.value = profileDataHome.value.languages!;
        isCompleted!.value = true;
        if (profileDataHome.value.profileImg != null) {
          isImageSelected!.value = true;
          image!.value = XFile((await getImageFromURL(
                  url: profileDataHome.value.profileImg != null
                      ? profileDataHome.value.profileImg!.contains("http")
                          ? profileDataHome.value.profileImg!
                          : "${ApiRoutes.BASE_URL}/" +
                              profileDataHome.value.profileImg!
                      : ""))
              .path);
        } else {
          isCompleted!.value = false;
          isImageSelected!.value = false;
        }
        if (profileDataHome.value.onDuty == 1) {
          bool permission = await checkPermission();
          if (permission) {
            statusDuty.value = true;
            // BackgroundLocation.setAndroidNotification(
            //   title: "Wedun Location Notification ",
            //   message: "We are getting your location in background ",
            //   icon: "@mipmap/ic_launcher",
            // );
            // BackgroundLocation.setAndroidConfiguration(30);
            // BackgroundLocation.startLocationService(
            //     forceAndroidLocationManager: true);
            getCurrentLocation();
            print(profileDataHome.value.active!);
            if (profileDataHome.value.active!){
              print("active hai");
              updateLatLang();
            }
          } else {
            // BackgroundLocation.stopLocationService();
            //TODO driver permission on Duty

            // await driverDuty(getAccessToken().toString(), "off");
            statusDuty.value = false;
          }
        } else {
          statusDuty.value = false;
        }
        bool? kycValue =  await Get.find<AuthController>().checkAllDoc(result);
        if(!kycValue!){
          Get.offAll(const PendingDocument());
        }else{

        }
        print(accessToken);
        return result;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<void> saveAccessToken(String tokenData) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString("access_token", tokenData);
    print(tokenData);
  }

  Future<String?> getAccessToken() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString("access_token");
  }

  Future<DriverDutyResponse?> driverDuty(
    String accessToken,
    String type,
  ) async {
    updateLatLang();
    SharedPreferences prefe = await SharedPreferences.getInstance();
    String? accessToken = prefe.getString("access_token");
    print("test $type");
    DriverDutyResponse result = await Repository.dutyOnAndOff(
      accessToken!,
      type,
    );
    print("Printing data");
    print(result.toJson());
    print(result.message);
    if (result.success ?? false) {
      if (result.data != null) {
        return result;
      } else {
        Get.snackbar(
            "Error", "${result.message}",
            backgroundColor: Colors.red, colorText: Colors.white,
        );
        // if(result.message=="Please deliver the order before"){
        //   Get.defaultDialog(
        //     title: "Please",
        //     middleText: "Please deliver the order before",
        //     backgroundColor: Colors.green,
        //     titleStyle: const TextStyle(color: Colors.white),
        //     middleTextStyle: const TextStyle(color: Colors.white),
        //   );
        // }
        profileData();
        return null;
      }
    } else {
      //TODO Location Of On duty permission

      if(Get.isDialogOpen==false){
        Get.defaultDialog(
          title: "Error",
          middleText: "${result.message}",
          backgroundColor: Colors.red,
          titleStyle: const TextStyle(color: Colors.white),
          middleTextStyle: const TextStyle(color: Colors.white),
          radius: 10,
        );
      }

      //TODO  kyc  rejected;

      profileData();

      // if(result.message!.contains("not verified yet")){
      //   Get.offAll(const PendingDocument());
      // }
      return null;
    }
  }

  Future<SyncDriverResponse?> syncDriver(
    String accessToken,
    String latitude,
    String longitude,
    String fcm_token,
    String bearing,
  ) async {
    print("sync ke andar");
    SharedPreferences prefe = await SharedPreferences.getInstance();
    String? accessToken = prefe.getString("access_token");

    SyncDriverResponse? result = await Repository.syncDriver(
        accessToken!, latitude, longitude, fcm_token, bearing);

    if (result != null) {
      if (result.success!) {
        if (result.data!.duty != null) {
          print("DriverDuty");
          // String? date = result.data!.duty!.startTime!.replaceAll(":", "-");
          print(result.data?.duty?.startTime);
          // startDateTime = DateTime.parse(result.data!.duty!.startTime ?? DateTime.now().toString());
          startDateTime = result.data!.duty!.createdAt ?? DateTime.now();
          if (timer == null) {
            startTimer();
          }
          print(startDateTime.minute);
          return result;
        } else {
          return null;
        }
      }
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    myControllerDOB.text = DateFormat('yyyy-MM-dd')
        .format(DateTime.now().subtract(const Duration(days: 365 * 18)));
    settingData();
    super.onInit();
  }

  Future<SettingResponse?> settingData() async {
    String? accessToken = await getAccessToken();
    SettingResponse result = await Repository.getSetting(accessToken);
    if (result.data != null) {
      if (result.success!) {
        print("Setting Data");
        storedSettingData.value = result;
        return result;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
}
