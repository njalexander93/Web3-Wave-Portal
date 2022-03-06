// The SPDX License List is an integral part of the SPDX Specification. The SPDX License List itself is a list of
// commonly found licenses and exceptions used in free and open or collaborative software, data, hardware, or
// documentation. The SPDX License List includes a standardized short identifier, the full name, the license text, and a
// canonical permanent URL for each license and exception.

// The purpose of the SPDX License List is to enable efficient and reliable identification of such licenses and
// exceptions in an SPDX document, in source files or elsewhere.
//
// SPDX-License-Identifier: UNLICENSED

// The version of the Solidity compile we want our contract to use.
pragma solidity ^0.8.0;

// Useful for debugging smart contracts
import "hardhat/console.sol";



// Library to store user data
library User {
    struct data {
        uint num_waves;
        bool exists;
    }
}



// Wave portal
contract WavePortal {
    using User for User.data; // Pulling library data

    address[] private USER_ADDRESS_ARRAY;
    mapping(address => User.data) private USER;

    constructor() {
        console.log("Yo yo, I am a contract and I am smart");
    }


    // Add the address of the wave sender to a dynamic array
    function updateWaveData (address _send_address, uint256 _wave) private {
        if(!USER[_send_address].exists) {
            USER_ADDRESS_ARRAY.push(_send_address);
            USER[_send_address].exists = true;
            USER[_send_address].num_waves = _wave;
        }
        else {
            USER[_send_address].num_waves += _wave;
        }
    }


    // Iteritively prints all addresses that have waved!
    // A view function will read the data from the state variables but cannot change or write the data.
    function printAddresses () public view {
        console.log("All addresses that waved:");
        for (uint i = 0; i <= USER_ADDRESS_ARRAY.length - 1; i++) {
            address user_address = USER_ADDRESS_ARRAY[i];
            console.log("\t%s - Number of Waves: %s", user_address, USER[user_address].num_waves);
        }
    }


    function wave () public {
        updateWaveData(msg.sender, 1);
        console.log("%s has waved!", msg.sender);
    }


    function printWaveData () public view {
        console.log("All addresses that waved:");
        for (uint i = 0; i <= USER_ADDRESS_ARRAY.length - 1; i++) {
            address user_address = USER_ADDRESS_ARRAY[i];
            console.log("\t%s - Number of Waves: %s", user_address, USER[user_address].num_waves);
        }
    }
}
