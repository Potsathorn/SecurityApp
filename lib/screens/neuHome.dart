import 'dart:async';

import 'package:Security/screens/NeuScene.dart';
import 'package:Security/widgets/NeuRectButton.dart';
import 'package:Security/widgets/ProfileGreeting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class NeuHome extends StatefulWidget {
  @override
  _NeuHomeState createState() => _NeuHomeState();
}

class _NeuHomeState extends State<NeuHome> {
  String groupScene;
  Timer _timer;
  double progressValue = 0;
  double progressValueshow = 100;
  double secondaryProgressValue = 0;

  _NeuHomeState() {
    _timer = Timer.periodic(const Duration(milliseconds: 5), (Timer _timer) {
      setState(() {
        progressValue++;
        secondaryProgressValue = secondaryProgressValue + 2;
        if (progressValue == progressValueshow) {
          _timer.cancel();
        }
        if (secondaryProgressValue > 100) {
          secondaryProgressValue = 100;
        }
      });
    });
  }
  // var progressValue

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFe6ebf2),
      // appBar: AppBar(
      //   title: Center(
      //     child: Text('SMART HOME'),
      //   ),
      // ),
      body: Column(
        children: [
          SizedBox(
              // height: 40.0,
              ),
          Container(
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 40.0,
                  ),
                  ListTile(
                    title: Text(
                      'Welcome Home!',
                      style: TextStyle(
                        letterSpacing: 1.5,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: "nunito",
                      ),
                    ),
                    subtitle: Text(
                      'Taem Potsathorn',
                      style: TextStyle(
                        // letterSpacing: 1.5,
                        fontSize: 20.0,
                        // fontWeight: FontWeight.bold,
                        // fontFamily: "nunito",
                      ),
                    ),
                    trailing: Container(
                        width: 50.0,
                        height: 50.0,
                        decoration: new BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                            shape: BoxShape.rectangle,
                            image: new DecorationImage(
                                fit: BoxFit.fill,
                                image: new NetworkImage(
                                    'https://scontent.fbkk14-1.fna.fbcdn.net/v/t1.0-9/13177687_995427020556595_9011059072266479109_n.jpg?_nc_cat=106&_nc_sid=174925&_nc_ohc=mSEMdIUWPp4AX9qrhK0&_nc_ht=scontent.fbkk14-1.fna&oh=63c13e736bd0e094686a5f4e3dd150f9&oe=5FA01EA7')))),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 3.0,
          ),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                NeumorphicRadio(
                  groupValue: groupScene,
                  style: NeumorphicRadioStyle(
                      //   boxShape: NeumorphicBoxShape.circle(),
                      shape: NeumorphicShape.convex),
                  value: "Coming Home",
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
                        Icons.person_pin,
                        color: (groupScene == 'Coming Home')
                            ? Colors.white
                            : Colors.black.withOpacity(.5),
                      ))),
                ),
                SizedBox(
                  width: 5.0,
                ),
                NeumorphicRadio(
                  groupValue: groupScene,
                  style: NeumorphicRadioStyle(
                      // boxShape: NeumorphicBoxShape.circle(),
                      shape: NeumorphicShape.convex),
                  value: "Going Out",
                  onChanged: (value) {
                    setState(() {
                      groupScene = value;
                    });
                  },
                  child: Container(
                      color: (groupScene == 'Going Out')
                          ? Colors.lightBlue[300]
                          : Color(0xFFe6ebf2),
                      height: 40,
                      width: 40,
                      child: Center(
                          child: Icon(
                        FontAwesome.lock,
                        color: (groupScene == 'Going Out')
                            ? Colors.white
                            : Colors.black.withOpacity(.5),
                      ))),
                ),
                SizedBox(
                  width: 5.0,
                ),
                NeumorphicRadio(
                  groupValue: groupScene,
                  style: NeumorphicRadioStyle(
                      // boxShape: NeumorphicBoxShape.circle(),
                      shape: NeumorphicShape.convex),
                  value: "Watch Over",
                  onChanged: (value) {
                    setState(() {
                      groupScene = value;
                    });
                  },
                  child: Container(
                      color: (groupScene == 'Watch Over')
                          ? Colors.lightBlue[300]
                          : Color(0xFFe6ebf2),
                      height: 40,
                      width: 40,
                      child: Center(
                          child: Icon(
                        FontAwesome.eye,
                        color: (groupScene == 'Watch Over')
                            ? Colors.white
                            : Colors.black.withOpacity(.5),
                      ))),
                ),
                SizedBox(
                  width: 5.0,
                ),
                NeumorphicRadio(
                  groupValue: groupScene,
                  style: NeumorphicRadioStyle(
                      // boxShape: NeumorphicBoxShape.circle(),
                      shape: NeumorphicShape.convex),
                  value: "Good Night",
                  onChanged: (value) {
                    setState(() {
                      groupScene = value;
                    });
                  },
                  child: Container(
                      color: (groupScene == 'Good Night')
                          ? Colors.lightBlue[300]
                          : Color(0xFFe6ebf2),
                      height: 40,
                      width: 40,
                      child: Center(
                          child: Icon(
                        FontAwesome.moon_o,
                        color: (groupScene == 'Good Night')
                            ? Colors.white
                            : Colors.black.withOpacity(.5),
                      ))),
                ),
              ],
            ),
            trailing: (groupScene != null)
                ? Text(groupScene, //trow Excep debug
                    style: TextStyle(
                      // letterSpacing: 1.5,
                      fontSize: 20.0,
                      color: Colors.lightBlue[500],
                      fontWeight: FontWeight.bold,
                      // fontWeight: FontWeight.bold,
                      // fontFamily: "nunito",
                    ))
                : Text(''),
          ),
          SizedBox(
            height: 3.0,
          ),
           Row(
             children: [
              //  Text(
              //             'Family Members Access',
              //             style: TextStyle(
              //               color: Colors.black.withOpacity(.5),
              //               //letterSpacing: 1,
              //               fontSize: 15.0,
              //               fontWeight: FontWeight.bold,
              //               fontFamily: "nunito",
              //             ),
              //           ),
             ],
           ),
          Neumorphic(
            style: NeumorphicStyle(
                // boxShape: NeumorphicBoxShape.circle(),
                shape: NeumorphicShape.concave),
            child: Container(
              color: Color(0xFFe6ebf2),
              width: MediaQuery.of(context).size.width - 20,
              height: 90.0,
              child: ListTile(
                // leading: Neumorphic(
                //   child: Container(
                //     color: Colors.blueAccent[50],
                //     width: 50,
                //     height: 50,
                //     child: Center(
                //       child: Icon(FontAwesome.users,
                //       color: Colors.cyan,),
                //     ),
                //   ),
                // ),
                // title: Row(
                //   children: [
                //     Text(
                //       'Family Members Access',
                //       style: TextStyle(
                //         color: Colors.black.withOpacity(.5),
                //         //letterSpacing: 1,
                //         fontSize: 15.0,
                //         fontWeight: FontWeight.bold,
                //         fontFamily: "nunito",
                //       ),
                //     ),
                //   ],
                // ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    
                    Neumorphic(
                      style: NeumorphicStyle(
                          boxShape: NeumorphicBoxShape.circle(),
                          shape: NeumorphicShape.convex),
                      child: Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: new BoxDecoration(
                              // borderRadius: BorderRadius.all(
                              //   Radius.circular(15),
                              // ),
                              // shape: BoxShape.rectangle,
                              image: new DecorationImage(
                                  fit: BoxFit.fill,
                                  image: new NetworkImage(
                                      'https://scontent.fbkk14-1.fna.fbcdn.net/v/t1.0-9/13177687_995427020556595_9011059072266479109_n.jpg?_nc_cat=106&_nc_sid=174925&_nc_ohc=mSEMdIUWPp4AX9qrhK0&_nc_ht=scontent.fbkk14-1.fna&oh=63c13e736bd0e094686a5f4e3dd150f9&oe=5FA01EA7')))),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 3.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Column(
            children: [
              Text(
                      'Intrusion Detection System',
                      style: TextStyle(
                        color: Colors.black.withOpacity(.5),
                        //letterSpacing: 1,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: "nunito",
                      ),
                    ),
                     SizedBox(
            height: 3.0,
          ),
          

              
            ],
          ),
              Container(
                  height: 130,
                  width: 130,
                  child: SfRadialGauge(axes: <RadialAxis>[
                    RadialAxis(
                        showLabels: false,
                        showTicks: false,
                        startAngle: 270,
                        endAngle: 270,
                        radiusFactor: 0.8,
                        axisLineStyle: AxisLineStyle(
                          thickness: 0.2,
                          color: const Color.fromARGB(30, 0, 169, 181),
                          thicknessUnit: GaugeSizeUnit.factor,
                          cornerStyle: CornerStyle.startCurve,
                        ),
                        pointers: <GaugePointer>[
                          RangePointer(
                              value: progressValue,
                              width: 0.2,
                              sizeUnit: GaugeSizeUnit.factor,
                              enableAnimation: true,
                              animationDuration: 100,
                              animationType: AnimationType.linear,
                              cornerStyle: CornerStyle.startCurve,
                              gradient: const SweepGradient(colors: <Color>[
                                Color(0xFF00a9b5),
                                Color(0xFFa4edeb)
                              ], stops: <double>[
                                0.25,
                                0.75
                              ])),
                          MarkerPointer(
                            value: progressValue,
                            markerType: MarkerType.circle,
                            enableAnimation: true,
                            animationDuration: 100,
                            animationType: AnimationType.linear,
                            color: const Color(0xFF87e8e8),
                          )
                        ],
                        annotations: <GaugeAnnotation>[
                          GaugeAnnotation(
                              positionFactor: 0,
                              widget: Text(progressValue.toStringAsFixed(0) + '%',style: TextStyle(
                                              color: Colors.black.withOpacity(.6),
                                              fontFamily: "nunito",
                                              fontSize: 30.0)))
                        ]),
                  ])),
            
         
            ],
          )
        ],
      ),
    );
  }

  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
