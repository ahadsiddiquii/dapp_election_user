// import 'dart:convert';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/services.dart';
// import 'package:web3dart/web3dart.dart';
// import 'package:http/http.dart';
// import 'package:web_socket_channel/io.dart';

// class EventContractLinking extends ChangeNotifier {
//   final String _rpcUrl = "http://10.0.2.2:7545";
//   final String _wsUrl = "ws://10.0.2.2:7545/";
//   // final String _rpcUrl = "HTTP://127.0.0.1:7545";
//   // final String _wsUrl = "ws://127.0.0.1:7545";
//   // final String _privateKey =
//   //     "52e4c5d8f07c21d880b072f70234e7eb9bc273d645bbf41a53e58524e325004d";
//   // final String _privateKey =
//   //     "1db6afc4c0303973e4cd90db72bd27a05d011bcc317d9e27505097cf9aaf40f9";
//   final String _privateKey =
//       "c6bb9a9eaa73cff36df24db8f2fe9224706359f80f1302fc24bb1f8f8eb09945";
//   Web3Client _client;
//   bool isLoading = true;

//   String _abiCode;
//   EthereumAddress _contractAddress;

//   Credentials _credentials;

//   DeployedContract _contract;

//   ContractFunction _createEvent;
//   ContractFunction _getEventData;

//   String deployedName;
//   int deployedStatus;

//   EventContractLinking() {
//     initialSetup();
//   }

//   initialSetup() async {
//     // establish a connection to the ethereum rpc node. The socketConnector
//     // property allows more efficient event streams over websocket instead of
//     // http-polls. However, the socketConnector property is experimental.
//     _client = Web3Client(_rpcUrl, Client(), socketConnector: () {
//       return IOWebSocketChannel.connect(_wsUrl).cast<String>();
//     });

//     await getAbi();
//     await getCredentials();
//     await getDeployedContract();
//   }

//   Future<void> getAbi() async {
//     // Reading the contract abi
//     // String abiStringFile =
//     //     await rootBundle.loadString("src/artifacts/HelloWorld.json");
//     String abiStringFile =
//         await rootBundle.loadString("src/artifacts/EventContract.json");
//     var jsonAbi = jsonDecode(abiStringFile);
//     _abiCode = jsonEncode(jsonAbi["abi"]);

//     //
//     _contractAddress =
//         EthereumAddress.fromHex(jsonAbi["networks"]["5777"]["address"]);
//   }

//   Future<void> getCredentials() async {
//     _credentials = await _client.credentialsFromPrivateKey(_privateKey);
//   }

//   Future<void> getDeployedContract() async {
//     // Telling Web3dart where our contract is declared.
//     // _contract = DeployedContract(
//     //     ContractAbi.fromJson(_abiCode, "HelloWorld"), _contractAddress);
//     _contract = DeployedContract(
//         ContractAbi.fromJson(_abiCode, "EventContract"), _contractAddress);

//     // Extracting the functions, declared in contract.
//     // _yourName = _contract.function("yourName");
//     // _setName = _contract.function("setName");
//     _createEvent = _contract.function("createEvent");
//     _createEvent = _contract.function("getEventData");

//     deployedName = "initial";

//     isLoading = false;

//     notifyListeners();
//   }

//   createEvent(
//       String newEventName,
//       String newStateOfEvent,
//       String newStartTime,
//       String newEndTime,
//       List<List<String>> userList,
//       List<List<String>> positionList,
//       List<List<String>> partyList,
//       List<List<String>> candidatesList) async {
//     print(newEventName);
//     print(newStateOfEvent);
//     print(newStartTime);
//     print(newEndTime);
//     print(userList);
//     print(positionList);
//     print(partyList);
//     print(candidatesList);

//     // Getting the current name declared in the smart contract.
//     try {
//       isLoading = true;
//       notifyListeners();
//       // print("${enteredEmail}, ${enteredPassword}");
//       // var currentName =

//       await _client.sendTransaction(
//           _credentials,
//           Transaction.callContract(
//               contract: _contract,
//               function: _createEvent,
//               parameters: [
//                 newEventName,
//                 // newStateOfEvent,
//                 newStartTime,
//                 newEndTime

//                 // userList,
//                 // positionList,
//                 // partyList,
//                 // candidatesList
//               ],
//               maxGas: 6721974));
//       // contract: _contract,
//       // function: _registerUser,
//       // params: [enteredEmail, enteredPassword]
//       // );
//       // deployedName = currentName[0];
//       isLoading = false;
//       notifyListeners();
//     } catch (e) {
//       print(e.toString());
//       isLoading = false;
//       notifyListeners();
//     }
//   }

//   getEventData() async {
//     // Setting the name to nameToSet(name defined by user)
//     try {
//       isLoading = true;
//       notifyListeners();
//       // print("${enteredEmail}, ${enteredPassword}");

//       // var credentialsOfUser = await _client.sendTransaction(
//       //     _credentials,
//       //     Transaction.callContract(
//       //         contract: _contract,
//       //         function: _loginUser,
//       //         parameters: [enteredEmail, enteredPassword]));

//       var credentialsOfUser = await _client
//           .call(contract: _contract, function: _getEventData, params: []);

//       print(credentialsOfUser[0]);
//       final eventsList = credentialsOfUser[0].toList();
//       print(eventsList);
//       // final responseBody = jsonDecode(credentialsOfUser[0].toString());

//       // deployedName = responseBody['StatusMessage'];

//       // adminCredentials = AdminCredentials.fromJson(responseBody['Data']);
//       // // deployedName = "abcd";
//       // print("${adminCredentials.userId} ${adminCredentials.userCnic} ");
//       // deployedStatus = responseBody['StatusCode'];
//       isLoading = false;
//       notifyListeners();
//     } catch (e) {
//       print(e.toString());
//       deployedName = "Incorrect Id or password";
//       deployedStatus = 400;
//       isLoading = false;
//       notifyListeners();
//     }
//   }
// }
