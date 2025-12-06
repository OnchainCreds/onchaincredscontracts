Overview
Minet is a decentralized platform for issuing and managing verifiable credentials using NFT technology on the Celo blockchain. The platform provides three specialized smart contracts for different credential types, enabling tamper-proof digital verification of professional and academic achievements.

Contract Architecture

Minet.sol - Resume Credential Contract

Purpose: Core soulbound NFT contract for permanent resume storage and verification.

Key Features:

· Non-transferable (soulbound) NFT implementation
· Permanent binding to wallet address
· IPFS-based resume metadata storage
· Custom ERC721 with disabled transfers

Contract Address: Deploy to obtain address

AcademicCertificate.sol - Academic Certificate Contract

Purpose: Standard ERC721 contract for transferable academic credentials.

Key Features:

· Transferable academic NFTs (diplomas, degrees, certifications)
· IPFS metadata for certificate details
· OpenZeppelin ERC721 standard compliance
· Institutional-grade verification

Contract Address: Deploy to obtain address

CVCreds.sol - CV / Professional Profile Credential Contract

Purpose: ERC721 contract for professional skills and experience validation.

Key Features:

· Professional credential issuance
· Skills and employment verification
· Transferable NFT implementation
· Employer attestation capabilities

Contract Address: Deploy to obtain address

Technical Specifications

Blockchain Network

```
Network: Celo Mainnet
Chain ID: 42220
RPC Endpoint: https://forno.celo.org
Block Explorer: https://celoscan.io
Solidity Version: ^0.8.20
```

Dependencies

· @openzeppelin/contracts: ^5.0.0
· OpenZeppelin Counters utility for token ID management

How the Contracts Work

Minet.sol (Soulbound Resume Contract)

This contract implements a modified ERC721 standard where tokens are permanently bound to their owners (soulbound). Once minted, resume credentials cannot be transferred to another address. The contract stores metadata on IPFS and provides functions for minting and querying credentials.

Key functions:

· mint(address to, string memory tokenURI): Creates a new resume credential
· ownerOf(uint256 tokenId): Returns the owner of a credential
· tokenURI(uint256 tokenId): Returns the IPFS metadata URI
· All transfer functions are disabled and will revert

AcademicCertificate.sol

This contract follows the standard ERC721 implementation for academic certificates. Certificates are transferable and can be moved between wallets. The contract uses OpenZeppelin's Counters utility for token ID management and stores metadata on IPFS.

Key functions:

· mint(address to, string memory tokenURI_): Mints a new academic certificate
· tokenURI(uint256 tokenId): Returns the IPFS metadata URI
· Standard ERC721 transfer functions are enabled

CVCreds.sol

This contract implements professional credentials as ERC721 tokens. It allows for the issuance of verifiable professional credentials that can be transferred between wallets. The contract includes custom _exists() and _setTokenURI() functions to ensure compatibility with OpenZeppelin v5.

Key functions:

· mint(address to, string memory tokenURI_): Issues a new professional credential
· tokenURI(uint256 tokenId): Returns the IPFS metadata URI
· Standard ERC721 transfer functions are enabled

Deployment Instructions Using Remix IDE

Prerequisites

1. MetaMask wallet installed and configured
2. MetaMask connected to Celo Mainnet (Chain ID: 42220)
3. CELO tokens in your wallet for gas fees
4. IPFS setup for metadata storage (Pinata or similar service)

Step 1: Open Remix IDE

1. Go to https://remix.ethereum.org
2. Create a new workspace or use the default one

Step 2: Add Contract Files

1. In the File Explorer, create a new file named Minet.sol
2. Copy and paste the Minet.sol contract code
3. Create a new file named CVCreds.sol
4. Copy and paste the CVCreds.sol contract code
5. Create a new file named AcademicCertificate.sol
6. Copy and paste the AcademicCertificate.sol contract code

Step 3: Install Dependencies

1. In the Solidity Compiler tab (left sidebar), set compiler version to 0.8.20
2. For CVCreds.sol and AcademicCertificate.sol, you need to import OpenZeppelin contracts
3. In Remix, you can use the "Import from GitHub" feature or install via npm if using Remix with local node

Step 4: Compile Contracts

1. Select the Solidity Compiler tab
2. For each contract:
   · Select the contract file from the dropdown
   · Click "Compile [ContractName].sol"
   · Ensure no errors appear in the console

Step 5: Deploy Contracts

Deploying Minet.sol:

1. Go to the "Deploy & Run Transactions" tab
2. Select "Injected Provider - MetaMask" as the environment
3. Ensure MetaMask is connected to Celo Mainnet
4. From the contract dropdown, select "Minet"
5. Click "Deploy"
6. Confirm the transaction in MetaMask
7. Wait for deployment confirmation
8. Copy the deployed contract address

Deploying CVCreds.sol:

1. From the contract dropdown, select "CVCreds"
2. Click "Deploy"
3. Confirm the transaction in MetaMask
4. Wait for deployment confirmation
5. Copy the deployed contract address

Deploying AcademicCertificate.sol:

1. From the contract dropdown, select "AcademicCertificate"
2. Click "Deploy"
3. Confirm the transaction in MetaMask
4. Wait for deployment confirmation
5. Copy the deployed contract address

Step 6: Verify Contracts on CeloScan

1. Go to https://celoscan.io
2. For each deployed contract address:
   · Search for the contract address
   · Click "Verify & Publish"
   · Select "Via solidity (single file)"
   · Enter contract name and compiler version (0.8.20)
   · Paste the contract code
   · Click "Verify and Publish"

Integration with OnchainCreds DApp

The Minet contracts are designed to work with the OnchainCreds decentralized application. After deployment:

Update DApp Configuration

1. Update the contract addresses in the DApp configuration file (shared/schema.ts or environment variables):

```
NEXT_PUBLIC_MINET_CONTRACT_ADDRESS=[Minet contract address]
NEXT_PUBLIC_CVCREDS_CONTRACT_ADDRESS=[CVCreds contract address]
NEXT_PUBLIC_ACADEMIC_CONTRACT_ADDRESS=[AcademicCertificate contract address]
```

Credential Minting Flow

1. User submits supporting documentation through the DApp
2. Metadata is compiled and stored on IPFS
3. The DApp calls the appropriate contract's mint() function
4. Transaction is signed and sent to the Celo network
5. Credential NFT is minted to the user's wallet

Credential Verification Flow

1. User or verifier queries credentials via Token ID, Wallet Address, or Transaction Hash
2. DApp reads on-chain data to verify ownership and metadata
3. IPFS metadata is retrieved to display credential details
4. Verification status is displayed with clear attestation indicators

Usage Examples

Minting a Resume Credential

```javascript
// Example using ethers.js
const minetContract = new ethers.Contract(
  minetAddress,
  minetABI,
  signer
);

const tx = await minetContract.mint(
  "0xRecipientAddress",
  "ipfs://QmXyz.../resume-metadata.json"
);

await tx.wait();
```

Minting an Academic Certificate

```javascript
const academicContract = new ethers.Contract(
  academicAddress,
  academicABI,
  signer
);

const tx = await academicContract.mint(
  "0xStudentAddress",
  "ipfs://QmAbc.../diploma.json"
);
```

Minting a Professional Credential

```javascript
const cvCredsContract = new ethers.Contract(
  cvCredsAddress,
  cvCredsABI,
  signer
);

const tx = await cvCredsContract.mint(
  "0xEmployeeAddress",
  "ipfs://QmDef.../employment-proof.json"
);
```

Querying Credentials

Check Credential Ownership

```javascript
const owner = await minetContract.ownerOf(tokenId);
```

Get Credential Metadata

```javascript
const metadataURI = await minetContract.tokenURI(tokenId);
```

Check Balance

```javascript
const credentialCount = await minetContract.balanceOf(walletAddress);
```

Security Considerations

Minet.sol Security

· Transfer functions are permanently disabled (soulbound)
· No approval mechanisms exist
· Direct minting only, no secondary market
· Tokens cannot be stolen or transferred

AcademicCertificate.sol & CVCreds.sol Security

· Standard ERC721 security practices apply
· Transferable with OpenZeppelin safeguards
· Implement access control for minting functions in production
· Consider adding pausable functionality for emergency stops

Testing on Celo Testnet

Before deploying to mainnet, test on Celo Alfajores testnet:

1. Configure MetaMask for Alfajores (Chain ID: 44787, RPC: https://alfajores-forno.celo-testnet.org)
2. Get test CELO from the faucet: https://faucet.celo.org
3. Deploy contracts to Alfajores using the same Remix process
4. Test all minting and querying functions
5. Verify contract functionality before mainnet deployment

Contract Addresses Management

After deployment, maintain a record of contract addresses:

```
Minet.sol: [Address after deployment]
CVCreds.sol: [Address after deployment]
AcademicCertificate.sol: [Address after deployment]
```

Update these in:

1. DApp configuration files
2. Documentation
3. Any integration scripts or tools

Troubleshooting

Deployment Issues

· Ensure MetaMask is connected to Celo Mainnet
· Verify sufficient CELO balance for gas fees
· Check that compiler version matches pragma statement (0.8.20)
· Confirm OpenZeppelin imports are correctly resolved

Contract Interaction Issues

· Verify contract addresses are correct
· Check that caller has required permissions for minting
· Ensure IPFS metadata is properly formatted
· Confirm wallet is connected and has sufficient gas

License

All contracts are released under MIT License. See SPDX-License-Identifier in each contract file.

Support

For technical assistance:

1. Review contract code comments
2. Test on Celo Alfajores testnet first
3. Check Celo documentation at https://docs.celo.org
4. Review OpenZeppelin documentation for ERC721 standards

Future Development

Potential enhancements for future versions:

1. Add role-based access control for minting
2. Implement credential revocation mechanisms
3. Add batch minting capabilities
4. Integrate with other identity standards (DID, Verifiable Credentials)
5. Multi-chain deployment support

---

Production Readiness: Compile with Solidity 0.8.20, deploy to Celo Mainnet, and integrate with OnchainCreds DApp for complete credential management solution.
