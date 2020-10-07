import 'package:Security/widgets/CircleIcon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlarmSystemPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('ALARM SYSTEM'),
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
              icon: Icons.notifications_active,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            "Turn Off",
            style: TextStyle(
                color: Colors.black.withOpacity(.6),
                fontFamily: "nunito",
                //fontWeight: FontWeight.bold,
                fontSize: 30),
          ),
          SizedBox(
            height: 10.0,
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
                  "ON",
                  style: TextStyle(
                      color: Colors.black.withOpacity(.6),
                      fontFamily: "nunito",
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                )),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.blue[200],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text('ALARM HISTORY',
                    style: TextStyle(
                        color: Colors.black.withOpacity(.6),
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
                TableRow(
                  
                  children: [
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
                TableRow(
                  
                  children: [
                  Text(
                    'Vibratin',
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
