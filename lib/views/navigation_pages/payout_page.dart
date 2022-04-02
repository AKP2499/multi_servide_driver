import 'package:dunzodriver_copy1/constant/color.dart';
import 'package:dunzodriver_copy1/controller/earning_controller.dart';
import 'package:dunzodriver_copy1/controller/profile_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Payout extends StatefulWidget {
  const Payout({Key? key}) : super(key: key);

  @override
  _PayoutState createState() => _PayoutState();
}

class _PayoutState extends State<Payout> {
  EarningController earningController= Get.put(EarningController());
  ProfileController profileController=Get.put(ProfileController());
  Future<Null> refresh() async{
    earningController.getAccessToken().then((value) =>
        earningController.driverEarning(value!,profileController.profileDataHome.value.id.toString()));
    earningController.update();
    earningController.driverWalletTrans(profileController.profileDataHome.value.id.toString());
    earningController.update();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title:  const Text(' Earning',style: TextStyle(
          color: Colors.white,
          // fontStyle: FontStyle.italic,
          letterSpacing: 1,
        ),),
        automaticallyImplyLeading: true,
        backgroundColor: Constant.secondary,
      ),
      body: RefreshIndicator(
        color: Constant.secondary,
        onRefresh: () {
          return refresh();
        },
        child: SingleChildScrollView(
          child: Obx(() =>
          (earningController.isEarningLoading.value)?
          Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Center(child: CircularProgressIndicator()),
              ],
            ),
          ):Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20,top: 20,bottom: 0,left: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    SizedBox(width: 20,),
                    Text("Start Date"),
                    SizedBox(width: 100,),
                    Text("End Date"),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: InkWell(
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
                                                earningController.selectedStartDate.value = value;
                                                earningController.myControllerStartDate.text = DateFormat('MMMM dd, yyyy').format(earningController.selectedStartDate.value);
                                              });
                                            }
                                          },
                                          initialDateTime: earningController.selectedStartDate.value,
                                          minimumYear: 2021,
                                          maximumYear: 2022,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }
                          );
                        },
                        child: TextFormField(
                          onChanged: (value){
                            earningController.Dob=value;
                          },
                          controller: earningController.myControllerStartDate,
                          onFieldSubmitted: (value) {
                            print('start date text field : $value');
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Start Date';
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
                    const SizedBox(width: 20,),
                    Expanded(
                      child: InkWell(
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
                                                earningController.selectedEndDate.value = value;
                                                earningController.myControllerEndDate.text = DateFormat('MMMM dd, yyyy').format(earningController.selectedEndDate.value);
                                              });
                                              // earningController.getAccessToken().then((value) =>  earningController.driverEarning(value!))

                                            }
                                          },
                                          initialDateTime: earningController.selectedEndDate.value,
                                          minimumYear: 2021,
                                          maximumYear: 2022,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }
                          );
                        },
                        child: TextFormField(
                          onChanged: (value){
                            earningController.Dob=value;
                          },
                          controller: earningController.myControllerEndDate,
                          onFieldSubmitted: (value) {
                            print('End date text field : $value');
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter EndDate';
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
                    const SizedBox(width: 20,),
                    InkWell(
                      onTap: () {
                        earningController.getAccessToken().then((value) =>
                            earningController.driverEarning(value!,profileController.profileDataHome.value.id.toString()));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                            color: Constant.secondaryTransparent,
                            borderRadius: BorderRadius.all(Radius.circular(15.0))),
                        child: const Text(
                          'Go',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Constant.primary,
                            fontFamily: 'Source Sans Pro',
                            fontSize: 17,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10,),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: (){
                            earningController.selectedEarning.value="EARNING";
                            earningController.getAccessToken().then((value) =>
                                earningController.driverEarning(value!,profileController.profileDataHome.value.id.toString()));
                            earningController.update();
                          },
                          child: Container(
                            margin: const EdgeInsets.only(left: 10, right: 10),
                            padding: const EdgeInsets.all(16),
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              shape: BoxShape.rectangle,
                              border: earningController.selectedEarning.value ==
                                  "EARNING"
                                  ? Border.all(color: Constant.secondary, width: 4)
                                  : Border.all(color: Constant.secondary, width: 0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children:[
                                const Text("Total Earning",style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold
                                ),),
                                const SizedBox(height: 20,),
                                Row(
                                  children:  [
                                    Obx(()=>
                                        Column(
                                          children: [
                                            Container(
                                              child: FittedBox(
                                                child: Text(
                                                  "₹${(earningController.earningList.value.earnings!=null)
                                                    ?int.parse(earningController.earningList.value.earnings!.toStringAsFixed(0)):""}",
                                                  style: const TextStyle(
                                                    color: Constant.secondary,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 25,
                                                  ),
                                                ),
                                                fit: BoxFit.fitWidth,
                                                alignment: Alignment.center,
                                              ),
                                            ),
                                          ],
                                        ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 10,),
                                // (earningController.earningList.value != null)?Row(
                                //   children: [
                                //     Text('${earningController.earningList.value.transactions!.length} tasks completed',
                                //       style: const TextStyle(
                                //         color: Colors.grey,
                                //         fontSize: 16,
                                //         letterSpacing: .5,
                                //       ),),
                                //   ],
                                // ):Container(),
                              ],

                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: (){
                            earningController.selectedEarning.value="CASH IN HAND";
                            earningController.driverWalletTrans(profileController.profileDataHome.value.id.toString());
                            earningController.update();
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 10, left: 10),
                            padding: const EdgeInsets.all(16),
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              shape: BoxShape.rectangle,
                              border: earningController.selectedEarning.value =="CASH IN HAND"
                                  ? Border.all(color: Constant.secondary, width: 4)
                                  : Border.all(color: Constant.secondary, width: 0),
                              color: ((
                                  profileController.storedSettingData.value.data!=null?
                                  profileController.storedSettingData.value.data!.driverBootcashLimit!:0.0)>=profileController.profileDataHome.value.cashInHand!)?
                              Colors.red:
                                  Colors.white
                            ),
                            child:
                                Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children:[
                                  const Text("Cash in Hand",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  Obx(()=>
                                     Text("Bootcash Limit ${profileController.storedSettingData.value.data!=null?
                                        profileController.storedSettingData.value.data!.driverBootcashLimit.toString().replaceAll("-","" ):0}",style: const TextStyle(
                                      fontSize: 10,
                                    ),),
                                  ),
                                  const SizedBox(height: 5.0,),
                                     Row(
                                      children:  [
                                            Obx(()=>
                                               Container(
                                                 child: FittedBox(
                                                   child: Text("₹${(profileController.profileDataHome.value.cashInHand!=null)
                                                      ?profileController.profileDataHome.value.cashInHand!.toStringAsFixed(0):""}",
                                                    style: const TextStyle(
                                                      color: Constant.secondary,
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                              ),
                                                 ),
                                               ),
                                            ),
                                      ],
                                    ),

                                  const SizedBox(height: 10,),
                                  InkWell(
                                    onTap: (){
                                      print("Pay Now!");
                                      showDialog(context: context, builder: (context){
                                        return AlertDialog(
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(16))),
                                          backgroundColor: Colors.white,
                                          title: const Text("Payment",
                                            style: TextStyle(
                                              color: Constant.primary,
                                              fontSize: 20,
                                              fontFamily: "Source Sans Pro",
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: .5
                                            ),
                                          ),
                                          content: TextField(
                                            cursorColor: Constant.secondary,
                                            keyboardType: TextInputType.number,
                                            style: const TextStyle(
                                              color: Colors.black,

                                            ),
                                            onChanged: (value){
                                              setState(() {
                                                // valueText=value;
                                              });
                                            },
                                            controller: earningController.myControllerPayment,
                                            decoration:   const InputDecoration(
                                                hintText: "Enter the Amount",
                                              labelStyle: TextStyle(
                                                color: Constant.secondary
                                              ),
                                              enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(color: Constant.secondary),
                                              ),
                                              focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(color:  Constant.secondary),
                                              ),
                                            ),
                                          ),
                                          actions: [
                                            Center(
                                              child: MaterialButton(
                                                color: Constant.secondary,
                                                  onPressed: () async{
                                                  String remark ="Payment for bootCash";
                                                  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
                                                  final SharedPreferences prefs =await _prefs;
                                                  String? accessToken= prefs.getString("access_token");
                                                  String paymentTypeId="1";
                                                  num amount= num.parse(earningController.myControllerPayment.text);
                                                    earningController.initiateRazorpay(
                                                      accessToken!,
                                                      paymentTypeId,
                                                      amount,
                                                      remark,
                                                    );
                                                    Get.back();
                                                  }
                                                  , child: const Text("Pay")),
                                            )
                                          ],
                                        );
                                      });
                                      // earningController.openCheckout;
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: const BoxDecoration(
                                          color: Constant.secondaryTransparent,
                                          borderRadius: BorderRadius.all(Radius.circular(5.0))),
                                      child: const Text(
                                        'Pay now',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                          fontFamily: 'Source Sans Pro',
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                  // (earningController.earningList.value != null)?Row(
                                  //   children: [
                                  //     Text('${earningController.earningList.value.transactions!.length} tasks completed',
                                  //       style: const TextStyle(
                                  //         color: Colors.grey,
                                  //         fontSize: 16,
                                  //         letterSpacing: .5,
                                  //       ),),
                                  //   ],
                                  // ):Container(),
                                ],

                              ),
                          ),
                        ),
                      ),
                    ),
                    // Stack(
                    //   children: [
                    //     const CircleAvatar(
                    //       backgroundColor: Colors.white,
                    //
                    //     ),
                    //     Positioned(
                    //       bottom:8,
                    //       right: 7,
                    //       child: Row(
                    //         children: const [
                    //           Icon(
                    //             Icons.arrow_forward_ios,
                    //             color: Colors.green,
                    //             size: 24.0,
                    //             semanticLabel: 'Text to announce in accessibility modes',
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ],
                    // )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  boxShadow:const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 2.0,
                      spreadRadius: 0.0,
                      offset: Offset(.5, 0.5), // shadow direction: bottom right
                    )
                  ],
                  color:Colors.white,
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                margin: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        const Text('Total Incentive',style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),),
                        const SizedBox(height: 10,),
                        const Text('Your incentive which you have earned',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13
                          ),
                        ),
                        const SizedBox(height: 15,),
                        Row(
                          children: [
                            Text('₹${profileController.profileDataHome.value.incentive} till now',
                              style: const TextStyle(
                                  color: Constant.secondary,
                                  fontSize: 20
                              ),
                            ),

                            // Icon(Icons.arrow_forward_ios,
                            //   size: 15,
                            //   color: Constant.secondary,
                            // ),

                          ],
                        ),
                      ],
                    ),
                    Image.asset('lib/Images/walet.png',
                      height: 60,
                      width: 60,
                    ),
                  ],
                ),
              ),
              (earningController.selectedEarning.value == "EARNING")?
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text('Total Earning',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),

                    ),
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    color: Colors.grey,
                    width: MediaQuery.of(context).size.width,
                    height: 2,
                  ),
                ],
              ):const Text(""),
              (earningController.earningList.value.transactions!.isNotEmpty)
                  ?(earningController.selectedEarning.value == "EARNING")?
              ListView.builder(
                reverse: true,
                  shrinkWrap: true,
                  itemCount: earningController.earningList.value.transactions!.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder:(BuildContext context,int index){
                    return ListTile(
                        subtitle: Text(
                            DateFormat('MMMM dd, yyyy')
                                .format(earningController.earningList.value.transactions![index].createdAt!)
                        ),
                        leading:  Image.asset('lib/Images/walet.png',
                          height: 30,
                          width: 30,
                        ),
                        trailing: Text(
                                     " ₹${
                                        earningController.earningList.value
                                            .transactions![index].amount.toString()
                                      }",
                          style: const TextStyle(
                              color: Colors.green,fontSize: 15),),
                        title:Text("${earningController.earningList.value.transactions![index].remarks.toString()}")
                    );
                  }

              ):Container()
                  :Container(),

              (earningController.selectedEarning.value == "CASH IN HAND")?
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:   [
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text('Cash in Hand',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    color: Colors.grey,
                    width: MediaQuery.of(context).size.width,
                    height: 2,
                  ),
                ],
              ):Container(),
              (earningController.storedWalletTransactionData.value.data!=null)
                  ?(earningController.selectedEarning.value == "CASH IN HAND")?
              ListView.builder(
                reverse: true,
                  shrinkWrap: true,
                  itemCount: earningController.storedWalletTransactionData.value.data!.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder:(BuildContext context,int index){
                    return ListTile(
                        subtitle: Text(
                            DateFormat('MMMM dd, yyyy')
                                .format(earningController.storedWalletTransactionData.value.data![index].createdAt!)
                        ),
                        leading:  Image.asset('lib/Images/walet.png',
                          height: 30,
                          width: 30,
                        ),
                        trailing: Text(
                          " ₹${
                              earningController.storedWalletTransactionData.value
                                  .data![index].amount!.toStringAsFixed(0)
                          }",
                          style: const TextStyle(
                              color: Colors.green,fontSize: 15),),
                        title:Text(earningController.storedWalletTransactionData.value.data![index].remarks!.toString())
                    );
                  }

              ):Container()
                  :Container(),
              // Container(
              //   decoration: BoxDecoration(
              //     boxShadow:const [
              //       BoxShadow(
              //         color: Colors.grey,
              //         blurRadius: 2.0,
              //         spreadRadius: 0.0,
              //         offset: Offset(.5, 0.5),  // shadow direction: bottom right
              //       )
              //     ],
              //     color:Colors.white,
              //     border: Border.all(
              //       color: Colors.white,
              //       width: 2,
              //     ),
              //     borderRadius: BorderRadius.circular(12),
              //   ),
              //   padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
              //   margin: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Column(
              //         mainAxisAlignment: MainAxisAlignment.start,
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children:const [
              //           Text('Payouts',style: TextStyle(
              //             color: Colors.black,
              //             fontSize: 25,
              //             fontWeight: FontWeight.bold,
              //           ),),
              //           SizedBox(height: 10,),
              //           Text('Get Paid every week on Monday',
              //             style: TextStyle(
              //                 color: Colors.grey,
              //                 fontSize: 13
              //             ),
              //           ),
              //           SizedBox(height: 15,),
              //           // Row(
              //           //   children: const[
              //           //     Text('₹0 till now',
              //           //       style: TextStyle(
              //           //           color: Constant.secondary,
              //           //           fontSize: 20
              //           //       ),
              //           //     ),
              //           //     Icon(Icons.arrow_forward_ios,
              //           //       size: 15,
              //           //       color: Constant.secondary,
              //           //     ),
              //           //
              //           //   ],
              //           // ),
              //         ],
              //       ),
              //       Image.asset('lib/Images/logo.jpeg',
              //         height: 60,
              //         width: 60,
              //       ),
              //
              //
              //     ],
              //   ),
              // ),
              const Divider(
                thickness: 5,
              ),
              Container(
                height: 200,
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.white70, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 10,
                  color: Constant.secondary,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Ways to earn more!',style: TextStyle(
                              color: Colors.grey.shade200,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),),
                            // const SizedBox(height: 10,),
                            // Text('Wedun is here to help you with',
                            //   style: TextStyle(
                            //       color: Colors.grey.shade200,
                            //       fontWeight: FontWeight.bold,
                            //       fontSize: 15
                            //   ),
                            // ),
                           const SizedBox(height: 5,),
                            Text("Login for one hour you will get ${
                                profileController.storedSettingData.value.data!=null?
                                profileController.storedSettingData.value.data!.driverIncentivePerHour:0.0}*",
                              style: TextStyle(
                                  color: Colors.grey.shade200,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15
                              ),
                            ),
                            const SizedBox(height: 50,),
                            Text("* Minimum hour for incentive is ${
                                profileController.storedSettingData.value.data!=null?
                                profileController.storedSettingData.value.data!.minHourForIncentive:0.0}.",
                              style: TextStyle(
                                  color: Colors.grey.shade200,
                                  fontWeight: FontWeight.normal,
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
                          height: 110,
                          width: 110,
                        ),


                      ],
                    ),
                  ),
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