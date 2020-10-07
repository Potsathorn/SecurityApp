import 'dart:math';

import 'package:Security/screens/onbording/onbording.dart';
import 'package:Security/screens/onbording/pages/CommunityPage.dart';
import 'package:Security/screens/onbording/pages/EducationPage.dart';
import 'package:Security/screens/onbording/pages/WorkPage.dart';
import 'package:Security/widgets/AppBarHome.dart';
import 'package:Security/widgets/CardsStack.dart';
import 'package:Security/widgets/HomeEnv.dart';
import 'package:Security/widgets/IconWithText.dart';
import 'package:Security/widgets/toggleScene.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
//import 'Header.dart';
import 'NextPageButton.dart';

class _OnboardignPageIndicatorPainter extends CustomPainter {
  final Color color;
  final double startAngle;
  final double indicatorLength;

  const _OnboardignPageIndicatorPainter({
    @required this.color,
    @required this.startAngle,
    @required this.indicatorLength,
  })  : assert(color != null),
        assert(startAngle != null),
        assert(indicatorLength != null);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    canvas.drawArc(
      Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: (size.shortestSide + 12.0) / 2,
      ),
      startAngle,
      indicatorLength,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(_OnboardignPageIndicatorPainter oldDelegate) {
    return this.color != oldDelegate.color ||
        this.startAngle != oldDelegate.startAngle;
  }
}

class OnboardingPageIndicator extends StatelessWidget {
  final int currentPage;
  final Widget child;

  const OnboardingPageIndicator({
    @required this.currentPage,
    @required this.child,
  })  : assert(currentPage != null),
        assert(child != null);

  Color _getPageIndicatorColor(int pageIndex) {
    return currentPage > pageIndex ? kWhite : kWhite.withOpacity(0.25);
  }

  double get indicatorGap => pi / 12;
  double get indicatorLength => pi / 3;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        painter: _OnboardignPageIndicatorPainter(
          color: _getPageIndicatorColor(0),
          startAngle: (4 * indicatorLength) - (indicatorLength + indicatorGap),
          indicatorLength: indicatorLength,
        ),
        child: CustomPaint(
          painter: _OnboardignPageIndicatorPainter(
            color: _getPageIndicatorColor(1),
            startAngle: 4 * indicatorLength,
            indicatorLength: indicatorLength,
          ),
          child: CustomPaint(
            painter: _OnboardignPageIndicatorPainter(
              color: _getPageIndicatorColor(2),
              startAngle:
                  (4 * indicatorLength) + (indicatorLength + indicatorGap),
              indicatorLength: indicatorLength,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

class Onboarding extends StatefulWidget {
  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  int _currentPage = 1;

  bool get isFirstPage => _currentPage == 1;

  Widget _getPage() {
    switch (_currentPage) {
      case 1:
        return OnboardingPage(
          number: 1,
          lightCardChild: CommunityLightCardContent(),
          darkCardChild: CommunityDarkCardContent(),
          textColumn: CommunityTextColumn(),
        );
      case 2:
        return OnboardingPage(
          number: 2,
          lightCardChild: EducationLightCardContent(),
          darkCardChild: EducationDarkCardContent(),
          textColumn: EducationTextColumn(),
        );
      case 3:
        return OnboardingPage(
          number: 3,
          lightCardChild: WorkLightCardContent(),
          darkCardChild: WorkDarkCardContent(),
          textColumn: WorkTextColumn(),
        );
      default:
        throw Exception("Page with number '$_currentPage' does not exist.");
    }
  }

  void _setNextPage(int nextPageNumber) {
    setState(() {
      _currentPage = nextPageNumber;
    });
  }

  void _nextPage() {
    switch (_currentPage) {
      case 1:
        _setNextPage(2);
        break;
      case 2:
        _setNextPage(3);
        break;
      case 3:
        _setNextPage(1);
        break;
    }
  }

  void _goToLogin() {
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (_){

    //     },
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(),
      backgroundColor: kBlue,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(kPaddingS),
          child: Column(
            children: <Widget>[
              Container(
                  color: Colors.pink,),
                 // child: AppBarHome(notify: _goToLogin, setting: _goToLogin)),
              CardsStack(
                  pageNumber: 1,
                  lightCardChild: CommunityLightCardContent(),
                  darkCardChild: CommunityDarkCardContent()),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: Text('Home Environment'),
              ),
              HomeEnv(),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 18, 0, 0),
                child: Text('Security Control'),
              ),

              Container(
                width: 160.0,
                height: 120.0,
                child: IconWithText(icon: Icons.mail, size: 40, iconName: "Mail", gotoPage: _nextPage),
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.all(Radius.circular(25),
                  
                ),
              ),)

              // Header(
              //   onSkip: _goToLogin,
              // ),
              // Expanded(
              //   child: _getPage(),
              // ),
              // HomeEnv(),
              // ToggleScene(),
              // OnboardingPageIndicator(
              //   currentPage: _currentPage,
              //   child: NextPageButton(
              //     onPressed: _nextPage,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class Login {}
