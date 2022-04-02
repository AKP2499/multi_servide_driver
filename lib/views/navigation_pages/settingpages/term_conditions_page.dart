import 'dart:async';
import 'dart:io';

import 'package:dunzodriver_copy1/constant/color.dart';
import 'package:dunzodriver_copy1/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
class TermAndConditions extends StatefulWidget {
  const TermAndConditions({Key? key}) : super(key: key);


  @override
  _TermAndConditionsState createState() => _TermAndConditionsState();
}

class _TermAndConditionsState extends State<TermAndConditions> {
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();
  WebViewController? controller;
  ProfileController profileController=Get.find();
@override
  void initState() {
    super.initState();
    print("url: ${profileController.storedSettingData.value.data!.termsConditions!}");
    if(Platform.isAndroid){
      WebView.platform=SurfaceAndroidWebView();
    }
  }
  bool isLoading=true;
  String url="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constant.primary,
        title:const Text("Term & Conditions",
          style: TextStyle(
            fontFamily: "Source Sans Pro",
          ),
        ),
      ),
      body:  WebView(
        initialUrl:"${  profileController.storedSettingData.value.data!=null?
        profileController.storedSettingData.value.data!.termsConditions!:"Error"}",
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
  // HtmlWidget(
  //                     profileController.storedSettingData.value.data!=null?
  //                     profileController.storedSettingData.value.data!.termsConditions!:""
  //                  ),


//  WebView(
//               initialUrl: 'https://flutter.dev',
//               onPageStarted: (url) {
//                 setState(() {
//                   loadingPercentage = 0;
//                 });
//               },
//               onProgress: (progress) {
//                 setState(() {
//                   loadingPercentage = progress;
//                 });
//               },
//               onPageFinished: (url) {
//                 setState(() {
//                   loadingPercentage = 100;
//                 });
//               },
//             ),
//             if (loadingPercentage < 100)
//               LinearProgressIndicator(
//                 value: loadingPercentage / 100.0,
//               ),