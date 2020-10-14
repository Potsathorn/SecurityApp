import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class Ch extends StatefulWidget {
  @override
  _ChState createState() => _ChState();
}

class _ChState extends State<Ch> {
  bool isLocked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        height: 20,
        width: 40,
        child: NeumorphicSwitch(
          value: isLocked,
          style: NeumorphicSwitchStyle(
            activeTrackColor: Colors.cyan,
          ),
          onChanged: (value) {
            setState(() {
              isLocked = value;
            });
          },
        ),
      ),
    ));
  }
}


// NeumorphicCheckbox(

              //   value: isLocked,
              //   style: NeumorphicCheckboxStyle(
              //     selectedColor: Colors.cyan,
              //   ),
              //   onChanged: (value) {
              //     setState(() {
              //       isLocked = value;
              //     });
              //   },
              // ),