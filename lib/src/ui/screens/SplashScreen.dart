import 'package:auto_size_text/auto_size_text.dart';
import 'package:dapp_election_user/src/ui/screens/EventListScreen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'LoginScreen.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash-screen';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 4), () {
      Navigator.of(context).pushReplacementNamed(EventListScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: size.height * 0.3,
                width: size.width * 0.7,
                child: Lottie.network(
                    "https://assets6.lottiefiles.com/packages/lf20_omrk3sbt.json"),
              ),
              Container(
                alignment: Alignment.center,
                height: size.height * 0.1,
                width: size.width * 0.9,
                child: AutoSizeText(
                  "Decentralized Voting System",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  maxFontSize: 22,
                  minFontSize: 8,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
