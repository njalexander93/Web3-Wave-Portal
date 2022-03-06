const { hexStripZeros } = require("ethers/lib/utils");


const main = async() => {
    // Creates the wallet addresses. 'owner' is the address of the contract ower, and 'random_person' is a random
    // person.
    const [owner, random_person] = await hre.ethers.getSigners();

    // Compile the contract and generate the necessary files needed to work with the contract under artifacts directory.
    const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");

    // Hardhat creates a local Ethereum network, but just for this contract. After the script completes, it will destroy
    // that local networks. Every time you run the blockchain, it'll be a fresh blockchain.
    const waveContract = await waveContractFactory.deploy();

    // Wait for the contract to be deployed
    await waveContract.deployed();
    console.log("Contract deployed to: ", waveContract.address);
    console.log("Contract deployed by: ", owner.address);
    console.log(typeof(owner.address))

    for (let i = 0; i < 100; i++) {
        const coin_flip = Math.random();
        let wave_token;

        if (coin_flip < 0.5) {
            wave_token = await waveContract.wave();
        }
        else {
            wave_token = await waveContract.connect(random_person).wave();
        }
        await wave_token.wait();
    }

    await waveContract.printWaveData();
};


// Container module to run the main module within a try/catch. Print the error if there is one
const runMain = async() => {
    try {
        await main();
        process.exit(0);
    }
    catch (error) {
        console.log(error);
        process.exit(1);
    }
};

runMain();
