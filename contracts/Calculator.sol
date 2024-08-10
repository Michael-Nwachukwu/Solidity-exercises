// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

// Creating a calculator app 
// Make a contract called calculator 
// Create result variable to store result
// create a function to get result
// Deploy

contract Calculator {
    uint256 public result = 0;

    function add(uint256 num) internal {
        result += num;
    }

    function subtract(uint256 num) public {
        result -= num;
    }

    function multiply(uint256 num) public {
        result *= num;
    }

    function get() public view returns(uint256){
        return result;
    }
}