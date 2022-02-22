pragma solidity >=0.4.22 <0.9.0;


contract HelloWorld {
    string public yourName ;

    constructor() public{
        yourName = "Unknown" ;
    }

    function setName(string memory nm) public{
        yourName = nm ;
    }
}