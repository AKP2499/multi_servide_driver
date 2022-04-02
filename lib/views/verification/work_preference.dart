import 'package:dunzodriver_copy1/constant/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WorkPreference extends StatefulWidget {
  const WorkPreference({Key? key}) : super(key: key);

  @override
  _WorkPreferenceState createState() => _WorkPreferenceState();
}

class _WorkPreferenceState extends State<WorkPreference> {
  // bool selected=false;

  List<String>? selectedDocumentList = [""];
  // bool isChecked = false;
  List<String> documentList = [
    'Courier and Purchases',
    'Courier',
    'Purchases',
    'Purchasing Services',
    'Pick and Drop'
  ];

  @override
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Work preference details',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Source Sans Pro',
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                      'Tell us what type of order would you like to receive',
                      style: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'Source Sans Pro',
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        letterSpacing: .7,
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text('Choose one or both',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Source Sans Pro',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: documentList.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Card(
                          shape: selectedDocumentList!.contains(documentList.elementAt(index))
                              ? RoundedRectangleBorder(
                                  side: const BorderSide(
                                      color: Constant.primary, width: 2.0),
                                  borderRadius: BorderRadius.circular(4.0))
                              : RoundedRectangleBorder(
                                  side: const BorderSide(
                                      color: Colors.white, width: 2.0),
                                  borderRadius: BorderRadius.circular(4.0)),
                          child: ListTile(
                            leading: Checkbox(
                              checkColor: Colors.white,
                              fillColor:
                                  MaterialStateProperty.resolveWith(getColor),
                              onChanged: (value) {
                                setState(() {
                                  if (value == false) {
                                    selectedDocumentList!.remove(documentList.elementAt(index));
                                  }
                                  else {
                                    selectedDocumentList!.add(documentList.elementAt(index));
                                  }
                                });
                              },
                              value: selectedDocumentList!.contains(documentList.elementAt(index))
                                  ? true
                                  : false,
                            ),
                            title: Text(
                              documentList[index],
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Source Sans Pro',
                                  letterSpacing: .5),
                            ),
                            trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Image.asset(
                                    'lib/Images/icons8-in-transit.gif',
                                    height: 30,
                                    width: 30,
                                  )
                                ]),
                          ));
                    },
                  ),
                ],
              ),
            ),
            Card(
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
                    'Next',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontStyle: FontStyle.normal),
                  )),
            ),
          ],
        ));
  }
}

// const Icon(Icons.navigate_next)
