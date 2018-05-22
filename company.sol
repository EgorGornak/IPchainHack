pragma solidity ^0.4.22;

contract company {
    struct certificate {
        string name;
        string picture;
        mapping (address => bool) isValid;
    }
                
    address Company = 0xE0f5206BBD039e7b0592d8918820024e2a7437b9; // for example
    mapping (string => certificate) Certificates;
    
    function addCertificate(string pic, string name) public  {
        if (msg.sender != Company) {
            return;
        }
        certificate tmp;
        tmp.name = name;
        tmp.picture = pic;
        Certificates[name] = tmp;
    }
    
    function giveCertificate(string name, address receiver) public  {
        if (msg.sender != Company) {
            return;
        }
        Certificates[name].isValid[receiver] = true;
        address dc = receiver;
        require(dc.call(bytes4(keccak256("recieveCert(string)")), name));
    }
}
