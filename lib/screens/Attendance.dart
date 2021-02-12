import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

class AttendancePage extends StatefulWidget {
  AttendancePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AttendancePageState createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  Color themeColors = Color(0xFF1565c0);
  bool isActived = false;

  @override
  void initState() {
    super.initState();
    realtime();
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
//     SystemChrome.setPreferredOrientations([
//    DeviceOrientation.portraitDown,
//    DeviceOrientation.portraitUp,
// ]);

    var now = new DateTime.now();
    var nowToday = new DateTime(now.year, now.month, now.day);
    var now_1d = new DateTime(now.year, now.month, now.day-2);
    var now_1w = now.subtract(Duration(days: 7));
    var now_1m = new DateTime(now.year, now.month-1, now.day);
    var now_1y = new DateTime(now.year - 1, now.month, now.day);
    var alltime = [now_1d, now_1w, now_1m, now_1y];
    var labelFilter = [
    "All",
    "Today",
    "Yesterday",
    "Last Week",
    "Last Month",
    "Older",
    "Pat Supat",
    "Taeng Jidapa",
    "Taem Potsathorn",
    "Tar Chanita"
  ];
  var labelFilterTH = [
    "ทั้งหมด",
    "วันนี้",
    "เมื่อวานนี้",
    "สัปดาห์ที่แล้ว",
    "เดือนที่แล้ว",
    "เก่ากว่า",
    "ภัทร์ สุภัทร์",
    "แตง จิดาภา",
    "แต้ม พสธร",
    "ต้า ชนิตา"
  ];

    List<UserInfo> filterShow() {
     
      if(selectFilter=="Today"){
        return memInfo.where((element) =>  DateTime(now.year, now.month, now.day) == DateFormat("dd/MM/yyyy").parse(element.date)).toList();
      }
      else if(selectFilter=="Yesterday"){
        return memInfo.where((element) =>  now_1d.isBefore(DateFormat("dd/MM/yyyy").parse(element.date)) && nowToday.isAfter(DateFormat("dd/MM/yyyy").parse(element.date))).toList();
      }
      else if(selectFilter=="Last Week"){
        return memInfo.where((element) =>  now_1w.isBefore(DateFormat("dd/MM/yyyy").parse(element.date))).toList();
      }
      else if(selectFilter=="Last Month"){
        return memInfo.where((element) =>  now_1m.isBefore(DateFormat("dd/MM/yyyy").parse(element.date))).toList();
      }
      else if(selectFilter=="Older"){
        return memInfo.where((element) =>  now_1m.isAfter(DateFormat("dd/MM/yyyy").parse(element.date))).toList();
      }
      else if(selectFilter=="Pat Supat"){
        return memInfo.where((element) => element.name=="Pat Supat").toList();
      }
      else if(selectFilter=="Taeng Jidapa"){
        return memInfo.where((element) => element.name=="Taeng Jidapa").toList();
      }
      else if(selectFilter=="Taem Potsathorn"){
        return memInfo.where((element) => element.name=="Taem Potsathorn").toList();
      }
      else if(selectFilter=="Tar Chanita"){
        return memInfo.where((element) => element.name=="Tar Chanita").toList();
      }

      return memInfo;
    }

    themeColors = Colors.blue[800];
    // print(memInfo.length);
    // print(now);
    //DateTime tempDate = new DateFormat("dd/MM/yyyy").parse("12/01/2021");
    //print(tempDate);

    memInfo.sort((b, a) {
      return a.id.compareTo(b.id);
    });

    toShowList =  filterShow();
    // reversedMemInfo.addAll(memInfo.where((element) {
    //   final date = element.date;
    //   DateTime tempDate = new DateFormat("dd/MM/yyyy").parse(date);
    // return now_1m.isBefore(tempDate);
    // }).toList());

    //print("----");

    // print(reversedMemInfo);
 

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.title)),
        backgroundColor: themeColors,
        actions: [
          PopupMenuButton(
              onSelected: (selectedValue) {
                print(selectedValue);
                selectFilter = selectedValue;
                setState(() {
                  
                });
               
              },
              itemBuilder: (BuildContext ctx) => [
                    for (int i = 0; i < labelFilter.length; i++)
                      PopupMenuItem(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(labelFilter[i]),
                              Icon(
                                (selectFilter == labelFilter[i])
                                    ? Icons.check_circle_outline_rounded
                                    : null,
                                color: themeColors,
                              ),
                            ],
                          ),
                          value: labelFilter[i]),
                  ])
        ],
      ),
      body: _getBodyWidget(),
    );
  }

  List<Map> listMembers = [];
  List<UserInfo> memInfo = [];
  List<UserInfo> toShowList = [];

  String selectFilter = "All";
  

  var membersAccess;
  final bdref = FirebaseDatabase.instance.reference();
  var realTimeData;

  void realtime() {
    bdref.child('Sound Alarm').onValue.listen((event) {
      var snapshot = event.snapshot;

      String value = snapshot.value['Alert'];

      (value == 'Active') ? isActived = true : isActived = false;
      // print(value);
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

      setState(() {});
    });
  }

  Widget _getBodyWidget() {
    return Container(
      child: HorizontalDataTable(
        leftHandSideColumnWidth: 165,
        rightHandSideColumnWidth: MediaQuery.of(context).size.width - 150,
        isFixedHeader: true,
        headerWidgets: _getTitleWidget(),
        leftSideItemBuilder: _generateFirstColumnRow,
        rightSideItemBuilder: _generateRightHandSideColumnRow,
        itemCount: toShowList.length,
        rowSeparatorWidget: const Divider(
          height: 15,
          thickness: 1.0,
        ),
        leftHandSideColBackgroundColor: Color(0xFFe6ebf2),
        rightHandSideColBackgroundColor: Color(0xFFe6ebf2),
      ),
      height: MediaQuery.of(context).size.height,
    );
  }

  List<Widget> _getTitleWidget() {
    return [
      FlatButton(
        padding: EdgeInsets.all(0),
        child: _getTitleItemWidget('Name', 500),
        onPressed: () {},
      ),
      FlatButton(
        padding: EdgeInsets.all(0),
        child: _getTitleItemWidget('Date', 95),
        onPressed: () {},
      ),
      _getTitleItemWidget('Time', 100),
    ];
  }

  Widget _getTitleItemWidget(String label, double width) {
    return Neumorphic(
      style: NeumorphicStyle(shape: NeumorphicShape.flat, intensity: 0),
      child: Container(
        color: Color(0xFFe6ebf2),
        child: Container(
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
          width: 80,
          height: 30,
          color: Color(0xFFe6ebf2),
          child: Text(
            label,
            style: TextStyle(
              color: Colors.blue[900],

              //letterSpacing: 1,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              fontFamily: "nunito",
            ),
          ),
        ),
        width: width,
        height: 20,
        padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
        alignment: Alignment.center,
      ),
    );
  }

  Widget _generateFirstColumnRow(BuildContext context, int index) {
    return Container(
      color: Color(0xFFe6ebf2),
      child: Neumorphic(
        style: NeumorphicStyle(
            shape: NeumorphicShape.flat, oppositeShadowLightSource: true),
        child: Container(
          color: Color(0xFFe6ebf2),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(2, 5, 1, 5),
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white,
                  backgroundImage: new AssetImage(toShowList[index].utlimg),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                toShowList[index].name,
                style: TextStyle(
                  color: themeColors,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: "nunito",
                ),
              ),
            ],
          ),
        ),
      ),
      width: 500,
      height: 45,
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return Row(
      children: <Widget>[
        Container(
          color: Color(0xFFe6ebf2),
          child: Text(
            toShowList[index].date,
            style: TextStyle(
              color: Colors.black.withOpacity(.7),
              fontFamily: "nunito",
            ),
          ),
          width: 95,
          height: 45,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
        ),
        Container(
          color: Color(0xFFe6ebf2),
          child: Text(
            toShowList[index].time,
            style: TextStyle(
              color: Colors.black.withOpacity(.7),
              fontFamily: "nunito",
            ),
          ),
          width: 100,
          height: 45,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
        ),
      ],
    );
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
