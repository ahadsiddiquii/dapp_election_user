pragma solidity >=0.4.22 <0.9.0;

contract LoginSystem {

    struct User { 
        string userId;
        string userCnic;
        string password;
        
    }

    struct ToReturnUser{
        string userCnic;
        string userId;
    }

    mapping(string => uint256) private jsonLoginResponse;

    function mapUserToReturnUser(User memory newUser) private returns (ToReturnUser memory )
    {
        ToReturnUser memory newReturnUser;
        newReturnUser.userCnic = newUser.userCnic;
        newReturnUser.userId = newUser.userId;
        return newReturnUser;

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

    function mapToUserAssignId(string memory enteredCnic, string memory enteredPassword) private returns (User memory )
    {
        User memory newUserToBeRegistered;
        address addr = address(uint160(uint(keccak256(abi.encodePacked(block.timestamp)))));
        string memory id = toAsciiString(addr);
        newUserToBeRegistered.userId = id;
        newUserToBeRegistered.userCnic = enteredCnic;
        newUserToBeRegistered.password = enteredPassword;
        return newUserToBeRegistered;
    }

    

    

    mapping (string => User) private emailToUsers;

    mapping(string => bool) private emailToExists;

    function hashCompareWithLengthCheck(string memory a, string memory b) internal returns (bool) {
        if(bytes(a).length != bytes(b).length) {
            return false;
        } else {
            return keccak256(bytes(a)) == keccak256(bytes(b));
        }
    }

    uint private startTime; 

    constructor() public payable{
        startTime = block.timestamp;
    }

  function registerUser(string memory enteredCnic, string memory enteredPassword) public {
    // users.push(newUser);
    User memory newUser;
    newUser = mapToUserAssignId(enteredCnic,enteredPassword);
    emailToUsers[newUser.userCnic] = newUser;
    emailToExists[newUser.userCnic] = true;
  }

  

  function loginUser(string memory enteredCnic, string memory enteredPassword) public returns (string memory){

    

      if((emailToExists[enteredCnic] == true) && hashCompareWithLengthCheck(emailToUsers[enteredCnic].password,enteredPassword)){
          ToReturnUser memory returningUser = mapUserToReturnUser(emailToUsers[enteredCnic]);
        string memory jsonResponse = string(abi.encodePacked( "{\"StatusCode\":200,\"StatusMessage\":\"User Logged In\",\"Data\":{\"userId\":",'"' ,returningUser.userId,'"',",\"userCnic\":", '"',returningUser.userCnic,'"', "}}"));
            // string memory jsonResponse = string(abi.encodePacked( "{\"StatusCode\":200,\"StatusMessage\":\"User Logged In\",\"Data\":{\"userId\":\"", returningUser.userId, "\",\"userCnic\":\"", returningUser.userCnic, "\"}}"));
          
            return jsonResponse;
        //   return res.json({
        //     StatusCode:200,
        //     StatusMessage:"User Logged In",
        //     Data:returningUser
        //   });
      }
      else{
        require(emailToExists[enteredCnic] == true && hashCompareWithLengthCheck(emailToUsers[enteredCnic].password,enteredPassword), "Login User does not exist, Please register");
      }
  } 
 

    

}