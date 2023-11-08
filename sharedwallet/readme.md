# SharedWallet Diamond Facet

The `SharedWallet` is a facet of a Diamond Standard contract, which allows multiple facets to be aggregated into a single smart contract. This specific facet provides the functionality for a shared wallet, allowing users to deposit funds, withdraw funds, transfer funds to other addresses, and manage owners of the shared wallet.

## Features

- Deposit funds into the shared wallet.
- Withdraw funds from the shared wallet (for owners).
- Transfer funds from the shared wallet to other addresses (for owners).
- Add or remove owners who have access to the shared wallet.

## Usage

![Screenshot 2023-11-07 160628](https://github.com/Areeba000/diamondContract/assets/140241495/1f9937d0-5dba-4339-89b0-10515d779f27)


### Contract Initialization

1. The `SharedWallet` facet should be part of a Diamond Standard contract. The diamond owner or deployer should create and initialize the diamond, including the `SharedWallet` facet.

### Ownership

1. During deployment, the deployer's Ethereum address is typically set as the initial contract owner.
2. The contract owner can add or remove other addresses as owners of the shared wallet using the `setowner` and `removeOwner` functions.

### Deposit Funds

1. Send Ether to the contract address to deposit funds into the shared wallet. This can be done by sending Ether directly to the contract address.

### Withdraw Funds

1. Owners of the shared wallet can use the `withdraw` function to withdraw a specific amount of Ether.
2. Specify the amount to be withdrawn as an argument when calling the function.

### Transfer Funds

1. Owners of the shared wallet can use the `transferTo` function to transfer a specific amount of Ether to another address.
2. Specify the recipient address and the amount to be transferred as arguments when calling the function.

### Ownership Management

1. The contract owner can add or remove owners using the `setowner` and `removeOwner` functions. Only owners have access to the shared wallet's functions.

## Modifiers

- `isOwner`: Ensures that a function is only accessible by the contract owner.
- `validOwner`: Ensures that a function is accessible by the contract owner or other addresses added as owners.

## Events

- `DepositFunds`: Logged when funds are deposited into the shared wallet.
- `WithdrawFunds`: Logged when funds are withdrawn from the shared wallet.
- `TransferFunds`: Logged when funds are transferred to another address.

## Diamond Standard

The `SharedWallet` facet is part of a Diamond Standard contract, which allows multiple facets to be composed together. The diamond owner can aggregate various facets to create a versatile smart contract with different functionalities.


