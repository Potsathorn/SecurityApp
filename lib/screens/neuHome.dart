import 'dart:async';
import 'package:Security/widgets/SideBar.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:Security/widgets/circle.dart';
import 'package:Security/widgets/keyboard.dart';
import 'package:Security/screens/PassCode.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../SceneCubit.dart';
import 'PassCode.dart';

class NeuHome extends StatefulWidget {
  @override
  _NeuHomeState createState() => _NeuHomeState();
}

class _NeuHomeState extends State<NeuHome> {
  String groupScene;

  Future<Null> checkPreference() async {
    try {
      FirebaseMessaging firebaseMessaging = FirebaseMessaging();
      String token = await firebaseMessaging.getToken();
      print('token===> $token');
    } on Exception catch (_) {
      print('never reached');
    }
  }

  final StreamController<bool> _verificationNotifier =
      StreamController<bool>.broadcast();
  bool isAuthenticated = false;

  void _gotoCamera() {
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.landscapeLeft,
    //   DeviceOrientation.landscapeRight,
    // ]);
    Navigator.pushNamed(context, "/showCamera_page");
  }

  void _gotoIntrusion() {
    Navigator.pushNamed(context, "/showIntrusionfirst_page");
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

  String timerUnlock = "";

  bool noMotion = false;
  bool noVibration = false;
  bool noContact = false;
  bool isEnglish = true;

  String statusSecurity = 'Loading...';
  String statusSecurityDes = 'Loading...';
  IconData iconSecurity = Icons.verified_user_outlined;

  final bdref = FirebaseDatabase.instance.reference();
  var realTimeData;
  List<UserInfo> memInfo = [];

  void initState() {
    super.initState();
    readData();
    // realtime();
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

    bdref.child('Languages').onValue.listen((event) {
      var snapshot = event.snapshot;

      String value = snapshot.value;

      (value == 'English') ? isEnglish = true : isEnglish = false;
      //print(value);
    });

    bdref.child('Scene').onValue.listen((event) {
      var snapshot = event.snapshot;

      String value = snapshot.value['Scene'];

      // (value == 'Normal') ? noContact = true : noContact = false;
      if (value == "I'm Home") {
        groupScene = "I'm Home";
      } else if (value == "I'm Leave") {
        groupScene = "I'm Leave";
      } else if (value == "Good Morning") {
        groupScene = "Good Morning";
      } else {
        groupScene = "Good Night";
      }

      //print(value);
    });

    bdref.child('Members Access').onValue.listen((event) {
      memInfo.clear();
      listMembers.clear();

      var snapshot = event.snapshot;
      var members = snapshot.value;

      listMembers.add(members);

      for (var i in listMembers) {
        i.forEach((key, value) {
          String _genURL() {
            if (value['Name'] == 'Taem Potsathorn') {
              return "images/taem.png";
            } else if (value['Name'] == 'Taeng Jidapa') {
              return "images/taeng.png";
            } else if (value['Name'] == 'Tar Chanita') {
              return "images/ta.png";
            } else if (value['Name'] == 'Pat Supat') {
              return "images/supat.png";
            } else {
              return "images/def.png";
            }
          }

          memInfo.add(UserInfo(value['ID'], value['Name'], value['Date'],
              value['Time'], _genURL()));
        });
      }

      memInfo.sort((b, a) {
        return a.id.compareTo(b.id);
      });

      //print(memInfo[0].name);

      setState(() {});
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
        statusSecurityDes = (isEnglish)?'No intrusion was detected':'ไม่พบการบุกรุก';
        iconSecurity = Icons.verified_user_outlined;
        statusSecurity = (isEnglish)?'Undetected':'เหตุการณ์ปรกติ';
      } else if (!noMotion && noContact && noVibration) {
        statusSecurityDes = (isEnglish)?'Motion Sensor':'เซนเซอร์ตรวจจับความเคลื่อนไหว';
        iconSecurity = Icons.directions_walk_rounded;
        statusSecurity = (isEnglish)?'Motion was detected':'ตรวจพบความเคลื่อนไหว';
      } else if (noMotion && noContact && !noVibration) {
        statusSecurityDes = (isEnglish)?'Vibration Sensor':"เซนเซอร์ตรวจจับการสั่นสะเทือน";
        iconSecurity = Icons.vibration_rounded;
        statusSecurity = (isEnglish)?'Vibration was detected':"ตรวจพบการทุบกระจก";
      } else if (noMotion && !noContact && noVibration) {
        statusSecurityDes = (isEnglish)?'Contact Sensor':"เซนเซอร์ตรวจจับการเปิดประตู";
        iconSecurity = Icons.sensor_door;
        statusSecurity = (isEnglish)?'Contact was detected':"ขณะนี้ประตูเปิดอยู่";
      } else {
        statusSecurityDes = (isEnglish)?'Intrusion was detected':"ตรวจพบการบุกรุก";
        iconSecurity = Icons.warning_amber_rounded;
        statusSecurity = (isEnglish)?'Detected':"เหตุการณ์ไม่ปรกติ";
      }

      // membersAccess = realTimeData['Members Access'];

      // listMembers.add(membersAccess);

      // for (var i in listMembers) {
      //   i.forEach((key, value) {
      //     if (value['Status'] == 'In') {
      //       inMembers.add(key);
      //     } else {
      //       outMembers.add(key);
      //     }
      //   });
      // }
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
                (isEnglish)?'Enter App Passcode':"ป้อนรหัสผ่าน",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 28),
              ),
              passwordEnteredCallback: _onPasscodeEntered,
              cancelButton: cancelButton,
              deleteButton: Text(
                (isEnglish)?'Delete':"ลบ",
                style: const TextStyle(fontSize: 16, color: Colors.white),
                semanticsLabel:(isEnglish)?'Delete':"ลบ",
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
        this.isAuthenticated = isValid;
        isLocked = false;
        bdref.child('Remote Locking').update({
          'Door': (isLocked) ? 'Lock' : 'Unlock',
          'Last Unlocked': timerUnlock,
          'Unlocked By': 'Application',
        });
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
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitDown,
    //   DeviceOrientation.portraitUp,
    // ]);
    realtime();
    readData();
    //checkPreference();
    (isActived)
        ? themeColor = Colors.redAccent[700]
        : themeColor = Colors.blue[800];
    var now = DateTime.now();

    //print(DateFormat('hh:mm aaa').format(now));
    timerUnlock = DateFormat('hh:mm aaa').format(now);

    String groupSceneTH(){
      if(groupScene=="I'm Home"){
        groupScene="มีคนอยู่บ้าน";
      }
      else if(groupScene=="I'm Leave"){
        groupScene="ไม่มีคนอยู่บ้าน";
      }
      else if(groupScene=="Good Morning"){
        groupScene="อรุณสวัสดิ์";
      }
      else{
        groupScene="ราตรีสวัสดิ์";
      }
      return groupScene;
    }

    String nameTH(String thName){
      if (thName == 'Taem Potsathorn') {
              return "แต้ม พสธร";
            } else if (thName == 'Taeng Jidapa') {
              return "แตง จิดาภา";
            } else if (thName == 'Tar Chanita') {
              return "ต้า ชนิตา";
            } else if (thName == 'Pat Supat') {
              return "ภัทร์ สุภัทร์";
            } else {
              return "";
            }
    }

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

    FirebaseMessaging fcm  =  FirebaseMessaging();
   // print(fcm.getToken());
   //checkPreference();

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      endDrawer: InkWellDrawer(),
      backgroundColor: Color(0xFFe6ebf2),
      body: SingleChildScrollView(
              child: Column(
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
                        (isEnglish)?'Welcome Home!':'ยินดีต้อนรับกลับบ้านค่ะ',
                        style: TextStyle(
                          color: themeColor,
                         // letterSpacing: 1.5,
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: "nunito",
                        ),
                      ),
                      subtitle: Text(
                        (isEnglish)?'Taem Potsathorn':'คุณพสธร ดวงแก้วเจริญ',
                        style: TextStyle(
                          fontWeight: (!isEnglish)?FontWeight.bold:null,
                          fontSize: 19.0,
                        ),
                      ),
                      trailing: Builder(
                        builder: (cntx) =>GestureDetector(
                          onTap: (){
                            
                            Scaffold.of(cntx).openEndDrawer();
                          },
                              child: Container(
                              width: 50.0,
                              height: 50.0,
                              decoration: new BoxDecoration(
                                image: new DecorationImage(
                                    fit: BoxFit.fill,
                                    image: new AssetImage("images/taem.png")),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                shape: BoxShape.rectangle,
                              )),
                        ),
                      ),
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
                          //context.bloc<SceneCubit>().scenetoggle(value);
                          setState(() {
                            groupScene = value;
                            (groupScene != "I'm Home")
                                ? null
                                : bdref.child('Scene').update({
                                    'Scene': groupScene,
                                  });
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
                              SimpleLineIcons.home,
                              color: (groupScene == "I'm Home")
                                  ? Colors.white
                                  : Colors.black.withOpacity(.5),
                            ))),
                      ),
                      SizedBox(
                        width: 7.0,
                      ),
                      NeumorphicRadio(
                        groupValue: groupScene,
                        style:
                            NeumorphicRadioStyle(shape: NeumorphicShape.convex),
                        value: "I'm Leave",
                        onChanged: (value) {
                          //context.bloc<SceneCubit>().scenetoggle(value);
                          setState(() {
                            groupScene = value;
                            (groupScene != "I'm Leave")
                                ? null
                                : bdref.child('Scene').update({
                                    'Scene': groupScene,
                                  });
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
                            child: Stack(children: [
                              Positioned(
                                left: 2,
                                top: 4,
                                child: Icon(
                                  SimpleLineIcons.home,
                                  color: (groupScene == "I'm Leave")
                                      ? Colors.white
                                      : Colors.black.withOpacity(.5),
                                  size: 22,
                                ),
                              ),
                              Positioned(
                                right: 1,
                                bottom: 1,
                                child: Icon(
                                  Icons.directions_walk_rounded,
                                  color: (groupScene == "I'm Leave")
                                      ? Colors.white
                                      : Colors.black.withOpacity(.5),
                                  // size: 20,
                                ),
                              ),
                            ])),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      NeumorphicRadio(
                        groupValue: groupScene,
                        style:
                            NeumorphicRadioStyle(shape: NeumorphicShape.convex),
                        value: "Good Morning",
                        onChanged: (value) {
                          //context.bloc<SceneCubit>().scenetoggle(value);
                          setState(() {
                            groupScene = value;
                            (groupScene != "Good Morning")
                                ? null
                                : bdref.child('Scene').update({
                                    'Scene': groupScene,
                                  });
                          });
                        },
                        child: Container(
                            color: (groupScene == 'Good Morning')
                                ? (!isActived)
                                    ? themeColor
                                    : Color(0xFFd51a00)
                                : Color(0xFFe6ebf2),
                            height: 40,
                            width: 40,
                            child: Center(
                                child: Icon(
                              FontAwesome.sun_o,
                              color: (groupScene == 'Good Morning')
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
                          //context.bloc<SceneCubit>().scenetoggle(value);
                          setState(() {
                            groupScene = value;

                            (groupScene != "Good Night")
                                ? null
                                : bdref.child('Scene').update({
                                    'Scene': groupScene,
                                  });
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text((isEnglish)?"Scene":"โหมด",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.black.withOpacity(.5),
                                      fontWeight: FontWeight.bold,
                                    )),
                                Text((isEnglish)?groupScene:groupSceneTH(), //trow Excep debug
                                    style: TextStyle(
                                      fontSize: 17.0,
                                      color: (!isActived)
                                          ? themeColor
                                          : Color(0xFFd51a00),
                                      fontWeight: FontWeight.bold,
                                    )),
                              ],
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
                  (isEnglish)?'  Members Last Access':'  สมาชิกที่เข้าบ้านล่าสุด',
                  style: TextStyle(
                    color: Colors.black.withOpacity(.5),
                    letterSpacing: (isEnglish)?1:0,
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
                          radius: 30.0,
                          backgroundColor: Colors.white,
                          backgroundImage: new AssetImage(
                            // ignore: null_aware_before_operator
                            (memInfo?.length > 0
                                ? memInfo[0].utlimg
                                : "images/def.png"),
                          ),
                        ),
                        title: Text(
                          // ignore: null_aware_before_operator
                          (memInfo?.length > 0 ? (isEnglish)? memInfo[0].name:nameTH(memInfo[0].name) : 'loading...'),
                          style: TextStyle(
                            color: themeColor,

                            //letterSpacing: 1,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: "nunito",
                          ),
                        ),
                        // ignore: null_aware_before_operator
                        subtitle: Text(
                            // ignore: null_aware_before_operator
                            (memInfo?.length > 0 ? memInfo[0].date : 'loading...') +
                                ', ' +
                                // ignore: null_aware_before_operator
                                (memInfo?.length > 0 ? memInfo[0].time : '')),
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
                                color:
                                    (!isActived) ? themeColor : Color(0xFFd51a00),
                                size: 35,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                (isEnglish)? 'Intrusion Detection':'ระบบตรวจจับการบุกรุก',
                                style: TextStyle(
                                  color: (!isActived) ? themeColor : Color(0xFFd51a00),
                                  letterSpacing: (isEnglish)?1:0,
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
                              letterSpacing: (isEnglish)?1:0,
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
                              color:
                                  (!isActived) ? themeColor : Color(0xFFd51a00),
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
                            color: (!isActived) ? themeColor : Color(0xFFd51a00),
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
                  (isEnglish)?'  Security System Control':'  การควบคุมระบบรักษาความปลอดภัย',
                  style: TextStyle(
                    color: Colors.black.withOpacity(.5),
                    letterSpacing: (isEnglish)?1:0,
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
                                (isEnglish)?'Remote Locking':'ระบบล็อกจากระยะไกล',
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
                              (isEnglish)?'Manage your door latch':(isLocked) ?'สั่งการปลดล็อกประตู':'สั่งการล็อกประตู',
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
                              (isLocked) ? (isEnglish)?'Lock':'ล็อก' : (isEnglish)?'Unlock':'ไม่ล็อก',
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
                                  print(isLocked);

                                  (isLocked && !isAuthenticated)
                                      ? _showLockScreen(
                                          context,
                                          opaque: false,
                                          cancelButton: Text(
                                            (isEnglish)?'Cancel':"ยกเลิก",
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.white),
                                            semanticsLabel: (isEnglish)?'Cancel':"ยกเลิก",
                                          ),
                                        )
                                      : setState(() {
                                          isLocked = value;
                                          bdref.child('Remote Locking').update({
                                            'Door':
                                                (isLocked) ? 'Lock' : 'Unlock',
                                          });
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
                                (isEnglish)?'Security Lighting':'ระบบแสงสว่างอัจฉริยะ',
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
                              (isEnglish)?'Manage your lights':'ควบคุมแสงสว่างของบ้าน',
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
                              (isOn) ? (isEnglish)?'On':'เปิด' : (isEnglish)?'Off':'ปิด',
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
                                (isEnglish)?'Sound Alarm':'ระบบเสียงเตือนภัย',
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
                              (isEnglish)?'Manage your sound alarm':'ควบคุมการทำงานกริ่งเตือนภัย',
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
                              (isActived) ? (isEnglish)?'Active':'ทำงาน' : (isEnglish)?'Inactive':'ไม่ทำงาน',
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
                  style: NeumorphicStyle(
                    shape: NeumorphicShape.flat,
                    intensity: 1,
                  ),
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
                                (isEnglish)?'Video Streaming':'ระบบดูภาพเคลื่อนไหว',
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
                              (isEnglish)?'Monitors home activities':'ดูภาพเหตุการณ์บริเวณบ้าน',
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
                              (isEnglish)?'Streaming...':'สตรีมมิ่ง...',
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
      ),
    );
  }

  void dispose() {
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.landscapeRight,
    //   DeviceOrientation.landscapeLeft,
    //   // DeviceOrientation.portraitUp,
    //   // DeviceOrientation.portraitDown,
    // ]);
    _timer.cancel();
    super.dispose();
    _verificationNotifier.close();
  }
}

class UserInfo {
  int id;
  String name;
  String date;
  String time;
  String utlimg;

  UserInfo(this.id, this.name, this.date, this.time, this.utlimg);
}
