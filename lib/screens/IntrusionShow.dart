import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  int locationNum = 0;

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

    List<LocationInfo> location = [
      LocationInfo('Front Door', '', '', '',
          'https://scontent.fbkk3-3.fna.fbcdn.net/v/t1.15752-9/133693402_448213409889610_8975913812051939973_n.png?_nc_cat=104&ccb=2&_nc_sid=ae9488&_nc_eui2=AeH_LCMLAiDXQB_b6l14zTEDCpBTtLbCAekKkFO0tsIB6Y31-WCmJSOJxfPFlXcboEgLWo6kOXYbyyTZ04g-MbMn&_nc_ohc=tA46ULPiOCoAX8_nS74&_nc_ht=scontent.fbkk3-3.fna&oh=2b3feb853c4d74b4ef7d3bffabb464a6&oe=6018A53A'),
      LocationInfo('Next Door', 'NORMAL', 'NORMAL', 'NORMAL',
          'https://scontent.fbkk3-4.fna.fbcdn.net/v/t1.15752-9/134729772_317866069488773_361573051837134372_n.png?_nc_cat=108&ccb=2&_nc_sid=ae9488&_nc_eui2=AeGFAq-nk7o8kJsES81rIumVI5prKmqI6kEjmmsqaojqQbiRk_-s0B8OROqaS03askIVXJvSSRRFBR98a687KtGp&_nc_ohc=BY--BFejO_IAX8H3A3n&_nc_ht=scontent.fbkk3-4.fna&oh=30cd19e0f65a982a122c6c932af0e007&oe=60173ED2'),
      LocationInfo('Back Door', 'NORMAL', 'NORMAL', 'NORMAL',
          'https://scontent.fbkk4-4.fna.fbcdn.net/v/t1.15752-9/135297093_194822842359070_4370813469458184717_n.png?_nc_cat=111&ccb=2&_nc_sid=ae9488&_nc_eui2=AeFLrXPz4OWvD5NOWLkAFlLmVqxUOhAAANtWrFQ6EAAA2_qGnBs3nZOGU16QcHLIFN2hBREjDHmEAmTpXgGwjN8o&_nc_ohc=E9rEcI_5KNcAX_CRB6A&_nc_ht=scontent.fbkk4-4.fna&oh=bf8dcb11e2bae0b09bc902f18bfd0975&oe=6017AF16'),
      LocationInfo("Living Room's Window", 'NORMAL', 'NORMAL', 'NORMAL',
          'https://scontent.fbkk4-1.fna.fbcdn.net/v/t1.15752-9/135567816_2537981849827505_6685207942632704171_n.png?_nc_cat=107&ccb=2&_nc_sid=ae9488&_nc_eui2=AeFWyIMFVVita72aM1iCweizU-ywuZ5wgh9T7LC5nnCCH45TJgdspyIAAEvTz0UbTiay3ELmO0ew4vnUeHtQ5wS9&_nc_ohc=6ajbyD8PGbQAX94lvnK&_nc_ht=scontent.fbkk4-1.fna&oh=e080f254ee76fc2b0cbf3968ec34b1d4&oe=60177735'),
      LocationInfo("Kitchen's Window", 'NORMAL', 'NORMAL', 'NORMAL',
          'https://scontent.fbkk4-4.fna.fbcdn.net/v/t1.15752-9/134474047_401091994533191_2891419308019061032_n.png?_nc_cat=111&ccb=2&_nc_sid=ae9488&_nc_eui2=AeGOfgU68vwVVkdGhgPpgEt0MV8h05OKe58xXyHTk4p7n_673oIYK2QOHLSvMTFH7C3URy4OWRC74mIdloQYjv3R&_nc_ohc=Bpp9Kbm1QhQAX_Krbv2&_nc_ht=scontent.fbkk4-4.fna&oh=af493785cbafbda8a145d05d94407889&oe=60157121'),
      LocationInfo("Stair's Window", 'NORMAL', 'NORMAL', 'NORMAL',
          'https://scontent.fbkk3-3.fna.fbcdn.net/v/t1.15752-9/135347267_1026331314527037_5232366427455365012_n.png?_nc_cat=104&ccb=2&_nc_sid=ae9488&_nc_eui2=AeGAkqhbA_NJ0dvr46TlHJLP5mc-GZSzRd_mZz4ZlLNF30qJ4msO2CreaoMnGY_Ym9L_OIA_X9PiAEzC2wa0GogX&_nc_ohc=WM4zHHQb0y8AX_4sqnd&_nc_ht=scontent.fbkk3-3.fna&oh=06526d28967063ff10cff8fac2dc61f8&oe=6018BAEF'),
      LocationInfo("PAT Bedroom's Window", 'NORMAL', 'NORMAL', 'NORMAL',
          'https://scontent.fbkk3-4.fna.fbcdn.net/v/t1.15752-9/135218935_451625629199410_3815511025306032076_n.png?_nc_cat=108&ccb=2&_nc_sid=ae9488&_nc_eui2=AeH3tEoNuMLaZOBrCdyjc5wHlxV5q2EOFDiXFXmrYQ4UOAL9PDHtFLyucp30jeDjEOR_Gf_KzdeoJ2TGxFLsGfrA&_nc_ohc=7HJCCymCjG4AX9Dqja5&_nc_ht=scontent.fbkk3-4.fna&oh=a8ac6df080525cce1e7cb2c06e508c52&oe=60159FFD'),
      LocationInfo("Taem Bedroom's Window", 'NORMAL', 'NORMAL', 'NORMAL',
          'https://scontent.fbkk4-3.fna.fbcdn.net/v/t1.15752-9/134376058_2478421079120183_9048098443268557538_n.png?_nc_cat=100&ccb=2&_nc_sid=ae9488&_nc_eui2=AeFkFfEnXSiL1S_gpWG8DY1_Go59DUgm8lcajn0NSCbyV8nyU3VAhsNB9uYyyBe1ptiCLqM9AY_gkATekD3YgTMd&_nc_ohc=QvRI9K7IJ3YAX8cK1qg&_nc_ht=scontent.fbkk4-3.fna&oh=291b1eaeedbdee206fec85a3179fa42a&oe=6016FD87'),
      LocationInfo("Taeng&TAR Room's Window", 'NORMAL', 'NORMAL', 'NORMAL',
          'https://scontent.fbkk4-4.fna.fbcdn.net/v/t1.15752-9/134642100_239282994407159_6083245002180057512_n.png?_nc_cat=111&ccb=2&_nc_sid=ae9488&_nc_eui2=AeF73jW8j37DdCTbK9zzuxRKESCuCPqBrVoRIK4I-oGtWvOF7LfUKNFBVUPaZL2ovD86S00Ynu4WIDmzAOMs6ibt&_nc_ohc=6s3wDjeuJoEAX9tmSIu&_nc_ht=scontent.fbkk4-4.fna&oh=f0daae0d692bc122be78f67398af2d9e&oe=601627A1'),
    ];

    location[0].motionStatus = (noMotion) ? 'NORMAL' : 'DETECTED';
    location[0].vibrationStatus = (noVibration) ? 'NORMAL' : 'DETECTED';
    location[0].contactStatus = (noContact) ? 'NORMAL' : 'DETECTED';

    return Scaffold(
      backgroundColor: Color(0xFFe6ebf2),
      appBar: AppBar(
        backgroundColor: themeColors,
        title: Center(
          child: Text('INTRUSION DETECTION'),
        ),
      ),
      body: Column(
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
                child: Icon(Icons.arrow_back_ios_rounded),
                padding: EdgeInsets.all(10),
                onPressed: () {
                  (locationNum <= 0)
                      ? locationNum = location.length - 1
                      : locationNum = locationNum - 1;
                  setState(() {});
                },
              ),
              Text(
                location[locationNum].location,
                style: TextStyle(
                  color: themeColors,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: "nunito",
                ),
              ),
              NeumorphicButton(
                style: NeumorphicStyle(
                    shape: NeumorphicShape.flat, color: Color(0xFFe6ebf2)),
                child: Icon(Icons.arrow_forward_ios_rounded),
                padding: EdgeInsets.all(10),
                onPressed: () {
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
                            color: themeColors,
                          ),
                        ),
                      ),
                      title: Text(
                        'Motion Sensor',
                        style: TextStyle(
                          color: themeColors,

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
                              : Icons.warning_amber_rounded),
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
                            color: themeColors,
                          ),
                        ),
                      ),
                      title: Text(
                        'Contact Sensor',
                        style: TextStyle(
                          color: themeColors,

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
                              : Icons.warning_amber_rounded),
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
                            color: themeColors,
                          ),
                        ),
                      ),
                      title: Text(
                        'Vibration Sensor',
                        style: TextStyle(
                          color: themeColors,

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
                              : Icons.warning_amber_rounded,color: Colors.yellow[700],),
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
  String motionStatus;
  String vibrationStatus;
  String contactStatus;
  String imgUrl;

  LocationInfo(this.location, this.motionStatus, this.vibrationStatus,
      this.contactStatus, this.imgUrl);
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
