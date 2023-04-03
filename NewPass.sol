//SPDX-License-Identifier: Undefined



pragma solidity ^0.8.0;



import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

interface NakamigosContracts{
    function tokensOfOwner(address _to) external view returns(uint[] memory);
}

contract ExampleToken is ERC721 {
    
    address public nakaAddress = 0x7EF2e0048f5bAeDe046f6BF797943daF4ED8CB47;
    uint16 counter = 0;
    
    mapping(address => bool) public passIssued;
    
    

    constructor() ERC721("ExampleTokens", "EXt") {
        
    }

    function giveArray(address _to) public view returns(bool){
        uint[] memory arr = NakamigosContracts(nakaAddress).tokensOfOwner(_to);
         if(arr.length >= 1){
             return true;
         }
         else{
             return false;
         }
    }

    function newPass() external returns(bool) {
        require(msg.sender != address(0), "Not a valid address");
        require(passIssued[msg.sender] == false, "pass has been already issed");
        bool holdsNakaTokens = giveArray(msg.sender);
        require(holdsNakaTokens == true, "You have no nakamigos NFTs");

        uint256 newTokenId = counter++;
        _mint(msg.sender ,newTokenId);
        tokenURI(newTokenId);
        passIssued[msg.sender] = true;

        return true;

    }

}
