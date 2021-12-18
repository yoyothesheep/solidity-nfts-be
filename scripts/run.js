//const { expect } = require("chai");
//const { ethers } = require("hardhat");

const main = async() => {

    // compiles contract
    const nftContractFactory = await hre.ethers.getContractFactory("GroupNFT");

    // create localnet
    const nftContract = await nftContractFactory.deploy();

    // mine contract and deploy to localnet
    await nftContract.deployed();

    console.log("GroupNFT deployed -> ", nftContract.address);

    // Call the function, then wait for it to be minted
    let txn = await nftContract.makeGroupNFTs()
    await txn.wait()

    // Mint another of the same NFT I guess.
    txn = await nftContract.makeGroupNFTs()
    await txn.wait()

};

const runMain = async() => {
    try {
        await main();
        process.exit(0);
      } catch (error) {
        console.log(error);
        process.exit(1);
      }
};

runMain();

/*
describe("Greeter", function () {
  it("Should return the new greeting once it's changed", async function () {
    const Greeter = await ethers.getContractFactory("Greeter");
    const greeter = await Greeter.deploy("Hello, world!");
    await greeter.deployed();

    expect(await greeter.greet()).to.equal("Hello, world!");

    const setGreetingTx = await greeter.setGreeting("Hola, mundo!");

    // wait until the transaction is mined
    await setGreetingTx.wait();

    expect(await greeter.greet()).to.equal("Hola, mundo!");
  });
});
*/
