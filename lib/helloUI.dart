import 'package:flutter/material.dart';
import 'package:dapp_election_user/contract_linking.dart';
import 'package:provider/provider.dart';

import 'hello_world_contract_linking.dart';

class HelloUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Getting the value and object or contract_linking
    var contractLink = Provider.of<ContractLinking>(context);
    var helloworldcontractLink =
        Provider.of<HelloWorldContractLinking>(context);
    final size = MediaQuery.of(context).size;
    TextEditingController yourNameController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Hello World !"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: contractLink.isLoading
              ? CircularProgressIndicator()
              : SingleChildScrollView(
                  child: Form(
                    child: Column(
                      children: [
                        Container(
                          width: size.width * 0.95,
                          child: Center(
                            child: Text(
                              "Hello ${helloworldcontractLink.deployedName}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.tealAccent),
                            ),
                          ),
                        ),
                        Container(
                          width: size.width * 0.95,
                          child: Center(
                            child: Text(
                              "Email ID: ${contractLink.deployedName}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.tealAccent),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 29),
                          child: TextFormField(
                            controller: yourNameController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Your Name",
                                hintText: "What is your name ?",
                                icon: Icon(Icons.drive_file_rename_outline)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 30),
                          child: ElevatedButton(
                            child: Text(
                              'Set Name',
                              style: TextStyle(fontSize: 30),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                            ),
                            onPressed: () {
                              helloworldcontractLink
                                  .setName(yourNameController.text);
                              yourNameController.clear();
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 30),
                          child: ElevatedButton(
                            child: Text(
                              'Register User',
                              style: TextStyle(fontSize: 30),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                            ),
                            onPressed: () {
                              contractLink.registerUser(
                                  "ahad@gmail.com", "qwerty1234");
                              yourNameController.clear();
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 30),
                          child: ElevatedButton(
                            child: Text(
                              'Login User',
                              style: TextStyle(fontSize: 30),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                            ),
                            onPressed: () {
                              contractLink.loginUser(
                                  "ahad@gmail.com", "qwerty1234");
                              yourNameController.clear();
                            },
                          ),
                        ),
                        // Padding(
                        //   padding: EdgeInsets.only(top: 30),
                        //   child: ElevatedButton(
                        //     child: Text(
                        //       'Start Time',
                        //       style: TextStyle(fontSize: 30),
                        //     ),
                        //     style: ElevatedButton.styleFrom(
                        //       primary: Colors.green,
                        //     ),
                        //     onPressed: () {
                        //       contractLink.getNewString();
                        //       yourNameController.clear();
                        //     },
                        //   ),
                        // )
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
