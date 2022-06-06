import 'dart:async';
import 'package:dapp_election_user/models/Election/BackendFunctions.dart';
import 'package:dapp_election_user/models/Election/ElectionCandidate.dart';
import 'package:dapp_election_user/models/Election/ElectionEvent.dart';
import 'package:dapp_election_user/models/Election/ElectionParty.dart';
import 'package:dapp_election_user/models/Election/ElectionPosition.dart';
import 'package:dapp_election_user/models/Election/ElectionUser.dart';
import 'package:dapp_election_user/src/ui/screens/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/ElectionEvent/electionevent_bloc.dart';
import 'ResultsScreen.dart';

class EventListScreen extends StatefulWidget {
  static const routeName = '/eventList-screen';
  @override
  _EventListScreenState createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  String eventStatus = "In Progress Events";
  @override
  void initState() {
    Timer.periodic(Duration(seconds: 2), (timer) {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    // var contractLink = Provider.of<EventContractLinking>(context);

    Widget oneElection(String status, ElectionEvent event, String image,
        void Function() function) {
      return InkWell(
        onTap: function,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Stack(
            children: [
              Container(
                height: 150,
                width: size.width * 0.5,
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  image: DecorationImage(
                      image: AssetImage(image), fit: BoxFit.cover),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 3.0,
                    ),
                  ],
                  color: Colors.white,
                ),
              ),
              Container(
                alignment: AlignmentDirectional.bottomStart,
                height: 150,
                width: size.width * 0.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  gradient: LinearGradient(
                      begin: Alignment.center,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.9),
                      ]),
                  color: Colors.black,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    event.eventName,
                    style: theme.textTheme.subtitle1?.merge(
                      TextStyle(
                        color: Colors.white,
                        // fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget electionInProgressList() {
      return BlocBuilder<ElectioneventBloc, ElectioneventState>(
        builder: (context, state) {
          List<ElectionEvent> newEvent = [];
          if (state is AllElectionEventsRetrieved) {
            state.electionEvents.forEach((element) {
              if (element.stateOfEvent == "inProgress") {
                newEvent.add(element);
              }
            });
            return Container(
              width: size.width,
              height: 160,
              padding: EdgeInsets.only(left: size.width * 0.03),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: newEvent.map((p) {
                    return oneElection(
                        "inProgress", p, 'assets/images/electionImage.jpg', () {
                      // TODO:LoginCheck
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LoginScreen(
                                eEvent: p,
                              )));
                      // Navigator.of(context).pushNamed(LoginScreen.routeName);
                    });
                  }).toList(),
                ),
              ),
            );
          } else {
            return Container(
              width: size.width * 0.9,
            );
          }
        },
      );
    }

    Widget electionCompletedList() {
      return BlocBuilder<ElectioneventBloc, ElectioneventState>(
        builder: (context, state) {
          List<ElectionEvent> newEvent = [];
          if (state is AllElectionEventsRetrieved) {
            state.electionEvents.forEach((element) {
              if (element.stateOfEvent == "Completed") {
                newEvent.add(element);
              }
            });
            return Container(
              width: size.width,
              height: 160,
              padding: EdgeInsets.only(left: size.width * 0.03),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: newEvent.map((p) {
                    return oneElection(
                        "Completed", p, 'assets/images/votingImage.jpg', () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ResultScreen(
                                eEvent: p,
                              )));
                      // Navigator.of(context).pushNamed(ResultScreen.routeName);
                    });
                  }).toList(),
                ),
              ),
            );
          } else {
            return Container(
              width: size.width * 0.9,
            );
          }
        },
      );
    }

    return Scaffold(
      backgroundColor: theme.primaryColor,
      drawer: Drawer(
        backgroundColor: Colors.white,
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            // SizedBox(height: 20),
            DrawerHeader(
              decoration: BoxDecoration(
                color: theme.primaryColor,
              ),
              child: Container(
                  // color: Colors.red,
                  ),
            ),
            ListTile(
              title: const Text('In Progress'),
              onTap: () {
                // Update the state of the app.
                // ...
                setState(() {
                  eventStatus = 'In Progress';
                });
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text('Completed Events'),
              onTap: () {
                setState(() {
                  eventStatus = 'Completed Events';
                });
                // Update the state of the app.
                // ...
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        // shadowColor: Colors.grey.shade100,
        elevation: 0,
        bottomOpacity: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          // height: size.height,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: size.width * 0.9,
                  child: GestureDetector(
                    onTap: () {
                      allEvents.add(ElectionEvent(
                          eid: "D",
                          eventName: "City School Election 2022",
                          stateOfEvent: "inProgress",
                          startTime: DateTime.now(),
                          endTime: DateTime.now().add(Duration(days: 10)),
                          electionUsers: [
                            ElectionUser(
                              eid: "a",
                              userCnic: "42101123456790",
                              userPhone: "+923222111222",
                              userFullName: "Hateem Amir",
                              dateOfBirth: DateTime.now(),
                              gender: "M",
                              dateOfCnicExpiry:
                                  DateTime.now().add(Duration(days: 1000)),
                            ),
                            ElectionUser(
                              eid: "a",
                              userCnic: "42101123456791",
                              userPhone: "+923222111223",
                              userFullName: "Malaika Aslam",
                              dateOfBirth: DateTime.now(),
                              gender: "F",
                              dateOfCnicExpiry:
                                  DateTime.now().add(Duration(days: 1000)),
                            ),
                            ElectionUser(
                              eid: "a",
                              userCnic: "42101123456792",
                              userPhone: "+923222111224",
                              userFullName: "Emma Hudson",
                              dateOfBirth: DateTime.now(),
                              gender: "T",
                              dateOfCnicExpiry:
                                  DateTime.now().add(Duration(days: 1000)),
                            ),
                            ElectionUser(
                              eid: "a",
                              userCnic: "42101123456793",
                              userPhone: "+923222111225",
                              userFullName: "Ahad Siddiqui",
                              dateOfBirth: DateTime.now(),
                              gender: "M",
                              dateOfCnicExpiry:
                                  DateTime.now().add(Duration(days: 1000)),
                            ),
                            ElectionUser(
                              eid: "a",
                              userCnic: "42101123456794",
                              userPhone: "+923222111226",
                              userFullName: "Uzair Nadeem",
                              dateOfBirth: DateTime.now(),
                              gender: "M",
                              dateOfCnicExpiry:
                                  DateTime.now().add(Duration(days: 1000)),
                            ),
                            ElectionUser(
                              eid: "a",
                              userCnic: "42101123456797",
                              userPhone: "+923222111226",
                              userFullName: "Musab Nadeem",
                              dateOfBirth: DateTime.now(),
                              gender: "M",
                              dateOfCnicExpiry:
                                  DateTime.now().add(Duration(days: 1000)),
                            ),
                          ],
                          electionPositions: [
                            ElectionPosition(
                                positionId: "a1",
                                eid: "a",
                                positionName: "head"),
                          ],
                          electionParties: [
                            ElectionParty(
                                partyCode: "ppp",
                                eid: "a",
                                partyName: "Public Peoples Party"),
                            ElectionParty(
                                partyCode: "dds",
                                eid: "a",
                                partyName: "Democrats")
                          ],
                          electionBallots: [],
                          electionCandidates: [
                            ElectionCandidate(
                                eid: "a",
                                candidateCnic: "42101123456790",
                                position: ElectionPosition(
                                    positionId: "a1",
                                    eid: "a",
                                    positionName: "president"),
                                party: ElectionParty(
                                    partyCode: "ppp",
                                    eid: "a",
                                    partyName: "Public Peoples Party"),
                                votes: 0),
                            ElectionCandidate(
                                eid: "a",
                                candidateCnic: "42101123456791",
                                position: ElectionPosition(
                                    positionId: "a1",
                                    eid: "a",
                                    positionName: "president"),
                                party: ElectionParty(
                                    partyCode: "dds",
                                    eid: "a",
                                    partyName: "Democrats"),
                                votes: 0)
                          ]));
                    },
                    child: Text(
                      'Welcome',
                      style: theme.textTheme.headline2?.merge(
                        TextStyle(
                          color: Colors.black,
                          // fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                        ),
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
                    'Elections in Progress',
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
                electionInProgressList(),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: size.width * 0.9,
                  child: Text(
                    'Elections Completed',
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
                electionCompletedList(),
                // Container(
                //   height: 50,
                //   width: size.width * 0.9,
                //   padding: EdgeInsets.symmetric(horizontal: 20),
                //   color: Colors.yellow,
                //   child: InkWell(
                //     onTap: () {
                //       // contractLink.getEventData();
                //       Navigator.of(context).pushNamed(ResultScreen.routeName);
                //     },
                //     child: Container(
                //       alignment: Alignment.centerLeft,
                //       height: size.height * 0.1,
                //       width: size.width * 0.8,
                //       child: AutoSizeText(
                //         // ""
                //         // "Current Events",
                //         "Event 1",
                //         style: TextStyle(
                //             fontSize: 18, fontWeight: FontWeight.w600),
                //         maxFontSize: 22,
                //         minFontSize: 8,
                //       ),
                //     ),
                //   ),
                // ),
                // SizedBox(height: 10),
                // Container(
                //   height: 50,
                //   width: size.width * 0.9,
                //   padding: EdgeInsets.symmetric(horizontal: 20),
                //   color: Colors.yellow,
                //   child: InkWell(
                //     onTap: () {
                //       // contractLink.getEventData();

                //       Navigator.of(context).pushNamed(LoginScreen.routeName);
                //     },
                //     child: Container(
                //       alignment: Alignment.centerLeft,
                //       height: size.height * 0.1,
                //       width: size.width * 0.8,
                //       child: AutoSizeText(
                //         // ""
                //         // "Current Events",
                //         "Event 2",
                //         style: TextStyle(
                //             fontSize: 18, fontWeight: FontWeight.w600),
                //         maxFontSize: 22,
                //         minFontSize: 8,
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
