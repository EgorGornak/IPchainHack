pragma solidity ^0.4.22;

import "./company.sol";

contract Student{
    
    struct pair{
        address companyAddress;
        string cerificateName;
    }
    
    struct vector{
        uint size;
        mapping (uint => pair) arr;
    }
    
    vector certificates;
    
    address studentOwner;
    
    constructor() public{
        studentOwner = msg.sender;
    }
    
    mapping (address => bool) allowance;//we need this to verify if the recieveCertificate caller can assign us a new certificate
    
    function allow(address company) public{
        if(msg.sender != studentOwner)
            return;
        allowance[company] = true;
    }

    function prohibit(address company) public{
        if(msg.sender != studentOwner)
            return;
        allowance[company] = false;
    }
    
    
    function recieveCertificate(string cerificateName) public{
        if(allowance[msg.sender] == false)
            return;
        pair memory tmp;
        tmp.companyAddress = msg.sender;
        tmp.cerificateName = cerificateName;
        certificates.arr[certificates.size] = tmp;
        certificates.size += 1;
        allowance[msg.sender] = false;
    }
    
}