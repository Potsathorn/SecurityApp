import 'dart:async';

import 'package:Security/screens/NeuScene.dart';
import 'package:Security/widgets/IconWithText.dart';
import 'package:Security/widgets/NeuRectButton.dart';
import 'package:Security/widgets/ProfileGreeting.dart';
import 'package:Security/widgets/neuCircleimg.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:Security/widgets/circle.dart';
import 'package:Security/widgets/keyboard.dart';
import 'package:Security/screens/PassCode.dart';

import '../SceneCubit.dart';
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

  void _gotoCamera() {
    Navigator.pushNamed(context, "/showCamera_page");
  }

  void _gotoIntrusion() {
    Navigator.pushNamed(context, "/showIntrusion_page");
  }

  void _gotoAttendance() {
    Navigator.pushNamed(context, "/showAttendance_page");
  }

  void _gotoLockink() {
    Navigator.pushNamed(context, "/showLocking_page");
  }

  void _gotoLightnig() {
    Navigator.pushNamed(context, "/showLightning_page");
  }

  void _gotoAlarm() {
    Navigator.pushNamed(context, "/showAlarm_page");
  }

  bool isActived = false;
  bool isLocked = false;
  bool isOn = false;

  Color themeColor = Colors.blue[800];

  List<String> inMembers = [];
  List<String> outMembers = [];
  List<Map> listMembers = [];
  var membersAccess;

  bool noMotion = false;
  bool noVibration = false;
  bool noContact = false;

  String statusSecurity = 'Loading...';
  String statusSecurityDes = 'Loading...';
  IconData iconSecurity = Icons.verified_user_outlined;

  final bdref = FirebaseDatabase.instance.reference();
  var realTimeData;

  void initState() {
    super.initState();
    readData();
    //test();
  }

  void writeData() {
    bdref.child('Test').set({
      'id': 'Test1',
      'data': 'This is a test send data from App to Firebase'
    });
  }

  void realtime() {
    bdref.child('Security Light').onValue.listen((event) {
      var snapshot = event.snapshot;

      String value = snapshot.value['Light'];

      (value == 'On') ? isOn = true : isOn = false;
      setState(() {});
    });

    bdref.child('Remote Locking').onValue.listen((event) {
      var snapshot = event.snapshot;

      String value = snapshot.value['Door'];

      (value == 'Lock') ? isLocked = true : isLocked = false;
    });

    bdref.child('Sound Alarm').onValue.listen((event) {
      var snapshot = event.snapshot;

      String value = snapshot.value['Alert'];

      (value == 'Active') ? isActived = true : isActived = false;
      // print(value);
    });

    bdref.child('Intrusion Detection').onValue.listen((event) {
      var snapshot = event.snapshot;

      String value = snapshot.value['Motion'];

      (value == 'Normal') ? noMotion = true : noMotion = false;
      //print(value);
    });

    bdref.child('Intrusion Detection').onValue.listen((event) {
      var snapshot = event.snapshot;

      String value = snapshot.value['Vibration'];

      (value == 'Normal') ? noVibration = true : noVibration = false;
      //print(value);
    });

    bdref.child('Intrusion Detection').onValue.listen((event) {
      var snapshot = event.snapshot;

      String value = snapshot.value['Contact'];

      (value == 'Normal') ? noContact = true : noContact = false;
      //print(value);
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

      // (noContact) ? progressValueshow += 40 : progressValueshow += 2;
      // (noVibration) ? progressValueshow += 40 : progressValueshow += 2;
      // (noMotion) ? progressValueshow += 20 : progressValueshow += 10;

      // if (progressValueshow == 100) {
      //   statusSecurity = 'Secure';
      // } else if (progressValueshow >= 80) {
      //   statusSecurity = 'Normal';
      // } else if (progressValueshow >= 40) {
      //   statusSecurity = 'Abnormal';
      // } else {
      //   statusSecurity = 'Insecure';
      // }

      if (noContact && noVibration && noMotion) {
        statusSecurityDes = 'No intrusion was detected';
        iconSecurity = Icons.verified_user_outlined;
        statusSecurity = 'Undetected';
      } else if (!noMotion && noContact && noVibration) {
        statusSecurityDes = 'Motion Sensor';
        iconSecurity = Icons.directions_walk_rounded;
        statusSecurity = 'Motion was detected';
      } else if (noMotion && noContact && !noVibration) {
        statusSecurityDes = 'Vibration Sensor';
        iconSecurity = Icons.vibration_rounded;
        statusSecurity = 'Vibration was detected';
      } else if (noMotion && !noContact && noVibration) {
        statusSecurityDes = 'Contact Sensor';
        iconSecurity = Icons.sensor_door;
        statusSecurity = 'Contact was detected';
      } else {
        statusSecurityDes = 'Intrusion was detected';
        iconSecurity = Icons.warning_amber_rounded;
        statusSecurity = 'Detected';
      }

      membersAccess = realTimeData['Members Access'];

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
    });

    setState(() {
      themeColor = (isActived) ? Colors.redAccent[700] : Colors.blue[800];
    });
  }

  void updateData() {
    setState(() {});
    bdref.child('Test').update({'data': 'This is a updated value'});
  }

  void deleteData() {
    setState(() {});
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

  @override
  Widget build(BuildContext context) {
    realtime();
    readData();

    // bool isDoorLock() {
    //   // readData();

    //   return (realTimeData['Remote Locking']['Door'] == 'Lock') ? true : false;
    // }

    // bool isOnLight() {
    //   return (realTimeData['Security Light']['Light'] == 'On') ? true : false;
    // }

    // bool isAlertActive() {
    //   //readData();
    //   return (realTimeData['Sound Alarm']['Alert'] == 'Active') ? true : false;
    // }

    List<String> inOutHomeAccess(String access) {
      return (access == 'In') ? inMembers : outMembers;
    }

    // if (isOn == null) {
    //   (isOn != null) ? isOn = isOnLight() : isOn = isOnLight();
    // }

    // if (isLocked == null) {
    //   (isLocked != null) ? isLocked = isDoorLock() : isLocked = isDoorLock();
    // }

    // if (isActived == null) {
    //   (isActived != null)
    //       ? isActived = isAlertActive()
    //       : isActived = isAlertActive();
    // }

    if (groupScene == null) {
      groupScene = "I'm Home";
    } else {}

    return Scaffold(
      backgroundColor: Color(0xFFe6ebf2),
      body: Column(
        children: [
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
                        color: themeColor,
                        letterSpacing: 1.5,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: "nunito",
                      ),
                    ),
                    subtitle: Text(
                      'Taem Potsathorn',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    trailing: Container(
                        width: 50.0,
                        height: 50.0,
                        decoration: new BoxDecoration(
                          image: new DecorationImage(
                              fit: BoxFit.fill,
                              image: new NetworkImage(
                                  "https://lh5.ggpht.com/_S0f-AWxKVdM/S5TpU6kRmUI/AAAAAAAAL4Y/wrjx3_23kw4/s72-c/d_silhouette%5B2%5D.jpg?imgmax=800")),
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                          shape: BoxShape.rectangle,
                        )),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 3.0,
          ),
          Neumorphic(
            style: NeumorphicStyle(shape: NeumorphicShape.flat, intensity: 1),
            child: Container(
              color: Color(0xFFe6ebf2),
              width: MediaQuery.of(context).size.width - 20,
              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    NeumorphicRadio(
                      groupValue: groupScene,
                      style:
                          NeumorphicRadioStyle(shape: NeumorphicShape.convex),
                      value: "I'm Home",
                      onChanged: (value) {
                        context.bloc<SceneCubit>().scenetoggle(value);
                        setState(() {
                          groupScene = value;
                        });
                      },
                      child: Container(
                          color: (groupScene == "I'm Home")
                              ? ((!isActived) ? themeColor : Color(0xFFd51a00))
                              : Color(0xFFe6ebf2),
                          height: 40,
                          width: 40,
                          child: Center(
                              child: Icon(
                            SimpleLineIcons.login,
                            color: (groupScene == "I'm Home")
                                ? Colors.white
                                : Colors.black.withOpacity(.5),
                          ))),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    NeumorphicRadio(
                      groupValue: groupScene,
                      style:
                          NeumorphicRadioStyle(shape: NeumorphicShape.convex),
                      value: "I'm Leave",
                      onChanged: (value) {
                        context.bloc<SceneCubit>().scenetoggle(value);
                        setState(() {
                          groupScene = value;
                        });
                      },
                      child: Container(
                          color: (groupScene == "I'm Leave")
                              ? (!isActived)
                                  ? themeColor
                                  : Color(0xFFd51a00)
                              : Color(0xFFe6ebf2),
                          height: 40,
                          width: 40,
                          child: Center(
                              child: Icon(
                            SimpleLineIcons.logout,
                            color: (groupScene == "I'm Leave")
                                ? Colors.white
                                : Colors.black.withOpacity(.5),
                          ))),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    NeumorphicRadio(
                      groupValue: groupScene,
                      style:
                          NeumorphicRadioStyle(shape: NeumorphicShape.convex),
                      value: "Watch Over",
                      onChanged: (value) {
                        context.bloc<SceneCubit>().scenetoggle(value);
                        setState(() {
                          groupScene = value;
                        });
                      },
                      child: Container(
                          color: (groupScene == 'Watch Over')
                              ? (!isActived)
                                  ? themeColor
                                  : Color(0xFFd51a00)
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
                      style:
                          NeumorphicRadioStyle(shape: NeumorphicShape.convex),
                      value: "Good Night",
                      onChanged: (value) {
                        context.bloc<SceneCubit>().scenetoggle(value);
                        setState(() {
                          groupScene = value;
                        });
                      },
                      child: Container(
                          color: (groupScene == 'Good Night')
                              ? (!isActived)
                                  ? themeColor
                                  : Color(0xFFd51a00)
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
                    ? Container(
                        color: Color(0xFFe6ebf2),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(3, 6, 3, 3),
                          child: BlocBuilder<SceneCubit, String>(
                            builder: (context, state) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text("Scene",
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.black.withOpacity(.5),
                                        fontWeight: FontWeight.bold,
                                      )),
                                  Text(state, //trow Excep debug
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: (!isActived)
                                            ? themeColor
                                            : Color(0xFFd51a00),
                                        fontWeight: FontWeight.bold,
                                      )),
                                ],
                              );
                            },
                          ),
                        ),
                      )
                    : Text(''),
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '  Members Last Access',
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
            height: 5.0,
          ),
          Neumorphic(
              style: NeumorphicStyle(shape: NeumorphicShape.flat, intensity: 1),
              child: Container(
                color: Color(0xFFe6ebf2),
                width: MediaQuery.of(context).size.width - 20,
                // height: 50.0,
                child: Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: new NetworkImage(
                            "https://lh5.ggpht.com/_S0f-AWxKVdM/S5TpU6kRmUI/AAAAAAAAL4Y/wrjx3_23kw4/s72-c/d_silhouette%5B2%5D.jpg?imgmax=800"),
                      ),
                      title: Text(
                        'Taem Potsathorn',
                        style: TextStyle(
                          color: themeColor,

                          //letterSpacing: 1,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: "nunito",
                        ),
                      ),
                      subtitle: Text('26/12/2020, 7:47 PM'),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      onTap: () {
                        _gotoAttendance();
                      },
                    ),
                  ],
                ),
              )),
          SizedBox(
            height: 20.0,
          ),
          GestureDetector(
            onTap: () => _gotoIntrusion(),
            child: Neumorphic(
              style: NeumorphicStyle(
                  // boxShape: NeumorphicBoxShape.circle(),
                  shape: NeumorphicShape.flat,
                  intensity: 1),
              child: Container(
                color: Color(0xFFe6ebf2),
                width: MediaQuery.of(context).size.width - 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 7,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.policy,
                              color: (statusSecurity == 'Undetected')
                                  ? themeColor
                                  : Colors.redAccent[700],
                              size: 35,
                            ),
                          ],
                        ),
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
                            fontFamily: "nunito",
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          statusSecurity,
                          style: TextStyle(
                            color: (statusSecurity == 'Undetected')
                                ? themeColor
                                : Colors.redAccent[700],
                            //letterSpacing: 1,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: "nunito",
                          ),
                        ),
                      ],
                    ),
                    Neumorphic(
                      style: NeumorphicStyle(shape: NeumorphicShape.convex),
                      child: Container(
                        height: 120,
                        width: 120,
                        color: Color(0xFFe6ebf2),
                        child: Icon(
                          iconSecurity,
                          color: (statusSecurity == 'Undetected')
                              ? themeColor
                              : Colors.redAccent[700],
                          size: 100,
                        ),
                      ),
                    ),
                  ],
                ),
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
                style:
                    NeumorphicStyle(shape: NeumorphicShape.flat, intensity: 1),
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
                      Row(
                        children: [
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.lock_outline,
                            color: (isLocked)
                                ? themeColor
                                : Colors.black.withOpacity(.5),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () => _gotoLockink(),
                            child: Text(
                              'Remote Locking',
                              style: TextStyle(
                                color: (isLocked)
                                    ? themeColor
                                    : Colors.black.withOpacity(.5),
                                //letterSpacing: 1,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: "nunito",
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 3.0,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Manage your door latch',
                            style: TextStyle(
                              color: (isLocked)
                                  ? themeColor
                                  : Colors.black.withOpacity(.5),
                              fontSize: 13.0,
                              fontFamily: "nunito",
                            ),
                          ),
                        ],
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
                              color: (isLocked)
                                  ? themeColor
                                  : Colors.black.withOpacity(.5),
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
                                activeTrackColor: (!isActived)
                                    ? themeColor
                                    : Color(0xFFd51a00),
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
                    shape: NeumorphicShape.flat,
                    intensity: 1),
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
                      Row(
                        children: [
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.lightbulb_outline,
                            color: (isOn)
                                ? themeColor
                                : Colors.black.withOpacity(.5),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () => _gotoLightnig(),
                            child: Text(
                              'Security Lighting',
                              style: TextStyle(
                                color: (isOn)
                                    ? themeColor
                                    : Colors.black.withOpacity(.5),
                                //letterSpacing: 1,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: "nunito",
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 3.0,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Manage your lights',
                            style: TextStyle(
                              color: (isOn)
                                  ? themeColor
                                  : Colors.black.withOpacity(.5),
                              //letterSpacing: 1,
                              fontSize: 13.0,
                              // fontWeight: FontWeight.bold,
                              fontFamily: "nunito",
                            ),
                          ),
                        ],
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
                              color: (isOn)
                                  ? themeColor
                                  : Colors.black.withOpacity(.5),
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
                                activeTrackColor: (!isActived)
                                    ? themeColor
                                    : Color(0xFFd51a00),
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
                    shape: NeumorphicShape.flat,
                    intensity: 1),
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
                      Row(
                        children: [
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.notifications_active_outlined,
                            color: (isActived)
                                ? themeColor
                                : Colors.black.withOpacity(.5),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () => _gotoAlarm(),
                            child: Text(
                              'Sound Alarm',
                              style: TextStyle(
                                color: (isActived)
                                    ? themeColor
                                    : Colors.black.withOpacity(.5),
                                //letterSpacing: 1,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: "nunito",
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 3.0,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Manage your sound alarm',
                            style: TextStyle(
                              color: (isActived)
                                  ? themeColor
                                  : Colors.black.withOpacity(.5),
                              fontSize: 13.0,
                              fontFamily: "nunito",
                            ),
                          ),
                        ],
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
                              color: (isActived)
                                  ? themeColor
                                  : Colors.black.withOpacity(.5),
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
                                activeTrackColor: (!isActived)
                                    ? themeColor
                                    : Color(0xFFd51a00),
                              ),
                              onChanged: (value) {
                                setState(() {
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
                ),
              ),
              Neumorphic(
                style:
                    NeumorphicStyle(shape: NeumorphicShape.flat, intensity: 1),
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
                      Row(
                        children: [
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.videocam_outlined,
                            color: themeColor,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () => _gotoCamera(),
                            child: Text(
                              'Video Streaming',
                              style: TextStyle(
                                color: themeColor,
                                //letterSpacing: 1,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: "nunito",
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 3.0,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Monitors home activities',
                            style: TextStyle(
                              color: themeColor,
                              //letterSpacing: 1,
                              fontSize: 13.0,
                              // fontWeight: FontWeight.bold,
                              fontFamily: "nunito",
                            ),
                          ),
                        ],
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
                              color: themeColor,
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
                            color:
                                (!isActived) ? themeColor : Color(0xFFd51a00),
                          )
                        ],
                      )
                    ],
                  ),
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
