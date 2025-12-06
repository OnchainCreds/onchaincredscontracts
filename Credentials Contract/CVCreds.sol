// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract CVCreds is ERC721 {
    using Counters for Counters.Counter;
        Counters.Counter private _tokenIds;

            mapping(uint256 => string) private _tokenURIs;

                constructor() ERC721("CVCreds", "CVC") {}

                    function mint(address to, string memory tokenURI_) public returns (uint256) {
                            _tokenIds.increment();
                                    uint256 newTokenId = _tokenIds.current();

                                            _mint(to, newTokenId);
                                                    _setTokenURI(newTokenId, tokenURI_);

                                                            return newTokenId;
                                                                }

                                                                    // ---- FIX: Implement _exists(), removed in OZ v5 ----
                                                                        function _exists(uint256 tokenId) internal view returns (bool) {
                                                                                return _ownerOf(tokenId) != address(0);
                                                                                    }

                                                                                        function _setTokenURI(uint256 tokenId, string memory tokenURI_) internal {
                                                                                                require(_exists(tokenId), "URI set for nonexistent token");
                                                                                                        _tokenURIs[tokenId] = tokenURI_;
                                                                                                            }

                                                                                                                function tokenURI(uint256 tokenId) public view override returns (string memory) {
                                                                                                                        require(_exists(tokenId), "URI query for nonexistent token");
                                                                                                                                return _tokenURIs[tokenId];
                                                                                                                                    }
                                                                                                                                    }