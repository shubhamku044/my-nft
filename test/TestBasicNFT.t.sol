// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {DeployBasicNFT} from "../script/DeployBasicNFT.s.sol";
import {BasicNFT} from "../src/BasicNFT.sol";

contract TestBasicNFT is Test {
    DeployBasicNFT public deployer;
    BasicNFT public basicNFT;
    address public USER = makeAddr("user");
    string public constant PUG_URI =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function setUp() public {
        deployer = new DeployBasicNFT();
        basicNFT = deployer.run();
    }

    function testNameIsCorrect() public view {
        string memory expectedName = "PuppyPals";
        string memory actualName = basicNFT.name();
        assertEq(
            keccak256(abi.encodePacked(expectedName)),
            keccak256(abi.encodePacked(actualName))
        );
    }

    function testCanMintAndHaveABalance() public {
        vm.prank(USER);
        basicNFT.mintNFT(PUG_URI);

        assert(basicNFT.balanceOf(USER) == 1);
    }
}
