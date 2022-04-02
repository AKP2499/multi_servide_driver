import 'dart:io';
import 'package:dunzodriver_copy1/controller/auth_controller.dart';
import 'package:dunzodriver_copy1/controller/profile_controller.dart';
import 'package:intl/intl.dart';
import 'package:dunzodriver_copy1/constant/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  AuthController authController = Get.find();
  ProfileController profileController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    profileController.profileData();
  }
  @override
  Widget build(BuildContext context) {
    return Form(
        key: profileController.personalInfoEditFormKey,
        child: Obx(() => Scaffold(
            appBar: AppBar(
              backgroundColor: Constant.primary,
              title: Row(
                children: const [
                  Text(
                    'Edit Profile',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(left: 15, top: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Row(
                    //   children: const [
                    //     Text(
                    //       'Edit Profile',
                    //       style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    //     ),
                    //   ],
                    // ),
                    // const SizedBox(height: 15),
                    // const Text(
                    //   'Enter the details below so we can',
                    //   style: TextStyle(fontSize: 17, color: Colors.black87),
                    // ),
                    // const SizedBox(height: 5),
                    // const Text(
                    //   'get to know and serve you better',
                    //   style: TextStyle(fontSize: 17, color: Colors.black87),
                    // ),
                    // const SizedBox(height: 20),
                    const Text('Primary mobile number'),
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(1, 10, 20, 4.0),
                      child: Container(
                        margin: const EdgeInsets.only(top: 4, left: 4),
                        child: TextFormField(
                            enabled: false,
                            controller: authController.myControllerPhone,
                            onFieldSubmitted: (value) {
                              print('First text field : $value');
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Constant.primary)),
                              prefixIcon: const Padding(
                                padding: EdgeInsets.all(15),
                                child: Text('+91 '),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: 'e.g.8265914635',
                              hintStyle: const TextStyle(color: Colors.grey),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter correct value';
                              }
                              return null;
                            }),
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text('Secondary mobile number'),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(1, 0, 20, 4.0),
                      child: Container(
                        margin: const EdgeInsets.only(top: 4, left: 4),
                        child: TextFormField(
                          controller: profileController.myControllerSecondPhone,
                          onFieldSubmitted: (value) {
                            print('Second text field : $value');
                            if (value != null) {
                              setState(() {
                                profileController.secondPhone = value;
                                profileController.myControllerSecondPhone.text =
                                    value;
                                print(profileController
                                    .myControllerSecondPhone.text);
                              });
                            }
                          },
                          validator: (value) {
                            if (value!.isNotEmpty && value.length == 10) {
                              return null;
                            }
                            return "Enter correct value";
                          },
                          maxLength: 10,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Constant.primary)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: 'e.g.9999888777 ',
                            hintStyle: const TextStyle(color: Colors.grey),
                            prefixIcon: const Padding(
                              padding: EdgeInsets.all(15),
                              child: Text('+91 '),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Text('Full name'),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(1, 0, 20, 4.0),
                      child: Container(
                        margin: const EdgeInsets.only(top: 4, left: 4),
                        child: TextFormField(
                          controller: profileController.myControllerName,
                          onFieldSubmitted: (value) {
                            print('Third text field : $value');
                            if (value != null) {
                              setState(() {
                                profileController.name = value;
                                profileController.myControllerName.text = value;
                                print(profileController.myControllerName.text);
                              });
                            }
                          },
                          validator: (text) {
                            if (text!.isEmpty) {
                              return 'Enter Invalid Text';
                            }
                            return null;
                          },
                          autofocus: false,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Constant.primary)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: 'e.g.Manjunath ',
                            hintStyle: const TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text('Email'),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(1,0, 20, 4.0),
                      child: Container(
                        margin: const EdgeInsets.only(top: 10,left: 4 ),
                        child: TextFormField(
                          controller: profileController.myControllerEmail,
                          onFieldSubmitted: (value) {
                            print('Forth text field : $value');
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Invalid Text';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Constant.primary)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: 'e.g.Kalyan@gmail.com',
                            hintStyle: const TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                    // const SizedBox(height: 5),
                    // const Text('Father name'),
                    // Padding(
                    //   padding: const EdgeInsets.fromLTRB(1,10 , 20, 4.0),
                    //   child: Container(
                    //     margin: const EdgeInsets.only(top: 10,left: 4),
                    //     child: TextFormField(
                    //       controller: authController.myControllerFatherName,
                    //       onFieldSubmitted: (value) {
                    //         print('Third text field : $value');
                    //       },
                    //       validator: (value) {
                    //         if (value!.isEmpty) {
                    //           return 'Invalid Text';
                    //         }
                    //         return null;
                    //       },
                    //       keyboardType: TextInputType.text,
                    //       decoration: InputDecoration(
                    //         focusedBorder: const OutlineInputBorder(
                    //             borderSide: BorderSide(color: Constant.primary)),
                    //         border: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(10),
                    //         ),
                    //         hintText: 'e.g.Suresh Sharma ',
                    //         hintStyle: const TextStyle(color: Colors.grey),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(height: 10),
                    const Text('Date of birth'),
                    InkWell(
                      onTap: () async {
                        FocusScope.of(context).unfocus();
                        showCupertinoModalPopup(
                            context: context,
                            builder: (BuildContext builder) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    height: MediaQuery.of(context)
                                            .copyWith().size.height * 0.25,
                                    color: Colors.white,
                                    child: CupertinoTheme(
                                      data: const CupertinoThemeData(
                                        brightness: Brightness.light,
                                        textTheme: CupertinoTextThemeData(
                                          dateTimePickerTextStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0,
                                          ),
                                        ),
                                      ),
                                      child: CupertinoDatePicker(
                                        backgroundColor: Constant.primary,
                                        mode: CupertinoDatePickerMode.date,
                                        onDateTimeChanged: (value) {
                                          if (value != null) {
                                            setState(() {
                                              profileController
                                                  .selectedDate.value = value;
                                              profileController
                                                      .myControllerDOB.text =
                                                  DateFormat('yyyy-MM-dd')
                                                      .format(profileController
                                                          .selectedDate.value);
                                              print(profileController
                                                  .selectedDate.value);
                                            });
                                          }
                                        },
                                        initialDateTime: DateTime.now(),
                                        minimumYear: 1970,
                                        maximumYear: 2022,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 450,
                                    child: CupertinoButton(
                                        color: Constant.primary,
                                        child: const Text('OK'),
                                        onPressed: () =>
                                            Navigator.pop(context)),
                                  )
                                ],
                              );
                            });
                        // DateTime? datePicked = await DatePicker.showSimpleDatePicker(
                        //     context,
                        //     initialDate: DateTime(1994),
                        //     firstDate: DateTime(1960),
                        //     lastDate: DateTime(2021),
                        //     dateFormat: "DD-MMMM-YYYY",
                        //     locale: DateTimePickerLocale.en_us,
                        //     looping: true,
                        //     textColor: Constant.primary);
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(1, 0, 20, 4.0),
                        child: Container(
                          padding: const EdgeInsets.only(top: 10, left: 4),
                          child: TextFormField(
                            controller: profileController.myControllerDOB,
                            onFieldSubmitted: (value) {
                              print('DOB text field : $value');
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter Date of Birth ';
                              }
                              return null;
                            },
                            enabled: false,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Constant.primary)),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: 'dd-mm-yyyy',
                              hintStyle: const TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text('Language'),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(1, 10, 20, 4.0),
                      child: Container(
                        padding: const EdgeInsets.only(top: 4, left: 10),
                        height: 60,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey)),
                        child: Obx(() => DropdownButton<String>(
                              onTap: () {
                                FocusScope.of(context).unfocus();
                              },
                              value: profileController
                                          .selectedLanguageEdit!.value ==
                                      "Both Hindi & English"
                                  ? "English"
                                  : profileController
                                      .selectedLanguageEdit!.value,
                              underline: const Padding(
                                padding: EdgeInsets.all(5),
                              ),
                              isExpanded: true,
                              hint: const Text(
                                "language",
                                style: TextStyle(color: Colors.grey),
                              ),
                              style: const TextStyle(color: Colors.black),
                              items: <String>[
                                'Hindi',
                                'English',
                                'Kannada',
                              ].map((String value) {
                                return DropdownMenuItem<String>(
                                  child: SizedBox(
                                    width: 100,
                                    child: Text(value,
                                        style: const TextStyle(
                                            color: Colors.black),
                                        textAlign: TextAlign.center),
                                  ),
                                  value: value,
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  print("language");
                                  profileController.languages = value;
                                  // profileController.isCompleted!.value = true;
                                  profileController
                                      .selectedLanguageEdit!.value = value!;
                                  print(profileController.selectedLanguageEdit);
                                });
                              },
                            )),
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text('Your profile picture'),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(1, 10, 20, 4.0),
                      child: Container(
                        margin: const EdgeInsets.only(top: 4, left: 4),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        height: 100,
                        child: Obx(
                          () => Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              (profileController.isImageSelected!.value &&
                                      profileController.image!.value.path !=null &&
                                      profileController.image!.value.path.isNotEmpty)
                                  ? Image.file(
                                      File(profileController.image != null
                                          ? profileController.image!.value.path
                                          : ""),
                                      width: 70,
                                      height: 70,
                                    )
                                  : Image.asset(
                                      'lib/Images/icons8-name.gif',
                                      height: 80,
                                      width: 80,
                                    ),
                              // Image.network(
                              //   (profileController.profileDataHome.value.profileImg!.contains("https"))
                              //       ?profileController.profileDataHome.value.profileImg!
                              //       :ApiRoutes.BASE_URL + "/" + profileController.profileDataHome.value.profileImg!,
                              //   height: 80.0,
                              //   width: 80.0,
                              // )
                              const SizedBox(
                                width: 10,
                              ),
                              profileController.isImageSelected!.value
                                  ? InkWell(
                                      onTap: () {
                                        profileController.isImageSelected!.value = false;
                                        profileController.isCompleted!.value =
                                            true;
                                        setState(() {});
                                      },
                                      child: const Icon(
                                        Icons.remove_circle,
                                        color: Colors.red,
                                        size: 30,
                                      ),
                                    )
                                  : Container(),
                              const SizedBox(
                                width: 20,
                              ),
                              Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width*0.46,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Row(
                                    children: [
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      const Icon(
                                        Icons.photo_camera,
                                        size: 30,
                                        color: Constant.primary,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      InkWell(
                                          onTap: profileController.getImage,
                                          child: const Text(
                                            'Upload Photo',
                                            style: TextStyle(
                                                color: Constant.primary,
                                                fontSize: 20,
                                              fontWeight: FontWeight.w600
                                            ),
                                          )
                                      )
                                    ],
                                  )
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      alignment: Alignment.center,
                      height: 50,
                      width: 380,
                      decoration: BoxDecoration(
                          color: (profileController.isCompleted!.value)
                              ? Constant.primary
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(100)),
                      child: TextButton(
                        onPressed: () async {
                          print("edit profile");
                          if (profileController
                              .personalInfoEditFormKey.currentState!
                              .validate()) {}
                          if (profileController.isCompleted!.value) {
                            await profileController.editProfileData();
                            print("editProfileData");
                            Get.back();
                          }
                        },
                        child: const Text(
                          'Edit Profile',
                          style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.normal),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            )
        )
        )
    );
  }
}
