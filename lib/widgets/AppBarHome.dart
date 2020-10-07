import 'package:Security/constants.dart';
import 'package:Security/widgets/Logo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///import 'package:flutter/material.dart';

class AppBarHome extends StatelessWidget {
  final String title;
  final VoidCallback notify;
  final VoidCallback setting;
  const AppBarHome(
      {@required this.title, @required this.notify, @required this.setting})
      : assert(title != null),
        assert(notify != null),
        assert(setting != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,

        children: [
          Expanded(flex: 1, child: Logo(color: kWhite, size: 32.2)),
          Expanded(
              flex: 3,
              child: Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    .copyWith(color: kWhite),
              )),
          GestureDetector(
              onTap: notify,
              child: Icon(
                Icons.notifications_active,
                color: Colors.white,
                size: 32,
              )),
          Expanded(
              flex: 1,
              child: GestureDetector(
                  onTap: setting,
                  child: Icon(
                    Icons.settings,
                    color: Colors.white,
                    size: 32,
                  ))),
        ],
      ),
    );
  }
}
