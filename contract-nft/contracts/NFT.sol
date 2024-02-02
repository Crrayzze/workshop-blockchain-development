// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

contract NFTContract is ERC721, ERC721Burnable, Ownable, IERC721Receiver {
    struct NFTMetadata {
        string name;
        string image;
        uint256 tokenId;
    }

    uint256 private _nextTokenId = 0;
    mapping(uint256 => NFTMetadata) private _tokenMetadatas;

    event NewMint(string message, uint256 tokenId);
    event NewBurn(string message, uint256 tokenId);

    constructor() ERC721("Workshop Blockchain", "WB") Ownable(msg.sender) {}

    function mint(
        string memory name,
        string memory image,
        address to
    ) public onlyOwner returns (uint256) {
        uint256 tokenId = _nextTokenId++;

        _safeMint(to, tokenId);
        _tokenMetadatas[tokenId] = NFTMetadata(name, image, tokenId);

        emit NewMint("A new token has been minted", tokenId);
        return tokenId;
    }

    function onERC721Received(
        address,
        address,
        uint256,
        bytes calldata
    ) external pure returns (bytes4) {
        return this.onERC721Received.selector;
    }

    function _getBytesMetadata(
        NFTMetadata memory metadata
    ) private pure returns (bytes memory) {
        return
            abi.encodePacked(
                "{",
                '"name": "',
                metadata.name,
                '", ',
                '"tokenId": "',
                Strings.toString(metadata.tokenId),
                '", ',
                '"image": "',
                metadata.image,
                '" '
                "}"
            );
    }

    function tokenURI(
        uint256 _tokenId
    ) public view virtual override returns (string memory) {
        bytes memory metadata = _getBytesMetadata(_tokenMetadatas[_tokenId]);
        string memory json = Base64.encode(bytes(string(metadata)));
        return string(abi.encodePacked("data:application/json;base64,", json));
    }
}
