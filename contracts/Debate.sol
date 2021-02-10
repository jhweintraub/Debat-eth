pragma solidity ^0.7.6;
pragma abicoder v2;

import "./Users.sol";

contract Debate {
    
    Users.Team affTeam;
    Users.Team negTeam;
    
    mapping(address => bool) public judges;
    mapping(address => string) public judge_names;
    
    
    uint public numJudges;
    Users.Team winner;
    string roomNumber;
    bool roundOngoing = false;
    address tournamentContract;
    address roundContract;
    
    uint private ballotsOutstanding;
    
    uint affBallots = 0;
    uint negBallots = 0;
   
  struct rfd {
      Users.Team winner;
      string decision;
      string judgeName;
  }
    
    mapping(address => rfd) decisions;
    
    
    //Events
    event ballotSubmitted(string judgeName, string _decision, Users.Team winner);
    event winnerDetermined(Users.Team _winner, uint affBallots, uint negBallots);
    
    
    bool isElimRound = false;
    
    constructor(Users.Team memory _aff_team, Users.Team memory _neg_team, Users.Judge[] memory _judges, 
    string memory _roomNumber, address _tournamentContract) {
        affTeam = _aff_team;
        negTeam = _neg_team;
        
        numJudges = _judges.length;
        
        ballotsOutstanding = _judges.length;
        
        roomNumber = _roomNumber;
        roundContract = msg.sender;
        tournamentContract = _tournamentContract;
        
        for(uint x = 0; x < _judges.length; x++) {
        
            judges[_judges[x].judgeAddr] = true;
            judge_names[_judges[x].judgeAddr] = _judges[x].name;
        }//for
        
        
    }
    
    
    function startRound() public onlyJudges {
        roundOngoing = true;
    }
    
    
    
    function submitBallot(Users.Judge memory judge, string memory _decision, Users.Team memory _winner) 
    onlyJudges public returns(string memory) {
        
          
        decisions[msg.sender] = rfd(_winner, _decision, judge_names[msg.sender]);
        
        //Emit Ballot to the blockchain
        emit ballotSubmitted(judge_names[msg.sender], _decision, _winner);
        
        ballotsOutstanding--;
        
        if (ballotsOutstanding == 0) {
            
            winner = calculateWinner();
            emit winnerDetermined(winner, affBallots, negBallots);
        }
        
        
        return decisions[msg.sender].decision;
        
    }
    
    function calculateWinner() internal returns (Users.Team memory) {
        for(uint x = 0; x < numJudges; x++) {
            
          if (Users.compareTeams(decisions[msg.sender].winner, affTeam)) affBallots++; 
          else negBallots++;
        }
        
       
        // if (isElimRound) emit winnerDetermined()
        
        if (affBallots > numJudges/2) return affTeam;
        else return negTeam;
        
    }
    
    
    
    
    function getRFD(address _judgeAddr) public view returns (string memory) {
        return decisions[_judgeAddr].decision;
    }
    
    modifier onlyJudges {
        require(judges[msg.sender] == true);
        _;
    }
}