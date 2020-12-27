import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:firebase_database/firebase_database.dart';

class AttendancePage extends StatefulWidget {
  AttendancePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AttendancePageState createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
 
  Color themeColors = Color(0xFF1565c0);

  @override
  void initState() {
    // user.initData(100);
    //memInfo = [];
    super.initState();
    realtime();
    //memInfo = [];
  }

  void dispose() {
    super.dispose();
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    //realtime();

    //readData();
    //memInfo = [];

    print(memInfo.length);

    memInfo.sort((b, a) {
      return a.id.compareTo(b.id);
    });

  

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: themeColors,
      ),
      body: _getBodyWidget(),
    );
  }

  // void readData() {

  //   bdref.once().then((DataSnapshot dataSnapshot) {
  //     realTimeData = dataSnapshot.value;

  //     membersAccess = realTimeData['Members Access'];
  //     print(membersAccess);

  //   });

  // }
  List<String> inMembers = [];
  List<String> outMembers = [];
  List<Map> listMembers = [];
  List<UserInfo> memInfo = [];
  List<UserInfo> reversedMemInfo = [];
  var membersAccess;
  final bdref = FirebaseDatabase.instance.reference();
  var realTimeData;

  void realtime() {
    // bdref.child('Security Light').onValue.listen((event) {
    //   var snapshot = event.snapshot;

    //   String value = snapshot.value['Light'];

    //   print(value);

    //   //setState(() {});
    // });

    bdref.child('Members Access').onValue.listen((event) {
      memInfo.clear();
      listMembers.clear();

      var snapshot = event.snapshot;
      var members = snapshot.value;

      //print(members);

      listMembers.add(members);

      for (var i in listMembers) {
        i.forEach((key, value) {
          String _genURL() {
            if (value['Name'] == 'T Potsathorn') {
              return "https://cdn3.iconfinder.com/data/icons/business-round-flat-vol-1-1/36/user_account_profile_avatar_person_businessman_old-512.png";
            } else if (value['Name'] == 'Taeng Jidapa') {
              return "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTQVtMhWm3H7Vb8N07Tbb4V-ifx-bV9ncfyEQ&usqp=CAU";
            } else if (value['Name'] == 'Tar Chanita') {
              return "https://icons-for-free.com/iconfiles/png/512/avatar+contact+people+profile+profile+photo+user+icon-1320086030365969618.png";
            } else {
              return "https://lh5.ggpht.com/_S0f-AWxKVdM/S5TpU6kRmUI/AAAAAAAAL4Y/wrjx3_23kw4/s72-c/d_silhouette%5B2%5D.jpg?imgmax=800";
            }
          }

          memInfo.add(UserInfo(value['ID'], value['Name'], value['Date'],
              value['Time'], _genURL()));
        });
      }

      setState(() {});
      //setState(() {});

      //setState(() {});
    });

    // bdref.child('Members Access').onValue.listen((event) {
    //   var snapshot = event.snapshot;

    //   print(snapshot);

    //   //setState(() {});
    // });
  }

  Widget _getBodyWidget() {
    return Container(
      child: HorizontalDataTable(
        leftHandSideColumnWidth: 150,
        rightHandSideColumnWidth: MediaQuery.of(context).size.width - 150,
        isFixedHeader: true,
        headerWidgets: _getTitleWidget(),
        leftSideItemBuilder: _generateFirstColumnRow,
        rightSideItemBuilder: _generateRightHandSideColumnRow,
        itemCount: memInfo.length,
        rowSeparatorWidget: const Divider(
          color: Colors.black54,
          height: 1.0,
          thickness: 0.0,
        ),
        leftHandSideColBackgroundColor: Color(0xFFFFFFFF),
        rightHandSideColBackgroundColor: Color(0xFFFFFFFF),
      ),
      height: MediaQuery.of(context).size.height,
    );
  }

  List<Widget> _getTitleWidget() {
    return [
      FlatButton(
        padding: EdgeInsets.all(0),
        child: _getTitleItemWidget('Name', 150),
        onPressed: () {
          // sortType = sortName;
          // isAscending = !isAscending;
          // user.sortName(isAscending);
          // setState(() {});
        },
      ),
      FlatButton(
        padding: EdgeInsets.all(0),
        child: _getTitleItemWidget('Date', 110),
        onPressed: () {
          // sortType = sortStatus;
          // isAscending = !isAscending;
          // user.sortStatus(isAscending);
          // setState(() {});
        },
      ),
      _getTitleItemWidget('Time', 100),
    ];
  }

  Widget _getTitleItemWidget(String label, double width) {
    return Neumorphic(
      style: NeumorphicStyle(
          shape: NeumorphicShape.convex, boxShape: NeumorphicBoxShape.rect()),
      child: Container(
        color: Color(0xFFe6ebf2),
        child: Text(
          label,
          style: TextStyle(
            color: themeColors,

            //letterSpacing: 1,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
            fontFamily: "nunito",
          ),
        ),
        width: width,
        height: 56,
        padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
        alignment: Alignment.center,
      ),
    );
  }

  Widget _generateFirstColumnRow(BuildContext context, int index) {
    return Container(
      color: Color(0xFFe6ebf2),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            backgroundImage: new NetworkImage(memInfo[index].utlimg),
          ),
          SizedBox(
            width: 5,
          ),
          Text(memInfo[index].name),
        ],
      ),
      width: 100,
      height: 52,
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return Row(
      children: <Widget>[
        Container(
          color: Color(0xFFa5ebf2),
          child: Text(memInfo[index].date),
          width: 110,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
        ),
        Container(
          color: Color(0xFFa5ebf2),
          child: Text(memInfo[index].time),
          width: 100,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
        ),
      ],
    );
  }
}

//User user = User();

// class User {
//   List<UserInfo> userInfo = [];

//   void initData(int size) {

//     // for (var i in listMembers) {
//     //     i.forEach((key, value) {
//     //       if (value['Status'] == 'In') {
//     //         inMembers.add(key);
//     //       } else {
//     //         outMembers.add(key);
//     //       }
//     //     });
//     //   }

//     for (int i = 0; i < size; i++) {
//       userInfo.add(UserInfo("User_$i", i % 3 == 0, '+', ''));
//     }
//   }

//   ///
//   /// Single sort, sort Name's id
//   void sortName(bool isAscending) {
//     userInfo.sort((a, b) {
//       int aId = int.tryParse(a.name.replaceFirst('User_', ''));
//       int bId = int.tryParse(b.name.replaceFirst('User_', ''));
//       return (aId - bId) * (isAscending ? 1 : -1);
//     });
//   }

//   ///
//   /// sort with Status and Name as the 2nd Sort
//   void sortStatus(bool isAscending) {
//     userInfo.sort((a, b) {
//       if (a.status == b.status) {
//         int aId = int.tryParse(a.name.replaceFirst('User_', ''));
//         int bId = int.tryParse(b.name.replaceFirst('User_', ''));
//         return (aId - bId);
//       } else if (a.status) {
//         return isAscending ? 1 : -1;
//       } else {
//         return isAscending ? -1 : 1;
//       }
//     });
//   }
// }

class UserInfo {
  int id;
  String name;
  String date;
  String time;
  String utlimg;

  UserInfo(this.id, this.name, this.date, this.time, this.utlimg);
}
