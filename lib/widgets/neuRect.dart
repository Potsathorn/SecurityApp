import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NeuRect extends StatelessWidget {
  final Color color;
  final double bLevel;
  final Offset offsetW;
  final double height1;
  final Offset offsetB;
  final double width1;
  final IconData iconData;
  final double iconSize;
  final String text;

  const NeuRect(
      {Key key,
      this.color,
      this.offsetW,
      this.bLevel,
      this.height1,
      this.width1,
      this.offsetB,
      this.iconData,
      this.text,
      this.iconSize})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
                  height: height1,
                  width: width1,
                  decoration: BoxDecoration(
                      color: Color(0xFFe6ebf2),
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 5.0,
                            offset: Offset(-3, -3),
                            color: Colors.white.withOpacity(.7)),
                        BoxShadow(
                            blurRadius: 5.0,
                            offset: Offset(3, 3),
                            color: Colors.black.withOpacity(.15))
                      ]),
                  child: Icon(
                    iconData,
                    color: Colors.black.withOpacity(.5),
                    size: 30.0,
                  ),
                ),
                Text(text,style: TextStyle(color: Colors.black.withOpacity(.5)),)
      ],
    );
  }
}
