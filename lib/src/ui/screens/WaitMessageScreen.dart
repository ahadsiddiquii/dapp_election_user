import 'package:auto_size_text/auto_size_text.dart';
import 'package:dapp_election_user/EventContractLinking.dart';
import 'package:dapp_election_user/models/Election/ElectionCandidate.dart';
import 'package:dapp_election_user/models/Election/ElectionEvent.dart';
import 'package:dapp_election_user/models/Election/ElectionUser.dart';
import 'package:dapp_election_user/src/ui/OtpScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../blocs/ElectionEvent/electionevent_bloc.dart';
import '../../blocs/ElectionEventSelected/electioneventselected_bloc.dart';

class WaitMessageScreen extends StatefulWidget {
  final ElectionEvent eEvent;
  const WaitMessageScreen({this.eEvent, Key key}) : super(key: key);

  static const routeName = '/waitmessage-screen';

  @override
  _WaitMessageScreenState createState() => _WaitMessageScreenState();
}

class _WaitMessageScreenState extends State<WaitMessageScreen> {
  final DateFormat formatter = DateFormat('dd/MM/yyyy hh:mm a');
  @override
  void initState() {
    super.initState();
  }

  String getWinningCandidateCnic() {
    int totalVotes = 0;
    ElectionCandidate selectedCandidate = ElectionCandidate();
    widget.eEvent.electionCandidates.forEach((element) {
      if (element.votes > totalVotes) {
        totalVotes = element.votes;
        selectedCandidate = element;
      }
    });
    print(selectedCandidate.candidateCnic);
    return selectedCandidate.candidateCnic;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.primaryColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        bottomOpacity: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          // height: size.height,
          width: size.width,
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: size.width * 0.9,
                child: Text(
                  'Election in process',
                  style: theme.textTheme.headline2?.merge(
                    TextStyle(
                      color: Colors.black,
                      // fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                width: size.width * 0.9,
                child: Text(
                  widget.eEvent.eventName,
                  style: theme.textTheme.headline3?.merge(
                    TextStyle(
                      color: Colors.black,
                      // fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Container(
                height: size.height * 0.2,
                width: size.width * 0.9,
                child: Lottie.network(
                    "https://assets10.lottiefiles.com/packages/lf20_xldzoar8.json"),
              ),
              SizedBox(height: 12),
              Container(
                width: size.width * 0.9,
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        // width: size.width * 0.9,
                        child: Text(
                          "You have already voted.",
                          style: theme.textTheme.headline3?.merge(
                            TextStyle(
                              color: Colors.black,
                              // fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        // width: size.width * 0.9,
                        child: Text(
                          "Stay tuned for the results",
                          style: theme.textTheme.headline3?.merge(
                            TextStyle(
                              color: Colors.black,
                              // fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        // width: size.width * 0.9,
                        child: Text(
                          "Election end date \n${formatter.format(widget.eEvent.endTime)}",
                          textAlign: TextAlign.center,
                          style: theme.textTheme.headline3?.merge(
                            TextStyle(
                              color: Colors.black,
                              // fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
