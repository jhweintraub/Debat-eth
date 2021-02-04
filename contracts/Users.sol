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
    
    
    
    
}
