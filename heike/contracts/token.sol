pragma solidity ^0.5.0;

import "./ERC20/ERC20.sol";
import "./ERC20/MintableToken.sol";
import "./ERC20/BurnableToken.sol";
import "./ERC20/SafeMath.sol";

/**
 * The contractName contract does this and that...
 */
contract IssueToken is ERC20, MintableToken, BurnableToken {

	using SafeMath for uint256;

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

    // Total supply

    function totalSupply() public view returns (uint) {
        return _totalSupply  - balances[address(0)];
    }

    // Get the token balance for account tokenOwner

    function balanceOf(address tokenOwner) public view returns (uint balance) {
        return balances[tokenOwner];
    }

    // Transfer the balance from token owner's account to to account
    // - Owner's account must have sufficient balance to transfer
    // - 0 value transfers are allowed

    function transfer(address to, uint tokens) public returns (bool success) {
        balances[msg.sender] = balances[msg.sender].sub(tokens);
        balances[to] = balances[to].add(tokens);
        emit Transfer(msg.sender, to, tokens);
        return true;
    }

    // Token owner can approve for spender to transferFrom(...) tokens
    // from the token owner's account
    //
    // https://github.com/ethereum/EIPs/blob/master/EIPS/eip-20-token-standard.md
    // recommends that there are no checks for the approval double-spend attack
    // as this should be implemented in user interfaces 

    function approve(address spender, uint tokens) public returns (bool success) {
        allowed[msg.sender][spender] = tokens;
        emit Approval(msg.sender, spender, tokens);
        return true;
    }

    // Transfer tokens from the from account to the to account
    // 
    // The calling account must already have sufficient tokens approve(...)-d
    // for spending from the from account and
    // - From account must have sufficient balance to transfer
    // - Spender must have sufficient allowance to transfer
    // - 0 value transfers are allowed

    function transferFrom(address from, address to, uint tokens) public returns (bool success) {
        balances[from] = balances[from].sub(tokens);
        allowed[from][msg.sender] = allowed[from][msg.sender].sub(tokens);
        balances[to] = balances[to].add(tokens);
        emit Transfer(from, to, tokens);
        return true;
    }


    // Returns the amount of tokens approved by the owner that can be
    // transferred to the spender's account

    function allowance(address tokenOwner, address spender) public view returns (uint remaining) {
        return allowed[tokenOwner][spender];
    }

    // Token owner can approve for spender to transferFrom(...) tokens
    // from the token owner's account. The spender contract function
    // receiveApproval(...) is then executed

    // function approveAndCall(address spender, uint tokens, bytes memory data) public returns (bool success) {
    //     allowed[msg.sender][spender] = tokens;
    //     emit Approval(msg.sender, spender, tokens);
    //     ApproveAndCallFallBack(spender).receiveApproval(msg.sender, tokens, this, data);
    //     return true;
    // }

    // Don't accept ETH

    function () external payable {
        revert();
    }

    // Owner can transfer out any accidentally sent ERC20 tokens

    function transferAnyERC20Token(address tokenAddress, uint tokens) public onlyOwner returns (bool success) {
        return ERC20(tokenAddress).transfer(owner, tokens);
    }


}
