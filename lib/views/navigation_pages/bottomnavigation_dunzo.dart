import 'package:dunzodriver_copy1/constant/color.dart';
import 'package:dunzodriver_copy1/controller/profile_controller.dart';
import 'package:dunzodriver_copy1/views/navigation_pages/home_page1.dart';
import 'package:dunzodriver_copy1/views/navigation_pages/payout_page.dart';
import 'package:dunzodriver_copy1/views/navigation_pages/settingpages/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'dart:io'show Platform, exit;
class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();

}


class _BottomNavigationState extends State<BottomNavigation> {
  ProfileController profileController=Get.put(ProfileController());
  Future<bool> _onWillPop(BuildContext context) async {
    bool? exitResult = await showDialog(
      context: context,
      builder: (context) => _buildExitDialog(context),
    );
    return exitResult ?? false;
  }
  Future<bool?> _showExitDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => _buildExitDialog(context),
    );
  }
  AlertDialog _buildExitDialog(BuildContext context) {
    return AlertDialog(
      elevation: 1,
      backgroundColor: Colors.white,
      shape:const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16))),
      title: const Text('Please confirm'),
      content: const Text('Do you want to exit the app?'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () =>  SystemNavigator.pop(),
          child: const Text('Yes'),
        ),
      ],
    );
  }
  /// showExitBottomSheet



  bool buttonSelected = false;
  int _currentIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex=index;
    });
  }
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    const Settings(),
    const Payout(),
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          child: const Center(
              child: Text(
                  'Coming soon',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,

                ),
              )),
        ),
      ],
    )

  ];

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () {
        Future.delayed(const Duration(seconds: 1), () {
          _onWillPop(context);
        });


        // getOutOfApp();
        // SystemNavigator.pop();
        // Fluttertoast.showToast(
        //     msg: "Add Dialog Box for exit confirmation",
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.CENTER,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.green,
        //     textColor: Colors.white,
        //     fontSize: 16.0);
        return Future.value(false);
      },
      child: Scaffold(
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.white,
            primaryColor: Colors.grey,
            textTheme: Theme.of(context).textTheme.copyWith(
              caption:const  TextStyle(color:Colors.black)
            )
          ), child: BottomNavigationBar(
          fixedColor: Constant.primary,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,

          items: const  <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.grid_view,),
              label: 'DashBoard',
            ),
            // BottomNavigationBarItem(
            //     icon: Icon(Icons.near_me,),
            // label: 'Map'
            // ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.notifications_none,),
            //   label: 'Notification',
            // ),
            BottomNavigationBarItem(
              icon: Icon(Icons.manage_accounts,),
              label: 'Settings',
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.emoji_events,),
              label: 'Earning',
            ),
        ],
          currentIndex: _currentIndex,
          // selectedItemColor: Colors.grey,
          onTap: _onItemTapped,
        ),
        ),
        body: Navigator(
          onGenerateRoute: (settings){
            return MaterialPageRoute(builder:(_)=>_widgetOptions[_currentIndex]);
        }
        ),
      ),
    );
  }
}

