import 'package:chessby/first/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';
/*
class TestScreen extends StatelessWidget {
  final List<Introduction> list = [
    Introduction(
      title: 'Find People near you', titleTextStyle: TextStyle(color: Colors.blueAccent, fontSize: 24, fontWeight: FontWeight.bold),
      subTitle: 'Browse your Locality, Find Peoples and Chat ',
      imageUrl: 'assets/comp_3.gif', imageHeight: 300,
    ),
    Introduction(
      title: 'OnSpot or Online play', titleTextStyle: TextStyle(color: Colors.blueAccent, fontSize: 24, fontWeight: FontWeight.bold),
      subTitle: 'Play chessby with them either On Spot to desired Location or Play with our Game on Playstore',
      imageUrl: 'assets/chessby-concept-illustration_114360-6059.png',  imageHeight: 200,
    ),
    Introduction(
      title: 'Find Teachers & Clubs',titleTextStyle: TextStyle(color: Colors.blueAccent, fontSize: 24, fontWeight: FontWeight.bold),
      subTitle: 'Find Teachers and Any Club taking place in your Locality',
      imageUrl: 'assets/32327e98fdff6cd75ce3cce17fa0660a.gif', imageHeight: 340,
    ),
    Introduction(
      title: 'Finish Setup !', titleTextStyle: TextStyle(color: Colors.blueAccent, fontSize: 24, fontWeight: FontWeight.bold),
      subTitle: 'Finally, Remember to Respect everyone and have Fun',
      imageUrl: 'assets/young-people-with-smartphone_23-2148477398.jpg', imageHeight: 300,
     ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: IntroScreenOnboarding(
          introductionList: list, backgroudColor: Colors.white,
          onTapSkipButton: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ), //MaterialPageRoute
            );
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setBool('Join', true);
          },
          // foregroundColor: Colors.red,
        ),
      ),
    );
  }
}*/

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  TestScreenState createState() => TestScreenState();
}

class TestScreenState extends State<TestScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => LoginScreen()),
    );
  }

  Widget _buildFullscreenImage() {
    return Image.asset(
      'assets/fullscreen.jpg',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(1.0, 0.0, 1.0, 8.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return Center(
      child: IntroductionScreen(
        key: introKey, pagesAxis: Axis.horizontal,
        globalBackgroundColor: Colors.white,
        allowImplicitScrolling: true,
        autoScrollDuration: 4000,
        infiniteAutoScroll: true,
        globalHeader: Align(
          alignment: Alignment.topRight,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 12, right: 12),
              child: _buildImage('chessbybe.jpg', 50),
            ),
          ),
        ),
        globalFooter: SizedBox(
          width: double.infinity,
          height: 60,
          child: MaterialButton(
            color: Color(0xffff79ac),
            textColor: Colors.white,
            child: const Text(
              'Let\'s go right away !',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            onPressed: () => _onIntroEnd(context),
          ),
        ),
        pages: [
          PageViewModel(
            title: "Find Players",
            body:
            "Find Players from your Locality and Challenge them",
            image: _buildImage('comp_3.gif'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "Learn as you go",
            body:
            "Find Teachers too ! And Book them right away ",
            image: _buildImage('32327e98fdff6cd75ce3cce17fa0660a.gif'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "Join chessby Clubs",
            body:
            "Join Clubs too around you, and Enjoy with those have same passion as you",
            image: _buildImage('young-people-with-smartphone_23-2148477398.jpg'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "Challenge Them !",
            body:
            "Challenge them and Earn Points !",
            image: _buildImage('chessby-concept-illustration_114360-6059.png'),
            decoration: pageDecoration,
          ),
        ],
        onDone: () => _onIntroEnd(context),
        onSkip: () => _onIntroEnd(context), // You can override onSkip callback
        showSkipButton: true,
        skipOrBackFlex: 0,
        nextFlex: 0,
        showBackButton: false,
        //rtl: true, // Display as right-to-left
        back: const Icon(Icons.arrow_back),
        skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xffff79ac))),
        next: const Icon(CupertinoIcons.forward, color: Color(0xffff79ac)),
        done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xffff79ac),)),
        curve: Curves.fastLinearToSlowEaseIn,
        controlsMargin: const EdgeInsets.all(2),
        controlsPadding: kIsWeb
            ? const EdgeInsets.all(12.0)
            : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
        dotsDecorator: const DotsDecorator(
          size: Size(10.0, 10.0),
          color: Colors.white,
          activeSize: Size(22.0, 10.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
        dotsContainerDecorator: const ShapeDecoration(
          color: Colors.white12,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
        ),
      ),
    );
  }
}