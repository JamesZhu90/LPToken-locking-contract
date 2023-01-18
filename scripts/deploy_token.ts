import { ethers } from "hardhat";

async function main() {

  const GoofyGoober = await ethers.getContractFactory("GoofyGoober");
  const lock = await GoofyGoober.deploy();

  await lock.deployed();

  console.log(`Contract is deployed to ${lock.address}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
