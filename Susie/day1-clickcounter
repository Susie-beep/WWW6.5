// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
contract ClickCounter {
    uint256 public counter;
    function click() public {
        counter++;
    }
     //计数器重置为0
    function reset() public {
        counter=0;
    }
    
    //计数器减1
    function decrease() public {
        require(counter>0, "Counter is already at 0");
        counter--;
    }

    //返回当前计数
    function getCounter() public view returns (uint256) {
        return counter;
    }
    //一次增加多次
    function clickMultiple(uint256 times) public {
        counter += times;
    }

}

