pragma solidity ^0.5.2;


contract Heike {
	
	// ENTITY STRUCT:
	
	struct Entity {
		address entityAddress; // Ethereum address of an entity
		bytes32 name; // Entity name
	}
	
	mapping (bytes32 => Entity) entities; 

	function innitEntity(bytes32 _name) public returns(bytes32){
        
        bytes32 id = keccak256(abi.encodePacked( block.number,  msg.sender));
        entities[id] = Entity(msg.sender, _name);

        return id;
	}

    function getEntity(bytes32 _id) public view returns(address, bytes32){
        return(entities[_id].entityAddress, entities[_id].name);
    }

	// FREELANCER STRUCT:

    struct Freelancer {
        bytes32 ipfsHash; // Hash link to a freelancer's profile
    }

	mapping (address => Freelancer) freelancers; 

    function innitFreelancer(address freelancer_, bytes32 ipfsHash_) public {
        freelancers[freelancer_] = Freelancer(ipfsHash_);
    }
    
    function getFreelancer(address freelancer_) public view returns( bytes32){
        return(freelancers[freelancer_].ipfsHash);
    }    

}