import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:Security/widgets/CircleImg.dart';
import 'package:firebase_database/firebase_database.dart';

class LightningControl extends StatefulWidget {
  LightningControl({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LightningControlState createState() => _LightningControlState();
}

class _LightningControlState extends State<LightningControl> {
  Color themeColors = Color(0xFF1565c0);

  @override
  void initState() {
    super.initState();
    realtime();
  }

  bool noMotion = false;
  bool noVibration = false;
  bool noContact = false;

  bool livingRM1 = false;
  bool livingRM2 = false;
  bool wc1 = false;
  bool kitchen = false;
  bool patRM = false;
  bool taemRM = false;
  bool ttRM = false;
  bool wc2 = false;
  bool stairs = false;
  bool  isOnControl = false;

  bool securityLight = false;

  bool allLight = false;
  bool firstFloor = false;
  bool secondFloor = false;
  bool isEnglish = true;

 

  IconData iconSecurity = Icons.verified_user_outlined;

  // String statusMotion = "";
  // String statusVibration = "";
  // String statusContact = "";

  int locationNum = 0;

  final bdref = FirebaseDatabase.instance.reference();
  var realTimeData;

  void realtime() {
    bdref.child('Security Light').onValue.listen((event) {
      var snapshot = event.snapshot;

      String value = snapshot.value['Light'];

      (value == 'On') ? securityLight = true : securityLight = false;
      //print(value);
      setState(() {});
    });

    bdref.child('Security Light').onValue.listen((event) {
      var snapshot = event.snapshot;

      String value = snapshot.value['LivingRM'];

      (value == 'On') ? livingRM1 = true : livingRM1 = false;
      //print(value);
    });

    bdref.child('Security Light').onValue.listen((event) {
      var snapshot = event.snapshot;

      String value = snapshot.value['Kitchen'];

      (value == 'On') ? kitchen = true : kitchen = false;
      //print(value);
    });

    bdref.child('Security Light').onValue.listen((event) {
      var snapshot = event.snapshot;

      String value = snapshot.value['LivingRM2'];

      (value == 'On') ? livingRM2 = true : livingRM2 = false;
      //print(value);
    });
    bdref.child('Security Light').onValue.listen((event) {
      var snapshot = event.snapshot;

      String value = snapshot.value['WC1'];

      (value == 'On') ? wc1 = true : wc1 = false;
      //print(value);
    });
    bdref.child('Security Light').onValue.listen((event) {
      var snapshot = event.snapshot;

      String value = snapshot.value['WC2'];

      (value == 'On') ? wc2 = true : wc2 = false;
      //print(value);
    });
    bdref.child('Security Light').onValue.listen((event) {
      var snapshot = event.snapshot;

      String value = snapshot.value['PatRM'];

      (value == 'On') ? patRM = true : patRM = false;
      //print(value);
    });
    bdref.child('Languages').onValue.listen((event) {
      var snapshot = event.snapshot;

      String value = snapshot.value;

      (value == 'English') ? isEnglish = true : isEnglish = false;
      //print(value);
    });

     bdref.child('Security Light').onValue.listen((event) {
      var snapshot = event.snapshot;

      String value = snapshot.value['LightControl'];

      (value == 'On') ? isOnControl = true : isOnControl = false;
      
    });

    bdref.child('Security Light').onValue.listen((event) {
      var snapshot = event.snapshot;

      String value = snapshot.value['TaemRM'];

      (value == 'On') ? taemRM = true : taemRM = false;
      //print(value);
    });
    bdref.child('Security Light').onValue.listen((event) {
      var snapshot = event.snapshot;

      String value = snapshot.value['TTRM'];

      (value == 'On') ? ttRM = true : ttRM = false;
      //print(value);
    });
    bdref.child('Security Light').onValue.listen((event) {
      var snapshot = event.snapshot;

      String value = snapshot.value['Stairs'];

      (value == 'On') ? stairs = true : stairs = false;
      //print(value);
    });
  }

  void _allLight() {
    if (allLight) {
      livingRM1 = true;
      livingRM2 = true;
      wc1 = true;
      kitchen = true;
      patRM = true;
      taemRM = true;
      ttRM = true;
      wc2 = true;
      stairs = true;
      securityLight = true;
    } else {
      livingRM1 = false;
      livingRM2 = false;
      wc1 = false;
      kitchen = false;
      patRM = false;
      taemRM = false;
      ttRM = false;
      wc2 = false;
      stairs = false;
      securityLight = false;
    }
  }

  void _firstFloor() {
    if (firstFloor) {
      livingRM1 = true;
      livingRM2 = true;
      wc1 = true;
      kitchen = true;
     // patRM = true;
     // taemRM = true;
     // ttRM = true;
     // wc2 = true;
     // stairs = true;
    } else {
      livingRM1 = false;
      livingRM2 = false;
      wc1 = false;
      kitchen = false;
     // patRM = false;
     // taemRM = false;
      //ttRM = false;
     // wc2 = false;
      //stairs = false;
    }
  }

  void _secondFloor() {
    if (secondFloor) {
      //livingRM1 = true;
      //livingRM2 = true;
      //wc1 = true;
      //kitchen = true;
      patRM = true;
      taemRM = true;
      ttRM = true;
      wc2 = true;
      stairs = true;
    } else {
      //livingRM1 = false;
      //livingRM2 = false;
      //wc1 = false;
      //kitchen = false;
      patRM = false;
      taemRM = false;
      ttRM = false;
      wc2 = false;
      stairs = false;
    }
  }

  String _securityLight() {
    if (!securityLight) {
      //livingRM1 = true;
      //livingRM2 = true;
      //wc1 = true;
      //kitchen = true;
      return (isEnglish)?'images/lt.png':'images/flthnos.png';
    } else {
      //livingRM1 = false;
      //livingRM2 = false;
      //wc1 = false;
      //kitchen = false;
      return (isEnglish)?'images/sl.png':'images/flth.png';
    }
   
  }

  void _updateData() {
    bdref.child('Security Light').update({
      "Kitchen": (kitchen)? "On":"Off",
      "Light": (isOnControl)? "Off":"On",
      "LivingRM": (livingRM1)? "On":"Off",
      "LivingRM2": (livingRM2)? "On":"Off",
      "PatRM": (patRM)? "On":"Off",
      "Stairs": (stairs)? "On":"Off",
      "TTRM": (ttRM)? "On":"Off",
      "TaemRM": (taemRM)? "On":"Off",
      "WC1": (wc1)? "On":"Off",
      "WC2": (wc2)? "On":"Off",
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget _positionIcon(
        double left, double top, double right, double bottom, String name) {
      bool status;
      if (name == "livingRM1") {
        status = livingRM1;
      } else if (name == "livingRM2") {
        status = livingRM2;
      } else if (name == "wc1") {
        status = wc1;
      } else if (name == "kitchen") {
        status = kitchen;
      } else if (name == "patRM") {
        status = patRM;
      } else if (name == "taemRM") {
        status = taemRM;
      } else if (name == "ttRM") {
        status = ttRM;
      } else if (name == "wc2") {
        status = wc2;
      } else {
        //stairs
        status = stairs;
      }

      

      return Positioned(
          left: left,
          top: top,
          right: right,
          bottom: bottom,
          child: NeumorphicButton(
            onPressed: () {
        
              if (name == "livingRM1") {
                livingRM1 = !livingRM1;
                status = !livingRM1;
              } else if (name == "livingRM2") {
                livingRM2 = !livingRM2;
                status = !livingRM2;
              } else if (name == "wc1") {
                wc1 = !wc1;
                status = !wc1;
              } else if (name == "kitchen") {
                kitchen = !kitchen;
                status = !kitchen;
              } else if (name == "patRM") {
                patRM = !patRM;
                status = !patRM;
              } else if (name == "taemRM") {
                taemRM = !taemRM;
                status = !taemRM;
              } else if (name == "ttRM") {
                ttRM = !ttRM;
                status = !ttRM;
              } else if (name == "wc2") {
                wc2 = !wc2;
                status = !wc2;
              } else {
                //stairs
                stairs = !stairs;
                status = !stairs;
              }
              _updateData();

              setState(() {});
            },
            style: NeumorphicStyle(
                depth: 10,
                shadowDarkColor: (status)
                    ? Colors.yellow[700]
                    : Colors.black.withOpacity(.5),
                shape: NeumorphicShape.convex,
                color: (status) ? Colors.yellow[700] : Color(0xFFe6ebf2),
                boxShape: NeumorphicBoxShape.circle()
                ),
            padding: EdgeInsets.all(4),
            child: Icon(
              FontAwesome.lightbulb_o,
              size: 25,
              color: (status) ? Colors.white : Colors.black.withOpacity(.5),
            ),
          ));
    }

  
    //realtime();

    // statusMotion = (noMotion) ? 'NORMAL' : 'DETECTED';
    // statusContact = (noVibration) ? 'NORMAL' : 'DETECTED';
    // statusVibration = (noContact) ? 'NORMAL' : 'DETECTED';

   (livingRM1 &&
      livingRM2 &&
      wc1&&
      kitchen &&
      patRM &&
      taemRM &&
      ttRM &&
      wc2 &&
      stairs &&
      securityLight) ? allLight = true : allLight=false;

      (livingRM1 &&
      livingRM2 &&
      wc1&&
      kitchen ) ? firstFloor = true : firstFloor=false;

      (
      patRM &&
      taemRM &&
      ttRM &&
      wc2 &&
      stairs) ? secondFloor = true : secondFloor=false;

    return Scaffold(
        backgroundColor: Color(0xFFe6ebf2),
        appBar: AppBar(
          backgroundColor: themeColors,
          title: Center(
            child: Text((isEnglish)?'SECURITY LIGHTING':'ระบบแสงสว่างอัจฉริยะ'),
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
                          _securityLight())))),
          _positionIcon(null, 85, 85, null, "ttRM"),
          _positionIcon(130, 85, null, null, "taemRM"),
          _positionIcon(75, 160, null, null, "patRM"),
          _positionIcon(170, 185, null, null, "wc2"),
          _positionIcon(null, 225, 70, null, "stairs"),
          //_positionIcon(72, null, null, 90), //*** */
          _positionIcon(null, null, 85, 250, "kitchen"),
          _positionIcon(85, null, null, 140, "livingRM1"),
          _positionIcon(null, null, 140, 149, "wc1"),
          _positionIcon(85, null, null, 225, "livingRM2"),
          // _positionIcon(null, null, 160, 275, true),
          Positioned(
              left: 1,
              top: null,
              right: 1,
              bottom: 19,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  NeumorphicButton(
                    onPressed: () {
                
                      firstFloor = !firstFloor;
                      _firstFloor();
                      setState(() {});
                      _updateData();
                      // Navigator.pushNamed(context, '/showIntrusion_page',
                      //     arguments: idx);
                    },
                    style: NeumorphicStyle(
                        depth: 5,

                        //shadowDarkColor: Colors.yellow[700],
                        shape: NeumorphicShape.convex,
                        color: (firstFloor) ? themeColors : Color(0xFFe6ebf2),
                        //boxShape: NeumorphicBoxShape.circle()
                        ),
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      Icons.looks_one_outlined,
                      size: 40,
                      color:
                          (firstFloor) ? Colors.white : Colors.black.withOpacity(.5),
                    ),
                  ),
                  NeumorphicButton(
                    onPressed: () {
              
                      secondFloor = !secondFloor;
                      _secondFloor();
                      setState(() {});
                      _updateData();
                      // Navigator.pushNamed(context, '/showIntrusion_page',
                      //     arguments: idx);
                    },
                    style: NeumorphicStyle(
                        depth: 5,

                        //shadowDarkColor: Colors.yellow[700],
                        shape: NeumorphicShape.convex,
                        color: (secondFloor) ?themeColors : Color(0xFFe6ebf2),
                        //boxShape: NeumorphicBoxShape.circle()
                        ),
                    padding: EdgeInsets.all(10),
                    child: Icon(
                     Icons.looks_two_outlined,
                      size: 40,
                      color:
                          (secondFloor) ? Colors.white : Colors.black.withOpacity(.5),
                    ),
                  ),
                  NeumorphicButton(
                    onPressed: () {
         
                      securityLight = !securityLight;
                      _securityLight();
                      setState(() {});
                      _updateData();
                      // Navigator.pushNamed(context, '/showIntrusion_page',
                      //     arguments: idx);
                    },
                    style: NeumorphicStyle(
                        depth: 5,

                        //shadowDarkColor: Colors.yellow[700],
                        shape: NeumorphicShape.convex,
                        color: (securityLight) ? themeColors : Color(0xFFe6ebf2),
                        //boxShape: NeumorphicBoxShape.circle()
                        ),
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      Icons.security_outlined,
                      size: 40,
                      color:
                          (securityLight) ? Colors.white : Colors.black.withOpacity(.5),
                    ),
                  ),
                  NeumorphicButton(
                    onPressed: () {
             
                      allLight = !allLight;
                      _allLight();
                      setState(() {});
                      _updateData();
                      // Navigator.pushNamed(context, '/showIntrusion_page',
                      //     arguments: idx);
                    },
                    style: NeumorphicStyle(
                        depth: 5,

                        //shadowDarkColor: Colors.yellow[700],
                        shape: NeumorphicShape.convex,
                        color: (allLight) ? themeColors : Color(0xFFe6ebf2),
                        //boxShape: NeumorphicBoxShape.circle()
                        ),
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      Icons.lightbulb_outline,
                      size: 40,
                      color:
                          (allLight) ? Colors.white : Colors.black.withOpacity(.5),
                    ),
                  ),
                  
                  
                  
                ],
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

Widget _bumpCircle(String iurl) {
  return Container(
      width: 50.0,
      height: 50.0,
      decoration: new BoxDecoration(
          shape: BoxShape.circle,
          image: new DecorationImage(
              fit: BoxFit.fill, image: new AssetImage(iurl))));
}

Widget _imgeCirclei(String url) {
  return Container(
      width: 90.0,
      height: 90.0,
      decoration: new BoxDecoration(
          shape: BoxShape.circle,
          image: new DecorationImage(
              fit: BoxFit.fill, image: new AssetImage(url))));
}
