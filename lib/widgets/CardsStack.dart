import 'package:Security/widgets/toggleScene.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class CardsStack extends StatelessWidget {
  final int pageNumber;
  final Widget lightCardChild;
  final Widget darkCardChild;

  const CardsStack({
    @required this.pageNumber,
    @required this.lightCardChild,
    @required this.darkCardChild,
  })  : assert(pageNumber != null),
        assert(lightCardChild != null),
        assert(darkCardChild != null);

  bool get isOddPageNumber => pageNumber % 2 == 1;

  @override
  Widget build(BuildContext context) {
    var darkCardWidth = MediaQuery.of(context).size.width;
    var darkCardHeight = MediaQuery.of(context).size.height / 4;

    return Padding(
      padding: EdgeInsets.only(
        //top: isOddPageNumber ? 25.0 : 50.0,
      ),
      child: Stack(
        alignment: AlignmentDirectional.center,
        overflow: Overflow.visible,
        children: <Widget>[
          Card(
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(16.0),
            // ),
            color: kDarkBlue,
            child: Container(
              width: darkCardWidth,
              height: darkCardHeight,
              padding: EdgeInsets.only(
                top: !isOddPageNumber ? 100.0 : 0.0,
                bottom: isOddPageNumber ? 100.0 : 0.0,
              ),
              child: Center(
                child: darkCardChild,
              ),
            ),
          ),
          Positioned(
            top: !isOddPageNumber ? -25.0 : null,
            bottom: isOddPageNumber ? -25.0 : null,
            child: ToggleScene(),
          ),
        ],
      ),
    );
  }
}