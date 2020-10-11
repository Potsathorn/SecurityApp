import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LightningControl extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var backgroundWidth = MediaQuery.of(context).size.width;
    var backgroundHeiht = MediaQuery.of(context).size.height / 1.5;
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('LIGHTNING CONTROL'),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _imgeCirclei(
                  'https://thumbs.dreamstime.com/z/light-bulb-setting-gear-vector-icon-configuration-illustration-symbol-sign-web-sites-mobile-light-bulb-setting-160714880.jpg'),
            ],
          ),
          Stack(
            children: [
              _backgroundImage(backgroundWidth, backgroundHeiht,
                  'https://scontent.fbkk14-1.fna.fbcdn.net/v/t1.15752-9/120850983_786164901942896_6982487596443238375_n.png?_nc_cat=111&_nc_sid=ae9488&_nc_ohc=VjK4vaulWFoAX9GC7Wy&_nc_ht=scontent.fbkk14-1.fna&oh=efa35027146a06bd18ac0d782acaf772&oe=5FA25FBC'),
              Positioned(
                right: 40,
                bottom: 60,
                child: _bumpCircle(
                    'https://png.pngtree.com/png-vector/20190820/ourlarge/pngtree-light-bulb-icon-vector--light-bulb-ideas-symbol-illustration-png-image_1694700.jpg'),
              ),
              Positioned(
                left: 150,
                bottom: 60,
                child: _bumpCircle(
                    'https://png.pngtree.com/png-vector/20190820/ourlarge/pngtree-light-bulb-icon-vector--light-bulb-ideas-symbol-illustration-png-image_1694700.jpg'),
              ),
              Positioned(
                left: 160,
                top: 195,
                child: _bumpCircle(
                    'https://cdn.pixabay.com/photo/2018/09/04/19/47/light-bulb-3654558_960_720.jpg'),
              ),
              Positioned(
                right: 60,
                top: 160,
                child: _bumpCircle(
                    'https://cdn.pixabay.com/photo/2018/09/04/19/47/light-bulb-3654558_960_720.jpg'),
              ),
              Positioned(
                left: 110,
                top: 260,
                child: _bumpCircle(
                    'https://cdn.pixabay.com/photo/2018/09/04/19/47/light-bulb-3654558_960_720.jpg'),
              ),
              Positioned(
                left: 130,
                top: 80,
                child: _bumpCircle(
                    'https://cdn.pixabay.com/photo/2018/09/04/19/47/light-bulb-3654558_960_720.jpg'),
              ),
              Positioned(
                right: 60,
                bottom: 180,
                child: _bumpCircle(
                    'https://cdn.pixabay.com/photo/2018/09/04/19/47/light-bulb-3654558_960_720.jpg'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "ON : 2",
                      style: TextStyle(
                          color: Colors.black.withOpacity(.6),
                          fontFamily: "nunito",
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    ),
                    Text('',
                        style: TextStyle(
                            color: Colors.black.withOpacity(.6),
                            fontFamily: "nunito",
                            //fontWeight: FontWeight.bold,
                            fontSize: 20))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "OFF : 5",
                      style: TextStyle(
                          color: Colors.black.withOpacity(.6),
                          fontFamily: "Locked Status",
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    ),
                    Text('',
                        style: TextStyle(
                            color: Colors.black.withOpacity(.6),
                            fontFamily: "nunito",
                            //fontWeight: FontWeight.bold,
                            fontSize: 20))
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

Widget _backgroundImage(double width, double height, String pathImage) {
  return Container(
      width: width,
      height: height,
      decoration: new BoxDecoration(
          image: new DecorationImage(
              fit: BoxFit.fill, image: new NetworkImage(pathImage))));
}

Widget _bumpCircle(String iurl) {
  return Container(
      width: 50.0,
      height: 50.0,
      decoration: new BoxDecoration(
          shape: BoxShape.circle,
          image: new DecorationImage(
              fit: BoxFit.fill, image: new NetworkImage(iurl))));
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
