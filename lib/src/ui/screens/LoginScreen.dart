import 'package:dapp_election_user/contract_linking.dart';
import 'package:dapp_election_user/main.dart';
import 'package:dapp_election_user/models/Election/BackendFunctions.dart';
import 'package:dapp_election_user/models/Election/ElectionEvent.dart';
import 'package:dapp_election_user/src/ui/OtpScreen.dart';
import 'package:dapp_election_user/src/ui/configs/Constants.dart';
import 'package:dapp_election_user/src/ui/configs/Helper.dart';
import 'package:dapp_election_user/src/ui/screens/WaitMessageScreen.dart';
import 'package:dapp_election_user/src/ui/widgets/FullWidthButton.dart';
import 'package:dapp_election_user/src/ui/widgets/Snackbar.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:provider/provider.dart';
import 'HomeScreen.dart';
import 'NavigationDrawerWidget.dart';

class LoginScreen extends StatefulWidget {
  final ElectionEvent eEvent;
  const LoginScreen({this.eEvent, Key key}) : super(key: key);

  static const routeName = '/login-screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final idController = TextEditingController();
  final passwordController = TextEditingController();
  bool _obscureText = true;
  bool correctPassword = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var contractLink = Provider.of<ContractLinking>(context);
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FullWidthButton(
          text: "Submit",
          func: () async {
            bool isFound = false;
            bool alreadyVoted = false;
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              widget.eEvent.electionUsers.forEach((element) {
                if (element.userCnic == idController.text) {
                  isFound = true;
                  print("Login User: ");
                  print(element.userCnic);
                  widget.eEvent.electionBallots.forEach((ballot) {
                    if (ballot.voterCnic == element.userCnic) {
                      alreadyVoted = true;
                    }
                  });
                  if (!alreadyVoted) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => OTPScreen(
                            eEvent: widget.eEvent,
                            userCnic: element.userCnic)));
                  } else {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => WaitMessageScreen(
                              eEvent: widget.eEvent,
                            )));
                  }
                  // Navigator.of(context)
                  //     .pushReplacementNamed(OTPScreen.routeName);
                }
              });
              if (isFound == false) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(showSnackbar("User not authorized"));
              }
            }

            //   await contractLink.loginUser(
            //       idController.text,
            //       passwordController.text);
            //   ScaffoldMessenger.of(context).showSnackBar(
            //       showSnackbar(contractLink.deployedName));
            //   print(contractLink.deployedStatus);
            //   if (contractLink.deployedStatus == 200) {
            //     Navigator.of(context).pushReplacementNamed(
            //         HomeScreen.routeName);
            //   }
            // }
            // Navigator.of(context).pushReplacementNamed(OTPScreen.routeName);
          },
          isFullWidth: false,
          isOutlined: false),
      body: SingleChildScrollView(
        child: Container(
          // height: size.height,
          child: Center(
              child:
                  // (!contractLink.isLoading)
                  // ?
                  Form(
            key: _formKey,
            child: Container(
              width: size.width * 0.9 > 500 ? 500 : size.width * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: size.width * 0.9,
                    child: Text(
                      'Login',
                      style: theme.textTheme.headline2?.merge(
                        TextStyle(
                          color: Colors.black,
                          // fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      allEvents.forEach((element) {
                        if (element.eid == widget.eEvent.eid) {
                          print("Ending Election");
                          element.stateOfEvent = "Completed";
                        }
                      });
                    },
                    child: Container(
                      height: size.height * 0.2,
                      width: size.width * 0.9,
                      child: Lottie.asset(
                          'assets/images/json_assets/loginLottie.json'),
                    ),
                  ),

                  InkWell(
                    onTap: () {
                      // contractLink.registerUser(
                      //     "4210112345678", "Ahadsiddiqui123.");
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: idController,
                      validator: (value) => !((value.length > 10 &&
                                  value.length < 15) &&
                              (isNumeric(value)))
                          ? "Enter a valid ID (Id must be numeric 13 digit number)"
                          : null,
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
                        labelStyle: TextStyle(color: Colors.black),
                        labelText: "Your ID",
                        hintText: "What is your ID ?",
                        hintStyle: TextStyle(color: Colors.black),
                        icon: Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 30),
                  //   child: TextFormField(
                  //     keyboardType: TextInputType.visiblePassword,
                  //     obscureText: _obscureText,
                  //     controller: passwordController,
                  //     validator: (value) =>
                  //         !((value.length > 5 && value.length < 20))
                  //             ? "Enter a valid password"
                  //             : null,
                  //     style: TextStyle(
                  //         fontWeight: FontWeight.normal,
                  //         color: Colors.white),
                  //     decoration: InputDecoration(
                  //       // enabledBorder: new OutlineInputBorder(
                  //       //   borderSide: BorderSide(color: buttonColor),
                  //       // ),
                  //       focusedBorder: new OutlineInputBorder(
                  //         borderSide: BorderSide(color: themeColorApp),
                  //       ),
                  //       border: OutlineInputBorder(
                  //         borderSide: BorderSide(color: themeColorApp),
                  //       ),
                  //       labelText: "Your Password",
                  //       labelStyle: TextStyle(color: Colors.grey[300]),
                  //       hintText: "What is your Password ?",
                  //       hintStyle: TextStyle(color: Colors.grey[300]),
                  //       icon: Icon(
                  //         Icons.password_rounded,
                  //         color: Colors.grey[300],
                  //       ),
                  //       suffixIcon: IconButton(
                  //         icon: Icon(
                  //           Icons.visibility,
                  //           color: Colors.grey[400],
                  //         ),
                  //         onPressed: () {
                  //           // print("Changing obscure");
                  //           setState(() {
                  //             if (_obscureText == true) {
                  //               _obscureText = false;
                  //             } else {
                  //               _obscureText = true;
                  //             }
                  //           });
                  //         },
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(height: 15),
                  // if (passwordController.text.isNotEmpty)
                  //   FlutterPwValidator(
                  //       defaultColor: theme.primaryColor,
                  //       successColor: Colors.green,
                  //       failureColor: Colors.red,
                  //       controller: passwordController,
                  //       uppercaseCharCount: 1,
                  //       numericCharCount: 2,
                  //       specialCharCount: 1,
                  //       minLength: 6,
                  //       width: size.width * 0.8 > 300 ? 300 : size.width * 0.8,
                  //       height: size.height * 0.15,
                  //       onSuccess: () {
                  //         print(passwordController.text);
                  //         print("Correct Password Found");
                  //         correctPassword = true;
                  //       }),
                  // SizedBox(height: 15),
                ],
              ),
            ),
          )
              // : CircularProgressIndicator(
              //     valueColor:
              //         new AlwaysStoppedAnimation<Color>(theme.buttonColor),
              //   ),
              ),
        ),
      ),
    );
  }
}
