import 'package:dunzodriver_copy1/constant/color.dart';
import 'package:dunzodriver_copy1/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
class AboutUs extends StatefulWidget {
   AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  WebViewController? controller;

ProfileController profileController=Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constant.primary,
        title: const Text("About Us",
          style: TextStyle(
            fontFamily: "Source Sans Pro",
          ),
        ),
      ),
      body: WebView(
        backgroundColor: Colors.grey,
        initialUrl:"${profileController.storedSettingData.value.data!=null?
        profileController.storedSettingData.value.data!.aboutUs!:"Error"}",
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (controller){
          this.controller=controller;
        },
        onPageFinished: (finish){
          setState(() {
          });
        },
      ),
    );
  }
}
