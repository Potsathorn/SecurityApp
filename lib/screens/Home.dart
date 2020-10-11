import 'package:Security/widgets/AppBarHome.dart';
import 'package:Security/widgets/CardGreetingStack.dart';
import 'package:Security/widgets/IconWithText.dart';
import 'package:Security/widgets/ProfileGreeting.dart';
import 'package:Security/widgets/toggleScene.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _gotoAttendance() {
      Navigator.pushNamed(context, "/showAttendance_page");
    }

    void _gotoIntrusion() {
      Navigator.pushNamed(context, "/showIntrusion_page");
    }

    void _gotoCamera() {
      Navigator.pushNamed(context, "/showCamera_page");
    }

    void _gotoLockink() {
      Navigator.pushNamed(context, "/showLocking_page");
    }

    void _gotoLightnig() {
      Navigator.pushNamed(context, "/showLightning_page");
    }

    void _gotoAlarm() {
      Navigator.pushNamed(context, "/showAlarm_page");
    }

    void _notify() {}
    void _setting() {}
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
              color: Colors.blue[300],
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 35, 0, 10),
                child: AppBarHome(
                    title: 'Security Home', notify: _notify, setting: _setting),
              )),
          CardGreetingStack(
            urlImage:
                'https://cf.bstatic.com/images/hotel/max1024x768/115/115643736.jpg',
            profile: ProfileGreeting(
                greeting: 'Good Morning',
                name: 'Taem Potsathorn',
                pathImage:
                    'https://scontent.fbkk14-1.fna.fbcdn.net/v/t1.0-9/13177687_995427020556595_9011059072266479109_n.jpg?_nc_cat=106&_nc_sid=174925&_nc_ohc=mSEMdIUWPp4AX9qrhK0&_nc_ht=scontent.fbkk14-1.fna&oh=63c13e736bd0e094686a5f4e3dd150f9&oe=5FA01EA7'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                child: Text('Home Environment',
                    style: Theme.of(context).textTheme.headline5),
              ),
            ],
          ),
          IntrinsicHeight(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Container(
                height: 140,
                decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.blue[300])),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconWithText(
                          icon: Icons.looks_two,
                          size: 90.0,
                          iconName: 'Attendance',
                          gotoPage: _gotoAttendance),
                      VerticalDivider(
                        color: Colors.blue[200],
                        indent: 15,
                        endIndent: 15,
                        thickness: 3,
                      ),
                      IconWithText(
                          icon: Icons.security,
                          size: 90.0,
                          iconName: 'Intrusion',
                          gotoPage: _gotoIntrusion),
                      VerticalDivider(
                        color: Colors.blue[200],
                        indent: 15,
                        endIndent: 15,
                        thickness: 3,
                      ),
                      IconWithText(
                          icon: Icons.videocam,
                          size: 90.0,
                          iconName: 'Camera',
                          gotoPage: _gotoCamera)
                    ],
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                child: Text('Security Control',
                    style: Theme.of(context).textTheme.headline5),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: (MediaQuery.of(context).size.width / 2) - 15,
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.blue[300]),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        )),
                    child: IconWithText(
                        icon: Icons.lock,
                        size: 130,
                        iconName: 'Remote Loocking',
                        gotoPage: _gotoLockink),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width / 2) - 15,
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.blue[300]),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        )),
                    child: IconWithText(
                        icon: Icons.lightbulb_outline,
                        size: 130,
                        iconName: 'Security Lightning',
                        gotoPage: _gotoLightnig),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 7, 10, 0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue[300], width: 2.0),
                borderRadius: BorderRadius.all(
                    Radius.circular(40.0) //         <--- border radius here
                    ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlatButton.icon(
                      onPressed: _gotoAlarm,
                      icon: Icon(
                        Icons.surround_sound,
                        size: 70,
                      ),
                      label: Text('Sound Alarm System',
                          style: Theme.of(context).textTheme.headline6)),
                  //RaisedButton.icon(onPressed: null, icon: null, label: null),
                ],
              ),

              // Row(mainAxisAlignment: MainAxisAlignment.center,)
            ),
          ),
        ],
      ),
    );
  }
}