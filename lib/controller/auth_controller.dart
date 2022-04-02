import 'dart:io';
import 'package:dunzodriver_copy1/api/repositiory.dart';
import 'package:dunzodriver_copy1/constant/color.dart';
import 'package:dunzodriver_copy1/models/infomatiion_response.dart';
import 'package:dunzodriver_copy1/models/otpverification_response.dart';
import 'package:dunzodriver_copy1/models/phone_loginresponse.dart';
import 'package:dunzodriver_copy1/models/profile_data.dart';
import 'package:dunzodriver_copy1/models/profile_data_response.dart';
import 'package:dunzodriver_copy1/models/vehicle_details_response.dart';
import 'package:dunzodriver_copy1/models/vehicle_response.dart';
import 'package:dunzodriver_copy1/views/verification/personal_information.dart';
import 'package:flutter/material.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constant/constants.dart';

class AuthController extends GetxController {

  makingPhoneCall() async {
    const url = 'tel:9876543210';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  final myControllerPhone = TextEditingController();
  final myControllerSecondPhone = TextEditingController();
  final myControllerName = TextEditingController();
  final myControllerLanguage = TextEditingController();
  final myControllerProfile = TextEditingController();
  final myControllerEmail = TextEditingController();
  final myControllerVehicleModel = TextEditingController();
  final myControllerVehicleNumber = TextEditingController();
  final myControllerVehicleType = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  Rx<XFile>? image = XFile("").obs;
  RxString? selectedCity = "Noida".obs;
  RxString? selectedLanguage = "Select".obs;
  RxString? vehicleType = "Bike".obs;
  RxBool? isImageSelected = false.obs;
  bool isCompleted = false;

  // RxString accessToken = "".obs;

  get icon => null;

  void getImage() async {
    image!.value = (await _picker.pickImage(source: ImageSource.gallery))!;
    isImageSelected!.value = true;
  }

  Rx<ProfileData> storedProfileData = ProfileData().obs;

//PersonalInformation
  RxBool step1Completed = true.obs;
  RxBool step2Completed = true.obs;
  RxBool step3Completed = true.obs;
  RxBool step4Completed = true.obs;
  RxBool step5Completed = true.obs;

  final personalInfoFormKey = GlobalKey<FormState>();
  var mobile;
  var pinn;
  var name;
  final myControllerFatherName = TextEditingController();
  final myControllerAddress = TextEditingController();
  final myControllerDOB = TextEditingController();
  var secondaryphone;
  var Dob;
  var language;
  var email;
  File? profileimage;
  Rx<DateTime> selectedDate = DateTime(1).obs;
  TextEditingController phone = TextEditingController();
  late GlobalKey<FormState> loginFormKey;
  late GlobalKey<FormState>? otpFormKey;
  RxList<String>? CompleteddocumentList = [""].obs;

  RxList<String> documentList = [
    'Personal Info',
    'Personal documents',
    'Emergency contact',
    // 'Work preference',
    'vehicle details',
    'Bank account details'
  ].obs;

  //vehicleType
  final vehicleTypeformKey = GlobalKey<FormState>();
  final emergencyContactFormKey = GlobalKey<FormState>();

  get prefixText => null;
  RxBool isChecked = false.obs;
  RxList<VehicleData> vehicleList = <VehicleData>[].obs;
  final myControllerVehicleRegistrationNumber = TextEditingController();
  final myControllerVehicleColors = TextEditingController();





  final ImagePicker pickerVehicle = ImagePicker();
  var vehicleRegistrationNumber;
  var vehicleColor;
  String? selectedVehicle;

// Account Details
  String regExp = "^[A-Z]{4}[0][A-Z0-9]{6}";
  bool isValid = false;
  final bankDetailsFormKey = GlobalKey<FormState>();
  String? BankName;
  String? IFSCCode;
  String? BranchName;
  String? AccountNumber;
  final myControllerBankName = TextEditingController();
  final myControllerIFSCCode = TextEditingController();
  final myControllerBankAccountNumber = TextEditingController();
  final myControllerBranchName = TextEditingController();

  // Emergency contact Details
  final myControllerEmergencyNumber = TextEditingController();
  final myControllerEmergencyContactName = TextEditingController();
  final myControllerRelation = TextEditingController();
  PhoneContact? phoneContact;
  String? contact;
  final formKey = GlobalKey<FormState>();
  String? EmergencyContactNumber;
  String? EmergencyContactName;
  String? YourRelation;

  // Personal documents "Aadhaar card images"
  final myControllerFrontAadhar = TextEditingController();
  final myControllerBackAadhar = TextEditingController();
  final myControllerDL = TextEditingController();
  final ImagePicker picker = ImagePicker();

  Rx<XFile>? imagePanCard = XFile("").obs;
  Rx<XFile>? imageAadhaarFront = XFile("").obs;
  Rx<XFile>? imageAadhaarBack = XFile("").obs;
  Rx<XFile>? imageDrivingLicense = XFile("").obs;
  Rx<XFile>? imagevehicle = XFile("").obs;

  void getImageVehicle() async {
    print("get images");
    final XFile? image =await _picker.pickImage(source: ImageSource.gallery);
    imagevehicle!.value= image!;
    print("upload bike image");
  }

  Future getImagePanCard() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    imagePanCard!.value = image!;
  }

  Future getImageFrontAadhaar() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    imageAadhaarFront!.value = image!;
  }

  Future getImageBackAadhaar() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    imageAadhaarBack!.value = image!;
  }

  Future getImageDrivingLicense() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    imageDrivingLicense!.value = image!;
  }

  @override
  void onInit() {
    myControllerDOB.text = DateFormat('yyyy-MM-dd')
        .format(DateTime.now().subtract(const Duration(days: 365 * 18)));
    super.onInit();
    getVehicleList();
    // getProfileData();
  }

  Future<bool> phoneLogin( ) async {
    PhoneLoginResponse result = await Repository.phoneLogin("+91" +   mobile);
    if (result.data != null) {
      if (result.data!.statusCode == 200) {
        print('otp send successfully');
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    }
  }

  Future<OTPResponse?> otpVerify() async {
    OTPResponse? result = await Repository.otpVerify(
      "+91" + mobile,
      pinn,
    );
    if (result != null) {
      if (result.success!) {
        print('verifiedddd');
        // accessToken.value = result.data!.token!;
        ConstantVariable.TOKEN = result.data?.token;
        saveAccessToken(result.data!.token!);
        saveDriverId(result.data!.id!.toString());
        phone.clear();
        // await getProfileData();
        return result;
      } else {
        // Fluttertoast.showToast(
        //     msg: "Wrong OTP",
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.CENTER,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 16.0);
        // print('incorrect Otp');
        return null;
      }
    } else {
      // Fluttertoast.showToast(
      //     msg: "Wrong OTP",
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.CENTER,
      //     timeInSecForIosWeb: 1,
      //     backgroundColor: Colors.red,
      //     textColor: Colors.white,
      //     fontSize: 16.0);
      return null;
    }
  }

  Future<bool> profileData() async {
    print(secondaryphone);
    print(name);
    print(myControllerDOB.text);
    print(language);
    print(image!.value.path);
    String? accessToken = await getAccessToken();
    documentList.value = [
      'Personal Info',
      'Personal documents',
      'Emergency contact',
      // 'Work preference',
      'vehicle details',
      'Bank account details'
    ];
    CompleteddocumentList!.value=[];
    PersonalInformationResponse result = await Repository.informationVerify(
      secondaryphone,
      name,
      myControllerDOB.text,
      language,
      myControllerEmail.value.text,
      image!.value,
      accessToken,
    );
    // print(result.toJson());
    if (result.success!) {
      await getProfileData();
      print('FullName');
      return true;
    } else {
      return false;
    }
  }

  Future<bool> getVehicleList() async {
    vehicleList.clear();
    VehicleResponse result = await Repository.vehicleVerify();
    if (result.success!) {
      vehicleList.addAll(result.data!);
      if (vehicleList.isEmpty) {
        selectedVehicle = "bike";
      } else {
        selectedVehicle = vehicleList.elementAt(0).name;
      }
      return true;
    } else {
      return false;
    }
  }

  Future<bool> vehicleVerfiy() async {
    print("vehicleRegishjssbcjshdbcjh");
    print(vehicleRegistrationNumber);
    print(vehicleColor);
    print(imagevehicle!.value.path);
    String? accessToken = await getAccessToken();

    VehicleDetailsResponse result = await Repository.vehicleDetailsVerify(
      vehicleType!.value,
      vehicleRegistrationNumber,
      vehicleColor,
      imagevehicle!.value,
      accessToken!,
    );
    print(result.toJson());
    if (result.success!) {
      await getProfileData();
      print('Vehicle Images');
      return true;
    } else {
      return false;
    }
  }

  Future<bool> uploadDocuments(File frontAadharCardPhoto,
      File backAadharCardPhoto, File dLPhoto, String accessToken) async {
    final response = await Repository.uploadDocuments(
      frontAadharCardPhoto,
      backAadharCardPhoto,
      dLPhoto,
      accessToken,
    );
    if (response.data != null) {
      await getProfileData();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> uploadBankAccountDetails() async {
    print('Upl');
    String? accessToken = await getAccessToken();
    final response = await Repository.uploadBankAccountDetails(
        BankName!, AccountNumber!, IFSCCode!, BranchName!, accessToken!);
    if (response.data != null) {
      await getProfileData();
      return true;
    } else {
      return false;
    }
  }

  emergencyContactDetails() async {
    String? accessToken = await getAccessToken();
    final response = await Repository.emergencyContactDetails(
        EmergencyContactNumber!,
        EmergencyContactName!,
        YourRelation!,
        accessToken);
    if (response.data != null) {

      await getProfileData();
      return true;
    } else {
      return false;
    }
  }

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

  Future<void> saveDriverId(String driverId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("driver_id", driverId);
    print(driverId);
  }
  RxBool isDocumentLoading = true.obs;


  Future<OTPResponse?> getProfileData() async {
    documentList.value = [
      'Personal Info',
      'Personal documents',
      'Emergency contact',
      // 'Work preference',
      'vehicle details',
      'Bank account details'
    ];
    CompleteddocumentList!.value=[];
    CompleteddocumentList!.remove("");
    CompleteddocumentList!.clear();
    isDocumentLoading.value=true;
    OTPResponse result = (await Repository.getProfile(ConstantVariable.TOKEN));
    if (result.data != null) {
      if (result.success!) {
        print("profileDataSuccessfully");
        print(storedProfileData.value);
        storedProfileData.value = result.data!;
        saveDriverId(storedProfileData.value.id.toString());
        if (!CompleteddocumentList!.contains("Personal Info")) {
          CompleteddocumentList!.add("Personal Info");
          documentList.remove("Personal Info");
        }
        else {
          // if(!documentList.contains("Personal info")){
          documentList.remove("Personal Info");
          // }
        }
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
            result.data!.dlPhoto != null) {
          if (aadhar == true &&
              backAadhar == true && dl == true) {
            step2Completed.value = true;
          } else {
            step2Completed.value = false;
          }
          if(step2Completed.value){
            if (!CompleteddocumentList!.contains("Personal documents")) {
              CompleteddocumentList!.add("Personal documents");
              documentList.remove("Personal documents");
            }
          }
          print("if me aaya");
        }
        else {
          if (!documentList.contains("Personal documents")) {
            documentList.add("Personal documents");
          }
        }
        if (result.data!.emergencyContactNo != null &&
            result.data!.emergencyContactName != null &&
            result.data!.emergencyContactRelation != null) {
          print("if mai aaya emergency data");
          if (!CompleteddocumentList!.contains("Emergency contact")) {
            CompleteddocumentList!.add("Emergency contact");
            documentList.remove("Emergency contact");
          }
        }
        else {
          if (!documentList.contains("Emergency contact")) {
            documentList.add("Emergency contact");
          }
        }
        if (result.data!.vehicleType != null &&
            result.data!.vehicleRegNo != null &&
            result.data!.vehicleColor != null &&
            result.data!.vehicleImg != null) {
          if (vehicleImg == true) {
            step4Completed.value = true;
          } else {
            step4Completed.value = false;
          }
          if(step4Completed.value){
            if (!CompleteddocumentList!.contains("vehicle details")) {
              CompleteddocumentList!.add("vehicle details");
              documentList.remove("vehicle details");
            }
          }
        }
        else {
          if (!documentList.contains("vehicle details")) {
            documentList.add("vehicle details");
          }
        }
        if (result.data!.bankName != null &&
            result.data!.ifscCode != null &&
            result.data!.accountNo != null &&
            result.data!.branchName != null) {
          if (!CompleteddocumentList!.contains("Bank account details")) {
            CompleteddocumentList!.add("Bank account details");
            documentList.remove("Bank account details");
          }
        } else {
          if (!documentList.contains("Bank account details")) {
            documentList.add("Bank account details");
          }
        }
        print("Profile");
        print("back bottom");
        isDocumentLoading.value=false;
        return result;
      } else {
        isDocumentLoading.value=false;
        return null;
      }
    } else {
      isDocumentLoading.value=false;
      return null;
    }
  }


  Future<bool?> checkAllDoc(ProfileDataResponse kycData)async{
    RxBool kyc1StepCompleted=false.obs;
    RxBool kyc2StepCompleted=false.obs;
    RxBool kyc3StepCompleted=false.obs;
    RxBool kyc4StepCompleted=false.obs;
    RxBool kyc5StepCompleted=false.obs;

    if(kycData.data!.name==null){
      kyc1StepCompleted.value =false;
      myControllerName.text="";
    }else {
      kyc1StepCompleted.value=true;
      myControllerName.text=kycData.data!.name!;
    }if(kycData.data!.mobile==null){
      kyc1StepCompleted.value=false;
      myControllerPhone.text="";
    }else{
      kyc1StepCompleted.value=true;
      myControllerPhone.text=kycData.data!.mobile!;
    }if(kycData.data!.email==null){
      kyc1StepCompleted.value=false;
      myControllerEmail.text="";
    }else{
      kyc1StepCompleted.value=true;
      myControllerEmail.text=kycData.data!.email!;
    }
    if(kycData.data!.secondaryMobile==null){
      kyc1StepCompleted.value=false;
      myControllerSecondPhone.text="";
    }else{
      kyc1StepCompleted.value=true;
      myControllerSecondPhone.text=kycData.data!.secondaryMobile!;
    }if(kycData.data!.dob==null){
      kyc1StepCompleted.value=false;
      selectedDate.value=DateTime.now().subtract(
          const Duration(days: 365 * 18));
      myControllerDOB.text= DateFormat('yyyy-MM-dd').format(
          DateTime.now().subtract(
              const Duration(days: 365 * 18)));
    }else{
      kyc1StepCompleted.value=true;
      myControllerDOB.text=kycData.data!.dob!;
    }if(kycData.data!.languages==null){
      kyc1StepCompleted.value=false;
      myControllerLanguage.text="";
    }else{
      kyc1StepCompleted.value=true;
      myControllerLanguage.text=kycData.data!.languages!;
    }if(kycData.data!.profileImg==null){
      kyc1StepCompleted.value=false;
      myControllerProfile.text="";
    }else{
      kyc1StepCompleted.value=true;
      myControllerProfile.text=kycData.data!.profileImg!;
    }
    if(kyc1StepCompleted.value){
      CompleteddocumentList!.add("Personal Info");
      documentList.remove("Personal Info");
    }else{
      if(!documentList.contains("Personal Info")){
        documentList.add("Personal Info");
      }
      if(CompleteddocumentList!.contains("Personal Info")){
        CompleteddocumentList!.remove("Personal Info");
      }
    }
    bool aadhar = false;
    bool backAadhar = false;
    bool dl = false;
    bool vehicleImg = false;
    for (int i = 0; i < kycData.data!.kycs!.length; i++) {
      String doctype = kycData.data!.kycs!.elementAt(i).docType!;
      String status = kycData.data!.kycs!.elementAt(i).status!;
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
    if (kycData.data!.aadharPhoto != null &&
        kycData.data!.aadharPhotoBack != null &&
        kycData.data!.dlPhoto != null) {
      if (aadhar == true &&
          backAadhar == true &&
          dl == true) {
        kyc2StepCompleted.value  = true;
      } else {
        kyc2StepCompleted.value  = false;
      }
    } else {
      kyc2StepCompleted.value = false;
      // Get.to(const PendingDocument());
    }
    if (kyc2StepCompleted.value) {
      CompleteddocumentList!.add("Personal documents");
    documentList.remove("Personal documents");
    }else{
      documentList.add("Personal documents");
    }
    if (kycData.data!.emergencyContactNo != null &&
        kycData.data!.emergencyContactName != null &&
       kycData.data!.emergencyContactRelation != null) {
      kyc3StepCompleted.value = true;
    } else {
      kyc3StepCompleted.value = false;
      // Get.to( const PendingDocument());
    }
    if (kyc3StepCompleted.value) {
     CompleteddocumentList!.add("Emergency contact");
     documentList.remove("Emergency contact");
    }else{
      documentList.add("Emergency contact");
    }
    if (kycData.data!.vehicleType != null &&
        kycData.data!.vehicleRegNo != null &&
        kycData.data!.vehicleColor != null &&
        kycData.data!.vehicleImg != null) {
      if (vehicleImg == true) {
        kyc4StepCompleted.value =
        true;
      } else {
        kyc4StepCompleted.value =
        false;
      }
    } else {
      kyc4StepCompleted.value = false;
    }
    if (kyc4StepCompleted.value) {
      CompleteddocumentList!
          .add("vehicle details");
      documentList
          .remove("vehicle details");
    }else{
      documentList
          .add("vehicle details");
    }
    if (kycData.data!.bankName != null &&
        kycData.data!.ifscCode != null &&
        kycData.data!.accountNo != null &&
        kycData.data!.branchName != null) {
      kyc5StepCompleted.value = true;
      phone.clear();
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
      kyc5StepCompleted.value =
      false;
    }
    if (kyc4StepCompleted.value) {
      CompleteddocumentList!
          .add("Bank account details");
      documentList
          .remove("Bank account details");
    }else{
      documentList
          .remove("Bank account details");
    }
    bool allStepCompleted = kyc1StepCompleted.isTrue
        &&kyc2StepCompleted.isTrue&&
        kyc3StepCompleted.isTrue&&kyc4StepCompleted.isTrue&&
        kyc5StepCompleted.isTrue;

    return allStepCompleted;
  }
}