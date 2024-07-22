// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract PreRevealedTokens is ERC721, Ownable {
  using Counters for Counters.Counter;

  Counters.Counter private _tokenIdCounter;

  bool public isRevealed = false;
  string preRevealedURI = "https://www.jsonkeeper.com/b/S00G";
  string baseURI = "";

  constructor() ERC721("NFTRevealed", "NFT") {}

  function _baseURI() internal view override returns (string memory) {
    return baseURI;
  }

  function safeMint(address to) public onlyOwner {
    uint256 tokenId = _tokenIdCounter.current();
    _tokenIdCounter.increment();
    _safeMint(to, tokenId);
  }

  function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
    if (isRevealed) {
      return super.tokenURI(tokenId);
    }

    return preRevealedURI;
  }

  function setPreRevealedURI(string memory _preRevealedURI) external onlyOwner {
    preRevealedURI = _preRevealedURI;
  }

  function revealAndSetBaseURI(string memory baseURI_) external onlyOwner {
    isRevealed = true;
    baseURI = baseURI_;
  }
}
