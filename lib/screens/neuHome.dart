import 'package:Security/screens/NeuScene.dart';
import 'package:Security/widgets/NeuRectButton.dart';
import 'package:Security/widgets/ProfileGreeting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NeuHome extends StatefulWidget {
  @override
  _NeuHomeState createState() => _NeuHomeState();
}

class _NeuHomeState extends State<NeuHome> {
  String groupScene;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFe6ebf2),
      // appBar: AppBar(
      //   title: Center(
      //     child: Text('SMART HOME'),
      //   ),
      // ),
      body: Column(
        children: [
          SizedBox(
              // height: 40.0,
              ),
          Container(
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 40.0,
                  ),
                  ListTile(
                    title: Text(
                      'Welcome Home!',
                      style: TextStyle(
                        letterSpacing: 1.5,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: "nunito",
                      ),
                    ),
                    subtitle: Text(
                      'Taem Potsathorn',
                      style: TextStyle(
                        // letterSpacing: 1.5,
                        fontSize: 20.0,
                        // fontWeight: FontWeight.bold,
                        // fontFamily: "nunito",
                      ),
                    ),
                    trailing: Container(
                        width: 50.0,
                        height: 50.0,
                        decoration: new BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                            shape: BoxShape.rectangle,
                            image: new DecorationImage(
                                fit: BoxFit.fill,
                                image: new NetworkImage(
                                    'https://scontent.fbkk14-1.fna.fbcdn.net/v/t1.0-9/13177687_995427020556595_9011059072266479109_n.jpg?_nc_cat=106&_nc_sid=174925&_nc_ohc=mSEMdIUWPp4AX9qrhK0&_nc_ht=scontent.fbkk14-1.fna&oh=63c13e736bd0e094686a5f4e3dd150f9&oe=5FA01EA7')))),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 3.0,
          ),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                NeumorphicRadio(
                  groupValue: groupScene,
                  style: NeumorphicRadioStyle(
                      //   boxShape: NeumorphicBoxShape.circle(),
                      shape: NeumorphicShape.convex),
                  value: "Coming In",
                  onChanged: (value) {
                    setState(() {
                      groupScene = value;
                    });
                  },
                  child: Container(
                      color: (groupScene == 'Coming In')
                          ? Colors.lightBlue[300]
                          : Color(0xFFe6ebf2),
                      height: 40,
                      width: 40,
                      child: Center(
                          child: Icon(
                        FontAwesome.users,
                        color: (groupScene == 'Coming In')
                            ? Colors.white
                            : Colors.black.withOpacity(.5),
                      ))),
                ),
                SizedBox(
                  width: 5.0,
                ),
                NeumorphicRadio(
                  groupValue: groupScene,
                  style: NeumorphicRadioStyle(
                      // boxShape: NeumorphicBoxShape.circle(),
                      shape: NeumorphicShape.convex),
                  value: "Going Out",
                  onChanged: (value) {
                    setState(() {
                      groupScene = value;
                    });
                  },
                  child: Container(
                      color: (groupScene == 'Going Out')
                          ? Colors.lightBlue[300]
                          : Color(0xFFe6ebf2),
                      height: 40,
                      width: 40,
                      child: Center(
                          child: Icon(
                        FontAwesome.lock,
                        color: (groupScene == 'Going Out')
                            ? Colors.white
                            : Colors.black.withOpacity(.5),
                      ))),
                ),
                SizedBox(
                  width: 5.0,
                ),
                NeumorphicRadio(
                  groupValue: groupScene,
                  style: NeumorphicRadioStyle(
                      // boxShape: NeumorphicBoxShape.circle(),
                      shape: NeumorphicShape.convex),
                  value: "Watch Over",
                  onChanged: (value) {
                    setState(() {
                      groupScene = value;
                    });
                  },
                  child: Container(
                      color: (groupScene == 'Watch Over')
                          ? Colors.lightBlue[300]
                          : Color(0xFFe6ebf2),
                      height: 40,
                      width: 40,
                      child: Center(
                          child: Icon(
                        FontAwesome.eye,
                        color: (groupScene == 'Watch Over')
                            ? Colors.white
                            : Colors.black.withOpacity(.5),
                      ))),
                ),
                SizedBox(
                  width: 5.0,
                ),
                NeumorphicRadio(
                  groupValue: groupScene,
                  style: NeumorphicRadioStyle(
                      // boxShape: NeumorphicBoxShape.circle(),
                      shape: NeumorphicShape.convex),
                  value: "Good Night",
                  onChanged: (value) {
                    setState(() {
                      groupScene = value;
                    });
                  },
                  child: Container(
                      color: (groupScene == 'Good Night')
                          ? Colors.lightBlue[300]
                          : Color(0xFFe6ebf2),
                      height: 40,
                      width: 40,
                      child: Center(
                          child: Icon(
                        FontAwesome.moon_o,
                        color: (groupScene == 'Good Night')
                            ? Colors.white
                            : Colors.black.withOpacity(.5),
                      ))),
                ),
              ],
            ),
            
            trailing: Text(groupScene,
                style: TextStyle(
                  // letterSpacing: 1.5,
                  fontSize: 20.0,
                  color: Colors.lightBlue[500],
                  fontWeight: FontWeight.bold,
                  // fontWeight: FontWeight.bold,
                  // fontFamily: "nunito",
                )),
          ),
          SizedBox(
           // height: 3.0,
          ),
          ListTile(
            title: Text(
                      'Family Members Access',
                      style: TextStyle(
                        color: Colors.black.withOpacity(.5),
                        //letterSpacing: 1,
                        fontSize: 20.0,
                       // fontWeight: FontWeight.bold,
                        fontFamily: "nunito",
                      ),
          ),
          subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Neumorphic(
                  
                  child: Container(
                        width: 50.0,
                        height: 50.0,
                        decoration: new BoxDecoration(
                            // borderRadius: BorderRadius.all(
                            //   Radius.circular(15),
                            // ),
                            // shape: BoxShape.rectangle,
                            image: new DecorationImage(
                                fit: BoxFit.fill,
                                image: new NetworkImage(
                                    'https://scontent.fbkk14-1.fna.fbcdn.net/v/t1.0-9/13177687_995427020556595_9011059072266479109_n.jpg?_nc_cat=106&_nc_sid=174925&_nc_ohc=mSEMdIUWPp4AX9qrhK0&_nc_ht=scontent.fbkk14-1.fna&oh=63c13e736bd0e094686a5f4e3dd150f9&oe=5FA01EA7')))),
                
                ),

                NeumorphicRadio(
                  groupValue: groupScene,
                  style: NeumorphicRadioStyle(
                      //   boxShape: NeumorphicBoxShape.circle(),
                      shape: NeumorphicShape.convex),
                  value: "Coming In",
                  onChanged: (value) {
                    setState(() {
                      groupScene = value;
                    });
                  },
                  child: Container(
                      color: (groupScene == 'Coming In')
                          ? Colors.lightBlue[300]
                          : Color(0xFFe6ebf2),
                      height: 40,
                      width: 40,
                      child: Center(
                          child: Icon(
                        FontAwesome.users,
                        color: (groupScene == 'Coming In')
                            ? Colors.white
                            : Colors.black.withOpacity(.5),
                      ))),
                ),
                SizedBox(
                  width: 5.0,
                ),
                NeumorphicRadio(
                  groupValue: groupScene,
                  style: NeumorphicRadioStyle(
                      // boxShape: NeumorphicBoxShape.circle(),
                      shape: NeumorphicShape.convex),
                  value: "Going Out",
                  onChanged: (value) {
                    setState(() {
                      groupScene = value;
                    });
                  },
                  child: Container(
                      color: (groupScene == 'Going Out')
                          ? Colors.lightBlue[300]
                          : Color(0xFFe6ebf2),
                      height: 40,
                      width: 40,
                      child: Center(
                          child: Icon(
                        FontAwesome.lock,
                        color: (groupScene == 'Going Out')
                            ? Colors.white
                            : Colors.black.withOpacity(.5),
                      ))),
                ),
                SizedBox(
                  width: 5.0,
                ),
                NeumorphicRadio(
                  groupValue: groupScene,
                  style: NeumorphicRadioStyle(
                      // boxShape: NeumorphicBoxShape.circle(),
                      shape: NeumorphicShape.convex),
                  value: "Watch Over",
                  onChanged: (value) {
                    setState(() {
                      groupScene = value;
                    });
                  },
                  child: Container(
                      color: (groupScene == 'Watch Over')
                          ? Colors.lightBlue[300]
                          : Color(0xFFe6ebf2),
                      height: 40,
                      width: 40,
                      child: Center(
                          child: Icon(
                        FontAwesome.eye,
                        color: (groupScene == 'Watch Over')
                            ? Colors.white
                            : Colors.black.withOpacity(.5),
                      ))),
                ),
                SizedBox(
                  width: 5.0,
                ),
                NeumorphicRadio(
                  groupValue: groupScene,
                  style: NeumorphicRadioStyle(
                      // boxShape: NeumorphicBoxShape.circle(),
                      shape: NeumorphicShape.convex),
                  value: "Good Night",
                  onChanged: (value) {
                    setState(() {
                      groupScene = value;
                    });
                  },
                  child: Container(
                      color: (groupScene == 'Good Night')
                          ? Colors.lightBlue[300]
                          : Color(0xFFe6ebf2),
                      height: 40,
                      width: 40,
                      child: Center(
                          child: Icon(
                        FontAwesome.moon_o,
                        color: (groupScene == 'Good Night')
                            ? Colors.white
                            : Colors.black.withOpacity(.5),
                      ))),
                ),
              ],
            )
            ,)
          // Stack(
          //   children: [
          //     Container(
          //         child: Column(
          //       children: [
          //         SizedBox(
          //           height: 30.0,
          //         ),
          //         SizedBox(
          //           child: ProfileGreeting(
          //               greeting: 'Welcome Home',
          //               name: 'Taem Potsathorn',
          //               pathImage:
          //                   'https://scontent.fbkk14-1.fna.fbcdn.net/v/t1.0-9/13177687_995427020556595_9011059072266479109_n.jpg?_nc_cat=106&_nc_sid=174925&_nc_ohc=mSEMdIUWPp4AX9qrhK0&_nc_ht=scontent.fbkk14-1.fna&oh=63c13e736bd0e094686a5f4e3dd150f9&oe=5FA01EA7'),
          //           height: 100,
          //           width: MediaQuery.of(context).size.width,
          //         ),
          //       ],
          //     ))
          //   ],
          // ),
          // SizedBox(
          //     // height: 40.0,
          //     ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //      NeumorphicRadio(

          //       groupValue: groupval,

          //       style: NeumorphicRadioStyle(boxShape: NeumorphicBoxShape.circle()),
          //       value: "A",
          //       onChanged: (value) {
          //         setState(() {
          //           groupval = 'A';
          //         });
          //       },
          //       child: Container(
          //         color: (groupval == 'A') ? Colors.red : null,
          //         height: 50,
          //         width: 50,
          //         child: Center(child: Text('A'))),
          //     ),
          //      NeumorphicRadio(

          //       groupValue: groupval,

          //       style: NeumorphicRadioStyle(boxShape: NeumorphicBoxShape.circle()),
          //       value: "B",
          //       onChanged: (value) {
          //         setState(() {
          //           groupval = 'B';
          //         });
          //       },
          //       child: Container(
          //         color: (groupval == 'B') ? Colors.red : null,
          //         height: 50,
          //         width: 50,
          //         child: Center(child: Text('B'))),
          //     ),
          //     NeumorphicRadio(

          //       groupValue: groupval,

          //       style: NeumorphicRadioStyle(boxShape: NeumorphicBoxShape.circle()),
          //       value: "C",
          //       onChanged: (value) {
          //         setState(() {
          //           groupval = 'C';
          //         });
          //       },
          //       child: Container(
          //         color: (groupval == 'C') ? Colors.red : null,
          //         height: 50,
          //         width: 50,
          //         child: Center(child: Text('C'))),
          //     ),
          //      NeumorphicRadio(

          //       groupValue: groupval,

          //     //  style: NeumorphicRadioStyle(boxShape: NeumorphicBoxShape.circle()),
          //       value: "D",
          //       onChanged: (value) {
          //         setState(() {
          //           groupval = 'D';
          //         });
          //       },
          //       child: Container(
          //         color: (groupval == 'D') ? Colors.red : null,
          //         height: 50,
          //         width: 50,
          //         child: Center(child: Text('D'))),
          //     ),
          //   ],
          // )
        ],
      ),
      // body: Column(
      //   mainAxisAlignment: MainAxisAlignment.start,
      //   children: [
      //     NeuScene(),

      //     NeuRectButton(),
      //     NeumorphicButton(
      //       onPressed: (){
      //         setState(() {

      //         });
      //       },
      //       child: Text('Click me'),

      //     ),

      //   ],
      // ),
    );
  }
}
