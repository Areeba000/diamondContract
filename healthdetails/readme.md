# Medical Records Smart Contract

This Solidity smart contract, named "MedicalRecords," is designed to manage and secure medical records for patients. It allows the data owner (patient) to add, update, grant access to, or revoke access from healthcare providers for their medical records.

## Features

- Data owner (patient) can add or update their medical records.
- Data owner can grant access to healthcare providers.
- Data owner can revoke access from healthcare providers.
- Healthcare providers can view medical records if access is granted by the data owner.

## Getting Started

1. Deploy the Smart Contract: Deploy the "MedicalRecords" smart contract on an Ethereum-compatible blockchain, such as Ethereum, using a compatible development environment like Remix.

2. Initialize the Contract: After deployment, the data owner (patient) should call the `initializecupcake` function to set themselves as the owner of the contract.

3. Add/Update Medical Records: The data owner can add or update their medical records using the `addOrUpdateRecord` function. This function sets the medical data and the number of reports.

4. Grant/Revoke Access: The data owner can grant access to healthcare providers using the `grantAccess` function and revoke access using the `revokeAccess` function.

5. View Medical Records: Healthcare providers can call the `viewRecord` function to view the medical records if access is granted by the data owner.

## Usage

Here's an example of how to interact with the "MedicalRecords" contract:

1. Initialize the contract by the data owner (patient):

2. Grant access to a healthcare provider:

3. Revoke access from a healthcare provider:

4. Healthcare providers can view medical records (if access is granted):


