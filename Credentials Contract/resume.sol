// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title Resume
 * @dev ERC721 Non-Transferable (Soulbound) NFT for verifiable credentials
 * 
 * This contract implements a simplified version of ERC721 with the following modifications:
 * 1. Tokens are non-transferable (Soulbound)
 * 2. Each address can mint credentials and own multiple tokens
 * 3. Credentials are stored with IPFS metadata URIs
 * 
 * DEPLOYMENT INSTRUCTIONS:
 * 1. Deploy to Celo Mainnet
 * 2. Network: Celo Mainnet
 * 3. Chain ID: 42220
 * 4. RPC: https://forno.celo.org
 * 5. Explorer: https://celoscan.io
 * 
 * To deploy using Remix:
 * - Compile with Solidity 0.8.20
 * - Deploy with Injected Provider (MetaMask on Celo Mainnet)
 * - After deployment, update CONTRACT_CONFIG.address in shared/schema.ts
 */

contract Minet {
    string public name = "Minet";
    string public symbol = "MINET";
    
    uint256 private _tokenIdCounter;
    
    // Token ID => Owner address
    mapping(uint256 => address) private _owners;
    
    // Owner address => Token count
    mapping(address => uint256) private _balances;
    
    // Token ID => Token URI (IPFS metadata)
    mapping(uint256 => string) private _tokenURIs;
    
    // Events
    event CredentialMinted(address indexed to, uint256 indexed tokenId, string tokenURI);
    
    /**
     * @dev Mint a new credential NFT
     * @param to Address to mint the credential to
     * @param tokenURI IPFS URI containing the credential metadata
     * @return The newly minted token ID
     */
    function mint(address to, string memory tokenURI) public returns (uint256) {
        require(to != address(0), "Cannot mint to zero address");
        require(bytes(tokenURI).length > 0, "Token URI cannot be empty");
        
        uint256 tokenId = _tokenIdCounter;
        _tokenIdCounter++;
        
        _balances[to]++;
        _owners[tokenId] = to;
        _tokenURIs[tokenId] = tokenURI;
        
        emit CredentialMinted(to, tokenId, tokenURI);
        
        return tokenId;
    }
    
    /**
     * @dev Get the owner of a specific token
     */
    function ownerOf(uint256 tokenId) public view returns (address) {
        address owner = _owners[tokenId];
        require(owner != address(0), "Token does not exist");
        return owner;
    }
    
    /**
     * @dev Get the number of tokens owned by an address
     */
    function balanceOf(address owner) public view returns (uint256) {
        require(owner != address(0), "Cannot query zero address");
        return _balances[owner];
    }
    
    /**
     * @dev Get the token URI (IPFS metadata)
     */
    function tokenURI(uint256 tokenId) public view returns (string memory) {
        require(_owners[tokenId] != address(0), "Token does not exist");
        return _tokenURIs[tokenId];
    }
    
    /**
     * @dev Returns false - credentials are non-transferable (Soulbound)
     */
    function isTransferable() public pure returns (bool) {
        return false;
    }
    
    /**
     * @dev Transfer functions are disabled for Soulbound tokens
     */
    function transferFrom(address, address, uint256) public pure {
        revert("Credentials are non-transferable (Soulbound)");
    }
    
    function safeTransferFrom(address, address, uint256) public pure {
        revert("Credentials are non-transferable (Soulbound)");
    }
    
    function safeTransferFrom(address, address, uint256, bytes memory) public pure {
        revert("Credentials are non-transferable (Soulbound)");
    }
}
netttt
