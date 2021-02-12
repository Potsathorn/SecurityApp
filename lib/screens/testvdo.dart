import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class TestVDO extends StatefulWidget {
  TestVDO({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _TestVDOState createState() => _TestVDOState();
}

class _TestVDOState extends State<TestVDO> {
  Color themeColors = Color(0xFF1565c0);
  bool isActived = false;

  @override
  void initState() {
    super.initState();
    //realtime();
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.landscapeLeft,
    //   DeviceOrientation.landscapeRight,
    // ]);

    return Scaffold(
      backgroundColor: Color(0xFFe6ebf2),
      appBar: AppBar(
        backgroundColor: themeColors,
        title: Center(
          child: Text('Video Streaming'),
        ),
      ),
      body: Stack(
        overflow: Overflow.visible,
        children: [
          Container(
              color: Colors.blue,
              child: Center(
                child: Text("Hello World"),
              )),
          Positioned(
            right: 1,
            top: 1,
            child: Container(
              width: MediaQuery.of(context).size.width / 5.4,
              height: MediaQuery.of(context).size.height,
              color: Color(0xFFe6ebf2),
              child: Column(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (int i = 0; i < 4; i++)
                    NeumorphicButton(
                      onPressed: () {
                        // Navigator.pushNamed(context, '/showIntrusion_page',
                        //     arguments: idx);
                        print(i);
                      },
                      style: NeumorphicStyle(
                          depth: 5,

                          //shadowDarkColor: Colors.yellow[700],
                          shape: NeumorphicShape.convex,
                          color:
                              (1 == 2) ? Colors.yellow[700] : Color(0xFFe6ebf2),
                          boxShape: NeumorphicBoxShape.circle()),
                      padding: EdgeInsets.all(10),
                      child: Icon(
                        (i == 0)
                            ? Icons.camera_alt
                            : (i == 1)
                                ? Icons.lock
                                : (i == 2)
                                    ? Icons.notifications_active_rounded
                                    : Icons.lightbulb,
                        size: 35,
                        color: (1 == 2)
                            ? Colors.white
                            : Colors.black.withOpacity(.5),
                      ),
                    ),
                    
                ],
              ),
            ),
          ),
          Positioned(
            left: 1,
            child: Container(
              width: MediaQuery.of(context).size.width / 5.4,
              height: MediaQuery.of(context).size.height,
              color: Colors.red,
              child: Column(
                children: [
                  for (int i = 0; i < 3; i++) Text("Hello'\n"),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
