pragma solidity >=0.4.22 <0.9.0;
pragma experimental ABIEncoderV2;


contract EventContract {



    struct User{
        string eid;
        string userCnic;
        string userPhone;
        string userFullName;
        string dateOfBirth;
        string gender;
        string dateOfCnicExpiry;
    }

    struct Candidate{
        string eid;
        string candidateCnic;
        string position;
        string party;
        uint votes;
    }

    //inProgress
    //finished
    //hidden

    struct Event { 
        string eid;
        string eventName;
        string stateOfEvent;
        string startTime;
        string endTime;
        
    }

    struct Position{
        string eid;
        string positionName;
    }

    struct Party{
        string eid;
        string partyName;
        string partyCode;
    }

    mapping (string => Event) public eIdToEvent;
    Event[] public allEvents;
    mapping (string => string[]) public eIdToUsers;
    User[] public allUsers; 
    mapping (string => string[]) public eIdToPosition;
    Position[] public allPositions;
    mapping (string => string[]) public eIdToParties;
    Party[] public allParties;
    Candidate[] public allCandidates;

    User[] private init1Users;
    Position[] private init1Positions;
    Party[] private init1Parties;
    Candidate[] private init1Candidates;
    User[] private init2Users;
    Position[] private init2Positions;
    Party[] private init2Parties;
    Candidate[] private init2Candidates;
    User[] private init3Users;
    Position[] private init3Positions;
    Party[] private init3Parties;
    Candidate[] private init3Candidates;

    constructor() public payable{

        
        User memory myStruct1 = User("a","42101123456790","+923222111222","John Kene","123","M","123");
        User memory myStruct2 = User("b","42101123456791","+923222111223","Michael lewis","124","F","124");
        User memory myStruct3 = User("c","42101123456792","+923222111224","John Cena","125","T","125");
        User memory myStruct4 = User("d","42101123456793","+923222111225","Michael Jackson","125","M","125");
        User memory myStruct5 = User("e","42101123456794","+923222111226","Elizabeth Kin","125","F","125");
        init1Users.push(myStruct1);
        init1Users.push(myStruct2);
        init1Users.push(myStruct3);
        init1Users.push(myStruct4);
        init1Users.push(myStruct5);

        Position memory myPos1 = Position("a","president");
        init1Positions.push(myPos1);

        Party memory myPart1 = Party("a","peoples party","pp");
        Party memory myPart2 = Party("a","democrats","dds");
        init1Parties.push(myPart1);
        init1Parties.push(myPart2);
        
        Candidate memory myCand1 = Candidate("1","42101123456790","president","ppp",0);
        Candidate memory myCand2 = Candidate("1","42101123456791","president","dds",0);
        init1Candidates.push(myCand1);
        init1Candidates.push(myCand2);



        createEvent(
            "USA Presedential",
            "inProgress",
            "2022-01-12T03:42:00.000",
            "2022-01-16T00:09:00.000",
            init1Users,init1Positions,init1Parties,init1Candidates
        );


        // User memory myStruct6 = User("abcd","42101123456780","+923222111222","Mathew Hayden","123","M","123");
        // User memory myStruct7 = User("abcd","42101123456781","+923222111223","Lewis litt","124","F","124");
        // User memory myStruct8 = User("abcd","42101123456782","+923222111224","John Max","125","T","125");
        // User memory myStruct9 = User("abcd","42101123456783","+923222111225","Michael Shawn","125","M","125");
        // User memory myStruct10 = User("abcd","42101123456784","+923222111226","Vinley","125","F","125");
        // allUsers.push(myStruct6);
        // allUsers.push(myStruct7);
        // allUsers.push(myStruct8);
        // allUsers.push(myStruct9);
        // allUsers.push(myStruct10);

        // Position memory myPos2 = Position("abcd","headstudent");
        // allPositions.push(myPos2);

        // Party memory myPart3 = Party("abcd","sharks","ss");
        // Party memory myPart4 = Party("abcd","lions","ll");
        // allParties.push(myPart3);
        // allParties.push(myPart4);
        
        // Candidate memory myCand3 = Candidate("abcd","42101123456780","headstudent","ss",0);
        // Candidate memory myCand4 = Candidate("abcd","42101123456781","headstudent","ll",0);
        // allCandidates.push(myCand3);
        // allCandidates.push(myCand4);
        
        // Event memory newEvent;
        // newEvent.eid = "abcd";
        // newEvent.eventName = "ST lewis School Elections";
        // newEvent.stateOfEvent = "inProgress";
        // newEvent.startTime =  "2022-01-12T03:42:00.000";
        // newEvent.endTime = "2022-01-16T00:09:00.000";
        // allEvents.push(newEvent);
        // eIdToEvent["abcd"] = newEvent;
        

        
    }



    function createEvent(string memory newEventName,string memory newStateOfEvent,string memory newStartTime,string memory newEndTime,User[] memory userList,Position[] memory positionList,Party[] memory partyList,Candidate[] memory candidatesList) public{

        //for Event
        address addr = address(uint160(uint(keccak256(abi.encodePacked(block.timestamp)))));
        string memory id = toAsciiString(addr);
        Event memory newEvent;
        newEvent.eid = id;
        newEvent.eventName = newEventName;
        newEvent.stateOfEvent = newStateOfEvent;
        newEvent.startTime = newStartTime;
        newEvent.endTime = newEndTime;
        allEvents.push(newEvent);
        eIdToEvent[id] = newEvent;
        
       
        //for Users    
        uint usersLength = userList.length;
        
        for(uint i = 0; i< usersLength ; i++){
            User memory newUser;
            newUser.eid = newEvent.eid;
            newUser.userCnic = userList[i].userCnic;    
            newUser.userPhone = userList[i].userPhone;  
            newUser.userFullName = userList[i].userFullName;
            newUser.dateOfBirth = userList[i].dateOfBirth;    
            newUser.gender = userList[i].gender;    
            newUser.dateOfCnicExpiry = userList[i].dateOfCnicExpiry;    
            if(i == 0){
                eIdToUsers[newEvent.eid].push(newUser.userCnic);  
                allUsers.push(newUser);
            }
            else{
                bool isPresent = false;
                string[] memory checkList = eIdToUsers[newEvent.eid];
                for(uint singleUserIndex = 0;singleUserIndex<checkList.length ;singleUserIndex++ ){
                    if(hashCompareWithLengthCheck(checkList[singleUserIndex], newUser.userCnic) ){
                       isPresent = true; 
                    }
                }
                if(!isPresent){
                    allUsers.push(newUser);
                }

            }
            
        }
       
       //position
        uint positionsLength = positionList.length;
        
        for(uint i = 0; i< positionsLength ; i++){
            Position memory newPosition;
            newPosition.eid = newEvent.eid; 
            newPosition.positionName = positionList[i].positionName;
            allPositions.push(newPosition);
        }

       //party
        uint partiesLength = partyList.length;
        
        for(uint i = 0; i< partiesLength ; i++){
            Party memory newParty;
            newParty.eid = newEvent.eid; 
            newParty.partyName = partyList[i].partyName;
            newParty.partyCode = partyList[i].partyCode;
            allParties.push(newParty);
        }

        //candidates
        uint candidatesLength = candidatesList.length;
        
        for(uint i = 0; i< candidatesLength ; i++){
            Candidate memory newCandidate;
            newCandidate.eid = newEvent.eid; 
            newCandidate.candidateCnic = candidatesList[i].candidateCnic;
            newCandidate.position = candidatesList[i].position;
            newCandidate.party = candidatesList[i].party;
            newCandidate.votes = 0;
             bool isPresent = false;
                string[] memory checkList = eIdToUsers[newEvent.eid];
                for(uint singleUserIndex = 0;singleUserIndex<checkList.length ;singleUserIndex++ ){
                    if(hashCompareWithLengthCheck(checkList[singleUserIndex],  newCandidate.candidateCnic) ){
                       isPresent = true; 
                    }
                }
                if(isPresent){
                    allCandidates.push(newCandidate);
                }

            
        }        
    }

    // function createTestEvent(string memory eventName,string memory startTime,string memory endTime)public{
        
    //     //for Event
    //     address addr = address(uint160(uint(keccak256(abi.encodePacked(block.timestamp)))));
    //     string memory id = "newString";

    //     Event memory newEvent;
    //     newEvent.eid = id;
    //     newEvent.eventName = eventName;
    //     newEvent.stateOfEvent = "inProgress";
    //     newEvent.startTime =  startTime;
    //     newEvent.endTime = endTime;
    //     allEvents.push(newEvent);
    //     eIdToEvent[id] = newEvent; 
    //     User memory myStruct6 = User(id,"42101123456780","+923222111222","Mathew Hayden","123","M","123");
    //     User memory myStruct7 = User(id,"42101123456781","+923222111223","Lewis litt","124","F","124");
    //     User memory myStruct8 = User(id,"42101123456782","+923222111224","John Max","125","T","125");
    //     User memory myStruct9 = User(id,"42101123456783","+923222111225","Michael Shawn","125","M","125");
    //     User memory myStruct10 = User(id,"42101123456784","+923222111226","Vinley","125","F","125");
    //     allUsers.push(myStruct6);
    //     allUsers.push(myStruct7);
    //     allUsers.push(myStruct8);
    //     allUsers.push(myStruct9);
    //     allUsers.push(myStruct10);

    //     Position memory myPos2 = Position(id,"headstudent");
    //     allPositions.push(myPos2);

    //     Party memory myPart3 = Party(id,"sharks","ss");
    //     Party memory myPart4 = Party(id,"lions","ll");
    //     allParties.push(myPart3);
    //     allParties.push(myPart4);
        
    //     Candidate memory myCand3 = Candidate(id,"42101123456780","headstudent","ss",0);
    //     Candidate memory myCand4 = Candidate(id,"42101123456781","headstudent","ll",0);
    //     allCandidates.push(myCand3);
    //     allCandidates.push(myCand4);
        
            
    // }

    function getEventData() public returns (Event[] memory){
        return allEvents;
    }


    function toAsciiString(address x) internal pure returns (string memory) {
        bytes memory s = new bytes(40);
        for (uint i = 0; i < 20; i++) {
            bytes1 b = bytes1(uint8(uint(uint160(x)) / (2**(8*(19 - i)))));
            bytes1 hi = bytes1(uint8(b) / 16);
            bytes1 lo = bytes1(uint8(b) - 16 * uint8(hi));
            s[2*i] = char(hi);
            s[2*i+1] = char(lo);            
        }
        return string(s);
    }

    function char(bytes1 b) internal pure returns (bytes1 c) {
        if (uint8(b) < 10) return bytes1(uint8(b) + 0x30);
        else return bytes1(uint8(b) + 0x57);
    }

    function hashCompareWithLengthCheck(string memory a, string memory b) internal returns (bool) {
        if(bytes(a).length != bytes(b).length) {
            return false;
        } else {
            return keccak256(bytes(a)) == keccak256(bytes(b));
        }
    }


}

