import 'package:Security/widgets/neuRect.dart';
import 'package:Security/widgets/neuRectTapped.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NeuScene extends StatefulWidget {
  @override
  _NeuSceneState createState() => _NeuSceneState();
}

class _NeuSceneState extends State<NeuScene> {
  // SET ICONS HERE

  var icons1 = Icons.home;
  var icons2 = Icons.settings;
  var icons3 = Icons.favorite;
  var icons4 = Icons.message;

  //

  bool buttonPressed1 = true;
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
    return Row(
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                        // FIRST BUTTON
                        onTap: _letsPress1,
                        child: buttonPressed1
                            ? NeuRectTapped(
                                height1: 55,
                                width1: 55,
                                color: Color(0xFFe6ebf2),
                                offsetB: Offset(-2, -2),
                                offsetW: Offset(2, 2),
                                bLevel: 5.0,
                                iconData: icons1,
                                iconSize: 30.0,
                                text: 'IN',
                              )
                            : NeuRect(
                                height1: 55,
                                width1: 55,
                                color: Color(0xFFe6ebf2),
                                offsetB: Offset(-2, -2),
                                offsetW: Offset(2, 2),
                                bLevel: 3.0,
                                iconData: icons1,
                                iconSize: 30.0,
                                text: 'IN',
                              )),
                  ),
                  Expanded(
                    child: GestureDetector(
                        // FIRST BUTTON
                        onTap: _letsPress2,
                        child: buttonPressed2
                            ? NeuRectTapped(
                                height1: 55,
                                width1: 55,
                                color: Color(0xFFe6ebf2),
                                offsetB: Offset(-2, -2),
                                offsetW: Offset(2, 2),
                                bLevel: 5.0,
                                iconData: icons2,
                                iconSize: 30.0,
                                text: 'OUT',
                              )
                            : NeuRect(
                                height1: 55,
                                width1: 55,
                                color: Color(0xFFe6ebf2),
                                offsetB: Offset(-2, -2),
                                offsetW: Offset(2, 2),
                                bLevel: 3.0,
                                iconData: icons2,
                                iconSize: 30.0,
                                text: 'OUT',
                              )),
                  ),
                  Expanded(
                    child: GestureDetector(
                        // FIRST BUTTON
                        onTap: _letsPress3,
                        child: buttonPressed3
                            ? NeuRectTapped(
                                height1: 55,
                                width1: 55,
                                color: Color(0xFFe6ebf2),
                                offsetB: Offset(-2, -2),
                                offsetW: Offset(2, 2),
                                bLevel: 5.0,
                                iconData: icons3,
                                iconSize: 30.0,
                                text: 'LOOK',
                              )
                            : NeuRect(
                                height1: 55,
                                width1: 55,
                                color: Color(0xFFe6ebf2),
                                offsetB: Offset(-2, -2),
                                offsetW: Offset(2, 2),
                                bLevel: 3.0,
                                iconData: icons3,
                                iconSize: 30.0,
                                text: 'LOOK',
                              )),
                  ),
                  Expanded(
                    child: GestureDetector(
                        // FIRST BUTTON
                        onTap: _letsPress4,
                        child: buttonPressed4
                            ? NeuRectTapped(
                                height1: 55,
                                width1: 55,
                                color: Color(0xFFe6ebf2),
                                offsetB: Offset(-2, -2),
                                offsetW: Offset(2, 2),
                                bLevel: 5.0,
                                iconData: icons4,
                                iconSize: 30.0,
                                text: 'NIGHT',
                              )
                            : NeuRect(
                                height1: 55,
                                width1: 55,
                                color: Color(0xFFe6ebf2),
                                offsetB: Offset(-2, -2),
                                offsetW: Offset(2, 2),
                                bLevel: 3.0,
                                iconData: icons4,
                                iconSize: 30.0,
                                text: 'NIGHT',
                              )),
                  ),
                ],
              );
            
  }
}
