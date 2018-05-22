pragma solidity ^0.4.21;

contract company {
    struct certificate { 
        bytes picture;
        mapping (address => bool) isValid;
    }
    
    address Company = 0xffffffffff;
    certificate[] Certificates; 
    
    function addCertificate(bytes pic)  {
        if (msg.sender != Company) {
            return;
        }
        certificate tmp;
        tmp.picture = pic;
        Certificates.push(tmp);
    }
    
    function giveCertificate(uint certificateID, address receiver)  {
        if (msg.sender != Company) {
            return;
        }
        if (certificateID >= Certificates.length) {
            return;
        }
        Certificates[certificateID].isValid[receiver] = true;
    }
}
