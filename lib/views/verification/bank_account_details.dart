import 'package:dunzodriver_copy1/constant/color.dart';
import 'package:dunzodriver_copy1/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BankAccountDetails extends StatefulWidget {
  const BankAccountDetails({Key? key}) : super(key: key);

  @override
  _BankAccountDetailsState createState() => _BankAccountDetailsState();
}

class _BankAccountDetailsState extends State<BankAccountDetails> {
  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Form(
      key: authController.bankDetailsFormKey,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 12, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Bank Account details',
                  style: TextStyle(
                    // fontFamily: 'Source Sans Pro',
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  child: const Text(
                    'Please tell us your account details where we will transact your earning',
                    style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                 Text(
                  'Bank Name',
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                  ),
                ),
                Container(
                  margin:
                  const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                  padding: const EdgeInsets.only(left: 10, bottom: 5),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius:
                      const BorderRadius.all(Radius.circular(10))),
                  child: TextFormField(
                    controller: authController.myControllerBankName,
                    onChanged: (value) {
                      authController.BankName = value;
                      authController.isCompleted = true;
                    },
                    onFieldSubmitted: (value) {
                      print('  Bank Name text field : $value');
                    },
                    validator: (value) {
                      if (value!.isEmpty ) {
                        return 'Enter Bank Name';

                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: ('e.g.PNB'),
                        hintStyle: TextStyle(color: Colors.grey)),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                 Text(
                  'IFSC Code',
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  margin:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  padding: const EdgeInsets.only(left: 10, bottom: 5),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius:
                      const BorderRadius.all(Radius.circular(10))),
                  child: TextFormField(
                    controller: authController.myControllerIFSCCode,
                    onChanged: (value) {
                      authController.IFSCCode = value;
                    },
                    onFieldSubmitted: (value) {
                      print('  IFSC CODE text field : $value');
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter IFSC Code';

                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: ('e.g.SIBN0004839'),
                        hintStyle: TextStyle(color: Colors.grey)),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                 Text(
                  'Bank Account Number',
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  margin:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  padding: const EdgeInsets.only(left: 10, bottom: 5),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius:
                      const BorderRadius.all(Radius.circular(10))),
                  child: TextFormField(
                    controller: authController.myControllerBankAccountNumber,
                    onChanged: (value) {
                      authController.AccountNumber = value;
                    },
                    onFieldSubmitted: (value) {
                      print('  Bank Account text field : $value');
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Bank Account Number';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: ('e.g.48422010299930'),
                        hintStyle: TextStyle(color: Colors.grey)),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                 Text(
                  'Branch Name',
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  margin:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  padding: const EdgeInsets.only(left: 10, bottom: 5),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius:
                      const BorderRadius.all(Radius.circular(10))),
                  child: TextFormField(
                    controller: authController.myControllerBranchName,
                    onChanged: (value) {
                      authController.BranchName = value;
                    },
                    onFieldSubmitted: (value) {
                      print(' Branch Name text field : $value');
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Branch Name';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: ('e.g. Area '),
                        hintStyle: TextStyle(color: Colors.grey)),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                InkWell(
                  onTap: () async {
                    if (authController.bankDetailsFormKey.currentState!
                        .validate()) {
                      if (authController.isCompleted) {

                      }
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
                      print('before response');

                      final response =
                          await authController.uploadBankAccountDetails();
                      (authController.isCompleted)
                          ? authController
                              .uploadBankAccountDetails()
                              .then((value) {
                              if (response) {
                                Get.back();
                                Get.back();
                                AlertDialog alert = AlertDialog(
                                  title: const Text(
                                      "Upload Bank Account Documents"),
                                  content: const Text(" Successfully "),
                                  actions: [
                                    TextButton(
                                      child: const Text('Ok'),
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
                                AlertDialog alert = const AlertDialog(
                                  title: Text("Upload Bank Account Documents"),
                                  content: Text(" Unsuccessfully "),
                                  actions: [],
                                );
                                // show the dialog
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return alert;
                                  },
                                );
                              }
                            })
                          : null;
                      if (authController.bankDetailsFormKey.currentState!
                          .validate()) {
                        if (authController.isCompleted) {}
                      }
                    }
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 10,
                    color: Constant.primary,
                    child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: 360,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
