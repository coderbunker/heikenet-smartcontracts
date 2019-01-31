pragma solidity ^0.5.0;

import "./ERC20/ERC20.sol";
import "./ERC20/MintableToken.sol";



/**
 * The contractName contract does this and that...
 */
contract Token is ERC20, MintableToken {

	function myFunction () public returns(bool) {
		return true;
	}
	

}
