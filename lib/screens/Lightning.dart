import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LightningControl extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('LIGHTNING CONTROL'),
        ),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [_imgeCirclei('https://previews.123rf.com/images/milta/milta1809/milta180900554/109683543-vector-illustration-of-modern-ceiling-lamp-flat-icon-of-recessed-light-home-office-lighting-isolated.jpg'),

            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text(
                    "ON : 2",
                    style: TextStyle(
                        color: Colors.black.withOpacity(.6),
                        fontFamily: "nunito",
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ), Text('',
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
                    "OFF : 5",
                    style: TextStyle(
                        color: Colors.black.withOpacity(.6),
                        fontFamily: "Locked Status",
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ), Text('',
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

Widget _imgeCirclei(String url) {
  return Container(
      width: 90.0,
      height: 90.0,
      decoration: new BoxDecoration(
    
        
          shape: BoxShape.circle,
          image: new DecorationImage(
              fit: BoxFit.fill, image: new NetworkImage(url))));
}