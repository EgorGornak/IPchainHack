pragma solidity ^0.4.22;

import "./company.sol";
import "./student.sol";

contract Main{
    address owner;
    mapping (address => address)ownership;
    
    constructor() public {
        owner = msg.sender;
    }
    
    function addStudent() public {
        
    }
    
    function addCompany() public {
        
    }
    
    function createStudent(){
        
    }
    
    function createCompany(){
        
    }
    
    function allow(){
        
    }
    
    function prohibit(){
        
    }
    
    function addCertificate(){
        
    }
    
    function giveCertificate(){
        
    }
    
    function changeStudentOwnership(){
        
    }
    
    function changeCompanyOwnership(){
        
    }
}