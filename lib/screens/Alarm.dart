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
    //realtime();
  }

  bool isActive = false;
  String timerUnlock = "";
  bool  isEnglish = true;

  final bdref = FirebaseDatabase.instance.reference();
  var realTimeData;

  List<Map> listHistory = [];
  List<AlarmHistory> alarmInfo = [];
  List<AlarmHistory> inverseAlarmInfo = [];
  var membersAccess;

  void realtime() {
    bdref.child('Sound Alarm').onValue.listen((event) {
      var snapshot = event.snapshot;

      String value = snapshot.value['Alert'];

      (value == 'Active') ? isActive = true : isActive = false;
      //print(value);
      setState(() {});
      
      
    });
    bdref.child('Languages').onValue.listen((event) {
      var snapshot = event.snapshot;

      String value = snapshot.value;

      (value == 'English') ? isEnglish = true : isEnglish = false;
      //print(value);
    });


    bdref.child('Alarm History').onValue.listen((event) {
      alarmInfo.clear();
     listHistory.clear();

      var snapshot = event.snapshot;
      var members = snapshot.value;

     listHistory.add(members);

      for (var i in listHistory) {
        i.forEach((key, value) {
          

          alarmInfo.add(AlarmHistory(value['ID'], value['Type'], value['Date'],
              value['Time'], value['Location'] ));
        });
      }

      
    });
    
  }

  Color themeColors = Color(0xFF1565c0);
  @override
  Widget build(BuildContext context) {
   
    realtime();
    alarmInfo.sort((b, a) {
      return a.id.compareTo(b.id);
    });

    String typeTH(String tTH){
      if(tTH=="Contact"){
        return "งัดประตู";
      }
      else if(tTH=="Motion"){
        return "ความเคลื่อนไหว";
      }
      else{
        return "ทุบกระจก";
      }

    }

    String locatTH(String lTH){
      if(lTH=="Front Door"){
        return "ประตูหน้า";
      }
      else if(lTH=="Back Door"){
        return "ประตูหลัง";
      }
      else if(lTH=="Kitchen"){
        return "ห้องครัว";
      }
      else{
        return "ห้องนั่งเล่น";
      }

    }

    TableRow _tableRow(String type,String locat,String date,String time){
      return TableRow(children: [
                  Text(
                    type,
                    style: TextStyle(
                        color: Colors.black.withOpacity(.6),
                        fontFamily: "nunito",
                        // fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  Text(
                    locat,
                    style: TextStyle(
                        color: Colors.black.withOpacity(.6),
                        fontFamily: "nunito",
                        //fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  Text(
                    time,
                    style: TextStyle(
                        color: Colors.black.withOpacity(.6),
                        fontFamily: "nunito",
                        //fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  Text(
                   date,
                    style: TextStyle(
                        color: Colors.black.withOpacity(.6),
                        fontFamily: "nunito",

                        //fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                ]);
    }
    return Scaffold(
      backgroundColor: Color(0xFFe6ebf2),
      appBar: AppBar(
        backgroundColor: (isActive)? Colors.redAccent[700]: themeColors,
        title: Center(
          child: Text((isEnglish)?'SOUND ALARM SYSTEM':"ระบบเสียงเตือนภัย"),
        ),
      ),
      body: SingleChildScrollView(
              child: Column(
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
                iconColors: (isActive) ? Colors.redAccent[700] : themeColors,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              (isActive) ? (isEnglish)?"ACTIVE":"ทำงาน" : (isEnglish)?"INACTIVE":"ไม่ทำงาน",
              style: TextStyle(
                   color: (isActive)? Colors.redAccent[700]: themeColors,

                  fontFamily: "nunito",
                  fontWeight: FontWeight.bold,
                  fontSize: 28),
              
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
                  (isActive) ? (isEnglish)?"Inactivate Alarm Bell":"หยุดการทำงาน" : (isEnglish)?"Activate Alarm Bell":"สั่งการทำงาน",
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
                  child: Text((isEnglish)?'ALARM HISTORY':"ประวัติการเตือนภัย",
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
                      (isEnglish)?"Type":"ประเภท",
                      style: TextStyle(
                          color: Colors.black.withOpacity(.6),
                          fontFamily: "nunito",
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    Text(
                      (isEnglish)?"Location":"ตำแหน่ง",
                      style: TextStyle(
                          color: Colors.black.withOpacity(.6),
                          fontFamily: "nunito",
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    Text(
                      (isEnglish)?"Time":"เวลา",
                      style: TextStyle(
                          color: Colors.black.withOpacity(.6),
                          fontFamily: "nunito",
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    Text(
                     (isEnglish)?"Date":"วันที่",
                      style: TextStyle(
                          color: Colors.black.withOpacity(.6),
                          fontFamily: "nunito",

                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ]),


                  for (var i in alarmInfo)
                    _tableRow((isEnglish)?i.type:typeTH(i.type), (isEnglish)?i.locat:locatTH(i.locat), i.date, i.time)
                  
                  
                  
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


class AlarmHistory {
  int id;
  String type;
  String date;
  String time;
  String locat;

  AlarmHistory(this.id, this.type, this.date, this.time, this.locat);
}
