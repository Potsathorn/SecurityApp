import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class IconWithText extends StatelessWidget {
  final IconData icon;
  final double size;
  final VoidCallback gotoPage;
  final String iconName;

  IconWithText(
      {@required this.icon,
      @required this.size,
      @required this.iconName,
      @required this.gotoPage})
      : assert(icon != null),
        assert(size != null),
        assert(iconName != null),
        assert(gotoPage != null);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: gotoPage,
      //color: Colors.orange,
      padding: EdgeInsets.all(3.0),
      child: Column(
        // Replace with a Row for horizontal icon + text
        children: <Widget>[
          Icon(
            icon,
            size: size,
          ),
          Text(iconName)
        ],
      ),
    );
  }
}
