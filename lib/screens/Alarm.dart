import 'package:Security/widgets/CircleIcon.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class AlarmSystemPage extends StatefulWidget {
  AlarmSystemPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AlarmSystemPageState createState() => _AlarmSystemPageState();
}

class _AlarmSystemPageState extends State<AlarmSystemPage> {
  @override
  void initState() {
    super.initState();
    realtime();
  }

  bool isActive = false;
  String timerUnlock = "";

  final bdref = FirebaseDatabase.instance.reference();
  var realTimeData;

  void realtime() {
    bdref.child('Sound Alarm').onValue.listen((event) {
      var snapshot = event.snapshot;

      String value = snapshot.value['Alert'];

      (value == 'Active') ? isActive = true : isActive = false;
      //print(value);
      setState(() {});
    });
  }

  Color themeColors = Color(0xFF1565c0);
  @override
  Widget build(BuildContext context) {
    realtime();
    return Scaffold(
      backgroundColor: Color(0xFFe6ebf2),
      appBar: AppBar(
        backgroundColor: (isActive)? Colors.redAccent[700]: themeColors,
        title: Center(
          child: Text('SOUND ALARM SYSTEM'),
        ),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: 20.0,
          ),
          Container(
            height: 300,
            width: 300,
            child: CircleIcon(
              icon: (isActive)
                  ? Icons.notifications_active
                  : Icons.notifications_off,
              iconColors: (isActive) ? Colors.redAccent[700] : Color(0xFFe6ebf2),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          NeumorphicText(
            (isActive) ? "ACTIVE" : "INACTIVE",
            textStyle: NeumorphicTextStyle(
                // color: themeColors,

                fontFamily: "nunito",
                fontWeight: FontWeight.bold,
                fontSize: 28),
            style: NeumorphicStyle(
              depth: 3,
              intensity: 1,
              shape: NeumorphicShape.flat,
              color: (isActive)? Colors.redAccent[700]: themeColors,
            ),
          ),
          SizedBox(
            height: 10.0,
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
                isActive = !isActive;
                bdref.child('Sound Alarm').update({
                  'Alert': (isActive) ? 'Active' : 'Inactive',
                });
              },
              child: Text(
                (isActive) ? "Inactivate Alarm Bell" : "Activate Alarm Bell",
                style: TextStyle(
                    color: Colors.black.withOpacity(.6),
                    fontFamily: "nunito",
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              )),
          SizedBox(
            height: 20.0,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            color: (isActive)? Colors.redAccent[700]: themeColors,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text('ALARM HISTORY',
                    style: TextStyle(
                        color: Colors.white.withOpacity(.8),
                        fontFamily: "nunito",
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Table(
              children: [
                TableRow(children: [
                  Text(
                    'Type',
                    style: TextStyle(
                        color: Colors.black.withOpacity(.6),
                        fontFamily: "nunito",
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  Text(
                    'Location',
                    style: TextStyle(
                        color: Colors.black.withOpacity(.6),
                        fontFamily: "nunito",
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  Text(
                    'Time',
                    style: TextStyle(
                        color: Colors.black.withOpacity(.6),
                        fontFamily: "nunito",
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  Text(
                    'Date',
                    style: TextStyle(
                        color: Colors.black.withOpacity(.6),
                        fontFamily: "nunito",
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                ]),
                TableRow(children: [
                  Text(
                    'Motion',
                    style: TextStyle(
                        color: Colors.black.withOpacity(.6),
                        fontFamily: "nunito",
                        // fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  Text(
                    'Back Door',
                    style: TextStyle(
                        color: Colors.black.withOpacity(.6),
                        fontFamily: "nunito",
                        //fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  Text(
                    '10:52 AM',
                    style: TextStyle(
                        color: Colors.black.withOpacity(.6),
                        fontFamily: "nunito",
                        //fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  Text(
                    '4 Sep. 2020',
                    style: TextStyle(
                        color: Colors.black.withOpacity(.6),
                        fontFamily: "nunito",

                        //fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                ]),
                TableRow(children: [
                  Text(
                    'Vibration',
                    style: TextStyle(
                        color: Colors.black.withOpacity(.6),
                        fontFamily: "nunito",
                        // fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  Text(
                    'Windows1',
                    style: TextStyle(
                        color: Colors.black.withOpacity(.6),
                        fontFamily: "nunito",
                        //fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  Text(
                    '11:23 AM',
                    style: TextStyle(
                        color: Colors.black.withOpacity(.6),
                        fontFamily: "nunito",
                        //fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  Text(
                    '5 Sep. 2020',
                    style: TextStyle(
                        color: Colors.black.withOpacity(.6),
                        fontFamily: "nunito",
                        //fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                ]),
              ],
            ),
          )
        ],
      ),
    );
  }
}
