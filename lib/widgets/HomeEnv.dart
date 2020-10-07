import 'package:Security/widgets/IconWithText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeEnv extends StatelessWidget {
  void _goto(){

  }
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(

        child: Container(
          color: Colors.orange,
          child: new Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
         IconWithText(icon: (false) ? Icons.looks_two : Icons.looks_one, size: 90.0, iconName: "Attendance", gotoPage: _goto),
          VerticalDivider(color: Colors.pink,
          indent: 15,
          endIndent: 15,
          thickness: 3,),
          FlatButton(
            onPressed: () => {},
            color: Colors.orange,
            padding: EdgeInsets.all(3.0),
            child: Column(
              // Replace with a Row for horizontal icon + text
              children: <Widget>[Icon(Icons.security,size: 90,), Text("Intrusion")],
            ),
          ),
          VerticalDivider(color: Colors.pink,
          indent: 15,
          endIndent: 15,
          thickness: 3,),
          FlatButton(
            onPressed: () => {},
            color: Colors.orange,
            padding: EdgeInsets.all(3.0),
            child: Column(
              // Replace with a Row for horizontal icon + text
              children: <Widget>[Icon(Icons.videocam,size: 90,), Text("Camera")],
            ),
          ),
      ],
    ),
        ));
  }
}
