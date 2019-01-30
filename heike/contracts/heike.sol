pragma solidity ^0.5.0;


contract Heike {
    
    bytes32 zeroBytes = 0x0000000000000000000000000000000000000000000000000000000000000000;
    
    // ENTITY STRUCT:
    
    struct Entity {
        bytes32 entityId; // Ethereum address of an entity TODO: change to IPFS hash
        bytes32 name; // Entity name
        bytes32[] ownerships; 
    }
    
    mapping (address => Entity) entities; 

    function innitEntity(bytes32 _name) public returns(bytes32){
        
        bytes32 id = keccak256(abi.encodePacked( block.number,  msg.sender));
        entities[msg.sender].entityId = id;
        entities[msg.sender].name = _name;

        return id;
    }

    function getEntity(address _address) public view returns(bytes32, bytes32){ //TODO: rewrite
        return(entities[_address].entityId, entities[_address].name);
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
        uint totalCapital;
        uint totalTimeValue;
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
        address owner;
        bytes32 projectId;
        uint capital;
        uint timeValue;
        uint payouts;
        uint totalOwnership;
    }
    
    mapping (bytes32 => Ownership) ownerships; 
    
    bytes32[] ownershipIds; // TODO: create list for other ids 
    
    function generateOwnershipId(bytes32 projectId_) public returns(bytes32) { // generate ownership id function
        require(entities[msg.sender].entityId != zeroBytes || freelancers[msg.sender].ipfsHash != zeroBytes,
        "There is no such owner in the system"); 
        
        bytes32 id = keccak256(abi.encodePacked( block.number,  msg.sender, projectId_)); //TODO: add more stuff
        ownershipIds.push(id);
        ownerships[id].owner = msg.sender; 
        
        if (entities[msg.sender].entityId == zeroBytes) {  //push to owner's ownerships
            freelancers[msg.sender].ownerships.push(id);
        } else {
            entities[msg.sender].ownerships.push(id);
        }
        
        ownerships[id].projectId = projectId_;
        return id;
    }
    
    //TODO: calculate ownership function
    
    function calculateOwnership(bytes32 ownershipId_) public returns (uint){
        bytes32 projectId =  ownerships[ownershipId_].projectId;
        uint ownership = (ownerships[ownershipId_].capital + ownerships[ownershipId_].timeValue+ownerships[ownershipId_].payouts)/(projects[projectId].totalCapital+projects[projectId].totalTimeValue+projects[projectId].totalPayouts);
        ownerships[ownershipId_].totalOwnership = ownership;
        return ownership;
    }
        

    // PAYOUTS STRUCT
    
    
}