import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NeuRectButton extends StatefulWidget {
  @override
  _NeuRectButtonState createState() => _NeuRectButtonState();
}

class _NeuRectButtonState extends State<NeuRectButton> {

  bool buttonPressed = true;

  void _letsPress() {
    setState(() {
      if(buttonPressed == true)
      {
      buttonPressed = false;
      }
      else
      {
      buttonPressed = true;
      }
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _letsPress,

      child: buttonPressed ? _pressedButton() : _unPressButton(),
    );
  }

  Widget _unPressButton() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: Container(
            height: 100.0,
            width: (MediaQuery.of(context).size.width) / 1.8,
            decoration: BoxDecoration(
                color: Color(0xFFe6ebf2),
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 5.0,
                      offset: Offset(-3, -3),
                      color: Colors.white.withOpacity(.7)),
                  BoxShadow(
                      blurRadius: 5.0,
                      offset: Offset(3, 3),
                      color: Colors.black.withOpacity(.15))
                ]),
            child: Container(
              child: Center(),
            )),
      );

  }

  Widget _pressedButton() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: Container(
            height: 100.0,
            width: (MediaQuery.of(context).size.width) / 1.8,
            decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 5.0,
                      offset: Offset(-3, -3),
                      color: Colors.white.withOpacity(.7)),
                  BoxShadow(
                      blurRadius: 5.0,
                      offset: Offset(3, 3),
                      color: Colors.black.withOpacity(.15))
                ]),
            child: Container(
              child: Center(),
            )),
      );

  }
}
