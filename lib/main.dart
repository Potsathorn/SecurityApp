import 'package:Security/SceneCubit.dart';
import 'package:Security/constants.dart';
import 'package:Security/screens/Alarm.dart';
import 'package:Security/screens/Attendance.dart';
import 'package:Security/screens/Firstpage.dart';
import 'package:Security/screens/Home.dart';
import 'package:Security/screens/IntrusionPlan.dart';
import 'package:Security/screens/IntrusionShow.dart';
import 'package:Security/screens/Lightning.dart';
import 'package:Security/screens/MyHomePage.dart';
import 'package:Security/screens/PassCode.dart';
import 'package:Security/screens/PasscodePage.dart';
import 'package:Security/screens/RemoteLocking.dart';
import 'package:Security/screens/VideoStreaming.dart';
import 'package:Security/screens/NeuScene.dart';
import 'package:Security/screens/neuHome.dart';
import 'package:Security/screens/test1.dart';
import 'package:Security/screens/testdata.dart';
import 'package:Security/screens/testvdo.dart';
import 'package:Security/test.dart';
import 'package:Security/widgets/CircleIcon.dart';
import 'package:Security/widgets/Header.dart';
import 'package:Security/widgets/IconContainer.dart';
import 'package:Security/widgets/Logo.dart';
import 'package:Security/widgets/OnboardignPageIndicatorPainter.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_channel/io.dart';

import 'Scene_Observer.dart';

void main() {
 
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.


  // BlocProvider(
  //     create: (_) => SceneCubit(),
  //     child: 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       debugShowCheckedModeBanner: false,
        
        title: 'Flutter Demo',
        theme: ThemeData(
    // This is the theme of your application.
    //
    // Try running your application with "flutter run". You'll see the
    // application has a blue toolbar. Then, without quitting the app, try
    // changing the primarySwatch below to Colors.green and then invoke
    // "hot reload" (press "r" in the console where you ran "flutter run",
    // or simply save your changes to "hot reload" in a Flutter IDE).
    // Notice that the counter didn't reset back to zero; the application
    // is not restarted.
    primarySwatch: Colors.blue,
    // This makes the visual density adapt to the platform that you run
    // the app on. For desktop platforms, the controls will be smaller and
    // closer together (more dense) than on mobile platforms.
    visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        //MyHomePage()
        //MySmartHome
        // home:  MyHomePage(),
        // home:  MySmartHome(),
    //home:  NeuHome(),
    // home : TestVDO(),
    home: FirstPage(),
    //home:  Home(
     //     channel: IOWebSocketChannel.connect('ws://34.87.169.81:65080')),
       // home: AttendancePage(),
        // home:  ExampleHomePage(title: 'Passcode Lock Screen '),
        routes: {
    '/showHome_page': (context) => HomePage(),
    '/show_neuHome': (context) => NeuHome(),
    '/showAttendance_page': (context) => AttendancePage(title: 'ATTENDANCE '),
    '/showIntrusion_page': (context) => IntrusionShowPage(),
    '/showIntrusionfirst_page': (context) => IntrusionFirstPage(),
    '/showCamera_page': (context) => Home(
          channel: IOWebSocketChannel.connect('ws://34.87.169.81:65080'),
        ),
    '/showLocking_page': (context) => RemoteLockingPage(),
    '/showLightning_page': (context) => LightningControl(),
    '/showAlarm_page': (context) => AlarmSystemPage(),
        },
      );
  }
}
