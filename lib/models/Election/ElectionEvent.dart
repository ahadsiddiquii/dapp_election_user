import 'ElectionBallots.dart';
import 'ElectionCandidate.dart';
import 'ElectionParty.dart';
import 'ElectionPosition.dart';
import 'ElectionUser.dart';

class ElectionEvent {
  String eid;
  String eventName;
  String stateOfEvent;
  DateTime startTime;
  DateTime endTime;
  List<ElectionUser> electionUsers;
  List<ElectionParty> electionParties;
  List<ElectionPosition> electionPositions;
  List<ElectionBallot> electionBallots;
  List<ElectionCandidate> electionCandidates;

  ElectionEvent({
    this.eid,
    this.eventName,
    this.stateOfEvent,
    this.startTime,
    this.endTime,
    this.electionUsers,
    this.electionCandidates,
    this.electionParties,
    this.electionPositions,
    this.electionBallots,
  });

  ElectionEvent.fromJson(Map<String, dynamic> json) {
    this.eid = json['eid'];
    this.eventName = json['eventName'];
    this.stateOfEvent = json['stateOfEvent'];
    this.startTime = json['startTime'] != null
        ? DateTime.parse(json['startTime'])
        : DateTime.now();
    this.endTime = json['endTime'] != null
        ? DateTime.parse(json['endTime'])
        : DateTime.now();

    final allElectionUsersLists = json['electionUsers'];
    List<ElectionUser> allElectionUsers = [];
    if (allElectionUsersLists != null) {
      allElectionUsersLists.forEach((e) {
        final currentUser = e as Map<String, dynamic>;
        allElectionUsers.add(ElectionUser.fromJson(currentUser));
      });
    }
    this.electionUsers = allElectionUsers;

    final allElectionCandidatesLists = json['electionCandidates'];
    List<ElectionCandidate> allElectionCandidates = [];
    if (allElectionCandidatesLists != null) {
      allElectionCandidatesLists.forEach((e) {
        final currentUser = e as Map<String, dynamic>;
        allElectionCandidates.add(ElectionCandidate.fromJson(currentUser));
      });
    }
    this.electionCandidates = allElectionCandidates;

    final allElectionPartiesLists = json['electionParties'];
    List<ElectionParty> allElectionParties = [];
    if (allElectionPartiesLists != null) {
      allElectionPartiesLists.forEach((e) {
        final currentUser = e as Map<String, dynamic>;
        allElectionParties.add(ElectionParty.fromJson(currentUser));
      });
    }
    this.electionParties = allElectionParties;

    final allElectionPositionsLists = json['electionPositions'];
    List<ElectionPosition> allElectionPositions = [];
    if (allElectionPositionsLists != null) {
      allElectionPositionsLists.forEach((e) {
        final currentUser = e as Map<String, dynamic>;
        allElectionPositions.add(ElectionPosition.fromJson(currentUser));
      });
    }
    this.electionPositions = allElectionPositions;

    final allElectionBallotsLists = json['electionBallots'];
    List<ElectionBallot> allElectionBallots = [];
    if (allElectionBallotsLists != null) {
      allElectionBallotsLists.forEach((e) {
        final currentUser = e as Map<String, dynamic>;
        allElectionBallots.add(ElectionBallot.fromJson(currentUser));
      });
    }
    this.electionBallots = allElectionBallots;
  }

  // Map<String, dynamic> toJson(ElectionEvent electionEvent) {
  //   Map<String, dynamic> electionsMap = {
  //     this.eid,
  //     this.eventName,
  //     this.stateOfEvent,
  //     this.startTime,
  //     this.endTime,
  //     this.electionUsers,
  //     this.electionCandidates,
  //     this.electionParties,
  //     this.electionPositions,
  //     this.electionBallots,
  //     "eid": electionCandidate.eid,
  //     "candidateCnic": electionCandidate.candidateCnic,
  //     "votes": electionCandidate.votes,
  //     "party": electionCandidate.party.toJson(electionCandidate.party),
  //     "position": electionCandidate.position.toJson(electionCandidate.position),
  //   };
  //   return electionsMap;
  // }
}
