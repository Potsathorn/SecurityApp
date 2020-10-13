import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileGreeting extends StatelessWidget {
  final String greeting;
  final String name;
  final String pathImage;

  const ProfileGreeting({
    @required this.greeting,
    @required this.name,
    @required this.pathImage,
  })  : assert(name != null),
        assert(pathImage != null);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
       
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 8),
              child:
                  Text(greeting, style: Theme.of(context).textTheme.headline5),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Text(name, style: Theme.of(context).textTheme.headline6),
            ),
          ],
        ),
         _imageCircle(pathImage),
      ],
    );
  }
}

Widget _imageCircle(String url) {
  return Container(
      width: 50.0,
      height: 50.0,
      decoration: new BoxDecoration(
          shape: BoxShape.circle,
          image: new DecorationImage(
              fit: BoxFit.fill, image: new NetworkImage(url))));
}
