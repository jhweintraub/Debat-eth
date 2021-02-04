pragma solidity ^0.8.0;

import "./Round.sol";
import "./Users.sol";

contract Debate {
    
    Users.Team affTeam;
    Users.Team negTeam;
    Users.Judge judge;
    address winner;
    string rfd; //consider making bytes for longer response
    string roomNumber;
    bool roundOngoing = false;
    address tournamentContract;
    address roundContract;
    
    constructor(Users.Team memory _aff_team, Users.Team memory _neg_team, Users.Judge memory _judge, string memory _roomNumber, address _tournamentContract) {
        affTeam = _aff_team;
        negTeam = _neg_team;
        judge = _judge;
        roomNumber = _roomNumber;
        roundContract = msg.sender;
        tournamentContract = _tournamentContract;
    }
    
    
    function startRound() public onlyJudge {
        roundOngoing = true;
    }
    
    function submitBallot(bytes memory decision, address _winner) onlyJudge public returns(string memory) {
        
        winner = _winner;
        
        rfd = string(decision);
        roundOngoing = false;
        return rfd;
    }
    
    
    function getRFD() public view returns (string memory) {
        return rfd;
    }
    
    modifier onlyJudge {
        require(judge.judgeAddr == msg.sender);
        _;
    }
    
    
    
    
}