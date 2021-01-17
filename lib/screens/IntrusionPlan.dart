import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:Security/widgets/CircleImg.dart';
import 'package:firebase_database/firebase_database.dart';

class IntrusionFirstPage extends StatefulWidget {
  IntrusionFirstPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _IntrusionFirstPageState createState() => _IntrusionFirstPageState();
}

class _IntrusionFirstPageState extends State<IntrusionFirstPage> {
  Color themeColors = Color(0xFF1565c0);

  @override
  void initState() {
    super.initState();
    realtime();
  }
  

  bool noMotion = false;
  bool noVibration = false;
  bool noContact = false;

  IconData iconSecurity = Icons.verified_user_outlined;

  // String statusMotion = "";
  // String statusVibration = "";
  // String statusContact = "";

  int locationNum = 0;
  bool isActived = false;

  final bdref = FirebaseDatabase.instance.reference();
  var realTimeData;

  void realtime() {
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
      setState(() {});
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
//     SystemChrome.setPreferredOrientations([
//    DeviceOrientation.portraitDown,
//    DeviceOrientation.portraitUp,
// ]);
    Widget _positionIcon(
        double left, double top, double right, double bottom, int idx) {
      return Positioned(
          left: left,
          top: top,
          right: right,
          bottom: bottom,
          child: NeumorphicButton(
            onPressed: () {
              Navigator.pushNamed(context, '/showIntrusion_page',
                  arguments: idx);
            },
            style: NeumorphicStyle(
                shape: NeumorphicShape.convex,
                color: themeColors,
                boxShape: NeumorphicBoxShape.circle()),
            padding: EdgeInsets.all(3),
            child: Icon(
              Icons.verified_user_outlined,
              size: 30,
              color: Color(0xFFe6ebf2),
            ),
          ));
    }

    if (noContact && noVibration && noMotion) {
      iconSecurity = Icons.verified_user_outlined;
    } else if (!noMotion && noContact && noVibration) {
      iconSecurity = Icons.directions_walk_rounded;
    } else if (noMotion && noContact && !noVibration) {
      iconSecurity = Icons.vibration_rounded;
    } else if (noMotion && !noContact && noVibration) {
      iconSecurity = Icons.sensor_door;
    } else {
      iconSecurity = Icons.warning_amber_rounded;
    }
    //realtime();

    // statusMotion = (noMotion) ? 'NORMAL' : 'DETECTED';
    // statusContact = (noVibration) ? 'NORMAL' : 'DETECTED';
    // statusVibration = (noContact) ? 'NORMAL' : 'DETECTED';

    return Scaffold(
        backgroundColor: Color(0xFFe6ebf2),
        appBar: AppBar(
          backgroundColor:  themeColors,
          title: Center(
            child: Text('INTRUSION DETECTION'),
          ),
        ),
        body: Stack(overflow: Overflow.visible, children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: new BoxDecoration(
                  image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new AssetImage(
                          'images/pn.png')))),
          _positionIcon(null, 43, 85, null, 7),
          _positionIcon(130, 43, null, null, 6),
          _positionIcon(75, 227, null, null, 5),
          _positionIcon(null, 247, 70, null, 4),
          //_positionIcon(72, null, null, 90), //*** */
          _positionIcon(null, null, 85, 275, 3),
          _positionIcon(85, null, null, 245, 2),
          _positionIcon(null, null, 160, 275, 1),
          Positioned(
              left: 65,
              bottom: 90,
              child: NeumorphicButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/showIntrusion_page",
                      arguments: 0);
                },
                style: NeumorphicStyle(
                    shape: NeumorphicShape.flat,
                    color: (noContact && noVibration && noMotion)
                        ? themeColors
                        : Colors.redAccent[700],
                    boxShape: NeumorphicBoxShape.circle()),
                padding: EdgeInsets.all(3),
                child: Icon(
                  iconSecurity,
                  size: 30,
                  color: Color(0xFFe6ebf2),
                ),
              ))
        ]
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
            ));
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
//               fit: BoxFit.fill, image: new AssetImage(url))));
// }
