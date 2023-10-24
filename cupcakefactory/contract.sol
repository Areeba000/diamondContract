// SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

contract cupcake {
     bytes32 internal constant CUPCAKENAMESPACE = keccak256('cupcake.facet');
      function getcupcakeStorage() internal pure returns( cupcakedata storage s) {
        bytes32 position = CUPCAKENAMESPACE;
        assembly {
            s.slot := position
        }
      }
        struct cupcakedata{
         bool initialized;
         address  owner;
         mapping (CupcakeType => uint)  cupcakePrices;
         mapping (address => uint) cupcakeBalances;
         mapping(address => bool) allowedAddresses;
    }
    enum CupcakeType { Vanilla, Chocolate, Strawberry, Carrot }
    function initializecupcake() public {
    cupcakedata storage s = getcupcakeStorage() ;
        s.owner = msg.sender;
        s.cupcakeBalances[address(this)] = 5;
    }
   
    modifier onlyowner{
         require( getcupcakeStorage().owner==msg.sender, "you are not owner.");
         _;
    }
    modifier Notenoughcupcakes(uint amount){
       require(getcupcakeStorage().cupcakeBalances[address(this)] >= amount, "Not enough cupcakes in stock "); 
       _; 
    }
    function getcakeprice(CupcakeType _type) public view returns (uint256) {
    cupcakedata storage s = getcupcakeStorage();
    return s.cupcakePrices[_type];
}
    function setCupcakePrice(CupcakeType _type, uint _price) public onlyowner {
         cupcakedata storage s = getcupcakeStorage() ;
         s.cupcakePrices[_type] = _price;
}
    function refillcupcake(uint amount) public onlyowner {
         cupcakedata storage s = getcupcakeStorage() ;
        s.cupcakeBalances[address(this)] += amount;
    }

    function purchasecupcake(CupcakeType _type,uint amount) public payable Notenoughcupcakes( amount) {
     cupcakedata storage s = getcupcakeStorage() ;
    if (!s.allowedAddresses[msg.sender]) {
        require(msg.value >= amount * s.cupcakePrices[_type], "You must pay the correct amount per cupcake");
    }  
        s.cupcakeBalances[address(this)] -= amount;
        s.cupcakeBalances[msg.sender] += amount;

    }
    
    //owner can transfer cupcake free to anyone address
     function transfercupcake( address to, uint256 amount) public onlyowner  Notenoughcupcakes( amount){
         cupcakedata storage s = getcupcakeStorage() ;
          s.cupcakeBalances[to] = amount;
          s.cupcakeBalances[address(this)] -= amount;
       
     }
     //owner can allow address 
     function allowaddress(address _add)public onlyowner{
         cupcakedata storage s = getcupcakeStorage() ;
         s.allowedAddresses[_add] = true;
     }


}
