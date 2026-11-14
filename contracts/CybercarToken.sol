
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract CybercarToken is ERC721, Ownable {

    mapping(uint256 => string) public filename;

    string public baseURI = "https://oca-nft.com/nft/2026aiwh3/metadata/2402pg0005/";

    // Constructor
    constructor()
        ERC721("CybercarToken", "CBC")
        Ownable(msg.sender)
    {}

    // Return the base URI
    function _baseURI() internal view override returns (string memory) {
        return baseURI;
    }

    // Update the base URI
    function updateBaseURI(string memory uri) public onlyOwner {
        baseURI = uri;
    }

    // Mint NFT
    function safeMint(
        address to,
        uint256 tokenId,
        string memory _filename
    ) public onlyOwner {

        require(bytes(filename[tokenId]).length == 0, "Token already exists");

        filename[tokenId] = _filename;

        _safeMint(to, tokenId);
    }

    // Get NFT metadata URI
    function tokenURI(uint256 tokenId)
        public
        view
        override
        returns (string memory)
    {
        _requireOwned(tokenId);

        string memory _url = _baseURI();

        return bytes(_url).length > 0
            ? string(abi.encodePacked(_url, filename[tokenId]))
            : "";
    }
}
