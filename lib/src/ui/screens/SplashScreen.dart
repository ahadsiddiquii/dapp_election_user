import 'package:auto_size_text/auto_size_text.dart';
import 'package:dapp_election_user/src/blocs/ElectionEvent/electionevent_bloc.dart';
import 'package:dapp_election_user/src/ui/screens/EventListScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    BlocProvider.of<ElectioneventBloc>(context).add(GetElectonEvents());
    Future.delayed(Duration(seconds: 4), () {
      Navigator.of(context).pushReplacementNamed(EventListScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            height: size.height * 1.2,
            width: size.width,

            // child: Image.asset('assets/images/SplashScreenV2.jpg',
            //     fit: BoxFit.cover),
            child: Image.asset('assets/images/splashScreen.png',
                fit: BoxFit.cover),
            // child: Lottie.asset('assets/images/splashScreen.json',
            //     fit: BoxFit.cover),
          ),
          Container(
            color: Colors.white,
            height: size.height,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: size.height * 0.3,
                    width: size.width * 0.7,
                    child: Lottie.asset(
                        "assets/images/json_assets/splashAsset.json"),
                  ),
                  // Container(
                  //   alignment: Alignment.center,
                  //   height: size.height * 0.1,
                  //   width: size.width * 0.9,
                  //   child: AutoSizeText(
                  //     "Decentralized Voting System",
                  //     style: theme.textTheme.headline3.merge(TextStyle(
                  //         color: Colors.black, fontWeight: FontWeight.bold)),
                  //     maxFontSize: 22,
                  //     minFontSize: 8,
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
