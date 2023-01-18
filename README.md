# LP and Token Locking Smart Contracts
##  Token Locking smart contract
```
The code  is a smart contract written in the Solidity programming language. It appears to be a token lock contract that allows users to deposit ERC-20 tokens for a specified period of time, and then later withdraw them.

It is utilizing OpenZeppelin libraries such as 'Ownable' and 'SafeMath' library to make sure the contract is safe and secure.

It has two main functions:

depositToken(IERC20 tokenAddress, uint256 amountToLockInWei, uint256 timeLockSeconds) - This function allows users to deposit ERC-20 tokens to the contract. It requires the address of the ERC-20 token contract, the amount of tokens to be locked, and the duration of the lock in seconds.
withdrawDeposit(uint256 depositId, uint256 withdrawAmount) - This function allows users to withdraw their deposited tokens, provided that the lock period has ended and the user is the depositor of the tokens.
It also has two events:

TokenDeposited - This event is emitted when a user deposits tokens to the contract.
TokenWithdrawn - This event is emitted when a user withdraws their deposited tokens.
It also has two view functions:

myLocks(address walletAddress) - This function allows users to view their own deposited tokens.
allLocks() - This function allows users to view all deposited tokens in the contract.
It is using the latest version of solidity (0.8.0) and has a license of MIT.
```

### Deployed Tokens Contract
- ERC-20 token
https://goerli.etherscan.io/token/0xa1CE1F4Ae36ea5fad3CE01fB11698Fa5213C7491   
Name: GoofyGoober   
Symbol:GG   
Total Supply: 100   


### Deployed TokenLock Contracts
- on Goerli
https://goerli.etherscan.io/address/0x373824ca6bb4ae543fffc205b9174237e7c1a8cc