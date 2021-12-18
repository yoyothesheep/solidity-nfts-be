//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

// We first import some OpenZeppelin Contracts.
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

// We need to import the helper functions from the contract that we copy/pasted.
import { Base64 } from "./libraries/Base64.sol";

contract GroupNFT is ERC721URIStorage {

    // OZ methods to keep track of tokens
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    // Our base SVG code, just the words will change
    string startSvg = "<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 350 350'><style>.base { fill: white; font-family: serif; font-size: 24px; }</style><rect width='100%' height='100%' fill='black' /><text x='50%' y='50%' class='base' dominant-baseline='middle' text-anchor='middle'>";
    string endSvg = "</text></svg>";

    string[] firstWords = ["Flip", "Himbo", "Zero Days", "Cup", "Vaccine", "Meow"];
    string[] secondWords = ["JORTS", "JEAN", "Margarine", "Sweet", "Accident", "Closet"];
    string[] thirdWords = ["Open", "Door", "Potato", "Help", "Trapped", "Friendly"];

    event MintedGroupNFT(address sender, uint256 tokenId);

    constructor() ERC721 ("GroupNFT1", "IGOTCHU"){
        console.log("created the token");
    }

    // function users call to mint their NFTs
    function makeGroupNFTs() public {
        // Get current tokenID
        uint256 newItemID = _tokenIds.current();

        // generate the 3 random words
        string memory first = getRandFirstWord(newItemID);
        string memory second = getRandSecondWord(newItemID);
        string memory third = getRandThirdWord(newItemID);
        string memory combinedWord = string(abi.encodePacked(first, second, third));

        // concat
        string memory finalSvg = string(abi.encodePacked(startSvg, combinedWord, endSvg));

        string memory json = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        '{"name": "',
                        // We set the title of our NFT as the generated word.
                        combinedWord,
                        '", "description": "A highly acclaimed collection of squares.", "image": "data:image/svg+xml;base64,',
                        // We add data:image/svg+xml;base64 and then append our base64 encode our svg.
                        Base64.encode(bytes(finalSvg)),
                        '"}'
                    )
                )
            )
        );

        string memory finalTokenUri = string(
            abi.encodePacked("data:application/json;base64,", json)
        );

        console.log("\n--------------------");
        console.log(
            string(
                abi.encodePacked(
                    "https://nftpreview.0xdev.codes/?code=",
                    finalTokenUri
                )
            )
        );
        console.log("--------------------\n");

        // Mint the NFT now for the sender
        _safeMint(msg.sender, newItemID);

        // Set the NFT data
        _setTokenURI(newItemID, finalTokenUri);

        // Increment tokenID for next person
        _tokenIds.increment();

        console.log("An NFT w/ ID %s has been minted for %s", newItemID, msg.sender);
        emit MintedGroupNFT(msg.sender, newItemID);
    }

    function getRandFirstWord(uint256 tokenId) public view returns (string memory){
        // seed
        uint256 randFirstIndex = random(string(abi.encodePacked("FIRST_WORD", Strings.toString(tokenId))));
        
        // don't go out of bounds
        randFirstIndex = randFirstIndex % firstWords.length;
        
        // return word at the random index
        return firstWords[randFirstIndex];
    }

    function getRandSecondWord(uint256 tokenId) public view returns (string memory){
        uint256 randSecondIndex = random(string(abi.encodePacked("FIRST_WORD", Strings.toString(tokenId))));
        randSecondIndex = randSecondIndex % firstWords.length;
        return secondWords[randSecondIndex];
    }

    function getRandThirdWord(uint256 tokenId) public view returns (string memory){
        uint256 randThirdIndex = random(string(abi.encodePacked("FIRST_WORD", Strings.toString(tokenId))));
        randThirdIndex = randThirdIndex % firstWords.length;
        return thirdWords[randThirdIndex];
    }

  function random(string memory input) internal pure returns (uint256) {
      return uint256(keccak256(abi.encodePacked(input)));
  }
}