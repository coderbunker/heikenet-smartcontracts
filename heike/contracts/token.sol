pragma solidity ^0.5.0;

import "./ERC20/ERC20.sol";
import "./ERC20/MintableToken.sol";



/**
 * The contractName contract does this and that...
 */
contract IssueToken is ERC20, MintableToken {

    string public symbol;
    string public  name;
    uint8 public decimals;
    uint public _totalSupply;

    mapping(address => uint) balances;
    mapping(address => mapping(address => uint)) allowed;

    constructor() public {
        symbol = "HUSD";
        name = "Heike USD";
        decimals = 18;
        _totalSupply = 0;
        balances[0x5A86f0cafD4ef3ba4f0344C138afcC84bd1ED222] = _totalSupply; // Adress should be changed for an entity adress
        emit Transfer(address(0), 0x5A86f0cafD4ef3ba4f0344C138afcC84bd1ED222, _totalSupply); // Adress should be changed to an entity adress
    }	

}
