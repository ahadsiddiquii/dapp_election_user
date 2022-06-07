import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dapp_election_user/models/Election/ElectionCandidate.dart';
import 'package:dapp_election_user/models/Election/ElectionEvent.dart';
import 'package:dapp_election_user/models/Election/ElectionParty.dart';
import 'package:dapp_election_user/models/Election/ElectionPosition.dart';

import '../../models/User.dart';
import '../models/Election/ElectionUser.dart';

class EventService {
  final String collectionName = "ElectionEvents";

  Future<bool> createElection(
      String userId,
      String eventId,
      String eventName,
      String stateOfEvent,
      String startDate,
      String endDate,
      List<ElectionUser> electionUsersList,
      List<ElectionPosition> electionPositionsList,
      List<ElectionParty> electionPartyList,
      List<ElectionCandidate> electionCandidatesList) async {
    print("EventService: createUser Function");
    bool eventExists = false;
    await FirebaseFirestore.instance
        .collection(collectionName)
        .where("eid", isEqualTo: eventId)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print("Event with this id already exists cannot create");
        eventExists = true;
      });
    });

    // String userId = DateTime.now().toIso8601String() + "_" + userEmail;
    try {
      if (eventExists) {
        print("Event with this id already exists cannot create");
        throw "Event already exists";
      }

      List<Map<String, dynamic>> electionUsersListJson = [];
      electionUsersList.forEach((element) {
        electionUsersListJson.add(element.toJson(element));
      });
      List<Map<String, dynamic>> electionPositionsListJson = [];
      electionPositionsList.forEach((element) {
        electionPositionsListJson.add(element.toJson(element));
      });
      List<Map<String, dynamic>> electionPartiesListJson = [];
      electionPartyList.forEach((element) {
        electionPartiesListJson.add(element.toJson(element));
      });

      List<Map<String, dynamic>> electionCandidatesListJson = [];
      electionCandidatesList.forEach((element) {
        electionCandidatesListJson.add(element.toJson(element));
      });

      Map<String, dynamic> userMap = {
        "userId": userId,
        "eid": eventId,
        "eventName": eventName,
        "stateOfEvent": stateOfEvent,
        "startTime": startDate,
        "endTime": endDate,
        "electionUsers": electionUsersListJson,
        "electionParties": electionPartiesListJson,
        "electionPositions": electionPositionsListJson,
        "electionBallots": [],
        "electionCandidates": electionCandidatesListJson,
      };
      await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(eventId)
          .set(userMap)
          .catchError((e) {
        print(e.toString());
      });
      return true;
    } catch (e) {
      print(e.toString());
      throw e.toString();
    }
  }

  Future<List<ElectionEvent>> getAllEvents() async {
    print("EventService: getAllEvents Function");
    try {
      var map = await FirebaseFirestore.instance
          .collection(collectionName)
          .doc()
          .snapshots();
      CollectionReference _collectionRef =
          FirebaseFirestore.instance.collection(collectionName);

      QuerySnapshot querySnapshot = await _collectionRef.get();
      // Get data from docs and convert map to List
      final allData = querySnapshot.docs.map((doc) {
        return doc.data();
      }).toList();

      print(allData);

      List<ElectionEvent> allGetEvents = [];

      allData.forEach((item) {
        final event = item as Map<String, dynamic>;

        allGetEvents.add(ElectionEvent.fromJson(event));
      });

      print("allGetEvents: ${allGetEvents.length}");

      return allGetEvents;
    } catch (e) {
      throw e.toString();
    }
  }
}
