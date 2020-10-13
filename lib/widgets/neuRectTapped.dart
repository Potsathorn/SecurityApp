import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NeuRectTapped extends StatelessWidget {
  final Color color;
  final double bLevel;
  final Offset offsetW;
  final double height1;
  final Offset offsetB;
  final double width1;
  final IconData iconData;
  final double iconSize;
  final String text;

  const NeuRectTapped(
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
              color: color,
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
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Container(
              decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: bLevel,
                            offset: offsetW,
                            color: Colors.white.withOpacity(.7)),
                        BoxShadow(
                            blurRadius: bLevel,
                            offset: offsetB,
                            color: Colors.black.withOpacity(.25))
                      ]),
                  child: Icon(
                    iconData,
                    size: iconSize,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ),
        ),
        Text(text,style: TextStyle(color: Colors.blue),)
      ],
    );
  }
}
