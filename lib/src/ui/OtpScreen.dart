import 'package:dapp_election_user/models/Election/ElectionEvent.dart';
import 'package:dapp_election_user/src/ui/screens/VotingScreen.dart';
import 'package:dapp_election_user/src/ui/widgets/FullWidthButton.dart';
import 'package:dapp_election_user/src/ui/widgets/Snackbar.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'dart:math';

import 'configs/ScreenSizeConfig.dart';

class OTPScreen extends StatefulWidget {
  final ElectionEvent eEvent;
  final String userCnic;
  const OTPScreen({this.eEvent, this.userCnic, Key key}) : super(key: key);
  static const routeName = '/OTPScreen';
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController otpController = TextEditingController();
  bool hasError = false;
  String currentText = "";

  String otp;

  bool firstTimeOtpSent = false;

  Widget otpField(double height) {
    return Container(
        // width: ScreenSizeConfig.safeBlockHorizontal * 85,
        height: height,
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
        ),
        child: PinCodeTextField(
          // backgroundColor: Colors.grey,
          textStyle: TextStyle(color: Colors.black),
          appContext: context,
          pastedTextStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          length: 4,
          obscureText: false,
          animationType: AnimationType.fade,

          pinTheme: PinTheme(
            shape: PinCodeFieldShape.underline,
            activeColor: Colors.grey[300],
            inactiveColor: Colors.grey[300],
            borderRadius: BorderRadius.circular(5),
            fieldHeight: 50,
            // fieldWidth: 50,
            selectedColor: Colors.grey[300],
            selectedFillColor: Colors.grey[300],
            activeFillColor: Colors.grey[300],
            inactiveFillColor: Colors.grey[300],
          ),
          // backgroundColor: Colors.white,
          cursorColor: Colors.black,
          animationDuration: Duration(milliseconds: 300),
          enableActiveFill: false,
          controller: otpController,
          keyboardType: TextInputType.number,

          onCompleted: (v) {
            print("Completed");
            setState(() {
              currentText = v;
            });
          },
          onChanged: (value) {
            print(value);
            // setState(() {
            //   currentText = value;
            // });
          },
          beforeTextPaste: (text) {
            print("Allowing to paste $text");
            return true;
          },
        ));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenSizeConfig().init(context);
    var screenSizeWidth = ScreenSizeConfig.safeBlockHorizontal * 100;
    var screenSizeHeight = ScreenSizeConfig.safeBlockVertical * 100;
    final size = MediaQuery.of(context).size;

    final theme = Theme.of(context);

    generateOtp() {
      Random random = new Random();

      String currentOtp = "";
      for (int i = 0; i < 4; i++) {
        int randomNumber1 = random.nextInt(9);
        currentOtp = currentOtp + randomNumber1.toString();
      }
      print(currentOtp);
      setState(() {
        firstTimeOtpSent = true;
        otp = currentOtp;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(showSnackbar("Your otp is $otp"));
    }

    return Scaffold(
      backgroundColor: theme.primaryColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FullWidthButton(
          text: "Continue",
          func: () async {
            if (otpController.text == otp) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => VotingScreen(
                      eEvent: widget.eEvent, userCnic: widget.userCnic)));
              // ScaffoldMessenger.of(context)
              //     .showSnackBar(showSnackbar("Your OTP is ${otp}"));
            } else {
              ScaffoldMessenger.of(context)
                  .showSnackBar(showSnackbar("Incorrect OTP"));
            }
            // bool isFound = false;
            // if (_formKey.currentState.validate()) {
            //   _formKey.currentState.save();
            //   widget.eEvent.electionUsers.forEach((element) {
            //     if (element.userCnic == idController.text) {
            //       isFound = true;
            //       Navigator.of(context).push(MaterialPageRoute(
            //           builder: (context) => OTPScreen(eEvent: widget.eEvent)));
            //       // Navigator.of(context)
            //       //     .pushReplacementNamed(OTPScreen.routeName);
            //     }
            //   });
            // if (isFound == false) {
            // ScaffoldMessenger.of(context)
            //     .showSnackBar(showSnackbar("User not authorized"));
            // }
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
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        // shadowColor: Colors.grey.shade100,
        elevation: 0,
        bottomOpacity: 0.0,
        // title: Text(
        //   'Verify Account',
        //   style: theme.textTheme.headline6?.merge(
        //     TextStyle(
        //       color: Colors.white,
        //       // fontSize: 18.0,
        //       fontWeight: FontWeight.w600,
        //     ),
        //   ),
        // ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: screenSizeHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: size.width * 0.9,
                child: Text(
                  'OTP Verification',
                  style: theme.textTheme.headline2?.merge(
                    TextStyle(
                      color: Colors.black,
                      // fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              // Container(height: screenSizeHeight * 0.1),
              // Container(
              //   width: screenSizeWidth * 0.4,
              //   height: screenSizeHeight * 0.1,
              //   decoration: const BoxDecoration(
              //     image: DecorationImage(
              //         image: AssetImage('assets/images/Weell_logo1.png'),
              //         fit: BoxFit.contain),
              //   ),
              // ),
              // Container(height: screenSizeHeight * 0.1),
              // Container(
              //   child: Text(
              //     'Verify Account',
              //     style: theme.textTheme.headline6?.merge(
              //       TextStyle(
              //         color: Colors.black,
              //         // fontSize: 18.0,
              //         fontWeight: FontWeight.w600,
              //       ),
              //     ),
              //   ),
              //   // height: ScreenSizeConfig.safeBlockVertical * 2.8,
              // ),
              SizedBox(height: 10),
              Container(
                width: screenSizeWidth * 0.9,
                child: Text(
                  'Please enter the 4 digit OTP sent to your phone number to verify your account.',
                  style: theme.textTheme.subtitle1?.merge(
                    TextStyle(
                      color: Colors.black,
                      // fontSize: 18.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                // height: ScreenSizeConfig.safeBlockVertical * 2.8,
              ),
              SizedBox(height: 20),
              Stack(children: [
                Container(
                  width: screenSizeWidth,
                  padding: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 60,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                      ),
                      Container(
                        width: 60,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                      ),
                      Container(
                        width: 60,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                      ),
                      Container(
                        width: 60,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: screenSizeWidth * 0.1,
                    ),
                    Container(
                        height: screenSizeHeight * 0.10,
                        width: screenSizeWidth * 0.80,
                        child: otpField(70)),
                    SizedBox(
                      width: screenSizeWidth * 0.1,
                    ),
                  ],
                )
              ]),
              SizedBox(
                height: 5,
              ),
              InkWell(
                onTap: generateOtp,
                child: Container(
                  width: screenSizeWidth * 0.85,
                  alignment: AlignmentDirectional.centerEnd,
                  child: Text(
                    firstTimeOtpSent ? 'Resend OTP' : 'Send OTP',
                    style: theme.textTheme.subtitle1?.merge(
                      TextStyle(
                        color: Colors.black,
                        // fontSize: 15.0,
                      ),
                    ),
                  ),
                ),
              ),
              // SizedBox(
              //   height: screenSizeHeight * 0.1,
              // ),

              // SizedBox(
              //   height: screenSizeHeight * 0.40,
              // ),

              //             InkWell(
              //               onTap: () {
              // //                Navigator.pushNamed(context, UploadDocuments.routeName);
              //               },
              //               child: Container(
              //                 height: 50,
              //                 width: screenSizeWidth * 0.55,
              //                 decoration: BoxDecoration(
              //                   color: Colors.grey,
              //                   borderRadius: BorderRadius.all(
              //                     Radius.circular(15.0),
              //                   ),
              //                 ),
              //                 child: Center(
              //                   child: Text(
              //                     'Start Ride',
              //                     style: theme.textTheme.headline5?.merge(TextStyle(
              //                       color: Colors.white,
              //                     )),
              //                   ),
              //                 ),
              //               ),
              //             ),
              // SizedBox(
              //   height: screenSizeHeight * 0.05,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
