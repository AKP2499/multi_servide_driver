import 'package:dunzodriver_copy1/constant/color.dart';
import 'package:dunzodriver_copy1/controller/auth_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:get/get.dart';

class EmergencyContact extends StatefulWidget {
  const EmergencyContact({Key? key}) : super(key: key);

  @override
  _EmergencyContactState createState() => _EmergencyContactState();
}

class _EmergencyContactState extends State<EmergencyContact> {
  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Form(
      key: authController.emergencyContactFormKey,
      child: Scaffold(
        key: authController.formKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Emergency contact details',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Provide contact details of someone you trust',
                    style: TextStyle(
                        color: Colors.grey,
                        letterSpacing: .7,
                        fontSize: 15,
                        fontWeight: FontWeight.w700),
                  ),
                  const Text(
                    'as an emergency contact',
                    style: TextStyle(
                        color: Colors.grey,
                        letterSpacing: .7,
                        fontSize: 15,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                   Text(
                    'Emergency contact number',
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      letterSpacing: .5,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                    padding: const EdgeInsets.only(left: 10, bottom: 5,top: 5),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius:
                        const BorderRadius.all(Radius.circular(10))),
                    child: TextFormField(
                      maxLength: 10,
                      buildCounter: (context, {required currentLength, required isFocused, maxLength}) {
                      },
                      onChanged: (value) {
                        authController.EmergencyContactNumber = value;
                        authController.isCompleted = true;
                      },
                      keyboardType: TextInputType.number,
                      controller: authController.myControllerEmergencyNumber,
                      onFieldSubmitted: (value) {
                        print('Second text field : $value');
                      },
                      validator: (value){
                        if(value!.isEmpty && value.length != 10){

                          return 'Enter invalid number';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(left: 0,top: 13),
                            child: Text('+91'),
                          ),
                          border: InputBorder.none,
                          hintText: ('9999999523'),
                          hintStyle: TextStyle(color: Colors.grey)),
                    ),
                  ),
                  const SizedBox(height: 5,),
                   Text('Emergency contact name',
                      style: TextStyle(
                          color: Colors.grey.shade700,
                          letterSpacing: .7,
                          fontSize: 15,
                          fontWeight: FontWeight.w700)),
                  const SizedBox(height: 5,),
                  Container(
                    margin:
                    const EdgeInsets.symmetric(vertical: 1, horizontal: 0),
                    padding: const EdgeInsets.only(left: 10, bottom: 10),

                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius:
                        const BorderRadius.all(Radius.circular(10))),
                    child: TextFormField(
                      onChanged: (value) {
                        authController.EmergencyContactName = value;
                        authController.isCompleted = true;
                      },
                      controller:authController.myControllerEmergencyContactName,
                      onFieldSubmitted: (value) {
                        print(' Emergency name text field : $value');
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Invalid Text';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: ('e.g.Manjunath'),
                          hintStyle: TextStyle(color: Colors.grey)),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                   Text('Your relation',
                      style: TextStyle(
                          color: Colors.grey.shade700,
                          letterSpacing: .7,
                          fontSize: 15,
                          fontWeight: FontWeight.w700)),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    margin:
                    const EdgeInsets.symmetric(vertical: 1, horizontal: 0),
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius:
                        const BorderRadius.all(Radius.circular(10))),
                    child: TextFormField(
                      onChanged: (value) {
                        authController.YourRelation = value;
                        authController.isCompleted = true;
                      },
                      controller: authController.myControllerRelation,
                      onFieldSubmitted: (value) {
                        print(' Relation  text field : $value');
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Invalid Text';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: (' e.g.Father'),
                          hintStyle: TextStyle(color: Colors.grey)),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  InkWell(
                    onTap: () {
                      if (authController.formKey.currentState!.validate()) {
                        print('myControllerEmergencyNumber');
                        print(' myControllerEmergencyContactName');
                      }
                    },
                    child: InkWell(
                      onTap: () async {
                        if (authController.emergencyContactFormKey.currentState!.validate()) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Center(
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  child: const CircularProgressIndicator(
                                    color: Constant.primary,
                                  ),
                                ),
                              );
                            },
                          );
                          final response = await authController.emergencyContactDetails();
                          if (response) {
                            Get.back();
                            Get.back();
                            AlertDialog alert = AlertDialog(
                              title: const Text(
                                  "Upload Emergency Contact Details"),
                              content: const Text(" Successfully "),
                              actions: [
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Get.back();
                                  },
                                ),
                              ],
                            );
                            // show the dialog
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return alert;
                              },
                            );
                          } else {
                            Get.back();
                            AlertDialog alert = AlertDialog(
                              title: const Text(
                                  "Upload Emergency Contact Details"),
                              content: const Text(" Unsuccessfully "),
                              actions: [
                                TextButton(
                                  child: const Text('Try Again'),
                                  onPressed: () {
                                    Get.back();
                                  },
                                ),
                              ],
                            );
                            // show the dialog
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return alert;
                              },
                            );
                          }
                        }
                      },
                      child: Container(
                        color: Colors.white,
                        height: 230,
                        alignment: Alignment.bottomCenter,
                        child: Card(
                          margin: const EdgeInsets.only(right: 0.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 10,
                          color: Constant.primary,
                          child: Container(
                              alignment: Alignment.center,
                              height: 50,
                              width: 360,
                              decoration: BoxDecoration(
                                  color: (authController.isCompleted)
                                      ? Constant.primary
                                      : Colors.grey,
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Text(
                                'Submit and Next',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontStyle: FontStyle.normal),
                              )),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
//
