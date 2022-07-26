pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "hardhat/console.sol";
import "@openzeppelin/contracts/access/Ownable.sol"; 
// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol

contract YourContract is Ownable {

  //address public constant ContractOwner = 0xdc1C7D69c66bADc7bD897c5257F9AC7e8a9FEECE; 
  address public constant ContractOwner = 0xef3A8D0a15755D024D514b984bec87d59638f1D1; 
  event SetPurpose(address sender, string purpose);
  // Custom errors save gas on deployment as well as on revert
  error NotOwner();
  error OnlyMember();

  mapping (address => bool) allowedMembers;

  modifier onlyContractOwner {
      if(msg.sender != ContractOwner){
      revert NotOwner();
      }
      _;
  } 
// Marking function as payable costs less gas as evm will not have to check if the user has sent value or not .
  function addMember(address _member)
      external payable 
      onlyContractOwner
  {
      allowedMembers[_member] = true;
      //members[_member];
  }

  modifier onlyMembers() {
        
        if(!allowedMembers[msg.sender]){
        revert OnlyMember();
        }
        _;
  }


  string public purpose = "Building Unstoppable Apps!!!";

  /* constructor() payable {
    // what should we do on deploy?
  }  */
// Payable saves gas 
  function setPurpose(string memory newPurpose)
      external payable
      onlyMembers
      //onlyContractOwner
  {
      purpose = newPurpose;
      console.log(msg.sender,"set purpose to",purpose);
      emit SetPurpose(msg.sender, purpose);
      
  }
  

  // to support receiving ETH by default
  receive() external payable {}
  fallback() external payable {}
}

/*
 /*modifier onlyContractOwner {
      require(msg.sender == contractOwner);
      _;
  } 
  
  function setContractOwnerAddress(address _contractOwner) external {
      contractOwner = _contractOwner;
  } */
 
  /*constructor() public payable Ownable() {
    contractOwner = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266;

  } */

/*
contract YourContract {

  event SetPurpose(address sender, string purpose);

  string public purpose = "Building Unstoppable Apps!!!";

  constructor() payable {
    // what should we do on deploy?
  }

  function setPurpose(string memory newPurpose) public {
      purpose = newPurpose;
      console.log(msg.sender,"set purpose to",purpose);
      emit SetPurpose(msg.sender, purpose);
      
  }
  

  // to support receiving ETH by default
  receive() external payable {}
  fallback() external payable {}
}
*/
