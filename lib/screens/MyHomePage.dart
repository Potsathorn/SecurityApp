import 'package:Security/widgets/neuButton.dart';
import 'package:Security/widgets/neuButtonTap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String groupScene;

  // SET ICONS HERE

  var icons1 = Icons.home;
  var icons2 = Icons.settings;
  var icons3 = Icons.favorite;
  var icons4 = Icons.message;

  //

  bool buttonPressed1 = false;
  bool buttonPressed2 = false;
  bool buttonPressed3 = false;
  bool buttonPressed4 = false;

  void _letsPress1() {
    setState(() {
      buttonPressed1 = true;
      buttonPressed2 = false;
      buttonPressed3 = false;
      buttonPressed4 = false;
    });
  }

  void _letsPress2() {
    setState(() {
      buttonPressed1 = false;
      buttonPressed2 = true;
      buttonPressed3 = false;
      buttonPressed4 = false;
    });
  }

  void _letsPress3() {
    setState(() {
      buttonPressed1 = false;
      buttonPressed2 = false;
      buttonPressed3 = true;
      buttonPressed4 = false;
    });
  }

  void _letsPress4() {
    setState(() {
      buttonPressed1 = false;
      buttonPressed2 = false;
      buttonPressed3 = false;
      buttonPressed4 = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                   NeumorphicRadio(
                  groupValue: groupScene,
                  style: NeumorphicRadioStyle(
                      //   boxShape: NeumorphicBoxShape.circle(),
                      shape: NeumorphicShape.convex),
                  value: "Coming In",
                  onChanged: (value) {
                    setState(() {
                      groupScene = value;
                    });
                  },
                  child: Container(
                      color: (groupScene == 'Coming Home')
                          ? Colors.lightBlue[300]
                          : Color(0xFFe6ebf2),
                      height: 40,
                      width: 40,
                      child: Center(
                          child: Icon(
                        FontAwesome.users,
                        color: (groupScene == 'Coming Home')
                            ? Colors.white
                            : Colors.black.withOpacity(.5),
                      ))),
                ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: GestureDetector(
                            // FIRST BUTTON
                            onTap: _letsPress1,
                            child: buttonPressed1
                                ? ButtonTapped(
                                    icon: icons1,
                                    color: Colors.red,
                                  )
                                : MyButton(
                                    icon: icons1,
                                  )),
                      ),
                      Expanded(
                        child: GestureDetector(
                            // SECOND BUTTON
                            onTap: _letsPress2,
                            child: buttonPressed2
                                ? ButtonTapped(
                                    icon: icons2,
                                    color: Colors.red,
                                  )
                                : MyButton(
                                    icon: icons2,
                                  )),
                      ),
                      Expanded(
                        child: GestureDetector(
                            // THIRD BUTTON
                            onTap: _letsPress3,
                            child: buttonPressed3
                                ? ButtonTapped(
                                    icon: icons3,
                                    color: Colors.red,
                                  )
                                : MyButton(
                                    icon: icons3,
                                  )),
                      ),
                      Expanded(
                        child: GestureDetector(
                            // FOURTH BUTTON
                            onTap: _letsPress4,
                            child: buttonPressed4
                                ? ButtonTapped(
                                    icon: icons4,
                                    color: Colors.red,
                                  )
                                : MyButton(
                                    icon: icons4,
                                  )),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}