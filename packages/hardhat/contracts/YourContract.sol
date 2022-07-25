pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "hardhat/console.sol";
import "@openzeppelin/contracts/access/Ownable.sol"; 
// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol

contract YourContract is Ownable {

  //address public constant ContractOwner = 0xdc1C7D69c66bADc7bD897c5257F9AC7e8a9FEECE; 
  address public constant ContractOwner = 0xef3A8D0a15755D024D514b984bec87d59638f1D1; 
  event SetPurpose(address sender, string purpose);

  mapping (address => bool) allowedMembers;

  modifier onlyContractOwner {
      require(msg.sender == ContractOwner);
      _;
  } 

  function addMember(address _member)
      external
      onlyContractOwner
  {
      allowedMembers[_member] = true;
      //members[_member];
  }

  modifier onlyMembers() {
        
        require(allowedMembers[msg.sender]);
        _;
  }


  string public purpose = "Building Unstoppable Apps!!!";

  /* constructor() payable {
    // what should we do on deploy?
  }  */

  function setPurpose(string memory newPurpose)
      external
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