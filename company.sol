pragma solidity ^0.4.22;

//https://solidity.readthedocs.io/en/v0.4.15/contracts.html - check for visibility and geters

//https://medium.com/coinmonks/storage-vs-memory-in-solidity-8251847186fd - easy way for understanding memory

//https://www.bitdegree.org/learn/solidity-importing/ - about imports easy

import "./student.sol";

contract Company {
    struct certificate {
        string name;
        string picture;
        mapping (address => bool) isValid;
    }
    
    address companyOwner;
    string public companyInfo;
    
     
    constructor(string _info, address owner) public{
        companyInfo = _info;
        companyOwner = owner;
    }
                
    mapping (string => certificate) certificates;
    
    function addCertificate(string name, string picture) public {
        if (msg.sender != companyOwner) {
            return;
        }
        certificate memory tmp;
        tmp.name = name;
        tmp.picture = picture;
        certificates[name] = tmp;
    }
    
    function giveCertificate(string name, address receiver) public  {
        if (msg.sender != companyOwner) {
            return;
        }
        Student dc = Student(receiver);
        dc.recieveCertificate(name);
        certificates[name].isValid[receiver] = true;
    }
}
