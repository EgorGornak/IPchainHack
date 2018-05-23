pragma solidity ^0.4.22;

//https://solidity.readthedocs.io/en/v0.4.15/contracts.html - check for visibility and geters

//https://medium.com/coinmonks/storage-vs-memory-in-solidity-8251847186fd - easy way for understanding memory

//https://www.bitdegree.org/learn/solidity-importing/ - about imports easy

import "./student.sol";

contract Company {
    struct certificate {
        string name;//name of cert
        string picture;//cert
        mapping (address => bool) isValid;//do adress has this cert
    }
    
    address companyOwner;//address of company for this contract
    string public info;//company info in any form : name, date of registration etc...
    
     
    constructor(string _info) public{// constructor
        info = _info;
        companyOwner = msg.sender;
    }
            
            
    function changeCompanyAdress(address newOwner) public{//if company changes thier adress 
        if(msg.sender == companyOwner)
            companyOwner = newOwner;
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
