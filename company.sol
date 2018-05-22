pragma solidity ^0.4.22;

contract company {
    struct certificate { 
        string picture;
        mapping (address => bool) isValid;
    }
                
    address Company = 0xE0f5206BBD039e7b0592d8918820024e2a7437b9;
    certificate[] public Certificates; 
    
    function addCertificate(string pic) public  {
        if (msg.sender != Company) {
            return;
        }
        certificate tmp;
        tmp.picture = pic;
        Certificates.push(tmp);
    }
    
    function giveCertificate(uint certificateID, address receiver) public  {
        if (msg.sender != Company) {
            return;
        }
        if (certificateID >= Certificates.length) {
            return;
        }
        Certificates[certificateID].isValid[receiver] = true;
    }
}
