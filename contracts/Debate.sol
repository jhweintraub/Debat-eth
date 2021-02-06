pragma solidity ^0.8.0;

import "./Round.sol";
import "./Users.sol";

contract Debate {
    
    Users.Team affTeam;
    Users.Team negTeam;
    
    address[] public judge_addrs;
    mapping(address => Users.Judge) public judges;
    
    Users.Team winner;
    string roomNumber;
    bool roundOngoing = false;
    address tournamentContract;
    address roundContract;
    
    uint private ballotsOutstanding;
   
   struct rfd {
       Users.Team winner;
       string decision;
   }
    
    mapping(address => rfd) decisions;
    
    
    
    bool isElimRound = false;
    
    constructor(Users.Team memory _aff_team, Users.Team memory _neg_team, Users.Judge[] memory _judges, string memory _roomNumber, address _tournamentContract) {
        affTeam = _aff_team;
        negTeam = _neg_team;
        
        ballotsOutstanding = _judges.length;
        
        roomNumber = _roomNumber;
        roundContract = msg.sender;
        tournamentContract = _tournamentContract;
        
        for(uint x = 0; x < _judges.length; x++) {
            judges[_judges[x].judgeAddr] = _judges[x];
        }//for
        
        
    }
    
    
    function startRound() public onlyJudges {
        roundOngoing = true;
    }
    
    
    
    function submitBallot(Users.Judge memory judge, string memory _decision, Users.Team memory _winner) 
    onlyJudges public returns(string memory) {
        
        
        //TODO - Create System for determining the winner in elim rounds cause rn the first judge 2 submit decides the winner
       
        
        
        
        decisions[msg.sender] = rfd(_winner, _decision);
        
        ballotsOutstanding--;
        
        if (ballotsOutstanding == 0) winner = calculateWinner();
        
        return decisions[msg.sender].decision;
        
    }
    
    function calculateWinner() internal returns (Users.Team memory) {
        uint affBallots = 0;
        uint negBallots = 0;
        for(uint x = 0; x < judge_addrs.length; x++) {
           if (Users.compareTeams(decisions[judge_addrs[x]].winner, affTeam)) affBallots++; 
           else negBallots++;
        }
        
        
        if (affBallots > judge_addrs.length/2) return affTeam;
        else return negTeam;
        
    }
    
    
    
    function getRFD(address _judgeAddr) public view returns (string memory) {
        return decisions[_judgeAddr].decision;
    }
    
    modifier onlyJudges {
        require(judges[msg.sender].judgeAddr != address(0x0));
        _;
    }
}