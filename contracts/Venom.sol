// This example code is designed to quickly deploy an example contract using Remix.
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "smartcontractkit/chainlink@1.1.1/contracts/src/v0.8/VRFConsumerBase.sol";

contract Venom is VRFConsumerBase {
    
    bytes32 internal keyHash;
    uint256 internal fee;
    
    constructor() 
        VRFConsumerBase(
            0xb3dCcb4Cf7a26f6cf6B120Cf5A73875B7BBc655B, // VRF Coordinator
            0x01BE23585060835E02B77ef475b0Cc51aA1e0709  // LINK Token
        ) 
    {
        keyHash = 0x2ed0feb3e7fd2022120aa84fab1945545a9f2ffc9076fd6156fa96eaff4c1311;
        fee = 0.1 * 10 ** 18; // 0.1 LINK
    }
  
    struct Venom {
        uint256 DNA ;
    }

    Venom[] public AllVenoms;
    uint256 internal DNA ;
    mapping (uint256 => bool) public alreadyCreated;
    uint digits = 10 ** 16;

    function generateVenom() public returns (bytes32 requestId) {
        require(LINK.balanceOf(address(this)) >= fee, "Not enough LINK");
        return requestRandomness(keyHash, fee);
    }

    function fulfillRandomness(bytes32 requestId, uint256 randomness) internal override {
        
        DNA = uint(keccak256(abi.encodePacked(randomness))) % digits ;
        if (alreadyCreated[DNA] == false ) {
            AllVenoms.push(Venom(DNA))  ;
            alreadyCreated[DNA] = true ;
        }
    }
    
    function getVenom(uint8 index) public view returns (uint256 ){
        Venom storage venom = AllVenoms[index]; 
        return venom.DNA ; 
    }
   
    function getCountOfVenoms() public view returns (uint256 ){
        return AllVenoms.length ; 
    }
    // function withdrawLink() external {
    //     require(LINK.transfer(msg.sender, LINK.balanceOf(address(this))), "Unable to transfer");
    // }
}