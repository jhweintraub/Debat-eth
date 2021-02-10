pragma solidity ^0.8.0;

import "./Debate.sol";
import "./Users.sol";

contract Round {
    
    Debate[] public debates; 
    int public roundNum;
    Users.Team[] public teams;
    Users.Judge[] public judges;
    
    
    //TODO: Add Modifier for TabDirector
    
    constructor(int _roundNum, Users.Team[] memory _teams, Users.Judge[] memory _judges) {
        roundNum = _roundNum;
        
    //     //doSomething();
        
    //     //createRound();
    }
    
    
    function createRound(Users.Team memory affTeam, Users.Team memory negTeam, Users.Judge[] memory _judges, string memory roomNum) public returns(Debate[] memory) {
        //doSomething();
        
        Debate debate = new Debate(affTeam, negTeam, _judges, roomNum, msg.sender);
        debates.push(debate);
        // 
        
    }
    
  
}