import 'package:Security/widgets/IconWithText.dart';
import 'package:Security/widgets/ProfileGreeting.dart';
import 'package:Security/widgets/toggleScene.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardGreetingStack extends StatelessWidget {
  void tt() {}
  final String urlImage;
  final ProfileGreeting profile;
  

  const CardGreetingStack(
      {@required this.urlImage,
      @required this.profile,
      })
      : assert(urlImage != null),
        assert(profile != null);

  @override
  Widget build(BuildContext context) {
    var backgroundWidth = MediaQuery.of(context).size.width;
    var backgroundHeiht = MediaQuery.of(context).size.height / 4;

    return Stack(
      alignment: AlignmentDirectional.center,
      overflow: Overflow.visible,
      children: [
        _backgroundImage(backgroundWidth, backgroundHeiht, urlImage),
        Positioned(top: 22.0, left: 25.0, child: profile),
        Positioned(
          bottom: 0,
          child: Container(
            width: backgroundWidth ,
            color: Colors.blue[50].withOpacity(0.6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconWithText(
                    icon: Icons.home, size: 30, iconName: "Coming Home", gotoPage: tt),
                IconWithText(
                    icon: Icons.lock_outline,
                    size: 30,
                    iconName: "Going Out",
                    gotoPage: tt),
                IconWithText(
                    icon: Icons.remove_red_eye,
                    size: 30,
                    iconName: "Old/Kids",
                    gotoPage: tt),
                IconWithText(
                    icon: Icons.hotel,
                    size: 30,
                    iconName: "Good Night",
                    gotoPage: tt),
              ],
            ),
          ),
        )
        //   Positioned(
        //   //  width: backgroundWidth,
        //  // height: 90,
        //    // left: 0,
        //     bottom: -25, child: sceneChoosed)
      ],
    );
  }

  Widget _backgroundImage(double width, double height, String pathImage) {
    return Container(
        width: width,
        height: height,
        decoration: new BoxDecoration(
            image: new DecorationImage(
                fit: BoxFit.fill, image: new NetworkImage(pathImage))));
  }
}
