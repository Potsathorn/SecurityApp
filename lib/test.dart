import 'package:Security/widgets/ProfileGreeting.dart';
import 'package:flutter/material.dart';

class TestWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ProfileGreeting(
              greeting: "Good Morning",
              name: "Peter Parker",
              pathImage: "https://i.imgur.com/BoN9kdC.png"),
        ],
      ),
    );
  }
}
