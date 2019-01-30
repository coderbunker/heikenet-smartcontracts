pragma solidity ^0.5.0;


contract Heike {
    
    // ENTITY STRUCT:
    
    struct Entity {
        address entityAddress; // Ethereum address of an entity
        bytes32 name; // Entity name
        bytes32[] ownerships; 
    }
    
    mapping (bytes32 => Entity) entities; 

    function innitEntity(bytes32 _name) public returns(bytes32){
        
        bytes32 id = keccak256(abi.encodePacked( block.number,  msg.sender));
        entities[id].entityAddress = msg.sender;
        entities[id].name = _name;

        return id;
    }

    function getEntity(bytes32 _id) public view returns(address, bytes32){
        return(entities[_id].entityAddress, entities[_id].name);
    }

    // FREELANCER STRUCT:

    struct Freelancer {
        bytes32 ipfsHash; // Hash link to a freelancer's profile
        bytes32[] ownerships; 
    }

    mapping (address => Freelancer) freelancers; 

    function innitFreelancer(address freelancer_, bytes32 ipfsHash_) public {
        freelancers[freelancer_].ipfsHash = ipfsHash_;
    }
    
    function getFreelancer(address freelancer_) public view returns( bytes32){
        return(freelancers[freelancer_].ipfsHash);
    }    

    // PROJECT STRUCT
    
    struct Project {
        bytes32 entity;
        address projectAddress;
        address[] freelancersList;
        uint capital;
        uint time_value;
        uint totalPayouts;
    }

    mapping (bytes32 => Project) projects; 
    
    function innitProject(bytes32 entityId_ , address projectAddress_) public returns(bytes32){
        bytes32 id = keccak256(abi.encodePacked( block.number,  msg.sender, entityId_, projectAddress_));
        projects[id].entity = entityId_;
        projects[id].projectAddress = projectAddress_;
        return id;
    }
    
    function assignFreelancer(bytes32 projectId_, address freelancer_) public {
        require(projects[projectId_].projectAddress == msg.sender,
        "Only project's main address has rights to assign freelancers");
        projects[projectId_].freelancersList.push(freelancer_); // ADD freelancer to the list
    } 
    
    // OWNERSHIP STRUCT
    
    struct Ownership { // structure of individual project ownership
        bytes32 projectId;
        uint capital;
        uint time_value;
        uint totalPayouts;
        
    }
    
    mapping (bytes32 => Ownership) ownerships; 
    
    //TODO: generate ownership id function
    //TODO: calculate ownership function
    
    //TODO: PUSH OWNERSHIP

    // your_sum(capital + time_value- payout) / total_sum(capital + time_value- payout)
    

    // PAYOUTS STRUCT
    
    
}