import 'package:dunzodriver_copy1/constant/color.dart';
import 'package:dunzodriver_copy1/views/verification/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerifyingPage extends StatelessWidget {
  const VerifyingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: MediaQuery.of(context).size.height*.22,
                decoration: BoxDecoration(
                  boxShadow:const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 2.0,
                      spreadRadius: 0.0,
                      offset: Offset(2.0, 2.0), // shadow direction: bottom right
                    )
                  ],
                  color:Constant.secondary,
                  border: Border.all(
                    color: Constant.secondary,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 25,horizontal: 10),
                margin: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Welcome to Wedun!',style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),),
                        const SizedBox(height: 10,),
                        Text('Just a few steps to',
                          style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 15
                          ),
                        ),
                        const SizedBox(height: 5,),
                        Text('complete and then you can',
                          style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 15
                          ),
                        ),
                        const SizedBox(height: 5,),
                        Text('start earning with Wedun',
                          style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 15
                          ),
                        ),
                        // Row(
                        //   children: const[
                        //     Text('Check it out',
                        //       style: TextStyle(
                        //           color: Colors.white,
                        //           fontSize: 20
                        //       ),
                        //     ),
                        //     SizedBox(width: 10,),
                        //     Icon(Icons.arrow_forward_ios,
                        //       size: 20,
                        //       color: Colors.white,
                        //     ),
                        //
                        //   ],
                        // ),
                      ],
                    ),
                    Image.asset('lib/Images/Final File.png',
                      height: 130,
                      width: 130,
                    ),


                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left:50.0,right: 50),
              child: Text(
                "Please Wait we got you document and verify you soon.",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,

                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Lottie.asset('lib/lottie_json/verifying.json'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Constant.primary,
        onPressed: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("access_token", "");
          Get.offAll(() => const DunzoPartner());
        },
        child: const Icon(
          Icons.logout,
          // color: Constant.primary,
        ),
      ),
    );
  }
}