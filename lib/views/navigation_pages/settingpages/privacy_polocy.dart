import 'package:dunzodriver_copy1/constant/color.dart';
import 'package:dunzodriver_copy1/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
class PrivacyPolicy extends StatefulWidget {
   PrivacyPolicy({Key? key}) : super(key: key);
  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  WebViewController? controller;
  ProfileController profileController=Get.find();
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constant.primary,
        title: const Text("Privacy Policy",style: TextStyle(
          fontFamily: "Source Sans Pro",
          fontSize: 20,
        ),),
      ),
      body:WebView(
        backgroundColor: Colors.grey,
        initialUrl:"${profileController.storedSettingData.value.data!=null?
        profileController.storedSettingData.value.data!.privacyPolicy!:"Error"}",
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (controller){
          this.controller=controller;
        },
        onPageFinished: (finish){
          setState(() {
            isLoading = false;
          });
        },
      ),
    );
  }
}
