
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
    console.log("Minted NFT hey now")
 
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
