pragma solidity ^0.5.6;

import "./klaytn-contracts/token/KIP37/KIP37.sol";
import "./klaytn-contracts/token/KIP37/KIP37Mintable.sol";
import "./klaytn-contracts/token/KIP37/KIP37Burnable.sol";
import "./klaytn-contracts/token/KIP37/KIP37Pausable.sol";

contract KlubsTestItems is KIP37, KIP37Mintable, KIP37Burnable, KIP37Pausable {

    constructor() public KIP37("https://api.klu.bs/test-items/{id}.json") {}

    function uri(uint256 _tokenId) external view returns (string memory) {
        uint256 tokenId = _tokenId;
        if (tokenId == 0) {
            return "https://api.klu.bs/test-items/0.json";
        }

        string memory baseURI = "https://api.klu.bs/test-items/";
        string memory idstr;
        
        uint256 temp = tokenId;
        uint256 digits;
        while (temp != 0) {
            digits += 1;
            temp /= 10;
        }
        bytes memory buffer = new bytes(digits);
        while (tokenId != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(tokenId % 10)));
            tokenId /= 10;
        }
        idstr = string(buffer);

        return bytes(baseURI).length > 0 ? string(abi.encodePacked(baseURI, idstr)) : "";
    }
}
