import 'package:dapp_election_user/models/Election/ElectionBallots.dart';
import 'package:dapp_election_user/models/Election/ElectionCandidate.dart';
import 'package:dapp_election_user/models/Election/ElectionEvent.dart';
import 'package:dapp_election_user/models/Election/ElectionParty.dart';
import 'package:dapp_election_user/models/Election/ElectionPosition.dart';
import 'package:dapp_election_user/models/Election/ElectionUser.dart';

List<ElectionEvent> allEvents = [
  ElectionEvent(
    eid: "a",
    eventName: "USA Presedential",
    stateOfEvent: "inProgress",
    startTime: DateTime.now(),
    endTime: DateTime.now().add(Duration(days: 10)),
    electionUsers: [
      ElectionUser(
        eid: "a",
        userCnic: "42101123456790",
        userPhone: "+923222111222",
        userFullName: "John Kene",
        dateOfBirth: DateTime.now(),
        gender: "M",
        dateOfCnicExpiry: DateTime.now().add(Duration(days: 1000)),
      ),
      ElectionUser(
        eid: "a",
        userCnic: "42101123456791",
        userPhone: "+923222111223",
        userFullName: "Michael lewis",
        dateOfBirth: DateTime.now(),
        gender: "F",
        dateOfCnicExpiry: DateTime.now().add(Duration(days: 1000)),
      ),
      ElectionUser(
        eid: "a",
        userCnic: "42101123456792",
        userPhone: "+923222111224",
        userFullName: "John Cena",
        dateOfBirth: DateTime.now(),
        gender: "T",
        dateOfCnicExpiry: DateTime.now().add(Duration(days: 1000)),
      ),
      ElectionUser(
        eid: "a",
        userCnic: "42101123456793",
        userPhone: "+923222111225",
        userFullName: "Michael Jackson",
        dateOfBirth: DateTime.now(),
        gender: "M",
        dateOfCnicExpiry: DateTime.now().add(Duration(days: 1000)),
      ),
      ElectionUser(
        eid: "a",
        userCnic: "42101123456794",
        userPhone: "+923222111226",
        userFullName: "Elizabeth Kin",
        dateOfBirth: DateTime.now(),
        gender: "M",
        dateOfCnicExpiry: DateTime.now().add(Duration(days: 1000)),
      ),
    ],
    electionPositions: [
      ElectionPosition(positionId: "a1", eid: "a", positionName: "president"),
    ],
    electionParties: [
      ElectionParty(
          partyCode: "ppp", eid: "a", partyName: "Public Peoples Party"),
      ElectionParty(partyCode: "dds", eid: "a", partyName: "Democrats")
    ],
    electionBallots: [],
    electionCandidates: [
      ElectionCandidate(
          eid: "a",
          candidateCnic: "42101123456790",
          position: ElectionPosition(
              positionId: "a1", eid: "a", positionName: "president"),
          party: ElectionParty(
              partyCode: "ppp", eid: "a", partyName: "Public Peoples Party"),
          votes: 0),
      ElectionCandidate(
          eid: "a",
          candidateCnic: "42101123456791",
          position: ElectionPosition(
              positionId: "a1", eid: "a", positionName: "president"),
          party:
              ElectionParty(partyCode: "dds", eid: "a", partyName: "Democrats"),
          votes: 0)
    ],
  ),
  ElectionEvent(
    eid: "ab",
    eventName: "Celebrity Group Leader",
    stateOfEvent: "Completed",
    startTime: DateTime.now(),
    endTime: DateTime.now(),
    electionUsers: [
      ElectionUser(
        eid: "ab",
        userCnic: "42101123456700",
        userPhone: "+923222121222",
        userFullName: "Michael B. Jordan",
        dateOfBirth: DateTime.now(),
        gender: "M",
        dateOfCnicExpiry: DateTime.now().add(Duration(days: 1000)),
      ),
      ElectionUser(
        eid: "ab",
        userCnic: "42101123456701",
        userPhone: "+923222121223",
        userFullName: "Kim Kardashian",
        dateOfBirth: DateTime.now(),
        gender: "F",
        dateOfCnicExpiry: DateTime.now().add(Duration(days: 1000)),
      ),
      ElectionUser(
        eid: "ab",
        userCnic: "42101123456702",
        userPhone: "+923222121224",
        userFullName: "J. Cole",
        dateOfBirth: DateTime.now(),
        gender: "T",
        dateOfCnicExpiry: DateTime.now().add(Duration(days: 1000)),
      ),
      ElectionUser(
        eid: "ab",
        userCnic: "42101123456703",
        userPhone: "+923222121225",
        userFullName: "Will Smith",
        dateOfBirth: DateTime.now(),
        gender: "M",
        dateOfCnicExpiry: DateTime.now().add(Duration(days: 1000)),
      ),
      ElectionUser(
        eid: "ab",
        userCnic: "42101123456704",
        userPhone: "+923222121226",
        userFullName: "Elisabeth Olsen",
        dateOfBirth: DateTime.now(),
        gender: "F",
        dateOfCnicExpiry: DateTime.now().add(Duration(days: 1000)),
      ),
    ],
    electionPositions: [
      ElectionPosition(
          positionId: "ab1", eid: "ab", positionName: "generalsecratery"),
    ],
    electionParties: [
      ElectionParty(partyCode: "g1", eid: "ab", partyName: "Group 1"),
      ElectionParty(partyCode: "g2", eid: "ab", partyName: "Group 2"),
    ],
    electionBallots: [
      ElectionBallot(
          eid: "ab",
          candidateCnic: "42101123456704",
          voterCnic: "42101123456700"),
      ElectionBallot(
          eid: "ab",
          candidateCnic: "42101123456704",
          voterCnic: "42101123456701"),
      ElectionBallot(
          eid: "ab",
          candidateCnic: "42101123456703",
          voterCnic: "42101123456702"),
    ],
    electionCandidates: [
      ElectionCandidate(
          eid: "ab",
          candidateCnic: "42101123456704",
          position: ElectionPosition(
              positionId: "ab1", eid: "ab", positionName: "generalsecratery"),
          party:
              ElectionParty(partyCode: "g2", eid: "ab", partyName: "Group 2"),
          votes: 2),
      ElectionCandidate(
          eid: "ab",
          candidateCnic: "42101123456703",
          position: ElectionPosition(
              positionId: "ab1", eid: "ab", positionName: "generalsecratery"),
          party:
              ElectionParty(partyCode: "g1", eid: "ab", partyName: "Group 1"),
          votes: 1),
    ],
  )
];
