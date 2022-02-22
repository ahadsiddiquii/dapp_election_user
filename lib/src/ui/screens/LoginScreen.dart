import 'package:dapp_election_user/contract_linking.dart';
import 'package:dapp_election_user/src/ui/configs/Constants.dart';
import 'package:dapp_election_user/src/ui/configs/Helper.dart';
import 'package:dapp_election_user/src/ui/widgets/FullWidthButton.dart';
import 'package:dapp_election_user/src/ui/widgets/Snackbar.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:provider/provider.dart';
import 'HomeScreen.dart';
import 'NavigationDrawerWidget.dart';

class LoginScreen extends StatefulWidget {
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
  Widget build(BuildContext context) {
    var contractLink = Provider.of<ContractLinking>(context);
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          child: Center(
            child: (!contractLink.isLoading)
                ? Form(
                    key: _formKey,
                    child: Container(
                      width: size.width * 0.8 > 500 ? 500 : size.width * 0.8,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: size.height * 0.3,
                            width: size.width * 0.7,
                            child: Lottie.network(
                                'https://assets5.lottiefiles.com/packages/lf20_jkvgdceo.json'),
                          ),
                          InkWell(
                            onTap: () {
                              contractLink.registerUser(
                                  "4210112345678", "Ahadsiddiqui123.");
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
                              validator: (value) => !((value.length == 13) &&
                                      (isNumeric(value)))
                                  ? "Enter a valid ID (Id must be numeric 13 digit number)"
                                  : null,
                              decoration: InputDecoration(
                                focusedBorder: new OutlineInputBorder(
                                  borderSide: BorderSide(color: themeColorApp),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: themeColorApp),
                                ),
                                labelStyle: TextStyle(color: Colors.grey[300]),
                                labelText: "Your ID",
                                hintText: "What is your ID ?",
                                hintStyle: TextStyle(color: Colors.grey[300]),
                                icon: Icon(
                                  Icons.person,
                                  color: Colors.grey[300],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: TextFormField(
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: _obscureText,
                              controller: passwordController,
                              validator: (value) =>
                                  !((value.length > 5 && value.length < 20))
                                      ? "Enter a valid password"
                                      : null,
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white),
                              decoration: InputDecoration(
                                // enabledBorder: new OutlineInputBorder(
                                //   borderSide: BorderSide(color: buttonColor),
                                // ),
                                focusedBorder: new OutlineInputBorder(
                                  borderSide: BorderSide(color: themeColorApp),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: themeColorApp),
                                ),
                                labelText: "Your Password",
                                labelStyle: TextStyle(color: Colors.grey[300]),
                                hintText: "What is your Password ?",
                                hintStyle: TextStyle(color: Colors.grey[300]),
                                icon: Icon(
                                  Icons.password_rounded,
                                  color: Colors.grey[300],
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    Icons.visibility,
                                    color: Colors.grey[400],
                                  ),
                                  onPressed: () {
                                    // print("Changing obscure");
                                    setState(() {
                                      if (_obscureText == true) {
                                        _obscureText = false;
                                      } else {
                                        _obscureText = true;
                                      }
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
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

                          FullWidthButton(
                              text: "Submit",
                              func: () async {
                                if (_formKey.currentState.validate()) {
                                  _formKey.currentState.save();

                                  await contractLink.loginUser(
                                      idController.text,
                                      passwordController.text);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      showSnackbar(contractLink.deployedName));
                                  print(contractLink.deployedStatus);
                                  if (contractLink.deployedStatus == 200) {
                                    Navigator.of(context).pushReplacementNamed(
                                        HomeScreen.routeName);
                                  }
                                }
                                Navigator.of(context)
                                    .pushReplacementNamed(HomeScreen.routeName);
                              },
                              isFullWidth: false,
                              isOutlined: false),
                        ],
                      ),
                    ),
                  )
                : CircularProgressIndicator(
                    valueColor:
                        new AlwaysStoppedAnimation<Color>(theme.buttonColor),
                  ),
          ),
        ),
      ),
    );
  }
}
