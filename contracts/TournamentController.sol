pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;


import "./Tournament.sol";


contract TournamentController {
    
    uint public numOpenTournaments;
    Tournament[] tournaments;
    
    /*
    TODO
    */
    constructor() {
        
    }
    
    
    function startNewTournament(uint256 _num_prelims, uint _registration_fee, string memory _tournament_name, address _first_verifier, address _second_verifier) public payable returns (address) {
        
        Tournament newTournament = new Tournament(
            payable(msg.sender), _num_prelims, _registration_fee, _tournament_name, _first_verifier, _second_verifier
        );
        
        tournaments.push(newTournament);
        return address(newTournament);
        
    }
  
   
    
    
    
    
    
    
    
}
