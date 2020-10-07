import 'package:Security/widgets/CircleIcon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RemoteLockingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('REMOTE LOCKING'),
        ),
      ),
      body: Column(
       // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
                height: 50.0,
              ),
          Container(
            height: 300,
            width: 300,
            child: CircleIcon(icon: Icons.lock_outline,),
          ),
          SizedBox(
                height: 20.0,
              ),
          Text(
            "Door Locked",
            style: TextStyle(
                color: Colors.black.withOpacity(.6),
                fontFamily: "nunito",
                //fontWeight: FontWeight.bold,
                fontSize: 30),
          ),
          SizedBox(
                height: 60.0,
              ),
          Container(
            width: 200,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue[300], width: 2.0),
              borderRadius: BorderRadius.all(
                  Radius.circular(5.0) //         <--- border radius here
                  ),
            ),
            child: FlatButton(
                onPressed: null,
                child: Text(
                  "UNLOCK",
                  style: TextStyle(
                      color: Colors.black.withOpacity(.6),
                      fontFamily: "nunito",
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                )),
          ),
          SizedBox(
                height: 40.0,
              ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text(
                    "Last Locked",
                    style: TextStyle(
                        color: Colors.black.withOpacity(.6),
                        fontFamily: "nunito",
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ), Text('4:35 PM',
                    style: TextStyle(
                        color: Colors.black.withOpacity(.6),
                        fontFamily: "nunito",
                        //fontWeight: FontWeight.bold,
                        fontSize: 20))],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text(
                    "Locked Status",
                    style: TextStyle(
                        color: Colors.black.withOpacity(.6),
                        fontFamily: "Locked Status",
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ), Text('OK',
                    style: TextStyle(
                        color: Colors.black.withOpacity(.6),
                        fontFamily: "nunito",
                        //fontWeight: FontWeight.bold,
                        fontSize: 20))],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
