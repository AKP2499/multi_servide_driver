import 'dart:io';
import 'package:dunzodriver_copy1/views/verification/panding_document_verification.dart';
import 'package:intl/intl.dart';
import 'package:dunzodriver_copy1/constant/color.dart';
import 'package:dunzodriver_copy1/controller/auth_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class PersonalInformation extends StatefulWidget {
  const PersonalInformation({Key? key}) : super(key: key);

  @override
  _PersonalInformationState createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  AuthController authController = Get.find();
  @override
  void initState() {
    // TODO: implement initState
    print('nskjbskb');
    super.initState();

  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: authController.personalInfoFormKey,
      child:Obx(()=> Scaffold(
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(left: 15, top: 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Text(
                        'Personal information',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Enter the details below so we can',
                    style: TextStyle(fontSize: 17, color: Colors.black87),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'get to know and serve you better',
                    style: TextStyle(fontSize: 17, color: Colors.black87),
                  ),
                  const SizedBox(height: 20),
                  const Text('Primary mobile number'),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(1,10 , 20, 4.0),
                    child: Container(
                      margin:const EdgeInsets.only(top: 4,left: 4),
                      child: TextFormField(
                        enabled: false,
                          controller: authController.myControllerPhone,
                          onFieldSubmitted: (value) {
                            print('First text field : $value');
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Constant.primary)),
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
                    padding: const EdgeInsets.fromLTRB(1,10 , 20, 4.0),
                    child: Container(
                      margin: const EdgeInsets.only(top: 4,left: 4),
                      child: TextFormField(
                        onChanged: (value){
                          authController.secondaryphone=value;
                        },
                         controller: authController.myControllerSecondPhone,
                        onFieldSubmitted: (value) {
                          print('Second text field : $value');
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
                              borderSide: BorderSide(color: Constant.primary)),
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
                    padding: const EdgeInsets.fromLTRB(1,10 , 20, 4.0),
                    child: Container(
                      margin: const EdgeInsets.only(top: 4,left: 4 ),
                      child: TextFormField(
                        onChanged: (value){
                          authController.name=value;
                        },
                        controller: authController.myControllerName,
                        onFieldSubmitted: (value) {
                          print('Third text field : $value');
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
                              borderSide: BorderSide(color: Constant.primary)),
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
                        controller: authController.myControllerEmail,
                        onChanged: (value){
                          authController.email=value;
                        },
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
                  // const Text('Last name'),
                  // Padding(
                  //   padding: const EdgeInsets.fromLTRB(1,10 , 20, 4.0),
                  //   child: Container(
                  //     margin: const EdgeInsets.only(top: 10,left: 4 ),
                  //     child: TextFormField(
                  //       controller: authController.myControllerLastName,
                  //       onFieldSubmitted: (value) {
                  //         print('Forth text field : $value');
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
                  //         hintText: 'e.g.Kalyan ',
                  //         hintStyle: const TextStyle(color: Colors.grey),
                  //       ),
                  //     ),
                  //   ),
                  // ),
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
                            return Column(crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  height: MediaQuery.of(context).copyWith().size.height*0.25,
                                  color: Colors.white,
                                  child: CupertinoTheme(
                                    data:  const CupertinoThemeData(
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
                                            authController.selectedDate.value = value;
                                            authController.myControllerDOB.text = DateFormat('yyyy-MM-dd').format(authController.selectedDate.value);
                                          });
                                        }
                                      },
                                      initialDateTime: authController.selectedDate.value,
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
                                    onPressed: () =>Navigator.pop(context)
                                  ),
                                )
                              ],
                            );
                          }
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(1, 10, 20, 4.0),
                      child: Container(
                        padding: const EdgeInsets.only(top: 10,left: 4),
                        child: TextFormField(
                          onChanged: (value){
                            authController.Dob=value;
                          },
                          controller: authController.myControllerDOB,
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
                                borderSide: BorderSide(color: Constant.primary)),
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
                  // const Text('City'),
                  // const SizedBox(height: 5),
                  // Padding(
                  //   padding: const EdgeInsets.fromLTRB(4, 6, 20, 10),
                  //   child: Container(
                  //     padding: const EdgeInsets.only(top: 5,left: 10),
                  //     height: 60,
                  //     decoration: BoxDecoration(
                  //         color: Colors.white,
                  //         borderRadius: BorderRadius.circular(10),
                  //         border: Border.all(color: Colors.grey)),
                  //     child: Column(
                  //       children: [
                  //         DropdownButton<String>(
                  //           underline: const Padding(
                  //             padding: EdgeInsets.all(5),
                  //           ),
                  //           isExpanded: true,
                  //           hint: const Text(
                  //             "City",
                  //             style: TextStyle(color: Colors.grey),
                  //           ),
                  //           style: const TextStyle(color: Colors.black),
                  //           value: authController.selectedCity!.value,
                  //           items: <String>[
                  //             'Noida',
                  //             'Muzaffarnagar',
                  //             'Meerut',
                  //             'Delhi',
                  //           ].map((String value) {
                  //             return DropdownMenuItem<String>(
                  //               child: SizedBox(
                  //                 width: 100,
                  //                 child: Text(
                  //                   value,
                  //                   style: const TextStyle(color: Colors.black),
                  //                 ),
                  //               ),
                  //               value: value,
                  //             );
                  //           }).toList(),
                  //           onChanged: (value) {
                  //             setState(() {
                  //               authController.selectedCity!.value = value!;
                  //             });
                  //           },
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(height: 5),
                  // const Text('Complete address'),
                  // Padding(
                  //   padding: const EdgeInsets.fromLTRB(1, 10, 20, 4.0),
                  //   child: Container(
                  //     padding: const EdgeInsets.only(top: 10,left: 4),
                  //     height: 90,
                  //     child: TextFormField(
                  //       onChanged: (value){
                  //         setState(() {
                  //           authController.isCompleted=true;
                  //         });
                  //       },
                  //       controller: authController.myControllerAddress,
                  //       onFieldSubmitted: (value) {
                  //         print('Address text field : $value');
                  //       },
                  //       validator: (value) {
                  //         if (value!.isEmpty) {
                  //           return 'Enter Invalid Address ';
                  //         }
                  //         return null;
                  //       },
                  //       decoration: InputDecoration(
                  //         focusedBorder: const OutlineInputBorder(
                  //             borderSide: BorderSide(color: Constant.primary)),
                  //         border: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(10),
                  //         ),
                  //         hintText: 'Search address',
                  //         hintStyle: const TextStyle(color: Colors.grey),
                  //         // suffixIcon: const Icon(
                  //         //   Icons.navigate_next_rounded,
                  //         //   color: Constant.secondary,
                  //         // ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(height: 5),
                  // const Text('Languages you know'),
                  // const SizedBox(height: 5),

                  const Text('Language'),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(1,10 , 20, 4.0),
                    child: Container(
                      padding: const EdgeInsets.only(top: 4,left: 10),
                      height: 60,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey)),
                      child: DropdownButton<String>(
                        onTap: (){
                          FocusScope.of(context).unfocus();
                        },
                        value:  authController.selectedLanguage!.value,
                        underline:const Padding(
                          padding: EdgeInsets.all(5),
                        ),
                        isExpanded: true,
                        hint: const Text(
                          "language",
                          style: TextStyle(color: Colors.grey),
                        ),
                        style: const TextStyle(color: Colors.black),
                        items: <String>[
                          'Select',
                          'Hindi',
                          'English',
                          'Kannada',
                          'Both Hindi & English'
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            child: SizedBox(
                              width: 100,
                              child: Text(
                               value,
                                style: const TextStyle(color: Colors.black),
                                  textAlign: TextAlign.center
                              ),
                            ),
                            value:  value,
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            authController.language=value;
                            authController.isCompleted=true;
                            authController.selectedLanguage!.value = value!;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text('Your profile picture'),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(1,10 , 20, 4.0),
                    child: Container(
                      margin: const EdgeInsets.only(top: 4,left: 4),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: const BorderRadius.all(Radius.circular(10))),
                      height: 100,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Obx(() =>
                          (authController.isImageSelected!.value)
                              ?Image.file(
                            File(authController.image!.value.path),
                            width: 70,
                            height: 70,
                          ):Image.asset(
                            'lib/Images/icons8-name.gif',
                            height: 80,
                            width: 80,
                          ),),
                          const SizedBox(
                            width: 10,
                          ),
                          authController.isImageSelected!.value
                              ? InkWell(
                            onTap: () {
                              authController.isImageSelected!.value = false;
                              authController.isCompleted=true;
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
                              width: 200,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.photo_camera,
                                    size: 30,
                                    color: Constant.primary,
                                  ),
                                  const SizedBox(width: 5,),
                                  TextButton(
                                      onPressed: authController.getImage,
                                      child: const Text(
                                        'Upload Photo',
                                        style: TextStyle(
                                            color: Constant.primary, fontSize: 20),
                                      ))
                                ],
                              )),
                        ],
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
                        color: (authController.isCompleted)?Constant.primary:Colors.grey,
                        borderRadius: BorderRadius.circular(10)),
                    child: TextButton(
                      onPressed: () {
                        if(authController.personalInfoFormKey.currentState!.validate()){
                          (authController.isCompleted)?
                          authController.profileData().then((value){
                            if(value){
                              authController.CompleteddocumentList!.add("Personal Info");
                              authController.documentList.remove("Personal Info");
                              Get.offAll(const PendingDocument());
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (_) => const PendingDocument()));
                            }else{

                            }
                          }):null;
                        }
                        // if(){
                        //   if(authController.isCompleted){
                        //
                        //   }
                        // }
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (_) => const PendingDocument()));
                      },
                      child: const Text(
                        'Submit and Next',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ))
      )
    );
  }
}