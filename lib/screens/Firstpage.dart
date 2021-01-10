import 'dart:async';

import 'package:Security/widgets/circle.dart';
import 'package:Security/widgets/keyboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'PassCode.dart';

class FirstPage extends StatefulWidget {
  FirstPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final StreamController<bool> _verificationNotifier =
      StreamController<bool>.broadcast();
  bool isAuthenticated = false;

  _showLockScreen(BuildContext context,
      {bool opaque,
      CircleUIConfig circleUIConfig1,
      KeyboardUIConfig keyboardUIConfig,
      Widget cancelButton,
      List<String> digits,
      CircleUIConfig circleUIConfig}) {
    Navigator.push(
        context,
        PageRouteBuilder(
          opaque: opaque,
          pageBuilder: (context, animation, secondaryAnimation) {
            // ignore: unused_local_variable
            var keyboardUIConfig2 = keyboardUIConfig;
            var passcodeScreen = PasscodeScreen(
              title: Text(
                'Enter App Passcode',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 28),
              ),
              passwordEnteredCallback: _onPasscodeEntered,
              cancelButton: cancelButton,
              deleteButton: Text(
                'Delete',
                style: const TextStyle(fontSize: 16, color: Colors.white),
                semanticsLabel: 'Delete',
              ),
              shouldTriggerVerification: _verificationNotifier.stream,
              backgroundColor: Colors.black.withOpacity(0.8),
              cancelCallback: _onPasscodeCancelled,
              digits: digits,
            );
            return passcodeScreen;
          },
        ));
  }

  _onPasscodeEntered(String enteredPasscode) {
    bool isValid = '080925' == enteredPasscode;
    _verificationNotifier.add(isValid);
    if (isValid) {
      setState(() {
        this.isAuthenticated = true;

        
      });

      //Navigator.pushNamed(context, "/show_neuHome");
    }
  }

  _onPasscodeCancelled() {
    Navigator.maybePop(context);
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration(milliseconds: 1000),
      () {
        _showLockScreen(
          context,
          opaque: false,
          cancelButton: Text(
            'Cancel',
            style: const TextStyle(fontSize: 16, color: Colors.white),
            semanticsLabel: 'Cancel',
          ),
        );
      },
    );
  }

  Color themeColors = Color(0xFF095a9d);
  Widget _showImages(String url, double width, double height) {
    return Container(
      width: width,
      height: height,
      child: Image.asset(url),
    );
  }

  @override
  Widget build(BuildContext context) {
    imageCache.clear();
   (this.isAuthenticated) ? Future.delayed(
      Duration(milliseconds: 500),
      () {
        Navigator.pushNamed(context, "/show_neuHome");
      },
    ) : null;
    return Scaffold(
      backgroundColor: Color(0xFFe6ebf2),
      body: GestureDetector(
        onTap: (){
          (this.isAuthenticated) ?Navigator.pushNamed(context, "/show_neuHome"):_showLockScreen(
          context,
          opaque: false,
          cancelButton: Text(
            'Cancel',
            style: const TextStyle(fontSize: 16, color: Colors.white),
            semanticsLabel: 'Cancel',
          ),
        );

        },
              child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _showImages('images/icon.png', 150, 150),
              SizedBox(
                height: 2.0,
              ),
              Text(
                "Home Security",
                style: TextStyle(
                    letterSpacing: 1,
                    color: themeColors,
                    fontFamily: "nunito",
                    fontWeight: FontWeight.bold,
                    fontSize: 28),
              ),

              Text(
                (this.isAuthenticated) ? "You are authenticated !":"",
                style: TextStyle(
                    //letterSpacing: 1,
                    color: Color(0xFF1fbcfd),
                    fontFamily: "nunito",
                   // fontWeight: FontWeight.bold,
                    fontSize: 28),
              ),
              
              // SizedBox(
              //   height: 200.0,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
