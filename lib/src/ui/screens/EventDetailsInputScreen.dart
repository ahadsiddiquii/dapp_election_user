import 'package:auto_size_text/auto_size_text.dart';
import 'package:dapp_election_user/EventContractLinking.dart';
import 'package:dapp_election_user/src/blocs/EventBloc/eventbloc_bloc.dart';
import 'package:dapp_election_user/src/ui/configs/Helper.dart';
import 'package:dapp_election_user/src/ui/widgets/FullWidthButton.dart';
import 'package:dapp_election_user/src/ui/widgets/Snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class EventDetailsInputScreen extends StatefulWidget {
  static const routeName = '/eventdetails-screen';
  @override
  _EventDetailsInputScreenState createState() =>
      _EventDetailsInputScreenState();
}

class _EventDetailsInputScreenState extends State<EventDetailsInputScreen> {
  List<List<String>> userList = [];
  List<List<String>> positionsList = [];
  List<List<String>> partiesList = [];
  List<List<String>> candidatesList = [];

  int index = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var eventContractLink = Provider.of<EventContractLinking>(context);
    return Scaffold(
      body: Container(
        height: size.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                height: size.height * 0.1,
                width: size.width * 0.9,
                child: AutoSizeText(
                  index == 0
                      ? "Input people in the event"
                      : index == 1
                          ? "Input positions in the event"
                          : index == 2
                              ? "Input parties in the event"
                              : "Input candidates standing for the election event",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  maxFontSize: 22,
                  minFontSize: 8,
                ),
              ),
              FullWidthButton(
                text: "Upload File",
                func: () async {
                  if (index == 0) {
                    userList = await readCSV("Party");
                  } else if (index == 1) {
                    positionsList = await readCSV("Party");
                  } else if (index == 2) {
                    partiesList = await readCSV("Party");
                  } else if (index == 3) {
                    candidatesList = await readCSV("Party");
                  } else {
                    print("Some Error Occured");
                  }
                  setState(() {});
                },
                isFullWidth: false,
                isOutlined: false,
              ),
              SizedBox(
                height: 10,
              ),
              if (userList.isNotEmpty && index == 0)
                Container(
                  width: size.width < 420 ? size.width * 0.8 : 420 * 0.8,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: userList.map((p) {
                        return Container(
                          width: size.width * 0.8,
                          child: Row(
                            children: [
                              AutoSizeText(" Username: ${p[3]}, "),
                              AutoSizeText(" ID: ${p[1]} "),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              if (positionsList.isNotEmpty && index == 1)
                Container(
                  width: size.width < 420 ? size.width * 0.8 : 420 * 0.8,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: positionsList.map((p) {
                        return Container(
                          width: size.width * 0.8,
                          child: Row(
                            children: [
                              AutoSizeText(" Position Name: ${p[1]}, "),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              if (partiesList.isNotEmpty && index == 2)
                Container(
                  width: size.width * 0.8,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: partiesList.map((p) {
                        return Container(
                          width: size.width * 0.8,
                          child: Row(
                            children: [
                              AutoSizeText(" Party Name: ${p[1]}, "),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              if (candidatesList.isNotEmpty && index == 3)
                Container(
                  width: size.width * 0.7,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: candidatesList.map((p) {
                        return Container(
                          width: size.width * 0.7,
                          child: Row(
                            children: [
                              AutoSizeText(" ID: ${p[1]}, "),
                              AutoSizeText(" From Party: ${p[3]}, "),
                              AutoSizeText(" For Position: ${p[2]}, "),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 70,
                width: size.width < 420 ? size.width * 0.9 : 420 * 0.9,
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    print(size.width);
                    if (userList.isNotEmpty && index == 0) {
                      setState(() {
                        index = 1;
                      });
                    } else if (positionsList.isNotEmpty && index == 1) {
                      setState(() {
                        index = 2;
                      });
                    } else if (partiesList.isNotEmpty && index == 2) {
                      setState(() {
                        index = 3;
                      });
                    } else if (candidatesList.isNotEmpty && index == 3) {
                      //runContract
                      // Navigation
                      final eventState =
                          BlocProvider.of<EventblocBloc>(context).state;
                      if (eventState is EventDetailsInitialAdded) {
                        eventContractLink.createEvent(
                            eventState.eventName,
                            eventState.stateOfEvent,
                            eventState.startDate,
                            eventState.endDate,
                            userList,
                            positionsList,
                            partiesList,
                            candidatesList);
                      }
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                          showSnackbar("Successfully initiated the event."));
                    } else {
                      print("Some Error Occured");
                    }
                  },
                  child: Container(
                    width: size.width < 420 ? size.width * 0.2 : 420 * 0.2,
                    child: Row(
                      children: [
                        Text(
                          "Next ",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          // size: 15,
                        ),
                      ],
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
