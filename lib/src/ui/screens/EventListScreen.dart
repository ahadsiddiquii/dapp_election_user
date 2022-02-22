import 'package:auto_size_text/auto_size_text.dart';
import 'package:dapp_election_user/EventContractLinking.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class EventListScreen extends StatefulWidget {
  static const routeName = '/eventList-screen';
  @override
  _EventListScreenState createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var contractLink = Provider.of<EventContractLinking>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          // height: size.height,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                InkWell(
                  onTap: () {
                    contractLink.getEventData();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: size.height * 0.1,
                    width: size.width * 0.9,
                    child: AutoSizeText(
                      "Current Events",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      maxFontSize: 22,
                      minFontSize: 8,
                    ),
                  ),
                ),
                // Container(
                //   height: size.height * 0.3,
                //   width: size.width * 0.7,
                //   child: Lottie.network(
                //       "https://assets6.lottiefiles.com/packages/lf20_omrk3sbt.json"),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
