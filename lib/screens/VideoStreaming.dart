import 'dart:async';
import 'dart:ui';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gesture_zoom_box/gesture_zoom_box.dart';
import 'package:intl/intl.dart';
import 'package:save_in_gallery/save_in_gallery.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Home extends StatefulWidget {
  final WebSocketChannel channel;

  Home({Key key, @required this.channel}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isEnglish = true;
  bool isOn = false;
  bool isActived = false;
  bool isLocked = false;
  bool isOnControl = false;
  bool isActiveControl = false;
  bool isLockControl = true ;

  final bdref = FirebaseDatabase.instance.reference();
  var realTimeData;

  void realtime() {
    bdref.child('Languages').onValue.listen((event) {
      var snapshot = event.snapshot;

      String value = snapshot.value;

      (value == 'English') ? isEnglish = true : isEnglish = false;
      //print(value);
      setState(() {});
    });

    bdref.child('Security Light').onValue.listen((event) {
      var snapshot = event.snapshot;

      String value = snapshot.value['LightControl'];

      (value == 'On') ? isOnControl = true : isOnControl = false;
    });

    bdref.child('Rlock').onValue.listen((event) {
      var snapshot = event.snapshot;

      String value = snapshot.value;

      (value == 'Lock') ? isLockControl = true : isLockControl = false;
      
    });

    bdref.child('Security Light').onValue.listen((event) {
      var snapshot = event.snapshot;

      String value = snapshot.value['Light'];

      (value == 'On') ? isOn = true : isOn = false;
      //print(value);
    });
    bdref.child('Remote Locking').onValue.listen((event) {
      var snapshot = event.snapshot;

      String value = snapshot.value['Door'];

      (value == 'Lock') ? isLocked = true : isLocked = false;
    });

    bdref.child('Sound Alarm').onValue.listen((event) {
      var snapshot = event.snapshot;

      String value = snapshot.value['AlertControl'];

      (value == 'Active') ? isActiveControl = true : isActiveControl = false;
    });

    bdref.child('Sound Alarm').onValue.listen((event) {
      var snapshot = event.snapshot;

      String value = snapshot.value['Alert'];

      (value == 'Active') ? isActived = true : isActived = false;
      // print(value);
    });
  }

  Color themeColors = Color(0xFF1565c0);
  final double videoWidth = 640;
  final double videoHeight = 480;

  double newVideoSizeWidth = 640;
  double newVideoSizeHeight = 480;

  bool isLandscape;
  String _timeString;

  var _globalKey = new GlobalKey();
  final _imageSaver = ImageSaver();

  @override
  void initState() {
    super.initState();
    isLandscape = false;
    realtime();

    _timeString = _formatDateTime(DateTime.now());
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      // DeviceOrientation.landscapeRight,
      // DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    widget.channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    void _gotoLockink() {
      Navigator.pushNamed(context, "/showLocking_page");
    }

    void _gotoLightnig() {
      Navigator.pushNamed(context, "/showLightning_page");
    }

    void _gotoAlarm() {
      Navigator.pushNamed(context, "/showAlarm_page");
    }

    return Scaffold(
      backgroundColor: Color(0xFFe6ebf2),
      body: OrientationBuilder(builder: (context, orientation) {
        //     SystemChrome.setPreferredOrientations([
        //   DeviceOrientation.landscapeLeft,
        //   DeviceOrientation.landscapeRight,
        // ]);
        var screenWidth = MediaQuery.of(context).size.width;
        var screenHeight = MediaQuery.of(context).size.height;

        if (orientation == Orientation.portrait) {
          //screenWidth < screenHeight

          isLandscape = false;
          newVideoSizeWidth =
              screenWidth > videoWidth ? videoWidth : screenWidth;
          newVideoSizeHeight = videoHeight * newVideoSizeWidth / videoWidth;
        } else {
          isLandscape = true;
          newVideoSizeHeight =
              screenHeight > videoHeight ? videoHeight : screenHeight;
          newVideoSizeWidth = videoWidth * newVideoSizeHeight / videoHeight;
        }

        return Stack(overflow: Overflow.visible, children: [
          Container(
            color: Color(0xFFe6ebf2),
            child: StreamBuilder(
              stream: widget.channel.stream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  );
                } else {
                  return Center(
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: isLandscape ? 0 : 30,
                          ),
                          Stack(
                            overflow: Overflow.visible,
                            children: <Widget>[
                              RepaintBoundary(
                                key: _globalKey,
                                child: GestureZoomBox(
                                  maxScale: 5.0,
                                  doubleTapScale: 2.0,
                                  duration: Duration(milliseconds: 200),
                                  child: Image.memory(
                                    snapshot.data,
                                    gaplessPlayback: true,
                                    width: newVideoSizeWidth,
                                    height: newVideoSizeHeight,
                                  ),
                                ),
                              ),
                              Positioned.fill(
                                  child: Align(
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 16,
                                    ),
                                    Text(
                                      'Video Streaming',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      'Live | $_timeString',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                                alignment: Alignment.topCenter,
                              )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
          ),
          Positioned(
            top: 1,
            left: 10,
            child: Container(
              width: MediaQuery.of(context).size.height / 2.5,
              //   color: Colors.redAccent,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        (isEnglish) ? "Video Streaming" : "วิดีโอสตรีมมิ่ง",
                        style: TextStyle(
                            color: themeColors,
                            fontFamily: "nunito",
                            fontWeight: FontWeight.bold,
                            fontSize: (isEnglish) ? 20 : 20),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    padding: const EdgeInsets.all(1),
                    color: Colors.red,
                    child: Text((isEnglish) ? "Live" : "ถ่ายทอดสด",
                        style: TextStyle(
                            color: Colors.black.withOpacity(.6),
                            fontFamily: "nunito",
                            //fontWeight: FontWeight.bold,
                            fontSize: 15)),
                  ),
                  Text(
                    "$_timeString",
                    style: TextStyle(
                        color: Colors.black.withOpacity(.5),
                        // fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Text(
                    ((isEnglish) ? "Camera : " : "กล้อง"),
                    style: TextStyle(
                        color: themeColors,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                  Text(
                    "ESP32-CAM #1",
                    style: TextStyle(
                        color: Colors.black.withOpacity(.5),
                        // fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Text(
                    (isEnglish) ? "Location : " : "ตำแหน่ง",
                    style: TextStyle(
                        color: themeColors,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                  Text(
                    (isEnglish) ? "Front Yard" : "หน้าบ้าน",
                    style: TextStyle(
                        color: Colors.black.withOpacity(.5),
                        // fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                  SizedBox(
                    height: (isEnglish) ? 40 : 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      NeumorphicButton(
                        onPressed: () {
                          isOn = !isOn;
                          bdref.child('Security Light').update(
                              {'LightControl': (isOnControl) ? 'Off' : 'On'});
                          setState(() {});

                          // Navigator.pushNamed(context, '/showIntrusion_page',
                          //     arguments: idx);
                        },
                        style: NeumorphicStyle(
                          depth: 5,

                          //shadowDarkColor: Colors.yellow[700],
                          shape: NeumorphicShape.convex,
                          color: (isOn) ? themeColors : Color(0xFFe6ebf2),
                          //boxShape: NeumorphicBoxShape.circle()
                        ),
                        padding: EdgeInsets.all(8),
                        child: Icon(
                          Icons.lightbulb_outline,
                          color: (isOn)
                              ? Colors.white
                              : Colors.black.withOpacity(.5),
                        ),
                      ),
                      NeumorphicButton(
                        onPressed: () {
                          isLocked = !isLocked;
                          bdref.update({
                            'Rlock': (isLockControl) ? 'Unlock' : 'Lock',
                          });
                          setState(() {});

                          // Navigator.pushNamed(context, '/showIntrusion_page',
                          //     arguments: idx);
                        },
                        style: NeumorphicStyle(
                          depth: 5,

                          //shadowDarkColor: Colors.yellow[700],
                          shape: NeumorphicShape.convex,
                          color: (isLocked) ? themeColors : Color(0xFFe6ebf2),
                          //boxShape: NeumorphicBoxShape.circle()
                        ),
                        padding: EdgeInsets.all(8),
                        child: Icon(
                          Icons.lock_outline_rounded,
                          color: (isLocked)
                              ? Colors.white
                              : Colors.black.withOpacity(.5),
                        ),
                      ),
                      NeumorphicButton(
                        onPressed: () {
                          isActived = !isActived;
                          bdref.child('Sound Alarm').update({
                            'AlertControl':
                                (isActiveControl) ? 'Inactive' : 'Active'
                          });

                          setState(() {});

                          // Navigator.pushNamed(context, '/showIntrusion_page',
                          //     arguments: idx);
                        },
                        style: NeumorphicStyle(
                          depth: 5,

                          //shadowDarkColor: Colors.yellow[700],
                          shape: NeumorphicShape.convex,
                          color: (isActived) ? themeColors : Color(0xFFe6ebf2),
                          //boxShape: NeumorphicBoxShape.circle()
                        ),
                        padding: EdgeInsets.all(8),
                        child: Icon(
                          Icons.notifications_on_outlined,
                          color: (isActived)
                              ? Colors.white
                              : Colors.black.withOpacity(.5),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ]);
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: takeScreenShot,
        child: Icon(Icons.photo_camera),
        backgroundColor: themeColors,
      ),
    );
  }

  takeScreenShot() async {
    RenderRepaintBoundary boundary =
        _globalKey.currentContext.findRenderObject();
    var image = await boundary.toImage();
    var byteData = await image.toByteData(format: ImageByteFormat.png);
    var pngBytes = byteData.buffer.asUint8List();
    final res = await _imageSaver.saveImage(imageBytes: pngBytes);

    Fluttertoast.showToast(
        msg: res
            ? (isEnglish)
                ? "ScreenShot Saved"
                : "การบันทึกภาพสำเร็จ"
            : (isEnglish)
                ? "ScreenShot Failure!"
                : "การบันทึกภาพล้มเหลว",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('hh:mm:ss aaa').format(dateTime);
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    setState(() {
      _timeString = _formatDateTime(now);
    });
  }

  Widget _getFab() {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22),
      visible: isLandscape,
      curve: Curves.bounceIn,
      children: [
        SpeedDialChild(
          child: Icon(Icons.photo_camera),
          onTap: takeScreenShot,
        ),
        SpeedDialChild(child: Icon(Icons.videocam), onTap: () {})
      ],
    );
  }
}
