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


    (count == 0)?locationNum = ModalRoute.of(context).settings.arguments:locationNum;
    
    

    List<LocationInfo> location = [
      LocationInfo('Front Door', '1st Floor', '', '', '',
          'images/fd.png'),
      LocationInfo('Back Door', '1st Floor', 'NORMAL', 'NORMAL', 'NORMAL',
          'images/bd.png'),
      LocationInfo(
          "Living room's Window",
          '1st Floor',
          'NORMAL',
          'NORMAL',
          'NORMAL',
          'images/living.png'),
      LocationInfo(
          "Kitchen's Window",
          '1st Floor',
          'NORMAL',
          'NORMAL',
          'NORMAL',
          'images/kitchen.png'),
      LocationInfo("Stair's Window", '2nd Floor', 'NORMAL', 'NORMAL', 'NORMAL',
          'images/stair.png'),
      LocationInfo(
          "Pat Bedroom's Window",
          '2nd Floor',
          'NORMAL',
          'NORMAL',
          'NORMAL',
          'images/pat.png'),
      LocationInfo(
          "Taem Bedroom's Window",
          '2nd Floor',
          'NORMAL',
          'NORMAL',
          'NORMAL',
          'images/tmrm.png'),
      LocationInfo(
          "Taeng&Tar Room's Window",
          '2nd Floor',
          'NORMAL',
          'NORMAL',
          'NORMAL',
          'images/tng.png'),
    ];

    location[0].motionStatus = (noMotion) ? 'NORMAL' : 'DETECTED';
    location[0].vibrationStatus = (noVibration) ? 'NORMAL' : 'DETECTED';
    location[0].contactStatus = (noContact) ? 'NORMAL' : 'DETECTED';

    return Scaffold(
      backgroundColor: Color(0xFFe6ebf2),
      appBar: AppBar(
        backgroundColor:  themeColors,
        title: Center(
          child: Text('INTRUSION DETECTION'),
        ),
      ),
      body:  SingleChildScrollView(
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
                              color:
                                  (location[locationNum].motionStatus == 'NORMAL')
                                      ? themeColors
                                      : Colors.redAccent[700],
                            ),
                          ),
                        ),
                        title: Text(
                          'Motion Sensor',
                          style: TextStyle(
                            color:
                                (location[locationNum].motionStatus == 'NORMAL')
                                    ? themeColors
                                    : Colors.redAccent[700],

                            //letterSpacing: 1,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: "nunito",
                          ),
                        ),
                        // ignore: null_aware_before_operator
                        subtitle: Text(location[locationNum].motionStatus),
                        trailing: Icon(
                          (location[locationNum].motionStatus == 'NORMAL')
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
                                      'NORMAL')
                                  ? themeColors
                                  : Colors.redAccent[700],
                            ),
                          ),
                        ),
                        title: Text(
                          'Contact Sensor',
                          style: TextStyle(
                            color:
                                (location[locationNum].contactStatus == 'NORMAL')
                                    ? themeColors
                                    : Colors.redAccent[700],

                            //letterSpacing: 1,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: "nunito",
                          ),
                        ),
                        // ignore: null_aware_before_operator
                        subtitle: Text(location[locationNum].contactStatus),
                        trailing: Icon(
                          (location[locationNum].contactStatus == 'NORMAL')
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
                                      'NORMAL')
                                  ? themeColors
                                  : Colors.redAccent[700],
                            ),
                          ),
                        ),
                        title: Text(
                          'Vibration Sensor',
                          style: TextStyle(
                            color: (location[locationNum].vibrationStatus ==
                                    'NORMAL')
                                ? themeColors
                                : Colors.redAccent[700],

                            //letterSpacing: 1,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: "nunito",
                          ),
                        ),
                        // ignore: null_aware_before_operator
                        subtitle: Text(location[locationNum].vibrationStatus),
                        trailing: Icon(
                          (location[locationNum].vibrationStatus == 'NORMAL')
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

            // Neumorphic(
            //     padding: EdgeInsets.all(15),
            //     drawSurfaceAboveChild: true,
            //     child: Neumorphic(
            //       //padding: EdgeInsets.all(4),
            //       child: Container(
            //           width: 250,
            //           height: 250,
            //           decoration: new BoxDecoration(
            //               //shape: BoxShape.circle,
            //               image: new DecorationImage(
            //                   fit: BoxFit.fill, image: new NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTQVtMhWm3H7Vb8N07Tbb4V-ifx-bV9ncfyEQ&usqp=CAU")))),
            //       //margin: EdgeInsets.all(2),
            //     ))
          ],
        ),
      ),
      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,

      // Stack(
      //   overflow: Overflow.visible,
      //   children: [
      //     Container(
      //         width: MediaQuery.of(context).size.width,
      //         height: MediaQuery.of(context).size.height / 3,
      //         decoration: new BoxDecoration(
      //             image: new DecorationImage(
      //                 fit: BoxFit.fill,
      //                 image: new NetworkImage(
      //                     'https://www.everest.co.uk/globalassets/everest/windows/1_upvc-casement.jpg')))),
      //     Positioned(
      //         top: 5,
      //         right: 5,
      //         child: Icon(
      //           Icons.videocam,
      //           size: 40,
      //           color: Colors.black,
      //         )),
      //     Positioned(

      //       bottom: -35,
      //       right: 10,

      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.end,
      //         children: [
      //           _imgeCircle(
      //               'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTEthKqazQTT9z0aVJSRgKZM1B9wFVpICB0og&usqp=CAU'),
      //         ],
      //       ),
      //     )
      //   ],
      // ),
      // Padding(
      //   padding: const EdgeInsets.fromLTRB(5, 50, 0, 30),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.start,
      //     children: [
      //       Text("Window1 (Chanita's Bedroom)",
      //           style: Theme.of(context).textTheme.headline5),
      //     ],
      //   ),
      // ),
      // Expanded(
      //   flex: 1,
      //   child: Column(
      //   //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       ListTile(

      //         leading: _imgeCircle(
      //             'https://static.vecteezy.com/system/resources/thumbnails/000/352/807/small/Health__2861_29.jpg'),
      //         title: Text('Motion Detection'),
      //         subtitle: Text('NORMAL'),
      //       ),
      //       ListTile(
      //         leading: _imgeCircle(
      //             'https://png.pngtree.com/png-clipart/20190619/original/pngtree-vector-door-icon-png-image_3989612.jpg'),
      //         title: Text('Contact Detection'),
      //         subtitle: Text('NORMAL'),
      //       ),
      //       ListTile(
      //         leading: _imgeCircle(
      //             'https://cdn.iconscout.com/icon/premium/png-256-thumb/breaking-glass-1500093-1270804.png'),
      //         title: Text('Vibration Detection'),
      //         subtitle: Text('Detected !'),
      //         trailing: Icon(Icons.warning),
      // //       ),
      //     ],
      //   ),
      //)
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

// Widget _imgeCircle(String url) {
//   return Container(
//       width: 60.0,
//       height: 60.0,
//       decoration: new BoxDecoration(
//           shape: BoxShape.circle,
//           image: new DecorationImage(
//               fit: BoxFit.fill, image: new NetworkImage(url))));
// }
