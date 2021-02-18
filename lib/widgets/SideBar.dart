import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InkWellDrawer extends StatefulWidget {
  @override
  _InkWellDrawerState createState() => _InkWellDrawerState();
}

class _InkWellDrawerState extends State<InkWellDrawer> {
  bool isEnglish = true;
  bool isSwitched = false;
  String _chosenValue = "English";
  @override
  void initState() {
    super.initState();
    realtime();
  }

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

    bdref.child('Notification').onValue.listen((event) {
      var snapshot = event.snapshot;

      String value = snapshot.value;

      (value == 'On') ? isSwitched = true : isSwitched = false;
      //print(value);
    });
  }

  @override
  Widget build(BuildContext ctxt) {
    realtime();
    _chosenValue = (isEnglish) ? "English" : 'ไทย';
    return new Drawer(
      child: Container(
        color: Color(0xFFe6ebf2),
        child: ListView(
          children: <Widget>[
            DrawerHeader(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: <Color>[Colors.lightBlue, Colors.blue[800]])),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 50.0,
                        backgroundColor: Colors.white,
                        backgroundImage: new AssetImage("images/taem.png"),
                      ),
                      Text(
                        (isEnglish) ? 'Taem Potsathorn' : 'พสธร ดวงแก้วเจริญ',
                        style: TextStyle(color: Colors.white, fontSize: 25.0),
                      )
                    ],
                  ),
                )),
            CustomListTile(
                Icons.notifications_none,
                (isEnglish) ? 'Notification' : 'การแจ้งเตือน',
                () => {},
                Switch(
                  value: isSwitched,
                  onChanged: (value) {
                    isSwitched = value;

                    bdref
                        .child('')
                        .update({'Notification': (isSwitched) ? 'On' : 'Off'});
                    setState(() {});
                  },
                  activeTrackColor: Colors.lightBlue,
                  activeColor: Colors.blue[800],
                )),
            CustomListTile(
              Icons.language,
              (isEnglish) ? 'Language' : 'ภาษา',
              () => {},
              DropdownButton<String>(
                value: _chosenValue,
                items: <String>['English', 'ไทย']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String value) {
                  setState(() {
                    _chosenValue = value;

                     (_chosenValue == "English")? isEnglish = true : isEnglish = false;


                    bdref
                        .child('')
                        .update({'Languages': _chosenValue});
                   
                  });
                },
              ),
            ),
            CustomListTile(
                Icons.upload_outlined, (isEnglish)?'Version':'เวอร์ชัน', () => {}, Text('1.0.0      ')),
            CustomListTile(
                Icons.exit_to_app_rounded, (isEnglish)?'Exit App':'ออกจากแอป', () => {SystemNavigator.pop()}, Text('')),
            
          ],
        ),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function onTap;
  final Widget end;

  CustomListTile(this.icon, this.text, this.onTap, this.end);
  @override
  Widget build(BuildContext context) {
    //ToDO
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey.shade400))),
        child: InkWell(
            splashColor: Colors.blue[800],
            onTap: onTap,
            child: Container(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(icon),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                        ),
                        Text(
                          text,
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    end,
                  ],
                ))),
      ),
    );
  }
}



class ClippingClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 80);
    path.quadraticBezierTo(
      size.width / 4,
      size.height,
      size.width / 2,
      size.height,
    );
    path.quadraticBezierTo(
      size.width - (size.width / 4),
      size.height,
      size.width,
      size.height - 80,
    );
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
