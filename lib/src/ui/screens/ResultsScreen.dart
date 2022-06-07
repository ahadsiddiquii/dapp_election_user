import 'package:auto_size_text/auto_size_text.dart';
import 'package:dapp_election_user/EventContractLinking.dart';
import 'package:dapp_election_user/models/Election/ElectionCandidate.dart';
import 'package:dapp_election_user/models/Election/ElectionEvent.dart';
import 'package:dapp_election_user/models/Election/ElectionUser.dart';
import 'package:dapp_election_user/src/ui/OtpScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../blocs/ElectionEvent/electionevent_bloc.dart';
import '../../blocs/ElectionEventSelected/electioneventselected_bloc.dart';

class ResultScreen extends StatefulWidget {
  final ElectionEvent eEvent;
  const ResultScreen({this.eEvent, Key key}) : super(key: key);

  static const routeName = '/result-screen';

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  bool isElectionTie = false;
  String winningCnic = " ";
  List<ElectionCandidate> electionCandidatesTieList = [];
  @override
  void initState() {
    winningCnic = getWinningCandidateCnic();
    print("Winning Cnic: ${winningCnic}");
    super.initState();
  }

  String getWinningCandidateCnic() {
    int totalVotes = 0;
    bool checkTie = false;
    ElectionCandidate selectedCandidate = ElectionCandidate();
    widget.eEvent.electionCandidates.forEach((element) {
      if (element.votes > totalVotes) {
        totalVotes = element.votes;
        selectedCandidate = element;
      }
    });

    widget.eEvent.electionCandidates.forEach(
      (element) {
        if (element.votes == totalVotes) {
          electionCandidatesTieList.add(element);
        }
      },
    );
    print(selectedCandidate.candidateCnic);
    if (electionCandidatesTieList.isEmpty)
      return selectedCandidate.candidateCnic;
    else
      return "Nothing";
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
                  'Results',
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
                child: Lottie.asset("assets/images/json_assets/results.json"),
              ),
              SizedBox(height: 12),
              Container(
                width: size.width * 0.9,
                child: Text(
                  electionCandidatesTieList.length < 2 ? "Winner" : "Tie",
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
                width: size.width * 0.9,
                child: Center(
                  child: Column(
                    children: [
                      (electionCandidatesTieList.isNotEmpty)
                          ? Column(
                              children: electionCandidatesTieList.map((p) {
                                return Text(
                                    (widget.eEvent.electionUsers.firstWhere(
                                            (e) =>
                                                e.userCnic == p.candidateCnic))
                                        .userFullName,
                                    style: theme.textTheme.headline2?.merge(
                                      TextStyle(
                                        color: Colors.black,
                                        // fontSize: 18.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ));
                              }).toList(),
                            )
                          // : Text(
                          //     (widget.eEvent.electionUsers.firstWhere(
                          //             (e) => e.userCnic == winningCnic))
                          //         .userFullName,
                          //     style: theme.textTheme.headline2?.merge(
                          //       TextStyle(
                          //         color: Colors.black,
                          //         // fontSize: 18.0,
                          //         fontWeight: FontWeight.w600,
                          //       ),
                          //     ))
                          : Text("No votes casted for this election",
                              style: theme.textTheme.headline2?.merge(
                                TextStyle(
                                  color: Colors.black,
                                  // fontSize: 18.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              )),
                      SizedBox(
                        height: 8,
                      ),
                      if (electionCandidatesTieList.isEmpty)
                        Text(
                          (widget.eEvent.electionCandidates.firstWhere(
                                  (e) => e.candidateCnic == winningCnic))
                              .votes
                              .toString(),
                          style: theme.textTheme.headline1?.merge(
                            TextStyle(
                              color: Colors.black,
                              // fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      if (electionCandidatesTieList.isEmpty)
                        Text(
                          "Vote Count",
                          style: theme.textTheme.headline5?.merge(
                            TextStyle(
                              color: Colors.black,
                              // fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      SizedBox(
                        height: 8,
                      ),
                      if (electionCandidatesTieList.isEmpty)
                        Text(
                          "Position",
                          style: theme.textTheme.headline2?.merge(
                            TextStyle(
                              color: Colors.black,
                              // fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      if (electionCandidatesTieList.isEmpty)
                        Text(
                          (widget.eEvent.electionCandidates.firstWhere(
                                  (e) => e.candidateCnic == winningCnic))
                              .position
                              .positionName,
                          style: theme.textTheme.headline3?.merge(
                            TextStyle(
                              color: Colors.black,
                              // fontSize: 18.0,
                              fontWeight: FontWeight.w600,
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
