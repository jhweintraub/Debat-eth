pragma solidity ^0.7.6;
pragma abicoder v2;

import "./Tournament.sol";


contract TournamentController {
    
    uint public numOpenTournaments;
    Tournament[] public _tournaments;
    
    /*
    TODO
    */
    constructor() {
        _tournaments = new Tournament[](10);
        numOpenTournaments = 0;
    }
    
    
    function startNewTournament(uint256 _num_prelims, uint _registration_fee, string memory _tournament_name, address _first_verifier, address _second_verifier) public payable returns (address) {
        
        Tournament newTournament = new Tournament(
            payable(msg.sender), _num_prelims, _registration_fee, _tournament_name, _first_verifier, _second_verifier
        );
        
        _tournaments.push(newTournament);
        numOpenTournaments++;
        
        return address(newTournament);
        
    }
  
}
