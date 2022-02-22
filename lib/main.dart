import 'package:dapp_election_user/EventContractLinking.dart';
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
      providers: [BlocProvider(create: (context) => EventblocBloc())],
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
              primaryColor: Colors.blueGrey[900],
              accentColor: Colors.deepOrange[200],
              backgroundColor: Color(0xffF5b301)),
          home: SplashScreen(),
        ),
      ),
    );
  }
}
