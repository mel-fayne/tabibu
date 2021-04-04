import 'package:Tabibu/app/auth/signin.dart';
import 'package:Tabibu/app/theme/fadeanimation.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = "/splashscreen";
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SignIn(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                        Color(0xFFFEDF00).withOpacity(0.2), BlendMode.srcOver),
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/splashscreen.jpg'))),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 400),
                    ),
                    FadeAnimation(
                        1.2,
                        Image(
                          image: AssetImage('assets/images/pulse.png'),
                          width: 45,
                          height: 45,
                        )),
                    FadeAnimation(
                      1.3,
                      Text(
                        'Tabibu',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Tangerine',
                            fontWeight: FontWeight.w900,
                            fontSize: 32),
                      ),
                    ),
                    FadeAnimation(
                      1.4,
                      Text(
                        'Your Treatment Journey Compainion',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Tangerine',
                            fontWeight: FontWeight.w900,
                            fontSize: 22),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
