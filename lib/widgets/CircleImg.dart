import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class CircleImg extends StatelessWidget {
  final String imgurl;

  const CircleImg({@required this.imgurl}) : assert(imgurl != null);
  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: [
        Container(
          // height: 250,
          //width: double.infinity,
          decoration: BoxDecoration(
              color: Color(0xFFe6ebf2),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                    offset: Offset(-3, -3),
                    blurRadius: 3.0,
                    color: Colors.white.withOpacity(.7)),
                BoxShadow(
                    offset: Offset(3, 3),
                    blurRadius: 3.0,
                    color: Colors.black.withOpacity(.15))
              ]),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Color(0xFFe6ebf2)),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xFFe6ebf2),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(-2, -2),
                            blurRadius: 2.0,
                            color: Colors.black.withOpacity(.3)),
                        BoxShadow(
                            offset: Offset(2, 2),
                            blurRadius: 2.0,
                            color: Colors.white.withOpacity(.7)),
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xFFe6ebf2), shape: BoxShape.circle),
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xFFDCE7F1),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(-2, -2),
                                    blurRadius: 2.0,
                                    color: Colors.black.withOpacity(.3)),
                                BoxShadow(
                                    offset: Offset(2, 2),
                                    blurRadius: 2.0,
                                    color: Colors.white.withOpacity(.7)),
                              ]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  width: 224.0,
                                  height: 224.0,
                                  decoration: new BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: new DecorationImage(
                                          fit: BoxFit.fill,
                                          image: new NetworkImage(imgurl))))

                              // Text(
                              //   "20°C",
                              //   style: TextStyle(
                              //       color: Colors.black.withOpacity(.6),
                              //       fontFamily: "nunito",
                              //       fontWeight: FontWeight.bold,
                              //       fontSize: 15.0),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 8,
          right: 35,
          child: Neumorphic(
            style: NeumorphicStyle(
                depth: 2,
                color: Color(0xFFe6ebf2),
                shape: NeumorphicShape.flat,
                oppositeShadowLightSource: false,
                lightSource: LightSource.bottomLeft,
                boxShape: NeumorphicBoxShape.circle()),
            padding: EdgeInsets.all(11),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "/showCamera_page");
              },
              child: Neumorphic(
                style: NeumorphicStyle(
                    depth: 2,
                    color: Color(0xFFe6ebf2),
                    shape: NeumorphicShape.flat,
                    oppositeShadowLightSource: false,
                    boxShape: NeumorphicBoxShape.circle()),
                padding: EdgeInsets.all(8),
                child: Icon(
                  Icons.videocam_outlined,
                  size: 30,
                  color: Color(0xFF1565c0),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
