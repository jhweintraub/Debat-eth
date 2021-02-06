pragma solidity ^0.8.0;

library Users {
    
    
    struct Debater {
        string name;
        address payable addr;
        uint totalSpeaks;
        uint[] speaks;
    }
    
    struct Team {
        Debater debater1;
        Debater debater2;
        
        string teamCode;
        uint totalSpeaks;
        uint wins;
        
    }
    
    struct Judge {
        address payable judgeAddr;
        string name;
        Team[] conflicts;
        uint roundsRemaining;
    }
    
    function compareTeams(Team memory _team1, Team memory _team2) public pure returns (bool) {
        
        //You Only need to compare one field because no two-teams with the same name would be registered Simultaneously
        if (keccak256(abi.encodePacked(_team1.teamCode)) == keccak256(abi.encodePacked(_team2.teamCode))) return true;
        else return false;
        
    }
    
    
    
    
}