import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
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
      appBar: AppBar(
        backgroundColor: themeColors,
        title: Center(
          child: Text('Video Streaming'),
        ),
      ),
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
                              Positioned(
                                bottom: 1,
                                left: -3,
                                child: Container(
                                  child: Text(
                                    'helldo',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.white),
                                  ),
                                ),
                              )
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
            left: 5,
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Last Unlocked",
                        style: TextStyle(
                            color: themeColors,
                            fontFamily: "nunito",
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      Text("last",
                          style: TextStyle(
                              color: Colors.black.withOpacity(.6),
                              fontFamily: "nunito",
                              //fontWeight: FontWeight.bold,
                              fontSize: 18))
                    ],
                  ),
            ),
          )
        ]);
      }),
      floatingActionButton: _getFab(),
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
        msg: res ? "ScreenShot Saved" : "ScreenShot Failure!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('MM/dd hh:mm:ss aaa').format(dateTime);
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
