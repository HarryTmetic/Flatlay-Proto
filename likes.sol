pragma solidity ^0.4.18;

contract Owned {
    address owner;
    
    constructor() public {
        owner = msg.sender;
    }
    
   modifier onlyOwner {
       require(msg.sender == owner);
       _;
   }
}

contract Likes is Owned {
    
    struct Liker {
        address likerAddress;
        bytes16 firstName;
        bytes16 lastName;
    }
    
    mapping (address => Liker) likes;
    address[] public likerAccts;
    
    event likerInfo(address likerAddress, bytes16 firstName, bytes16 lastName);
    
    function giveLike(bytes16 _firstName, bytes16 _lastName) public {
        var like = likes[msg.sender];
        
        like.firstName = _firstName;
        like.lastName = _lastName;
        
        likerAccts.push(msg.sender) -1;
        emit likerInfo(msg.sender, _firstName, _lastName);
    }
    
    function getLikers() view public returns(address[]) {
        return likerAccts;
    }
    
    function getLiker(address _address) view public returns (bytes16, bytes16) {
        return (likes[_address].firstName, likes[_address].lastName);
    }
    
    function likesCount() view public returns (uint) {
        return likerAccts.length;
    }
    
}
