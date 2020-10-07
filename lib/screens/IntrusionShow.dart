import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IntrusionShowPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('INTRUSION DETECTION'),
        ),
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Stack(
            overflow: Overflow.visible,
            children: [
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 3,
                  decoration: new BoxDecoration(
                      image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: new NetworkImage(
                              'https://www.everest.co.uk/globalassets/everest/windows/1_upvc-casement.jpg')))),
              Positioned(
                  top: 5,
                  right: 5,
                  child: Icon(
                    Icons.videocam,
                    size: 40,
                    color: Colors.black,
                  )),
              Positioned(

                bottom: -35,
                right: 10,
                
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _imgeCircle(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTEthKqazQTT9z0aVJSRgKZM1B9wFVpICB0og&usqp=CAU'),
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 50, 0, 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Window1 (Chanita's Bedroom)",
                    style: Theme.of(context).textTheme.headline5),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ListTile(
                  
                  leading: _imgeCircle(
                      'https://static.vecteezy.com/system/resources/thumbnails/000/352/807/small/Health__2861_29.jpg'),
                  title: Text('Motion Detection'),
                  subtitle: Text('NORMAL'),
                ),
                ListTile(
                  leading: _imgeCircle(
                      'https://png.pngtree.com/png-clipart/20190619/original/pngtree-vector-door-icon-png-image_3989612.jpg'),
                  title: Text('Contact Detection'),
                  subtitle: Text('NORMAL'),
                ),
                ListTile(
                  leading: _imgeCircle(
                      'https://cdn.iconscout.com/icon/premium/png-256-thumb/breaking-glass-1500093-1270804.png'),
                  title: Text('Vibration Detection'),
                  subtitle: Text('Detected !'),
                  trailing: Icon(Icons.warning),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget _imgeCircle(String url) {
  return Container(
      width: 60.0,
      height: 60.0,
      decoration: new BoxDecoration(
          shape: BoxShape.circle,
          image: new DecorationImage(
              fit: BoxFit.fill, image: new NetworkImage(url))));
}
