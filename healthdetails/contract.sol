// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MedicalRecords { 
    bytes32 internal constant HEALTHCARENAMESPACE = keccak256('healthcare.facet');

    // Function to retrieve the healthcare storage data
    function gethealthcareStorage() internal pure returns (healthcaredata storage s) {
        bytes32 position = HEALTHCARENAMESPACE;
        assembly {
            s.slot := position
        }
    }

    // Struct to store healthcare data
    struct healthcaredata {
        bool initialized;
        address dataowner;
        mapping(address => Record) records; // Mapping of providers to medical records
        Record data;
    }

    struct Record {
        string data;
        uint256 reportsNo;
        bool grantedAccess; 
    }

    // Function to initialize the contract by the data owner (patient)
    function initializehealthcare() public {
        healthcaredata storage s = gethealthcareStorage();
        s.dataowner = msg.sender;
        s.initialized = true;
    }
    
    // Modifier to restrict access to the data owner
    modifier onlydataowner {
        healthcaredata storage s = gethealthcareStorage();
        require(msg.sender == s.dataowner, "You are not the data owner");
        _;
    }
    
    // Function to add or update medical records by the data owner
    function addOrUpdateRecord(string memory _data, uint256 _reportsNo) public {
        healthcaredata storage s = gethealthcareStorage();
        s.records[msg.sender].data = _data;
        s.records[msg.sender].reportsNo = _reportsNo;
        s.records[msg.sender].grantedAccess = true; // Reset access permission
    }
    
    // Function to grant access to a healthcare provider by the data owner
    function grantAccess(address _doctor) public onlydataowner {
        healthcaredata storage s = gethealthcareStorage();
        s.records[_doctor].grantedAccess = true;
    }
    
    // Function to revoke access from a healthcare provider by the data owner
    function revokeAccess(address _doctor) public onlydataowner {
        healthcaredata storage s = gethealthcareStorage();
        s.records[_doctor].grantedAccess = false;
    }
    
    // Function to view medical records for a healthcare provider
    function viewRecord(address doctor) public view returns (string memory, uint256) {
        healthcaredata storage s = gethealthcareStorage();
        require(s.records[msg.sender].grantedAccess, "Access not granted");
        return (s.records[s.dataowner].data, s.records[s.dataowner].reportsNo);
    }
}
