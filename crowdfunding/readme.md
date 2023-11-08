# Crowdfunding Diamond Proxy Contract

This is a Diamond Proxy Contract for a decentralized crowdfunding campaign on the Ethereum blockchain. It uses the Diamond standard for upgradeable smart contracts, allowing for easy upgrades and maintenance.

## Features

- **Create a Campaign**: Users can create a crowdfunding campaign by specifying the funding goal in Ether and the campaign duration in minutes.

- **Contribute Funds**: Contributors can send Ether to the campaign using the `contribute` function, indicating the amount they wish to contribute.

- **Check Funding Goal**: The contract owner can check if the funding goal is reached using the `checkGoalReached` function.

- **Withdraw Funds**: If the funding goal is reached, the owner can withdraw the funds using the `withdrawFunds` function.

- **Refund Contributions**: If the funding goal is not met, contributors can request a refund of their contributions using the `refundContribution` function.

- **Diamond Standard**: This contract uses the Diamond standard for upgradeability, allowing for easy maintenance and updates of the contract's functionality.

## Contract Deployment

- Deploy the Crowdfunding Diamond Proxy Contract and associated facets.

- Facets for the contract functions can be added and upgraded as needed while keeping the main proxy contract intact.

## Usage

![Screenshot 2023-11-08 111833](https://github.com/Areeba000/diamondContract/assets/140241495/3c6b8cb0-c6ca-412b-828a-83196e1a80bf)


1. **Create a Campaign**: Deploy the contract with your desired funding goal and duration.

2. **Contribute Funds**: Contributors can call the `contribute` function and send Ether to the contract's address.

3. **Check Funding Goal**: The owner can call `checkGoalReached` to determine if the funding goal is reached.

4. **Withdraw Funds**: If the funding goal is reached, the owner can use the `withdrawFunds` function to collect the funds.

5. **Refund Contributions**: If the funding goal is not met, contributors can request refunds using the `refundContribution` function.

6. **Upgradeability**: Take advantage of the Diamond standard to add or upgrade facets as needed to improve or extend the contract's functionality.

## Important Notes

- Ensure the contract owner is a trusted entity, as they can control the campaign and withdraw funds.

- Contributors can only request refunds if the funding goal is not met.

- This contract is designed for upgradeability, making it easier to adapt to changing requirements or fix issues.

