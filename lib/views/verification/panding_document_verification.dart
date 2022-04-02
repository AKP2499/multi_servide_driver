import 'package:dunzodriver_copy1/constant/color.dart';
import 'package:dunzodriver_copy1/controller/auth_controller.dart';
import 'package:dunzodriver_copy1/controller/profile_controller.dart';
import 'package:dunzodriver_copy1/models/otpverification_response.dart';
import 'package:dunzodriver_copy1/views/navigation_pages/bottomnavigation_dunzo.dart';
import 'package:dunzodriver_copy1/views/verification/page5_personal_document.dart';
import 'package:dunzodriver_copy1/views/verification/personal_information.dart';
import 'package:dunzodriver_copy1/views/verification/vehicle_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../navigation_pages/bottomnavigation_dunzo.dart';
import '../pending_document_page.dart';
import 'bank_account_details.dart';
import 'emergecy_contact.dart';

class PendingDocument extends StatefulWidget {
  const PendingDocument({Key? key}) : super(key: key);

  @override
  _PendingDocumentState createState() => _PendingDocumentState();
}

class _PendingDocumentState extends State<PendingDocument> {
  ProfileController profileController = Get.put(ProfileController());
  AuthController authController = Get.put(AuthController());

  @override
  void initState() {
    // TODO: implement initState
    authController.isDocumentLoading.value=true;
    Future.delayed(const Duration(seconds: 2), () {
      if (Get.isDialogOpen! || Get.isSnackbarOpen) {
        Get.back();
      }
      authController.getProfileData();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    authController.isDocumentLoading.value=true;
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 34, horizontal: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .22,
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 2.0,
                    spreadRadius: 0.0,
                    offset: Offset(2.0, 2.0),
                    // shadow direction: bottom right
                  )
                ],
                color: Constant.primaryLight,
                border: Border.all(
                  color: Constant.primaryLight,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
              margin: const EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome to Wedun!',
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Just a few steps to',
                        style: TextStyle(
                            color: Colors.grey.shade700, fontSize: 15),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'complete and then you can',
                        style: TextStyle(
                            color: Colors.grey.shade700, fontSize: 15),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'start earning with Wedun',
                        style: TextStyle(
                            color: Colors.grey.shade700, fontSize: 15),
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
                  Image.asset(
                    'lib/Images/Final File.png',
                    height: 130,
                    width: 130,
                  ),
                ],
              ),
            ),
            // const Image(
            //   image: AssetImage('lib/Images/Welcome_dunzo.jpeg'),
            // ),
            Obx(() => (authController.isDocumentLoading.value)
                ? Center(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 250,
                        ),
                        Container(
                          child: const CircularProgressIndicator(),
                        ),
                      ],
                    ),
                  )
                : Column(
                    children: [
                      Obx(
                        () => Column(
                          children: [
                            (authController.documentList.isEmpty ||
                                    authController.documentList == [])
                                ? Container(
                                    height: 20,)
                                :Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 0),
                                    child: Column(
                                      children: [
                                        // (authController.documentList.isEmpty)?Container():
                                        Row(
                                          children: [
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              'Pending Documents',
                                              style: TextStyle(
                                                color: Colors.grey.shade700,
                                                fontSize: 17,
                                                letterSpacing: 1,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            )
                                          ],
                                        ),
                                        Obx(
                                          () => ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: authController.documentList.length,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                onTap: () {
                                                  if (authController.documentList[index] ==
                                                      "Personal Info") {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (_) =>
                                                                const PersonalInformation()));
                                                  }
                                                  if (authController
                                                              .documentList[index] ==
                                                      "Personal documents") {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (_) =>
                                                                PersonalDocuments()));
                                                  }
                                                  if (authController
                                                              .documentList[
                                                          index] ==
                                                      "Emergency contact") {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (_) =>
                                                                const EmergencyContact()));
                                                  }
                                                  // if(index==2){
                                                  //   Navigator.push(context, MaterialPageRoute(builder: (_)=>const WorkPreference()));
                                                  // }
                                                  if (authController
                                                              .documentList[
                                                          index] ==
                                                      "vehicle details") {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (_) =>
                                                                const VehicleDetails()));
                                                  }
                                                  if (authController
                                                              .documentList[
                                                          index] ==
                                                      "Bank account details") {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (_) =>
                                                                const BankAccountDetails()));
                                                  }
                                                },
                                                child: Container(
                                                    height: 70,
                                                    child: Card(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(10.0),
                                                      ),
                                                      color: Colors.white,
                                                      elevation: 1,
                                                      child: Container(
                                                        margin: const EdgeInsets
                                                            .all(15),
                                                        alignment:
                                                            Alignment.center,
                                                        height: 50,
                                                        width: 380,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              color: Colors
                                                                  .transparent),
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  authController
                                                                          .documentList[
                                                                      index],
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      letterSpacing:
                                                                          .5),
                                                                ),
                                                              ],
                                                            ),
                                                            const Icon(Icons
                                                                .navigate_next)
                                                          ],
                                                        ),
                                                      ),
                                                    )),
                                              );
                                            },
                                          ),
                                        )
                                      ],
                                    )
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Completed',
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: 17,
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Obx(() => ListView.builder(
                              shrinkWrap: true,
                              itemCount:
                                  authController.CompleteddocumentList!.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    // if(authController.documentList[index]==""){
                                    //   Navigator.push(context, MaterialPageRoute(builder: (_)=>const PersonalDocuments()));
                                    // }
                                    // if(index==1){
                                    //   Navigator.push(context, MaterialPageRoute(builder: (_)=>const EmergencyContact()));
                                    // }
                                    // // if(index==2){
                                    // //   Navigator.push(context, MaterialPageRoute(builder: (_)=>const WorkPreference()));
                                    // // }
                                    // if(index==2){
                                    //   Navigator.push(context, MaterialPageRoute(builder: (_)=> const VehicleDetails()));
                                    // }
                                    // if(index==3){
                                    //   Navigator.push(context,MaterialPageRoute(builder: (_)=>const BankAccountDetails()));
                                    // }
                                  },
                                  child: Container(
                                    height: 70,
                                    child: Card(
                                      color: Colors.white,
                                      elevation: 1,
                                      child: Container(
                                        margin: const EdgeInsets.all(15),
                                        alignment: Alignment.center,
                                        height: 50,
                                        width: 380,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.transparent),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                // const Icon(Icons.check,color: Constant.primary,),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  authController
                                                          .CompleteddocumentList![
                                                      index],
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                            const Icon(
                                              Icons.check,
                                              color: Constant.primary,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Obx(
                            () => authController
                                        .CompleteddocumentList!.length >=
                                    5
                                ? Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
                                    alignment: Alignment.center,
                                    height: 50,
                                    width: 380,
                                    decoration: BoxDecoration(
                                        color: Constant.primary,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: TextButton(
                                      onPressed: () async {
                                        OTPResponse? profileData =
                                            await authController
                                                .getProfileData();

                                        if (profileData != null &&
                                            authController
                                                    .CompleteddocumentList!
                                                    .length >=
                                                5) {
                                          if (profileData.data!.isVerified !=
                                              false) {
                                            authController
                                                .CompleteddocumentList!
                                                .clear();
                                            authController.documentList.clear();
                                            Get.offAll(
                                                const BottomNavigation());
                                          } else {
                                            authController
                                                .CompleteddocumentList!
                                                .clear();
                                            authController.documentList.clear();
                                            Get.offAll(const VerifyingPage());
                                          }
                                        } else {
                                          Fluttertoast.showToast(
                                              msg:
                                                  "Verification failed try again",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                        }
                                        // if (authController.CompleteddocumentList!.length >= 5) {
                                        //   if(profileController.profileDataHome.value.isVerified=true){
                                        //
                                        //   }else{
                                        //
                                        //   }
                                        //
                                        // }
                                        // Navigator.pushReplacement(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (_) => const BottomNavigation()));
                                      },
                                      child: const Text(
                                        ' Next',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 20),
                                      ),
                                    ),
                                  )
                                : Container(),
                          )
                        ],
                      ),
                    ],
                  )
            )
          ],
        ),
      ),
    ));
  }
}
