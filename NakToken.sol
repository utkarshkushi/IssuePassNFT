//SPDX-License-Identifier: Undefined



pragma solidity ^0.8.0;



import "@openzeppelin/contracts/token/ERC721/ERC721.sol";


contract ExampleToken is ERC721{
    
    address public owner;
    uint256 counter = 0;

    mapping (address => uint256[]) public tokensOfOwnerArray;
    mapping(uint256 => string) public tokenUri;
    mapping(address => uint) public balances;
    // mapping(address => bool) public holdsTokens;

    constructor() ERC721("ExampleTokens", "EXt") {
        owner = msg.sender;
    }

    function newToken() external returns(bool){
        require(msg.sender != address(0), "Not a valid address");
        uint256 newTokenId = counter++;
        _mint(msg.sender ,newTokenId);
        balances[msg.sender]++;
       tokenUri[newTokenId] = tokenURI(newTokenId);
       tokensOfOwnerArray[msg.sender].push(newTokenId);
        return true;
    }

    function tokensOfOwner(address _to) external view returns(uint[] memory){
        return tokensOfOwnerArray[_to];
    } 

    // function holdsNaka(address _to) external view returns(bool){
    //     return holdsTokens[_to];
    // }
}
