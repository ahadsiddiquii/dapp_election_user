import 'package:dapp_election_user/EventContractLinking.dart';
import 'package:dapp_election_user/src/blocs/ElectionEvent/electionevent_bloc.dart';
import 'package:dapp_election_user/src/blocs/EventBloc/eventbloc_bloc.dart';
import 'package:dapp_election_user/src/ui/screens/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:dapp_election_user/contract_linking.dart';
import 'package:dapp_election_user/helloUI.dart';
import 'package:dapp_election_user/hello_world_contract_linking.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'src/ui/configs/Routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => EventblocBloc()),
        BlocProvider(create: (context) => ElectioneventBloc())
      ],
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<ContractLinking>(
            create: (_) => ContractLinking(),
          ),
          ChangeNotifierProvider<HelloWorldContractLinking>(
            create: (_) => HelloWorldContractLinking(),
          ),
          ChangeNotifierProvider<EventContractLinking>(
            create: (_) => EventContractLinking(),
          ),
        ],

        // ChangeNotifierProvider<ContractLinking>(
        //   create: (_) => ContractLinking(),
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
    );
  }
}
