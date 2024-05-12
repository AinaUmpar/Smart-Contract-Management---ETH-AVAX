// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;


contract Assessment {
    address payable public admin;
    uint256 public fund;

    event Deposit(uint256 amount);
    event Withdraw(uint256 amount);

    constructor(uint initfund) payable {
        admin = payable(msg.sender);
        fund = initfund;
    }

    function getfund() public view returns(uint256){
        return fund;
    }

    function deposit(uint256 _amount) public payable {
        uint _previousfund = fund;

        
        require(msg.sender == admin, "You are not the owner of this account");

        
        fund += _amount;

        
        assert(fund == _previousfund + _amount);

        
        emit Deposit(_amount);
    }

    
    error InsufficientBalance(uint256 fund, uint256 withdrawAmount);

    function withdraw(uint256 _withdrawAmount) public {
        require(msg.sender == admin, "You are not the owner of this account");
        uint _previousBalance = fund;
        if (fund < _withdrawAmount) {
            revert InsufficientBalance({
                fund: fund,
                withdrawAmount: _withdrawAmount
            });
        }

        
        fund -= _withdrawAmount;

        
        assert(fund == (_previousfund - _withdrawAmount));

        emit Withdraw(_withdrawAmount);
    }
}
