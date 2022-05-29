import 'package:csv/csv.dart';
import 'package:dapp_election_user/src/blocs/EventBloc/eventbloc_bloc.dart';
import 'package:dapp_election_user/src/ui/configs/Constants.dart';
import 'package:dapp_election_user/src/ui/screens/EventDetailsInputScreen.dart';
import 'package:dapp_election_user/src/ui/widgets/Snackbar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:dapp_election_user/src/ui/widgets/FullWidthButton.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'NavigationDrawerWidget.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();

  final DateFormat formatter = DateFormat('dd/MM/yyyy hh:mm a');
  final DateFormat formatterDateOnly = DateFormat('MMMM yyyy');
  final DateFormat formatterDateReview = DateFormat('MMMM d, yyyy');
  final dateTimeformat = DateFormat("yyyy-MM-dd hh:mm");
  String eventName;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  bool startDateBeforeEndDateValidation() {
    return startDate.isBefore(endDate);
  }

  void pickDateDialogue(
      BuildContext context,
      String dateSelection,
      // ignore: non_constant_identifier_names
      String TimeSelection) {
    DatePicker.showDateTimePicker(context,
        theme: DatePickerTheme(
          containerHeight: 150.0,
        ),
        showTitleActions: true,
        minTime: DateTime.now(),
        maxTime: DateTime(2030, 12, 31, 0, 0), onConfirm: (date) {
      setState(() {
        if (dateSelection == "startDate")
          startDate = date;
        else
          endDate = date;
      });

      print('confirm $date');
    }, currentTime: DateTime.now(), locale: LocaleType.en);
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    Future readCSV(String type) async {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['csv', 'xls', 'xlsx'],
      );
      if (result == null) return;
      final file = result.files.first;
      final uploadedFile = String.fromCharCodes(file.bytes);
      List<List<dynamic>> rowsAsListOfValues =
          const CsvToListConverter().convert(uploadedFile);
      print(rowsAsListOfValues);
    }

    Future pickDateTime(String dateType) async {
      DatePicker.showDatePicker(context,
          showTitleActions: true,
          minTime: DateTime.now(),
          maxTime: DateTime(2032, 12, 30), onChanged: (date) {
        print('change $date');
      }, onConfirm: (date) {
        print('confirm $date');
      }, currentTime: DateTime.now(), locale: LocaleType.en);
    }

    headingAndSubheading(String title, String text, var width) {
      return Container(
        width: width,
        alignment: AlignmentDirectional.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                text != "null"
                    ? Container(
                        width: width,
                        child: Text(
                          text,
                          textAlign: TextAlign.left,
                          // maxLines: 3,
                          // overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 14,
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          ],
        ),
      );
    }

    return BlocListener<EventblocBloc, EventblocState>(
      listener: (context, state) {
        if (state is EventDetailsInitialAdded) {
          print("Moving to User Lists");
          Navigator.of(context).pushNamed(EventDetailsInputScreen.routeName);
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        drawer: NavigationDrawerWidget(),
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () => _scaffoldKey.currentState.openDrawer()),
        ),
        body: SingleChildScrollView(
            child: (Container(
          // height: size.height,
          child: Center(
            child: Form(
              key: _formKey,
              child: Container(
                width: size.width * 0.8 > 500 ? 500 : size.width * 0.8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 50),
                    Text(
                      "Voting Event",
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 4,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: TextFormField(
                        keyboardType: TextInputType.name,
                        controller: nameController,
                        validator: (value) => !(value.length > 0)
                            ? "Enter a valid Name (Name must be alphabetic string)"
                            : null,
                        decoration: InputDecoration(
                          focusedBorder: new OutlineInputBorder(
                            borderSide: BorderSide(color: themeColorApp),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: themeColorApp),
                          ),
                          labelStyle: TextStyle(color: Colors.grey[300]),
                          labelText: "Event Name",
                          hintText: "Please give your Election event a name ",
                          hintStyle: TextStyle(color: Colors.grey[300]),
                          icon: Icon(
                            Icons.person,
                            color: Colors.grey[300],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 70,
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Icon(
                                Icons.calendar_today_rounded,
                                color: Colors.white,
                              ),
                            ),
                            // SizedBox(width: 20),
                            // IconButton(
                            //   icon: Icon(
                            //     Icons.calendar_today_rounded,
                            //     color: Colors.white,
                            //   ),
                            //   onPressed: () {
                            //     pickDateDialogue(context, "endDate", "endTime");
                            //   },
                            // ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              children: [
                                headingAndSubheading(
                                  "Set event's start date and time",
                                  "",
                                  size.width < 420
                                      ? size.width * 0.5
                                      : 420 * 0.5,
                                ),
                                Container(
                                  child: Text(
                                    formatter.format(startDate),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ]),
                    ),

                    FullWidthButton(
                      text: "Set Start Date and Time",
                      func: () {
                        // pickDateTime("sdate");
                        pickDateDialogue(context, "startDate", "startTime");
                      },
                      isFullWidth: false,
                      isOutlined: false,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 70,
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Icon(
                                Icons.calendar_today_rounded,
                                color: Colors.white,
                              ),
                            ),
                            // SizedBox(width: 20),
                            // IconButton(
                            //   icon: Icon(
                            //     Icons.calendar_today_rounded,
                            //     color: Colors.white,
                            //   ),
                            //   onPressed: () {
                            //     pickDateDialogue(context, "endDate", "endTime");
                            //   },
                            // ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              children: [
                                headingAndSubheading(
                                  "Set event's end date and time",
                                  "",
                                  size.width < 420
                                      ? size.width * 0.5
                                      : 420 * 0.5,
                                ),
                                Container(
                                  child: Text(
                                    formatter.format(endDate),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ]),
                    ),

                    FullWidthButton(
                      text: "Set End Date and Time",
                      func: () {
                        pickDateDialogue(context, "endDate", "endTime");
                      },
                      isFullWidth: false,
                      isOutlined: false,
                    ),

                    Container(
                      height: 70,
                      width: size.width < 420 ? size.width * 0.9 : 420 * 0.9,
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          print(size.width);
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            if (startDateBeforeEndDateValidation()) {
                              print(nameController.text);
                              print(startDate.toIso8601String());
                              print(endDate.toIso8601String());

                              //add
                              BlocProvider.of<EventblocBloc>(context).add(
                                  EventsDetailsInsert(
                                      eventName: nameController.text,
                                      startDate: startDate.toIso8601String(),
                                      endDate: endDate.toIso8601String()));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  showSnackbar(
                                      "Please check start date is always before end date?"));
                            }

                            // await contractLink.loginUser(
                            //     idController.text,
                            //     passwordController.text);
                            // ScaffoldMessenger.of(context).showSnackBar(
                            //     showSnackbar(contractLink.deployedName));
                            // print(contractLink.deployedStatus);
                            // if (contractLink.deployedStatus == 200) {
                            //   Navigator.of(context).pushReplacementNamed(
                            //       HomeScreen.routeName);
                            // }
                          }
                          // Navigator.of(context)
                          //     .pushReplacementNamed(HomeScreen.routeName);
                        },
                        child: Container(
                          width:
                              size.width < 420 ? size.width * 0.2 : 420 * 0.2,
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
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 30),
                    //   child: TextFormField(
                    //     keyboardType: TextInputType.datetime,
                    //     controller: dateController,
                    //     decoration: InputDecoration(
                    //       focusedBorder: new OutlineInputBorder(
                    //         borderSide: BorderSide(color: themeColorApp),
                    //       ),
                    //       border: OutlineInputBorder(
                    //         borderSide: BorderSide(color: themeColorApp),
                    //       ),
                    //       labelStyle: TextStyle(color: Colors.grey[300]),
                    //       labelText: "Start Date",
                    //       hintText: "Please give a Start Date",
                    //       hintStyle: TextStyle(color: Colors.grey[300]),
                    //       icon: Icon(
                    //         Icons.calendar_today,
                    //         color: Colors.grey[300],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 30),
                    //   child: TextFormField(
                    //     keyboardType: TextInputType.datetime,
                    //     controller: dateController,
                    //     decoration: InputDecoration(
                    //       focusedBorder: new OutlineInputBorder(
                    //         borderSide: BorderSide(color: themeColorApp),
                    //       ),
                    //       border: OutlineInputBorder(
                    //         borderSide: BorderSide(color: themeColorApp),
                    //       ),
                    //       labelStyle: TextStyle(color: Colors.grey[300]),
                    //       labelText: "End Date",
                    //       hintText: "Please give an End Date",
                    //       hintStyle: TextStyle(color: Colors.grey[300]),
                    //       icon: Icon(
                    //         Icons.calendar_today,
                    //         color: Colors.grey[300],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // FullWidthButton(
                    //   text: "Upload File",
                    //   func: () {
                    //     readCSV("Party");
                    //   },
                    //   isFullWidth: false,
                    //   isOutlined: false,
                    // ),
                    // FullWidthButton(
                    //   text: "Upload File",
                    //   func: () {
                    //     readCSV("Party");
                    //   },
                    //   isFullWidth: false,
                    //   isOutlined: false,
                    // ),
                    // FullWidthButton(
                    //   text: "Upload File",
                    //   func: () {
                    //     readCSV("Party");
                    //   },
                    //   isFullWidth: false,
                    //   isOutlined: false,
                    // ),
                    // FullWidthButton(
                    //   text: "Upload File",
                    //   func: () {
                    //     readCSV("Party");
                    //   },
                    //   isFullWidth: false,
                    //   isOutlined: false,
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ))),
      ),
    );
  }
}
