import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:Security/widgets/CircleImg.dart';
import 'package:firebase_database/firebase_database.dart';

class IntrusionShowPage extends StatefulWidget {
  IntrusionShowPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _IntrusionShowPageState createState() => _IntrusionShowPageState();
}

class _IntrusionShowPageState extends State<IntrusionShowPage> {
  Color themeColors = Color(0xFF1565c0);

  @override
  void initState() {
    super.initState();
    realtime();
  }

  bool noMotion = false;
  bool noVibration = false;
  bool noContact = false;
  bool isEnglish = true;

  bool isActived = false;

  int locationNum = 0;
  int count = 0;

  final bdref = FirebaseDatabase.instance.reference();
  var realTimeData;

  void realtime() {
    bdref.child('Intrusion Detection').onValue.listen((event) {
      var snapshot = event.snapshot;

      String value = snapshot.value['Motion'];

      (value == 'Normal') ? noMotion = true : noMotion = false;
      //print(value);
      setState(() {});
    });

    bdref.child('Sound Alarm').onValue.listen((event) {
      var snapshot = event.snapshot;

      String value = snapshot.value['Alert'];

      (value == 'Active') ? isActived = true : isActived = false;
      // print(value);
    });
    bdref.child('Languages').onValue.listen((event) {
      var snapshot = event.snapshot;

      String value = snapshot.value;

      (value == 'English') ? isEnglish = true : isEnglish = false;
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

  @override
  Widget build(BuildContext context) {
    //realtime();
//     SystemChrome.setPreferredOrientations([
//    DeviceOrientation.portraitDown,
//    DeviceOrientation.portraitUp,
// ]);

    (count == 0)
        ? locationNum = ModalRoute.of(context).settings.arguments
        : locationNum;

    List<LocationInfo> location = [
      LocationInfo(
          (isEnglish) ? 'Front Door' : 'ประตูหน้าบ้าน',
          (isEnglish) ? '1st Floor' : 'ชั้น 1',
          (isEnglish) ? 'NORMAL' : 'ปรกติ',
          (isEnglish) ? 'NORMAL' : 'ปรกติ',
          (isEnglish) ? 'NORMAL' : 'ปรกติ',
          'images/fd.png'),
      LocationInfo(
          (isEnglish) ? 'Back Door' : 'ประตูหลังบ้าน',
          (isEnglish) ? '1st Floor' : 'ชั้น 1',
          (isEnglish) ? 'NORMAL' : 'ปรกติ',
          (isEnglish) ? 'NORMAL' : 'ปรกติ',
          (isEnglish) ? 'NORMAL' : 'ปรกติ',
          'images/bd.png'),
      LocationInfo(
          (isEnglish) ? "Living room's Window" : 'หน้าต่างห้องนั่งเล่น',
          (isEnglish) ? '1st Floor' : 'ชั้น 1',
          (isEnglish) ? 'NORMAL' : 'ปรกติ',
          (isEnglish) ? 'NORMAL' : 'ปรกติ',
          (isEnglish) ? 'NORMAL' : 'ปรกติ',
          'images/living.png'),
      LocationInfo(
          (isEnglish) ? "Kitchen's Window" : "หน้าต่างห้องครัว",
          (isEnglish) ? '1st Floor' : 'ชั้น 1',
          (isEnglish) ? 'NORMAL' : 'ปรกติ',
          (isEnglish) ? 'NORMAL' : 'ปรกติ',
          (isEnglish) ? 'NORMAL' : 'ปรกติ',
          'images/kitchen.png'),
      LocationInfo(
          (isEnglish) ? "Stair's Window" : "หน้าต่างบันได",
          (isEnglish) ? '2st Floor' : 'ชั้น 2',
          (isEnglish) ? 'NORMAL' : 'ปรกติ',
          (isEnglish) ? 'NORMAL' : 'ปรกติ',
          (isEnglish) ? 'NORMAL' : 'ปรกติ',
          'images/stair.png'),
      LocationInfo(
          (isEnglish) ? "Pat Bedroom's Window" : "หน้าต่างห้องคุณสุภัทร์",
          (isEnglish) ? '2st Floor' : 'ชั้น 2',
          (isEnglish) ? 'NORMAL' : 'ปรกติ',
          (isEnglish) ? 'NORMAL' : 'ปรกติ',
          (isEnglish) ? 'NORMAL' : 'ปรกติ',
          'images/pat.png'),
      LocationInfo(
          (isEnglish) ? "Taem Bedroom's Window" : 'หน้าต่างห้องแต้ม',
          (isEnglish) ? '2st Floor' : 'ชั้น 2',
          (isEnglish) ? 'NORMAL' : 'ปรกติ',
          (isEnglish) ? 'NORMAL' : 'ปรกติ',
          (isEnglish) ? 'NORMAL' : 'ปรกติ',
          'images/tmrm.png'),
      LocationInfo(
          (isEnglish) ? "Taeng&Tar Room's Window" : "หน้าต่างห้องแตงและต้า",
          (isEnglish) ? '2st Floor' : 'ชั้น 2',
          (isEnglish) ? 'NORMAL' : 'ปรกติ',
          (isEnglish) ? 'NORMAL' : 'ปรกติ',
          (isEnglish) ? 'NORMAL' : 'ปรกติ',
          'images/tng.png'),
    ];

    location[0].motionStatus = (noMotion)
        ? (isEnglish)
            ? 'NORMAL'
            : 'ปรกติ'
        : (isEnglish)
            ? 'DETECTED'
            : 'ตรวจพบความเคลื่อนไหว';
    location[0].vibrationStatus = (noVibration)
        ? (isEnglish)
            ? 'NORMAL'
            : 'ปรกติ'
        : (isEnglish)
            ? 'DETECTED'
            : 'ตรวจพบการทุบกระจก';
    location[0].contactStatus = (noContact)
        ? (isEnglish)
            ? 'NORMAL'
            : 'ปรกติ'
        : (isEnglish)
            ? 'DETECTED'
            : 'ตรวจพบการเปิดประตู';

    return Scaffold(
      backgroundColor: Color(0xFFe6ebf2),
      appBar: AppBar(
        backgroundColor: themeColors,
        title: Center(
          child: Text(
              (isEnglish) ? 'INTRUSION DETECTION' : 'ระบบตรวจจับการบุกรุก'),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NeumorphicButton(
                  style: NeumorphicStyle(
                      shape: NeumorphicShape.flat, color: Color(0xFFe6ebf2)),
                  child: Icon(Icons.arrow_back_ios_rounded,
                      color: Colors.black.withOpacity(0.5)),
                  padding: EdgeInsets.all(10),
                  onPressed: () {
                    count++;
                    (locationNum <= 0)
                        ? locationNum = location.length - 1
                        : locationNum = locationNum - 1;
                    setState(() {});
                  },
                ),
                Column(
                  children: [
                    Text(
                      location[locationNum].location,
                      style: TextStyle(
                        color: themeColors,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: "nunito",
                      ),
                    ),
                    Text(
                      location[locationNum].floor,
                      style: TextStyle(
                        color: themeColors,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: "nunito",
                      ),
                    ),
                  ],
                ),
                NeumorphicButton(
                  style: NeumorphicStyle(
                      shape: NeumorphicShape.flat, color: Color(0xFFe6ebf2)),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.black.withOpacity(0.5),
                  ),
                  padding: EdgeInsets.all(10),
                  onPressed: () {
                    count++;
                    (locationNum >= location.length - 1)
                        ? locationNum = 0
                        : locationNum = locationNum + 1;
                    setState(() {});
                  },
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 300,
              width: 300,
              child: CircleImg(imgurl: location[locationNum].imgUrl),
            ),
            SizedBox(
              height: 20,
            ),
            Neumorphic(
                style: NeumorphicStyle(
                  depth: 3,
                  shape: NeumorphicShape.flat,
                ),
                child: Container(
                  color: Color(0xFFe6ebf2),
                  width: MediaQuery.of(context).size.width - 50,

                  // height: 50.0,
                  child: Column(
                    children: [
                      ListTile(
                        leading: Neumorphic(
                          style: NeumorphicStyle(
                              depth: 2,
                              color: Color(0xFFe6ebf2),
                              shape: NeumorphicShape.flat,
                              oppositeShadowLightSource: true),
                          padding: EdgeInsets.all(5),
                          child: Neumorphic(
                            style: NeumorphicStyle(
                                depth: 2,
                                color: Color(0xFFe6ebf2),
                                shape: NeumorphicShape.flat,
                                oppositeShadowLightSource: true),
                            padding: EdgeInsets.all(5),
                            child: Icon(
                              Icons.directions_walk_rounded,
                              size: 30,
                              color: (location[locationNum].motionStatus ==
                                          'NORMAL' ||
                                      location[locationNum].motionStatus ==
                                          'ปรกติ')
                                  ? themeColors
                                  : Colors.redAccent[700],
                            ),
                          ),
                        ),
                        title: Text(
                          (isEnglish)
                              ? 'Motion Sensor'
                              : 'เซนเซอร์ตรวจจับความเคลื่อนไหว',
                          style: TextStyle(
                            color: (location[locationNum].motionStatus ==
                                        'NORMAL' ||
                                    location[locationNum].motionStatus ==
                                        'ปรกติ')
                                ? themeColors
                                : Colors.redAccent[700],

                            //letterSpacing: 1,
                            fontSize: (isEnglish) ? 15.0 : 12,
                            fontWeight: FontWeight.bold,
                            fontFamily: "nunito",
                          ),
                        ),
                        // ignore: null_aware_before_operator
                        subtitle: Text(location[locationNum].motionStatus),
                        trailing: Icon(
                          (location[locationNum].motionStatus == 'NORMAL' ||
                                  location[locationNum].motionStatus == 'ปรกติ')
                              ? null
                              : Icons.warning_amber_rounded,
                          color: Colors.redAccent[700],
                        ),
                        onTap: () {
                          // _gotoAttendance();
                        },
                      ),
                    ],
                  ),
                )),
            SizedBox(
              height: 12,
            ),
            Neumorphic(
                style: NeumorphicStyle(
                  depth: 3,
                  shape: NeumorphicShape.flat,
                ),
                child: Container(
                  color: Color(0xFFe6ebf2),
                  width: MediaQuery.of(context).size.width - 50,

                  // height: 50.0,
                  child: Column(
                    children: [
                      ListTile(
                        leading: Neumorphic(
                          style: NeumorphicStyle(
                              depth: 2,
                              color: Color(0xFFe6ebf2),
                              shape: NeumorphicShape.flat,
                              oppositeShadowLightSource: true),
                          padding: EdgeInsets.all(5),
                          child: Neumorphic(
                            style: NeumorphicStyle(
                                depth: 2,
                                color: Color(0xFFe6ebf2),
                                shape: NeumorphicShape.flat,
                                oppositeShadowLightSource: true),
                            padding: EdgeInsets.all(5),
                            child: Icon(
                              Icons.sensor_door,
                              size: 30,
                              color: (location[locationNum].contactStatus ==
                                          'NORMAL' ||
                                      location[locationNum].contactStatus ==
                                          'ปรกติ')
                                  ? themeColors
                                  : Colors.redAccent[700],
                            ),
                          ),
                        ),
                        title: Text(
                          (isEnglish)
                              ? 'Contact Sensor'
                              : "เซนเซอร์ตรวจจับการเปิดประตู",
                          style: TextStyle(
                            color: (location[locationNum].contactStatus ==
                                        'NORMAL' ||
                                    location[locationNum].contactStatus ==
                                        'ปรกติ')
                                ? themeColors
                                : Colors.redAccent[700],

                            //letterSpacing: 1,
                            fontSize: (isEnglish) ? 15.0 : 12,
                            fontWeight: FontWeight.bold,
                            fontFamily: "nunito",
                          ),
                        ),
                        // ignore: null_aware_before_operator
                        subtitle: Text(location[locationNum].contactStatus),
                        trailing: Icon(
                          (location[locationNum].contactStatus == 'NORMAL' ||
                                  location[locationNum].contactStatus ==
                                      'ปรกติ')
                              ? null
                              : Icons.warning_amber_rounded,
                          color: Colors.redAccent[700],
                        ),
                        onTap: () {
                          // _gotoAttendance();
                        },
                      ),
                    ],
                  ),
                )),
            SizedBox(
              height: 12,
            ),
            Neumorphic(
                style: NeumorphicStyle(
                  depth: 3,
                  shape: NeumorphicShape.flat,
                ),
                child: Container(
                  color: Color(0xFFe6ebf2),
                  width: MediaQuery.of(context).size.width - 50,

                  // height: 50.0,
                  child: Column(
                    children: [
                      ListTile(
                        leading: Neumorphic(
                          style: NeumorphicStyle(
                              depth: 2,
                              color: Color(0xFFe6ebf2),
                              shape: NeumorphicShape.flat,
                              oppositeShadowLightSource: true),
                          padding: EdgeInsets.all(5),
                          child: Neumorphic(
                            style: NeumorphicStyle(
                                depth: 2,
                                color: Color(0xFFe6ebf2),
                                shape: NeumorphicShape.flat,
                                oppositeShadowLightSource: true),
                            padding: EdgeInsets.all(5),
                            child: Icon(
                              Icons.vibration_rounded,
                              size: 30,
                              color: (location[locationNum].vibrationStatus ==
                                          'NORMAL' ||
                                      location[locationNum].vibrationStatus ==
                                          'ปรกติ')
                                  ? themeColors
                                  : Colors.redAccent[700],
                            ),
                          ),
                        ),
                        title: Text(
                          (isEnglish)
                              ? 'Vibration Sensor'
                              : "เซนเซอร์ตรวจจับการสั่นสะเทือน",
                          style: TextStyle(
                            color: (location[locationNum].vibrationStatus ==
                                        'NORMAL' ||
                                    location[locationNum].vibrationStatus ==
                                        'ปรกติ')
                                ? themeColors
                                : Colors.redAccent[700],

                            //letterSpacing: 1,
                            fontSize: (isEnglish) ? 15.0 : 12,
                            fontWeight: FontWeight.bold,
                            fontFamily: "nunito",
                          ),
                        ),
                        // ignore: null_aware_before_operator
                        subtitle: Text(location[locationNum].vibrationStatus),
                        trailing: Icon(
                          (location[locationNum].vibrationStatus == 'NORMAL' ||
                                  location[locationNum].vibrationStatus ==
                                      'ปรกติ')
                              ? null
                              : Icons.warning_amber_rounded,
                          color: Colors.redAccent[700],
                        ),
                        onTap: () {
                          // _gotoAttendance();
                        },
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

class LocationInfo {
  String location;
  String floor;
  String motionStatus;
  String vibrationStatus;
  String contactStatus;
  String imgUrl;

  LocationInfo(this.location, this.floor, this.motionStatus,
      this.vibrationStatus, this.contactStatus, this.imgUrl);
}
