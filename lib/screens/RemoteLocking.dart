import 'dart:async';

import 'package:Security/widgets/circle.dart';
import 'package:Security/widgets/keyboard.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intl/intl.dart';

import 'PassCode.dart';


/// Firbase หากข้อมูลไม่ update ยังมีข้อมูลที่เหมือนกัน จะไม่มีการ update ข้อมูลเดิม

class RemoteLockingPage extends StatefulWidget {
  RemoteLockingPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _RemoteLockingPageState createState() => _RemoteLockingPageState();
}

class _RemoteLockingPageState extends State<RemoteLockingPage> {
  @override
  void initState() {
    super.initState();
    realtime();
  }

  

  bool isLocked = false;
  String last = "";
  String by = "";
  String timerUnlock = "";

  final bdref = FirebaseDatabase.instance.reference();
  var realTimeData;

  void realtime() {
    bdref.child('Remote Locking').onValue.listen((event) {
      var snapshot = event.snapshot;

      String value = snapshot.value['Door'];

      (value == 'Lock') ? isLocked = true : isLocked = false;
      //print(value);
      setState(() {});
    });

    bdref.child('Remote Locking').onValue.listen((event) {
      var snapshot = event.snapshot;

      String value = snapshot.value['Unlocked By'];

      by = value;
      //print(value);
    });

    bdref.child('Remote Locking').onValue.listen((event) {
      var snapshot = event.snapshot;

      String value = snapshot.value['Last Unlocked'];

      last = value;
      //print(value);
    });
  }

  final StreamController<bool> _verificationNotifier =
      StreamController<bool>.broadcast();
  bool isAuthenticated = false;

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
            // ignore: unused_local_variable
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
    bool isValid = '080925' == enteredPasscode;
    _verificationNotifier.add(isValid);
    if (isValid) {
      setState(() {
        this.isAuthenticated = true;
        isLocked = false;
        last = timerUnlock;
        by = "Application";
        bdref.child('Remote Locking').update({
          'Door': (isLocked) ? 'Lock' : 'Unlock',
          'Last Unlocked': timerUnlock,
          'Unlocked By' : 'Application',

        });
        
      });
    }
  }

  _onPasscodeCancelled() {
    Navigator.maybePop(context);
  }

  @override
  Widget build(BuildContext context) {
//     SystemChrome.setPreferredOrientations([
//    DeviceOrientation.portraitDown,
//    DeviceOrientation.portraitUp,
// ]);
    realtime();
    Color themeColors = Color(0xFF1565c0);
    var now = DateTime.now();

    //print(DateFormat('hh:mm aaa').format(now));
    timerUnlock = DateFormat('hh:mm aaa').format(now);

    return Scaffold(
      backgroundColor: Color(0xFFe6ebf2),
      appBar: AppBar(
        backgroundColor: themeColors,
        title: Center(
          child: Text('REMOTE LOCKING'),
        ),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: 50.0,
          ),
          Stack(children: [
            Neumorphic(
              padding: EdgeInsets.all(20),
              style: NeumorphicStyle(
                  depth: 5,
                  //intensity: 1,
                  color: Color(0xFFe6ebf2),
                  shape: NeumorphicShape.flat,
                  oppositeShadowLightSource: true,
                  lightSource: LightSource.bottomLeft,
                  boxShape: NeumorphicBoxShape.circle()),
              child: Neumorphic(
                style: NeumorphicStyle(
                    depth: 2,
                   
                    color: (isLocked)?themeColors:Color(0xFFe6ebf2),
                    shape: NeumorphicShape.flat,
                    oppositeShadowLightSource: false,
                    lightSource: LightSource.bottomLeft,
                    boxShape: NeumorphicBoxShape.circle()),
                padding: EdgeInsets.all(11),
                child: GestureDetector(
                  onTap: () {
                    //Navigator.pushNamed(context, "/showCamera_page");
                  },
                  child: Neumorphic(
                    style: NeumorphicStyle(
                        depth: 2,
                        color: Color(0xFFe6ebf2),
                        shape: NeumorphicShape.convex,
                        oppositeShadowLightSource: true,
                        boxShape: NeumorphicBoxShape.circle()),
                    padding: EdgeInsets.all(5),
                    child: NeumorphicIcon(
                      Icons.house_rounded,
                      size: 220,
                      style: NeumorphicStyle(
                        depth: 4,
                        intensity: 1,
                        color: Color(0xFFe6ebf2),
                        shape: NeumorphicShape.flat,
                        oppositeShadowLightSource: true,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
                left: 1,
                top: 80,
                right: 1,
                bottom: null,
                child: Icon((isLocked) ? Icons.lock_outlined : Icons.lock_open_rounded,
                  size: 60,color: themeColors,))
          ]),
          SizedBox(
            height: 20.0,
          ),
          Text(
            (isLocked) ? "DOOR LOCKED" : "DOOR UNLOCKED",
            style: TextStyle(
                color: themeColors,
                fontFamily: "nunito",
                fontWeight: FontWeight.bold,
                fontSize: 30),
          ),
          SizedBox(
            height: 60.0,
          ),
          NeumorphicButton(
              //padding: EdgeInsets.all(8),
              style: NeumorphicStyle(
                depth: 3,
                intensity: 1,
                shape: NeumorphicShape.convex,
                color: Color(0xFFe6ebf2),
              ),
              onPressed: () {
                (isLocked) ? isAuthenticated = false : null;
                

                (isLocked)
                    ? _showLockScreen(
                        context,
                        opaque: false,
                        cancelButton: Text(
                          'Cancel',
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white),
                          semanticsLabel: 'Cancel',
                        ),
                      )
                    : setState(() {
                        isLocked = !isLocked;
                        bdref.child('Remote Locking').update({
                          'Door': (isLocked) ? 'Lock' : 'Unlock',
                        });
                      });
              },
              child: Text(
                (isLocked) ? "Unlock Door" : "Lock Door",
                style: TextStyle(
                    color: Colors.black.withOpacity(.6),
                    fontFamily: "nunito",
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              )),
          SizedBox(
            height: 60.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Last Unlocked",
                      style: TextStyle(
                          color: themeColors,
                          fontFamily: "nunito",
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    Text(last,
                        style: TextStyle(
                            color: Colors.black.withOpacity(.6),
                            fontFamily: "nunito",
                            //fontWeight: FontWeight.bold,
                            fontSize: 18))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Unlocked By',
                      style: TextStyle(
                          color: themeColors,
                          fontFamily: "Locked Status",
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    Text(by,
                        style: TextStyle(
                            color: Colors.black.withOpacity(.6),
                            fontFamily: "nunito",
                            //fontWeight: FontWeight.bold,
                            fontSize: 18))
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
