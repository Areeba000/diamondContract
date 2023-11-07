// SPDX-License-Identifier: MIT
pragma solidity 0.8.16;
contract SharedWallet {
    bytes32 internal constant WALLETNAMESPACE = keccak256('wallet.facet');
    function walletStorage() internal pure returns( walletdata storage s) {
        bytes32 position = WALLETNAMESPACE;
        assembly {
            s.slot := position
        }
    }

    struct walletdata{
    address  _owner;
    mapping(address => bool)  _owners;
    
    }

    event DepositFunds(address from, uint256 amount);
    event WithdrawFunds(address from, uint256 amount);
    event TransferFunds(address from, address to, uint256 amount);
    
    function initializewalletdata() public {
        walletdata storage s = walletStorage();
        s._owner=msg.sender;
    }

    modifier isOwner() {
        walletdata storage s = walletStorage();
        require(msg.sender == s._owner, "Not contract owner");
        _;
    }

    modifier validOwner() {
        walletdata storage s = walletStorage();
        require(msg.sender == s._owner || s._owners[msg.sender], "Not contract owner or owners of shared wallet");
        _;
    }
    
    function setowner(address owner)public isOwner{
        walletdata storage s = walletStorage();
        s._owners[owner]=true;
    }

    function removeOwner(address owner) public isOwner {
        walletdata storage s = walletStorage();
        s._owners[owner] = false;
    }

    receive() external payable {
        emit DepositFunds(msg.sender, msg.value);
    }

    function withdraw(uint256 amount) public validOwner {
        require(address(this).balance >= amount);
        payable(msg.sender).transfer(amount);
        emit WithdrawFunds(msg.sender, amount);
    }

    function transferTo(address payable to, uint256 amount) public validOwner {
        require(address(this).balance >= amount);
        payable(to).transfer(amount);
        emit TransferFunds(msg.sender, to, amount);
    }
}
