pragma solidity ^0.4.22;

//https://solidity.readthedocs.io/en/v0.4.15/contracts.html - check for visibility and geters
//https://solidity.readthedocs.io/en/latest/frequently-asked-questions.html#what-is-the-memory-keyword-what-does-it-do - read entire, easecially about memory

contract Company {
    struct certificate {
        string name;//name of cert
        string picture;//cert
        mapping (address => bool) isValid;//do adress has this cert
    }
    
    address companyAdress;//address of company for this contract
    string info;//company info in any form : name, date of registration etc...
    
     
    constructor(string _info) public{// constructor
        info = _info;
        companyAdress = msg.sender;
    }
            
            
    function changeCompanyAdress() public{//if company changes thier adress 
        if(msg.sender == companyAdress)
            companyAdress = msg.sender;
    }
                
    mapping (string => certificate) certificates;
    
    function addCertificate(string name, string picture) public {
        if (msg.sender != companyAdress) {
            return;
        }
        certificate memory tmp;//????
        tmp.name = name;
        tmp.picture = picture;
        certificates[name] = tmp;
    }
    
    function giveCertificate(string name, address receiver) public  {
        if (msg.sender != companyAdress) {
            return;
        }
        certificates[name].isValid[receiver] = true;
        address dc = receiver;//???
        require(dc.call(bytes4(keccak256("recieveCert(string)")), name));
    }
}
