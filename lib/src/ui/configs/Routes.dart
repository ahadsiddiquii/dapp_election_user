import 'package:dapp_election_user/src/ui/screens/EventDetailsInputScreen.dart';
import 'package:dapp_election_user/src/ui/screens/EventListScreen.dart';
import 'package:dapp_election_user/src/ui/screens/HomeScreen.dart';
import 'package:dapp_election_user/src/ui/screens/LoginScreen.dart';
import 'package:dapp_election_user/src/ui/screens/ResultsScreen.dart';
import 'package:dapp_election_user/src/ui/screens/SplashScreen.dart';
import 'package:dapp_election_user/src/ui/screens/HomeScreen.dart';
import 'package:dapp_election_user/src/ui/screens/VotingScreen.dart';

import 'package:flutter/material.dart';

import '../OtpScreen.dart';

final Map<String, Widget Function(BuildContext)> routes = {
  SplashScreen.routeName: (ctx) => SplashScreen(),
  LoginScreen.routeName: (ctx) => LoginScreen(),
  HomeScreen.routeName: (ctx) => HomeScreen(),
  EventDetailsInputScreen.routeName: (ctx) => EventDetailsInputScreen(),
  EventListScreen.routeName: (ctx) => EventListScreen(),
  OTPScreen.routeName: (ctx) => OTPScreen(),
  ResultScreen.routeName: (ctx) => ResultScreen(),
  VotingScreen.routeName: (ctx) => VotingScreen(),
};
