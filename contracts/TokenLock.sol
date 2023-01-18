// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract TokenLock is Ownable {
    using SafeMath for uint256;
    
    struct TokenDeposit {
        uint256 id;
        address depositOwner;
        IERC20 depositTokenAddress;        
        uint256 lockPeriod;
        uint256 depositTime;
        uint256 depositTokenAmount;
        uint256 unlockedTokenAmount;
    }

    TokenDeposit[] public tokenDeposits;
    function depositToken(IERC20 tokenAddress, uint256 amountToLockInWei, uint256 timeLockSeconds) external {
        require(amountToLockInWei != 0, "Cannot lock 0 amount of tokens");
        uint256 newItemId = tokenDeposits.length;
        tokenDeposits.push(
            TokenDeposit(
                newItemId,
                msg.sender,
                tokenAddress,
                timeLockSeconds,
                block.timestamp,
                amountToLockInWei,
                0
            )
        );
        tokenAddress.transferFrom(msg.sender, address(this), amountToLockInWei);
        emit TokenDeposited(
            newItemId,
            msg.sender,
            address(tokenAddress),
            timeLockSeconds,
            block.timestamp,
            amountToLockInWei,
            0
        );
    }

    function withdrawDeposit(uint256 depositId, uint256 withdrawAmount) external {
        IERC20 _beastnft = tokenDeposits[depositId].depositTokenAddress;

        require(depositId <= tokenDeposits.length);
        require(tokenDeposits[depositId].depositOwner == msg.sender, "You can only withdraw your own deposits.");
        require((block.timestamp - tokenDeposits[depositId].depositTime) >= tokenDeposits[depositId].lockPeriod, "You can't yet unlock this deposit. please use forceWithdrawDeposit instead");
        require(tokenDeposits[depositId].depositTokenAmount - tokenDeposits[depositId].unlockedTokenAmount >= withdrawAmount, "withdraw Amount exceeds locked amount");
        _beastnft.transfer(msg.sender, withdrawAmount);
        tokenDeposits[depositId].unlockedTokenAmount = tokenDeposits[depositId].unlockedTokenAmount + withdrawAmount;
        emit TokenWithdrawn(
            depositId,
            msg.sender,
            tokenDeposits[depositId].depositTokenAddress,
            tokenDeposits[depositId].depositTokenAmount,
            tokenDeposits[depositId].unlockedTokenAmount
        );
    }

    event TokenDeposited(
        uint256 depositId,
        address depositOwner,
        address depositTokenAddress,
        uint256 lockPeriod,
        uint256 depositTime,
        uint256 depositTokenAmount,
        uint256 unlockedTokenAmount
    );

    event TokenWithdrawn(
        uint256 depositId,
        address depositOwner,
        IERC20 depositTokenAddress,   
        uint256 depositTokenAmount,
        uint256 unlockedTokenAmount
    );


    function myLocks(address walletAddress) external view returns (TokenDeposit[] memory) {
        uint256 itemCount = 0;
        uint256 currentIndex = 0;
        for(uint256 i = 0; i < tokenDeposits.length; i ++){
            if(walletAddress == tokenDeposits[i].depositOwner){
                itemCount += 1;
            }
        }
        TokenDeposit[] memory items = new TokenDeposit[](itemCount);
        for (uint256 i = 0; i < tokenDeposits.length; i++) {
            if(walletAddress == tokenDeposits[i].depositOwner){
                TokenDeposit storage item = tokenDeposits[i];
                items[currentIndex] = item;
                currentIndex += 1;
            }
        }
        return items;
    }

    function allLocks() external view returns (TokenDeposit[] memory) {
        uint256 itemCount = tokenDeposits.length;
        TokenDeposit[] memory items = new TokenDeposit[](itemCount);
        for (uint256 i = 0; i < tokenDeposits.length; i++) {
                TokenDeposit storage item = tokenDeposits[i];
                items[i] = item;                
        }
        return items;
    } 
}
