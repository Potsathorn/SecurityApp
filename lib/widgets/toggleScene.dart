import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ToggleScene extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Row(
      
      children: [
        ToggleSwitch(
          
          // minWidth: MediaQuery.of(context).size.width,
          // minHeight: 50.0,
          initialLabelIndex: 2,

          cornerRadius: 0.0,
          activeFgColor: Colors.white,
          //inactiveBgColor: Colors.grey,
          inactiveFgColor: Colors.grey,
          

          labels: ['', '', '', ''],
          icons: [
            
            Icons.person_pin,
            Icons.lock_outline,
            Icons.remove_red_eye,
            Icons.hotel,
          ],
          iconSize: 40.0,
         // activeBgColors: [Colors.blue, Colors.pink, Colors.purple, Colors.cyan],
          onToggle: (index) {
            print('switched to: $index');
          },
        ),
      ],
    );
  }
}

class FontAwesomeIcons {}
