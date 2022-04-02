import 'package:dunzodriver_copy1/constant/color.dart';
import 'package:dunzodriver_copy1/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'otp.dart';

class DunzoPartner extends StatefulWidget {
  const DunzoPartner({Key? key}) : super(key: key);

  @override
  _DunzoPartnerState createState() => _DunzoPartnerState();
}

class _DunzoPartnerState extends State<DunzoPartner> with SingleTickerProviderStateMixin {
  AuthController authController = Get.put(AuthController());

  // AnimationController? controller;

  @override
  void initState() {
    authController.loginFormKey = GlobalKey<FormState>();
    // controller=AnimationController(
    //   duration: const Duration(seconds: 1),
    //  vsync: this,
    // );
    // controller!.forward();
    // controller!.addListener(() {
    //   setState(() {});
    //   print(controller!.value);
    // });

    super.initState();
  }



  @override
  void dispose() {
    if (authController.loginFormKey.currentState != null) {
      authController.loginFormKey.currentState!.reset();
      authController.loginFormKey.currentState!.dispose();
    }
    // TODO: implement dispose
    super.dispose();
  }
  static const Color primaryLight=Color(0xffC5E7CF);
  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.green;
    }
    return Scaffold(
      backgroundColor: primaryLight,
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                // SizedBox(height: 20,),
                Image.network("https://assets.grab.com/wp-content/uploads/sites/8/2020/12/02164630/GRAB_DAX_Q3Acquisition_WebsiteLanding_Icon_Mock-01.png",
                // Image.asset(
                //   "lib/Images/login_back.png",
                  // width: MediaQuery.of(context).size.width * 0.7,
                  height: MediaQuery.of(context).size.height * 0.6,
                  fit: BoxFit.fitHeight,
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child:
            Container(
              color: Colors.white,
              child: Form(
                key: authController.loginFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: const [
                          Text(
                            'Enter mobile number',
                            style: TextStyle(
                              color: Constant.primary,
                              fontFamily: 'Source Sans Pro',
                              letterSpacing: .5,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                    ),
                    // const SizedBox(
                    //   height: 5,
                    // ),
                    Container(
                      margin: const EdgeInsets.all(20),
                      child: TextFormField(
                        controller: authController.phone,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty && value.length != 10) {
                            return 'Enter invalid number';
                          }
                          return null;
                        },
                        buildCounter: (context,
                            {required currentLength, required isFocused, maxLength}) {},
                        maxLength: 10,
                        onFieldSubmitted: (value) {
                          print('Second text field : $value');
                        },
                        onChanged: (value) {
                          authController.mobile = value;
                          authController.myControllerPhone.text = value;
                        },
                        decoration: InputDecoration(
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Constant.primary)),
                          prefixIcon: const Padding(
                            padding: EdgeInsets.all(15),
                            child: Text('+91'),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: 'e.g.9999888777 ',
                          hintStyle: const TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                          checkColor: Colors.white,
                          fillColor: MaterialStateProperty.resolveWith(getColor),
                          onChanged: (bool? value) {
                            setState(() {
                              authController.isChecked.value = value!;
                            });
                          },
                          value: authController.isChecked.value,
                        ),
                        const Text(
                          'By signing up I agree to ',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        const Text(
                          'Term of Use ',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.black,
                            decorationThickness: 1.5,
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          ),
                        ),
                        const Text(
                          'and ',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        const Text(
                          'Privacy Policy',
                          style: TextStyle(
                              fontSize: 12,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.black,
                              decorationThickness: 1.5,
                              fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                    const Padding(padding: EdgeInsets.only(right: 100)),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(20,10,20,10),
                      padding: const EdgeInsets.fromLTRB(10,2,10,2),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: (authController.isChecked.value)
                              ? Constant.secondary
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(10)),
                      child: TextButton(
                        onPressed: () {
                          if (authController.loginFormKey.currentState!.validate()) {
                            (authController.isChecked.value) ? authController.phoneLogin().then((value) {
                              if (value) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => const OTPVerify()));
                              } else {
                                print('Error');
                              }
                            })
                                  : null;
                          }
                        },
                        child: const Text(
                          'Send OTP',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      )
    );
  }
}
