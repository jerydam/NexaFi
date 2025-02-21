// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "../lib/forge-std/src/Script.sol";
import {DAO} from "../src/dao.sol";
import {NexaNft} from "../src/nft.sol";
import {P2PLending} from "../src/lending.sol";
import {Treasury} from "../src/treasury.sol";
import {Nexa} from "../src/token.sol";
import {StakERC20} from "../src/stake.sol";
import {Swapper} from "../src/swap.sol";

contract Deployscript is Script {
    Treasury treasury;
    StakERC20 stakErc20;  
    NexaNft nexaNft;
    Swapper swap;
    DAO dao;
    Nexa erc20;
    P2PLending lending;

    function run() public {
        uint256 key = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(key);

        // Step 1: Deploy Token Contract
        erc20 = new Nexa(msg.sender);
        console.log("ERC20 Deployed at:", address(erc20));

        // Step 2: Deploy Treasury
        treasury = new Treasury(msg.sender, address(erc20));
        console.log("Treasury Deployed at:", address(treasury));

        // Step 3: Deploy Staking Contract
        stakErc20 = new StakERC20(msg.sender, address(erc20));
        console.log("Staking Contract at:", address(stakErc20));

        // Step 4: Deploy NFT Contract
        nexaNft = new NexaNft(msg.sender);
        console.log("NFT Contract at:", address(nexaNft));

        // Step 5: Deploy Swapper
        swap = new Swapper(msg.sender);
        console.log("Swapper Contract at:", address(swap));

        // Step 6: Deploy P2P Lending Contract
        lending = new P2PLending(
            msg.sender,
            address(erc20),
            address(stakErc20),
            address(treasury),
            address(swap)
        );
        console.log("P2P Lending Contract at:", address(lending));

        // Step 7: Deploy DAO Contract
        dao = new DAO(
            3,
            address(treasury),
            address(nexaNft),
            address(erc20),
            address(stakErc20),
            address(swap),
            address(lending)
        );
        console.log("DAO Contract at:", address(dao));

        vm.stopBroadcast();
    }
}
