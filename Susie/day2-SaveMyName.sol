// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract SaveMyName {
    string name = "";
    string bio = "";
    uint8 age=0;
    string job = "";

    function add(string memory _name, string memory _bio, uint8 _age, string memory _job) public {
        name =_name;
        bio = _bio;
        age = _age;
        job = _job;
    }
    function retrieve() public view returns (string memory, string memory, uint8, string memory) {
        return (name, bio, age, job);
    }
}
