import 'package:dunzodriver_copy1/api/api_routes.dart';
import 'package:dunzodriver_copy1/constant/color.dart';
import 'package:dunzodriver_copy1/controller/profile_controller.dart';
import 'package:dunzodriver_copy1/views/navigation_pages/settingpages/edit_profile.dart';
import 'package:dunzodriver_copy1/views/navigation_pages/settingpages/about_us.dart';
import 'package:dunzodriver_copy1/views/navigation_pages/settingpages/privacy_polocy.dart';
import 'package:dunzodriver_copy1/views/navigation_pages/settingpages/term_conditions_page.dart';
import 'package:dunzodriver_copy1/views/verification/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  ProfileController profileController = Get.find();

  @override
  void initState() {
    super.initState();
    profileController.profileData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          elevation: 10,
          backgroundColor: Constant.secondary,
          title: const Text(
            'Setting',
            style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.normal,
                fontFamily: 'Source Sans Pro'),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 0),
                child: Column(
                  children: [
                    Center(
                        child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Obx(() => Image.network(
                            // "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRh6oPIzWAVL6bJTbPZ4N2paZ1xpqti-QRj7g&usqp=CAU",
                                (profileController
                                        .profileDataHome.value.profileImg!
                                        .contains("https"))
                                    ? profileController
                                        .profileDataHome.value.profileImg!
                                    : ApiRoutes.BASE_URL +
                                        profileController
                                            .profileDataHome.value.profileImg!,
                                height: 80.0,
                                width: 80.0,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container();
                                },
                                // loadingBuilder:
                                //     (context, child, loadingProgress) {
                                //   return loadingProgress.expectedTotalBytes=const CircularProgressIndicator(
                                //     color: Constant.secondary,
                                //   );
                                // },
                              )),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Obx(
                              () => Text(
                                (profileController.profileDataHome.value.name !=
                                        null)
                                    ? profileController
                                        .profileDataHome.value.name!
                                    : "",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Obx(() => Text(
                              "Partner Id #${profileController.profileDataHome.value.id}",
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ))
                      ],
                    )),
                    const SizedBox(height: 30),
                    Center(
                        child: Container(
                      alignment: Alignment.topCenter,
                      width: 350,
                      color: Colors.grey.shade200,
                      child: Card(
                          elevation: 10.0,
                          // this field changes the shadow of the card 1.0 is default
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(width: 0.5),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 40.0,
                                ),
                                InkWell(
                                  onTap: () async {
                                    profileController.profileData();
                                    Get.to(const EditProfile());
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: const [
                                          Icon(Icons.person_outlined,
                                              color: Constant.secondary),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text('Edit Profile'),
                                        ],
                                      ),
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 15,
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        launch(
                                          "${profileController.storedSettingData.value.data!=null?
                                          profileController.storedSettingData.value.data!.contactPhone!:"Error"}"
                                            'mailto:support@wedun.in?subject=Help&body=Write your query to us.');
                                        // showModalBottomSheet<void>(
                                        //   backgroundColor: Colors.grey.shade300,
                                        //   elevation: 10,
                                        //   barrierColor: Colors.transparent,
                                        //   useRootNavigator: true,
                                        //   // context and builder are
                                        //   // required properties in this widget
                                        //   context: context,
                                        //   builder: (BuildContext context,) {
                                        //
                                        //     // we set up a container inside which
                                        //     // we create center column and display text
                                        //     return Container(
                                        //       height: 150,
                                        //       child: Column(
                                        //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        //         children:  <Widget>[
                                        //           Padding(
                                        //             padding: const EdgeInsets.all(16.0),
                                        //             child: Row(
                                        //               children: const [
                                        //                 Icon(Icons.phone,color: Constant.secondary,),
                                        //                 SizedBox(width: 20,),
                                        //                 Text('Phone',style: TextStyle(
                                        //                   color: Colors.black,
                                        //                   fontSize: 20,
                                        //                 ),),
                                        //               ],
                                        //             ),
                                        //           ),
                                        //           const Divider(thickness: 10,),
                                        //           Padding(
                                        //             padding: const EdgeInsets.all(16.0),
                                        //             child: Row(
                                        //               children: const [
                                        //                 Icon(Icons.mail,color: Constant.secondary,),
                                        //                 SizedBox(width: 20,),
                                        //                 Text('Gmail',style: TextStyle(
                                        //                   color: Colors.black,
                                        //                   fontSize: 20,
                                        //                 ),),
                                        //               ],
                                        //             ),
                                        //           ),
                                        //         ],
                                        //       ),
                                        //     );
                                        //   },
                                        // );
                                      },
                                      child: Row(
                                        children: const [
                                          Icon(Icons.support_agent,
                                              color: Constant.secondary),
                                          SizedBox(width: 20),
                                          Text('Support Centre'),
                                          SizedBox(width: 150),
                                        ],
                                      ),
                                    ),
                                    const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 15,
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.to(const TermAndConditions());
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: const [
                                          Icon(Icons.assignment,
                                              color: Constant.secondary),
                                          SizedBox(width: 20),
                                          Text('Terms & Conditions'),
                                        ],
                                      ),
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 15,
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.to(PrivacyPolicy());
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: const [
                                          Icon(Icons.privacy_tip_outlined,
                                              color: Constant.secondary),
                                          SizedBox(width: 20),
                                          Text('Privacy Policy'),
                                        ],
                                      ),
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 15,
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.to(AboutUs());
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: const [
                                          Icon(Icons.info_outline_rounded,
                                              color: Constant.secondary),
                                          SizedBox(width: 20),
                                          Text('About Us'),
                                        ],
                                      ),
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 15,
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                InkWell(
                                  onTap: () async {
                                    SharedPreferences prefs = await SharedPreferences.getInstance();
                                    prefs.setString("access_token", "");
                                    Get.offAll(() => const DunzoPartner());
                                    // Navigator.pushReplacement(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (_) =>
                                    //             const DunzoPartner()));
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: const [
                                          Icon(
                                            Icons.person,
                                            color: Constant.secondary,
                                          ),
                                          SizedBox(width: 20),
                                          Text('Logout'),
                                          SizedBox(
                                            width: 25,
                                          ),
                                        ],
                                      ),
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 15,
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 50.0),
                                Text(
                                    'Version ${profileController.storedSettingData.value.data != null ? profileController.storedSettingData.value.data!.driverAndroidVersion : "1.0.0"}'),
                                const SizedBox(height: 30),
                              ],
                            ),
                          )),
                    )),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
