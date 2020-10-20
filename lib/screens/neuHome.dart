import 'dart:async';

import 'package:Security/screens/NeuScene.dart';
import 'package:Security/widgets/IconWithText.dart';
import 'package:Security/widgets/NeuRectButton.dart';
import 'package:Security/widgets/ProfileGreeting.dart';
import 'package:Security/widgets/neuCircleimg.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import 'package:Security/widgets/circle.dart';
import 'package:Security/widgets/keyboard.dart';
import 'package:Security/screens/PassCode.dart';

import 'PassCode.dart';

class NeuHome extends StatefulWidget {
  @override
  _NeuHomeState createState() => _NeuHomeState();
}

class _NeuHomeState extends State<NeuHome> {
  String groupScene;
  final StreamController<bool> _verificationNotifier =
      StreamController<bool>.broadcast();
  bool isAuthenticated = false;

  void _gotoHome() {
    Navigator.pushNamed(context, "/showHome_page");
  }

  bool isActived = false;
  bool isLocked = false;
  bool isOn = false;

  List<String> inMembers = [];
  List<String> outMembers = [];
  List<Map> listMembers = [];
  var membersAccess;

  bool noMotion = false;
  bool noVibration = false;
  bool noContact = false;

  String statusSecurity = 'Loading...';
  String statusSecurityDes = 'Loading...';

  final bdref = FirebaseDatabase.instance.reference();
  var realTimeData;

  void initState() {
    super.initState();
    readData();
  }

  void writeData() {
    bdref.child('Test').set({
      'id': 'Test1',
      'data': 'This is a test send data from App to Firebase'
    });
  }

  void readData() {
    bdref.once().then((DataSnapshot dataSnapshot) {
      realTimeData = dataSnapshot.value;
      (realTimeData['Security Light']['Light'] == 'On')
          ? isOn = true
          : isOn = false;
      (realTimeData['Remote Locking']['Door'] == 'Lock')
          ? isLocked = true
          : isLocked = false;
      (realTimeData['Sound Alarm']['Alert'] == 'Active')
          ? isActived = true
          : isActived = false;
      (realTimeData['Intrusion Detection']['Motion'] == 'Normal')
          ? noMotion = true
          : noMotion = false;
      (realTimeData['Intrusion Detection']['Vibration'] == 'Normal')
          ? noVibration = true
          : noVibration = false;
      (realTimeData['Intrusion Detection']['Contact'] == 'Normal')
          ? noContact = true
          : noContact = false;

      (noContact) ? progressValueshow += 40 : progressValueshow += 2;
      (noVibration) ? progressValueshow += 40 : progressValueshow += 2;
      (noMotion) ? progressValueshow += 20 : progressValueshow += 10;

      if (progressValueshow == 100) {
        statusSecurity = 'Secure';
      } else if (progressValueshow >= 80) {
        statusSecurity = 'Normal';
      } else if (progressValueshow >= 40) {
        statusSecurity = 'Abnormal';
      } else {
        statusSecurity = 'Insecure';
      }

      if (noContact && noVibration && noMotion) {
        statusSecurityDes = 'No intrusion was detected';
      } else if (!noMotion && noContact && noVibration) {
        statusSecurityDes = 'Motion was detected';
      } else if (noMotion && noContact && !noVibration) {
        statusSecurityDes = 'Vibration was detected';
      } else if (noMotion && !noContact && noVibration) {
        statusSecurityDes = 'Contact was detected';
      } else {
        statusSecurityDes = 'Intrusion was detected';
      }

      membersAccess = realTimeData['Members Access'];
      // print(membersAccess);

      listMembers.add(membersAccess);

      for (var i in listMembers) {
        i.forEach((key, value) {
          if (value['Status'] == 'In') {
            inMembers.add(key);
          } else {
            outMembers.add(key);
          }
        });
      }

      // print(dataSnapshot.value);
      // print(st['Test Val']['Value']);

      // print(st['Security Light']['Light']);
    });

    setState(() {});
  }

  void updateData() {
    setState(() {
      // val = 'This is a updated value';
    });
    bdref.child('Test').update({'data': 'This is a updated value'});
  }

  void deleteData() {
    setState(() {
      // val = '';
    });
    bdref.child('Test').remove();
  }

  Timer _timer;
  double progressValue = 0;
  double progressValueshow = 0;
  double secondaryProgressValue = 0;

  _showLockScreen(BuildContext context,
      {bool opaque,
      CircleUIConfig circleUIConfig1,
      KeyboardUIConfig keyboardUIConfig,
      Widget cancelButton,
      List<String> digits,
      CircleUIConfig circleUIConfig}) {
    Navigator.push(
        context,
        PageRouteBuilder(
          opaque: opaque,
          pageBuilder: (context, animation, secondaryAnimation) {
            var keyboardUIConfig2 = keyboardUIConfig;
            var passcodeScreen = PasscodeScreen(
              title: Text(
                'Enter App Passcode',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 28),
              ),
              passwordEnteredCallback: _onPasscodeEntered,
              cancelButton: cancelButton,
              deleteButton: Text(
                'Delete',
                style: const TextStyle(fontSize: 16, color: Colors.white),
                semanticsLabel: 'Delete',
              ),
              shouldTriggerVerification: _verificationNotifier.stream,
              backgroundColor: Colors.black.withOpacity(0.8),
              cancelCallback: _onPasscodeCancelled,
              digits: digits,
            );
            return passcodeScreen;
          },
        ));
  }

  _onPasscodeEntered(String enteredPasscode) {
    bool isValid = '123456' == enteredPasscode;
    _verificationNotifier.add(isValid);
    if (isValid) {
      setState(() {
        this.isAuthenticated = isValid;
        isLocked = false;
        bdref
            .child('Remote Locking')
            .update({'Door': (isLocked) ? 'Lock' : 'Unlock'});
      });
    }
  }

  _onPasscodeCancelled() {
    Navigator.maybePop(context);
  }

  ///////===

  // void _gotoLockink() {
  //   Navigator.pushNamed(context, "/showLocking_page");
  // }

  // void _gotoLightnig() {
  //   Navigator.pushNamed(context, "/showLightning_page");
  // }

  // void _gotoAlarm() {
  //   Navigator.pushNamed(context, "/showAlarm_page");
  // }

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
    // String motion = realTimeData['Intrusion Detection']['Motion'];
    // String vibration = realTimeData['Intrusion Detection']['Vibration'];
    // String contact = realTimeData['Intrusion Detection']['Contact'];

    // print(motion);

    //  print(vibration);
    //   print(contact);

    bool isDoorLock() {
      // readData();
      return (realTimeData['Remote Locking']['Door'] == 'Lock') ? true : false;
    }

    bool isOnLight() {
      return (realTimeData['Security Light']['Light'] == 'On') ? true : false;
    }

    bool isAlertActive() {
      //readData();
      return (realTimeData['Sound Alarm']['Alert'] == 'Active') ? true : false;
    }

    List<String> inOutHomeAccess(String access) {
      return (access == 'In') ? inMembers : outMembers;
    }

    if (isOn == null) {
      (isOn != null) ? isOn = isOnLight() : isOn = isOnLight();
    }

    if (isLocked == null) {
      (isLocked != null) ? isLocked = isDoorLock() : isLocked = isDoorLock();
    }

    if (isActived == null) {
      (isActived != null)
          ? isActived = isAlertActive()
          : isActived = isAlertActive();
    }

    if (groupScene == null) {
      groupScene = 'Coming Home';
    } else {}

    return Scaffold(
      backgroundColor: Color(0xFFe6ebf2),
      // appBar: AppBar(
      //   title: Center(
      //     child: Text('SMART HOME'),
      //   ),
      // ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            //color: Colors.cyan[300],
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
                        color: Colors.black.withOpacity(0.6),
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
                          ? Colors.cyan
                          : Color(0xFFe6ebf2),
                      height: 40,
                      width: 40,
                      child: Center(
                          child: Icon(
                        SimpleLineIcons.login,
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
                          ? Colors.cyan
                          : Color(0xFFe6ebf2),
                      height: 40,
                      width: 40,
                      child: Center(
                          child: Icon(
                        SimpleLineIcons.logout,
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
                          ? Colors.cyan
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
                          ? Colors.cyan
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
                      color: Colors.cyan,
                      fontWeight: FontWeight.bold,
                      // fontWeight: FontWeight.bold,
                      // fontFamily: "nunito",
                    ))
                : Text(''),
          ),
          SizedBox(
            height: 10.0,
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
                title: Row(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Family Members Access',
                          style: TextStyle(
                            color: Colors.black.withOpacity(.5),
                            //letterSpacing: 1,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: "nunito",
                          ),
                        ),
                        SizedBox(
                          width: 110.0,
                        ),
                        Neumorphic(
                          style: NeumorphicStyle(
                              boxShape: NeumorphicBoxShape.circle(),
                              shape: NeumorphicShape.convex),
                          child: Container(
                            color:Color(0xFFe6ebf2),
                            width: 30,
                            height: 30,
                            child: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.cyan,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for (var p in inOutHomeAccess('In')) NeuCircleImg(name: p)
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Neumorphic(
            child: Container(
              color: Color(0xFFe6ebf2),
              width: MediaQuery.of(context).size.width - 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Icon(
                          //   FontAwesome.do,
                          //   color: Colors.cyan,
                          //   size: 35,
                          // ),
                          // SizedBox(
                          //   width: 10.0,
                          // ),
                          // Icon(
                          //   FontAwesome.shield,
                          //   color: Colors.cyan,
                          //   size: 35,
                          // ),
                          // SizedBox(
                          //   width: 10.0,
                          // ),
                          Icon(
                            Icons.security_outlined,
                            color: Colors.cyan,
                            size: 35,
                          ),
                        ],
                      ),
                      // Neumorphic(
                      //   style: NeumorphicStyle(
                      //       //boxShape: NeumorphicBoxShape.circle(),
                      //       shape: NeumorphicShape.concave),
                      //   child: Container(
                      //       width: 30.0,
                      //       height: 30.0,
                      //       child: Icon(
                      //         FontAwesome.shield,
                      //         color: Colors.cyan,
                      //       )),
                      // ),
                      Row(
                        children: [
                          Text(
                            'Intrusion Detection',
                            style: TextStyle(
                              color: Colors.black.withOpacity(.5),
                              letterSpacing: 1,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: "nunito",
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        statusSecurityDes,
                        style: TextStyle(
                          color: Colors.black.withOpacity(.5),
                          letterSpacing: 1,
                          fontSize: 15.0,
                          // fontWeight: FontWeight.bold,
                          fontFamily: "nunito",
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        statusSecurity,
                        style: TextStyle(
                          color: Colors.cyan,
                          letterSpacing: 1,
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: "nunito",
                        ),
                      ),
                    ],
                  ),
                  Neumorphic(
                    style: NeumorphicStyle(
                       // boxShape: NeumorphicBoxShape.circle(),
                        shape: NeumorphicShape.convex),
                    child: Container(
                        height: 120,
                        width: 120,
                        color: Color(0xFFe6ebf2),
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
                                    gradient: const SweepGradient(
                                        colors: <Color>[
                                          Color(0xFF00a9b5),
                                          Color(0xFFa4edeb)
                                        ],
                                        stops: <double>[
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
                                    widget: Text(
                                        progressValue.toStringAsFixed(0) + '%',
                                        style: TextStyle(
                                            color: Colors.black.withOpacity(.6),
                                            fontFamily: "nunito",
                                            fontSize: 27.0)))
                              ]),
                        ])),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '  Security System Control',
                style: TextStyle(
                  color: Colors.black.withOpacity(.5),
                  letterSpacing: 1,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: "nunito",
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Neumorphic(
                style: NeumorphicStyle(
                    // boxShape: NeumorphicBoxShape.circle(),
                    shape: NeumorphicShape.convex),
                child: Container(
                  color: Color(0xFFe6ebf2),
                  width: MediaQuery.of(context).size.width / 2.2,
                  height: MediaQuery.of(context).size.width / 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5.0,
                      ),
                      Icon(
                        Icons.lock_outline,
                        color: Colors.black.withOpacity(.5),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'Remote Locking',
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
                      Text(
                        'Manage your door latch',
                        style: TextStyle(
                          color: Colors.black.withOpacity(.5),
                          //letterSpacing: 1,
                          fontSize: 13.0,
                          // fontWeight: FontWeight.bold,
                          fontFamily: "nunito",
                        ),
                      ),
                      SizedBox(
                        height: 13.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            (isLocked) ? 'Lock' : 'Unlock',
                            style: TextStyle(
                              color: Colors.black.withOpacity(.5),
                              //letterSpacing: 1,
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: "nunito",
                            ),
                          ),
                          SizedBox(
                            width: 13.0,
                          ),
                          Container(
                            height: 20,
                            width: 40,
                            child: NeumorphicSwitch(
                              value: isLocked,
                              style: NeumorphicSwitchStyle(
                                activeTrackColor: Colors.cyan,
                              ),
                              onChanged: (value) {
                                (isLocked) ? isAuthenticated = false : null;
                                (isLocked && !isAuthenticated)
                                    ? _showLockScreen(
                                        context,
                                        opaque: false,
                                        cancelButton: Text(
                                          'Cancel',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.white),
                                          semanticsLabel: 'Cancel',
                                        ),
                                      )
                                    : setState(() {
                                        isLocked = value;
                                        bdref.child('Remote Locking').update({
                                          'Door': (isLocked) ? 'Lock' : 'Unlock'
                                        });

                                        // ignore: unnecessary_statements
                                      });

                                //   isAuthenticated
                                //       ? setState(() {
                                //           isLocked = value;
                                //           bdref.child('Remote Locking').update({
                                //             'Door': (isLocked) ? 'Lock' : 'Unlock'
                                //           });

                                //           // ignore: unnecessary_statements
                                //         })
                                //       : print(!isAuthenticated);
                                //   print(isAuthenticated);
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  //color: Colors.red,
                ),
              ),
              Neumorphic(
                style: NeumorphicStyle(
                    // boxShape: NeumorphicBoxShape.circle(),
                    shape: NeumorphicShape.convex),
                child: Container(
                  color: Color(0xFFe6ebf2),
                  width: MediaQuery.of(context).size.width / 2.2,
                  height: MediaQuery.of(context).size.width / 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5.0,
                      ),
                      Icon(
                        Icons.lightbulb_outline,
                        color: Colors.black.withOpacity(.5),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'Security Lightning',
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
                      Text(
                        'Manage your lights',
                        style: TextStyle(
                          color: Colors.black.withOpacity(.5),
                          //letterSpacing: 1,
                          fontSize: 13.0,
                          // fontWeight: FontWeight.bold,
                          fontFamily: "nunito",
                        ),
                      ),
                      SizedBox(
                        height: 13.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            (isOn) ? 'On' : 'Off',
                            style: TextStyle(
                              color: Colors.black.withOpacity(.5),
                              //letterSpacing: 1,
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: "nunito",
                            ),
                          ),
                          SizedBox(
                            width: 13.0,
                          ),
                          Container(
                            height: 20,
                            width: 40,
                            child: NeumorphicSwitch(
                              value: isOn,
                              style: NeumorphicSwitchStyle(
                                activeTrackColor: Colors.cyan,
                              ),
                              onChanged: (value) {
                                isOn = value;

                                bdref
                                    .child('Security Light')
                                    .update({'Light': (isOn) ? 'On' : 'Off'});
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  //color: Colors.red,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Neumorphic(
                style: NeumorphicStyle(
                    // boxShape: NeumorphicBoxShape.circle(),
                    shape: NeumorphicShape.convex),
                child: Container(
                  color: Color(0xFFe6ebf2),
                  width: MediaQuery.of(context).size.width / 2.2,
                  height: MediaQuery.of(context).size.width / 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5.0,
                      ),
                      Icon(
                        SimpleLineIcons.volume_2,
                        color: Colors.black.withOpacity(.5),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'Sound Alarm',
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
                      Text(
                        'Manage your sound alarm',
                        style: TextStyle(
                          color: Colors.black.withOpacity(.5),
                          //letterSpacing: 1,
                          fontSize: 13.0,
                          // fontWeight: FontWeight.bold,
                          fontFamily: "nunito",
                        ),
                      ),
                      SizedBox(
                        height: 13.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            (isActived) ? 'Active' : 'Inactive',
                            style: TextStyle(
                              color: Colors.black.withOpacity(.5),
                              //letterSpacing: 1,
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: "nunito",
                            ),
                          ),
                          SizedBox(
                            width: 13.0,
                          ),
                          Container(
                            height: 20,
                            width: 40,
                            child: NeumorphicSwitch(
                              value: isActived,
                              style: NeumorphicSwitchStyle(
                                activeTrackColor: Colors.cyan,
                              ),
                              onChanged: (value) {
                                setState(() {
                                  // print(in_out_HomeAccess('In'));
                                  // print(in_out_HomeAccess('Out'));

                                  isActived = value;
                                  bdref.child('Sound Alarm').update({
                                    'Alert': (isActived) ? 'Active' : 'Inactive'
                                  });
                                  setState(() {});
                                });
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  //color: Colors.red,
                ),
              ),
              Neumorphic(
                style: NeumorphicStyle(
                    // boxShape: NeumorphicBoxShape.circle(),
                    shape: NeumorphicShape.convex),
                child: Container(
                  color: Color(0xFFe6ebf2),
                  width: MediaQuery.of(context).size.width / 2.2,
                  height: MediaQuery.of(context).size.width / 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5.0,
                      ),
                      Icon(
                        Icons.videocam_outlined,
                        color: Colors.black.withOpacity(.5),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'Video Streaming',
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
                      Text(
                        'Moitors home activities',
                        style: TextStyle(
                          color: Colors.black.withOpacity(.5),
                          //letterSpacing: 1,
                          fontSize: 13.0,
                          // fontWeight: FontWeight.bold,
                          fontFamily: "nunito",
                        ),
                      ),
                      SizedBox(
                        height: 13.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Streaming...',
                            style: TextStyle(
                              color: Colors.black.withOpacity(.5),
                              //letterSpacing: 1,
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: "nunito",
                            ),
                          ),
                          SizedBox(
                            width: 13.0,
                          ),
                          Icon(
                            Icons.double_arrow_rounded,
                            color: Colors.cyan,
                          )
                        ],
                      )
                    ],
                  ),
                  //color: Colors.red,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void dispose() {
    _timer.cancel();
    super.dispose();
    _verificationNotifier.close();
  }
}
