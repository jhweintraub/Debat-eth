
// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;
import "https://raw.githubusercontent.com/OpenZeppelin/openzeppelin-contracts/master/contracts/token/ERC721/ERC721.sol";



contract Tournament {
    
    uint256 public num_prelims;
    address payable tabDirector;
    Team[] teamList;
    
    address public first_verifier;
    bool private first_person_verified = false;
    
    
    address public second_verifier;
    bool private second_person_verified = false;
    
    
    string tournamentName;
    uint public registration_fee;
    bool isOpen;
    bool hasConcluded = false;
    ERC721 public trophies;
    
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
    
    
    
    constructor(address payable _tabDirector, uint256 _num_prelims, uint _registration_fee, 
    string memory _tournament_name, address _first_verifier, address _second_verifier) {
        num_prelims = _num_prelims;
        registration_fee = _registration_fee;
        tournamentName = _tournament_name;
        tabDirector = _tabDirector;
        first_verifier = _first_verifier;
        second_verifier = _second_verifier;
    }
    
   function register(string memory teamCode, Debater memory _debater1, Debater memory _debater2) public payable {
        require(msg.value >= registration_fee, "Your registration_fee was too low.");

        teamList.push(Team(_debater1, _debater2, teamCode, 0.0, 0.0));
        
   }
   
   function startRound(int256 roundNum) onlyTabDirector public {
       
       
   }
   
   
   function startTournament() public onlyTabDirector {
       //Send Enough money to tab director to cover gas costs of running tournament
      tabDirector.transfer(address(this).balance / 3);
   }
   
   
   function getRegistrationFee() public view returns (uint){
       return registration_fee;
   }
   
   /*
   In Order to have the rest of the funds given to you after the tournament
   You must have 2 people whom you designate agree that the tournament is in fact over
   */
   function endTournament() private onlyTabDirector {
        require(first_person_verified && second_person_verified, "Not Verified");
        tabDirector.transfer(address(this).balance / 3);
        hasConcluded = true;
   }
   
   function verify() public onlyVerifiers {
       if (msg.sender == first_verifier) first_person_verified = true;
       else second_person_verified = true;
   }
   
   
   
   
   modifier onlyVerifiers {
       require(
           msg.sender == first_verifier || 
           msg.sender == second_verifier, 
           "Not Authorized to implement this function");
       _;
   }
   
   
   
    
    modifier onlyTabDirector {
        require(
            msg.sender == tabDirector,
            "Only the Tab Director can call this function."
            );
        _;
    }
    
    

}
