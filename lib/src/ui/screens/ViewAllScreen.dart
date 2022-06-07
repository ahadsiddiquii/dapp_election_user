import 'package:auto_size_text/auto_size_text.dart';
import 'package:dapp_election_user/models/Election/ElectionEvent.dart';
import 'package:dapp_election_user/src/blocs/Event/event_bloc.dart';
import 'package:dapp_election_user/src/ui/screens/LoginScreen.dart';
import 'package:dapp_election_user/src/ui/screens/ResultsScreen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ViewAllScreen extends StatefulWidget {
  static const routeName = '/viewList-screen';
  @override
  _ViewAllScreenState createState() => _ViewAllScreenState();
}

class _ViewAllScreenState extends State<ViewAllScreen> {
  TextEditingController searchController = TextEditingController();
  bool isSearching = false;
  List<ElectionEvent> allTheEvents = [];
  List<ElectionEvent> allFetchedEvents = [];

  @override
  void initState() {
    BlocProvider.of<EventBloc>(context).add(GetListOfEvents());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    List<ElectionEvent> getSearchResults() {
      List<ElectionEvent> listElections = [];
      final eventsState = BlocProvider.of<EventBloc>(context).state;
      if (eventsState is AllEventsRetrieved) {
        eventsState.listElectionEvents.forEach((element) {
          listElections.add(element);
        });
      }

      allFetchedEvents = listElections;
      return listElections;
    }

    List<ElectionEvent> getNewSearchList(String searchWord) {
      List<ElectionEvent> listEvents = [];
      allFetchedEvents.forEach((element) {
        final toSearch = element.eventName.toLowerCase();
        final query = searchWord.toLowerCase();
        if (toSearch.contains(query)) {
          listEvents.add(element);
        }
      });
      return listEvents;
    }

    Widget _listItem(ElectionEvent thisAdmin) {
      return Container(
        width: size.width * 0.95,
        // height: 100,
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
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                          child: Icon(
                        Icons.ballot,
                        // : Icons.supervised_user_circle,
                        color: thisAdmin.endTime.isBefore(DateTime.now())
                            ? Colors.grey[300]
                            : Colors.black,
                        size: 30,
                      )),
                      SizedBox(width: 10),
                      Container(
                        width: size.width * 0.7,
                        child: Text(
                          thisAdmin.eventName,
                          maxLines: 2,
                          style: theme.textTheme.headline6?.merge(
                            TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color:
                                  // userCnic.candidateCnic ==
                                  //         selectedCandidate.candidateCnic
                                  // ? Colors.grey
                                  // :
                                  thisAdmin.endTime.isBefore(DateTime.now())
                                      ? Colors.grey[300]
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
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Container(
                      child: Icon(
                    Icons.settings_backup_restore,
                    color: thisAdmin.endTime.isBefore(DateTime.now())
                        ? Colors.grey[300]
                        : Colors.black,
                    size: 30,
                  )),
                  SizedBox(width: 10),
                  Container(
                    width: size.width * 0.7,
                    child: Text(
                      "${thisAdmin.stateOfEvent}",
                      maxLines: 3,
                      style: theme.textTheme.subtitle1?.merge(
                        TextStyle(
                          color:
                              // userCnic.candidateCnic ==
                              //         selectedCandidate.candidateCnic
                              // ? Colors.grey
                              // :
                              thisAdmin.endTime.isBefore(DateTime.now())
                                  ? Colors.grey[300]
                                  : Colors.black,
                          // fontSize: 18.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  thisAdmin.stateOfEvent == "Completed"
                      ? InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ResultScreen(
                                      eEvent: thisAdmin,
                                    )));
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                            ),
                            child: Text(
                              "View Results",
                              maxLines: 1,
                              style: theme.textTheme.bodyText1?.merge(
                                TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => LoginScreen(
                                      eEvent: thisAdmin,
                                    )));
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                            ),
                            child: Text(
                              "Cast Vote",
                              maxLines: 1,
                              style: theme.textTheme.bodyText1?.merge(
                                TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
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

    return Scaffold(
      backgroundColor: theme.primaryColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        bottomOpacity: 0.0,
        automaticallyImplyLeading: false,
        title: Container(
          width: size.width * 0.9,
          child: Text(
            'Events List',
            style: theme.textTheme.headline5?.merge(
              TextStyle(
                color: Colors.black,
                // fontSize: 18.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
      ),
      body: BlocListener<EventBloc, EventState>(
        listener: (context, state) {
          if (state is AllEventsRetrieved) {
            setState(() {
              allTheEvents = getSearchResults();
            });
          }
        },
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: size.width * 0.92,
                child: TextFormField(
                  onTap: () {
                    setState(() {
                      isSearching = !isSearching;
                    });
                  },
                  readOnly: !isSearching,
                  cursorColor: Colors.black,
                  controller: searchController,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: new OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    hintText: "Search by election name",
                    hintStyle: TextStyle(color: Colors.black),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isSearching = !isSearching;
                        });
                        if (!isSearching) {
                          allTheEvents = getSearchResults();
                          searchController.clear();
                        }
                      },
                      icon: Icon(isSearching ? Icons.search_off : Icons.search,
                          color: Colors.black),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      allTheEvents = getNewSearchList(value);
                    });
                    allTheEvents.forEach((element) {
                      print(element.eventName);
                    });
                  },
                ),
              ),
              SizedBox(height: 15),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(6),
                  width: size.width * 0.95,
                  child: allTheEvents.length != 0
                      ? ListView.builder(
                          padding: EdgeInsets.all(2),
                          itemBuilder: (context, index) {
                            return _listItem(allTheEvents[index]);
                          },
                          itemCount: allTheEvents.length,
                        )
                      : Center(
                          child: Text(
                            "No election events to display",
                          ),
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
