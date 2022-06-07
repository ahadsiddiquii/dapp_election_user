import 'package:auto_size_text/auto_size_text.dart';
import 'package:dapp_election_user/EventContractLinking.dart';
import 'package:dapp_election_user/models/Election/BackendFunctions.dart';
import 'package:dapp_election_user/models/Election/ElectionBallots.dart';
import 'package:dapp_election_user/models/Election/ElectionCandidate.dart';
import 'package:dapp_election_user/models/Election/ElectionEvent.dart';
import 'package:dapp_election_user/models/Election/ElectionUser.dart';
import 'package:dapp_election_user/src/ui/OtpScreen.dart';
import 'package:dapp_election_user/src/ui/screens/YourVoteCastedScreen.dart';
import 'package:dapp_election_user/src/ui/widgets/FullWidthButton.dart';
import 'package:dapp_election_user/src/ui/widgets/Snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../blocs/ElectionEvent/electionevent_bloc.dart';
import '../../blocs/ElectionEventSelected/electioneventselected_bloc.dart';

class VotingScreen extends StatefulWidget {
  final ElectionEvent eEvent;
  final String userCnic;
  const VotingScreen({this.eEvent, this.userCnic, Key key}) : super(key: key);

  static const routeName = '/voting-screen';

  @override
  _VotingScreenState createState() => _VotingScreenState();
}

class _VotingScreenState extends State<VotingScreen> {
  ElectionCandidate selectedCandidate = ElectionCandidate();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    ballotSingle(ElectionCandidate userCnic, void Function() function) {
      return InkWell(
        onTap: function,
        child: Container(
          width: size.width * 0.9,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 1.0), //(x,y)
                blurRadius: 3.0,
              ),
            ],
          ),
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.all(
                        Radius.circular(3.0),
                      ),
                    ),
                  ),
                  Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      color: userCnic.candidateCnic ==
                              selectedCandidate.candidateCnic
                          ? Colors.black
                          : Colors.white,
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.all(
                        Radius.circular(1.0),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: size.width * 0.7,
                    child: Text(
                      "Candidate Name: ${(widget.eEvent.electionUsers.firstWhere((e) => e.userCnic == userCnic.candidateCnic)).userFullName}",
                      style: theme.textTheme.subtitle1?.merge(
                        TextStyle(
                          color: userCnic.candidateCnic ==
                                  selectedCandidate.candidateCnic
                              ? Colors.grey
                              : Colors.black,
                          // fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  // Container(
                  //   width: size.width * 0.7,
                  //   child: Text(
                  //     "Candidate ID: ${(widget.eEvent.electionUsers.firstWhere((e) => e.userCnic == userCnic.candidateCnic)).userCnic}",
                  //     style: theme.textTheme.subtitle1?.merge(
                  //       TextStyle(
                  //         color: userCnic.candidateCnic ==
                  //                 selectedCandidate.candidateCnic
                  //             ? Colors.grey
                  //             : Colors.black,
                  //         // fontSize: 18.0,
                  //         fontWeight: FontWeight.w600,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 5,
                  // ),
                  Container(
                    width: size.width * 0.7,
                    child: Text(
                      "Position: ${userCnic.position.positionName}",
                      style: theme.textTheme.subtitle1?.merge(
                        TextStyle(
                          color: userCnic.candidateCnic ==
                                  selectedCandidate.candidateCnic
                              ? Colors.grey
                              : Colors.black,
                          // fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: size.width * 0.7,
                    child: Text(
                      "Party Details",
                      style: theme.textTheme.subtitle1?.merge(
                        TextStyle(
                          color: userCnic.candidateCnic ==
                                  selectedCandidate.candidateCnic
                              ? Colors.grey
                              : Colors.black,
                          // fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: size.width * 0.7,
                    child: Text(
                      "Party Name: ${userCnic.party.partyName}",
                      style: theme.textTheme.subtitle1?.merge(
                        TextStyle(
                          color: userCnic.candidateCnic ==
                                  selectedCandidate.candidateCnic
                              ? Colors.grey
                              : Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: size.width * 0.7,
                    child: Text(
                      "Party Code: ${userCnic.party.partyCode}",
                      style: theme.textTheme.subtitle1?.merge(
                        TextStyle(
                          color: userCnic.candidateCnic ==
                                  selectedCandidate.candidateCnic
                              ? Colors.grey
                              : Colors.black,
                          // fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    allCandidatesListShow() {
      return Container(
        width: size.width,
        // height: size.he,
        // padding: EdgeInsets.only(left: size.width * 0.03),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.eEvent.electionCandidates.map((p) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
                child: widget.userCnic != p.candidateCnic
                    ? ballotSingle(p, () {
                        setState(() {
                          selectedCandidate = p;
                        });
                      })
                    : Container(),
              );
            }).toList(),
          ),
        ),
      );
    }

    learnMoreDialogBox({
      String heading,
      String content,
    }) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return new AlertDialog(
              backgroundColor: Colors.white,
              contentPadding: EdgeInsets.fromLTRB(24, 20, 24, 5),
              insetPadding: EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              content: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // IconButton(
                    //     padding: EdgeInsets.zero,
                    //     onPressed:,
                    //     icon: ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // SizedBox(
                        //   width: 10,
                        // ),
                        Text(heading,
                            style: theme.textTheme.headline5?.merge(
                                TextStyle(fontWeight: FontWeight.w600))),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            height: 13,
                            // margin: const EdgeInsets.symmetric(vertical: 5),
                            child: Image.asset(
                                'assets/images/crossNoBackground.png'),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      content,
                      textAlign: TextAlign.justify,
                      style: theme.textTheme.subtitle1
                          ?.merge(TextStyle(color: Colors.black)),
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 1,
                      color: Colors.grey[300],
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // InkWell(
                        //   onTap: () {
                        //     Navigator.of(context).pop();
                        //   },
                        //   child: Container(
                        //       // height: 13,
                        //       // margin: const EdgeInsets.symmetric(vertical: 5),
                        //       // child: Text('Cancel'),
                        //       ),
                        // ),
                        // DialogBoxWidthButton(
                        //     text: "Cancel",
                        //     func: () {
                        //       Navigator.of(context).pop();
                        //     },
                        //     isFullWidth: false,
                        //     isOutlined: true),
                        FullWidthButton(
                            text: "Yes",
                            func: () {
                              // allEvents.forEach((element) {
                              //   if (widget.eEvent.eid == element.eid) {
                              //     element.electionBallots.add(ElectionBallot(
                              //         eid: element.eid,
                              //         candidateCnic:
                              //             selectedCandidate.candidateCnic,
                              //         voterCnic: widget.userCnic));
                              //     element.electionCandidates
                              //         .forEach((candidate) {
                              //       if (candidate.candidateCnic ==
                              //           selectedCandidate.candidateCnic) {
                              //         candidate.votes++;
                              //       }
                              //     });
                              //   }
                              // });
                              Navigator.of(context).pop();
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          YourVoteCastedScreen(
                                              eEvent: widget.eEvent)));
                            },
                            isFullWidth: false,
                            isOutlined: false),
                      ],
                    ),
                    // SizedBox(height: 20),
                  ],
                ),
              ),
            );
          });
    }

    return Scaffold(
      backgroundColor: theme.primaryColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: selectedCandidate.candidateCnic != null
          ? FullWidthButton(
              text: "Cast Vote",
              func: () {
                if (selectedCandidate.candidateCnic == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      showSnackbar("Please make your selection first"));
                } else {
                  print(selectedCandidate.candidateCnic);
                  learnMoreDialogBox(
                      heading: "Confirm",
                      content: "Are you sure with your choice?");
                }
              },
              isFullWidth: false,
              isOutlined: false)
          : Container(),
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
                  'Vote Cast',
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
                child:
                    Lottie.asset("assets/images/json_assets/voteLottie.json"),
              ),
              SizedBox(height: 12),
              Container(
                width: size.width * 0.9,
                child: Text(
                  "Please select your choice",
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
              allCandidatesListShow(),
              SizedBox(
                height: 75,
              ),
            ],
          )),
        ),
      ),
    );
  }
}
