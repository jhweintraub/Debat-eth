pragma solidity ^0.8.0;

import "./Debate.sol";
import "./Tournament.sol";
import "./Users.sol";

contract Round {
    
    Debate[] public debates; 
    int public roundNum;
    Users.Team[] public teams;
    Users.Judge[] public judges;
    
    constructor(int _roundNum, Users.Team[] memory _teams, Users.Judge[] memory _judges) {
        roundNum = _roundNum;
        teams = _teams;
        judges = judges;
        
        //doSomething();
        
        //createRound();
    }
    
    
    function createRound(Users.Team memory affTeam, Users.Team memory negTeam, Users.Judge memory judge, string memory roomNum) public returns(Debate[] memory) {
        //doSomething();
        
        Debate debate = new Debate(affTeam, negTeam, judge, roomNum, msg.sender);
        // 
        
    }
    
 
    
    
    
}