// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PollStation {
    string [] public candidateNames;
    mapping(string => uint256) voteCount;
    mapping(string => bool) isCandidate;
    mapping(address=> bool) hasVoted;
    //添加候选人，最好限制长度控制gas
    function addCandidateNames(string memory _candidateNames) public {
        //空字符串检查
        require(bytes(_candidateNames).length>0, unicode"候选人名不能为空");
        //检查是否只有空格，不想写了，用户怎么这么刁钻
        //检查是否重复
        require(!isCandidate[_candidateNames], unicode"候选人已存在");
        candidateNames.push(_candidateNames);
        voteCount[_candidateNames] =0;
        isCandidate[_candidateNames] = true;
        
    }
    //检索候选人列表
    function getcandidateNames() public view returns (string[] memory) {
        return candidateNames;
    }
    //为候选人投票，校验候选人存在才能投票，好浪费gas不如不校验
    function vote(string memory _candidateNames) public {
        bool exists = false;
        for (uint i = 0; i < candidateNames.length; i++){
            if (keccak256(bytes(candidateNames[i]))==keccak256(bytes(_candidateNames))){
                exists = true;
                break;
            }
        }
        require(exists, "Candidate does not exist!");
        //防止多次投票
        require(!hasVoted[msg.sender],"you have already voted");
        voteCount[_candidateNames]+=1;
        hasVoted[msg.sender] = true;
    }
    //检查候选人票数
    function getVote(string memory _candidateNames) public view returns(uint256) {
        return voteCount[_candidateNames];
    }

}
