import 'package:dapp_election_user/EventContractLinking.dart';
import 'package:dapp_election_user/src/blocs/ElectionEvent/electionevent_bloc.dart';
import 'package:dapp_election_user/src/blocs/Event/event_bloc.dart';
import 'package:dapp_election_user/src/blocs/EventBloc/eventbloc_bloc.dart';
import 'package:dapp_election_user/src/ui/screens/SplashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:dapp_election_user/contract_linking.dart';
import 'package:dapp_election_user/hello_world_contract_linking.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'src/ui/configs/Routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Paint.enableDithering = true;
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();
  if (Firebase.apps.length == 0) {
    print("Firebase not initialized");
  } else {
    print("Firebase is initialized");
  }
  runApp(MyApp());
}

void registerNotification(String otp) {
  FlutterLocalNotificationsPlugin flip = new FlutterLocalNotificationsPlugin();

  // app_icon needs to be a added as a drawable
  // resource to the Android head project.
  var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
  var IOS = new IOSInitializationSettings();

  // initialise settings for both Android and iOS device.
  var settings = new InitializationSettings(android: android, iOS: IOS);
  flip.initialize(settings);
  _showNotificationWithDefaultSound(flip, otp);
}

Future _showNotificationWithDefaultSound(flip, otp) async {
  String notifTitle = "Two factor authentication";
  String notifDesc = "Your OTP is: $otp";
  // Show a notification after every 15 minute with the first
  // appearance happening a minute after invoking the method
  var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'your channel id', 'your channel name',
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority);
  var iOSPlatformChannelSpecifics = new IOSNotificationDetails();

  // initialise channel platform for both Android and iOS device.
  var platformChannelSpecifics = new NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics);
  await flip.show(0, notifTitle, notifDesc, platformChannelSpecifics,
      payload: 'Default_Sound');
  showSimpleNotification(
    Text(notifTitle),
    leading: Icon(Icons.notifications),
    subtitle: Text(
      notifDesc,
    ),
    slideDismissDirection: DismissDirection.horizontal,
    foreground: Colors.black,
    duration: Duration(seconds: 5),
    background: Colors.white,
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => EventblocBloc()),
        BlocProvider(create: (context) => ElectioneventBloc()),
        BlocProvider(create: (context) => EventBloc())
      ],
      // child: MultiProvider(
      // providers: [
      // ChangeNotifierProvider<ContractLinking>(
      //   create: (_) => ContractLinking(),
      // ),
      // ChangeNotifierProvider<HelloWorldContractLinking>(
      //   create: (_) => HelloWorldContractLinking(),
      // ),
      // ChangeNotifierProvider<EventContractLinking>(
      //   create: (_) => EventContractLinking(),
      // ),
      // ],

      // ChangeNotifierProvider<ContractLinking>(
      //   create: (_) => ContractLinking(),
      child: OverlaySupport(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: routes,
          title: 'Decentralized Voting System',
          theme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: Colors.white,
            backgroundColor: Colors.white,
            fontFamily: 'Gilroy',
            textTheme: TextTheme(
              headline1: TextStyle(
                  fontSize: 90.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              headline2: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              headline3: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              headline5: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black),
              headline6: TextStyle(fontSize: 18.0),
              subtitle1: TextStyle(fontSize: 16.0),
              bodyText1: TextStyle(fontSize: 14.0),
              bodyText2: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w100),
              button: TextStyle(fontSize: 12),
            ),
          ),
          home: SplashScreen(),
        ),
      ),
      // ),
    );
  }
}
