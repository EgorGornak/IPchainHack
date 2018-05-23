pragma solidity ^0.4.22;

import "./company.sol";
import "./student.sol";

contract Main{
    
    address owner;
    mapping (address => address) studentOwnership;
    mapping (address => address) companyOwnership;
    
    constructor() public {
        owner = msg.sender;
    }
    
    
    
    function addStudent(string studentInfo) public payable {
        //equals 1 ether
        if(msg.value != 100500 wei)revert();
        owner.transfer(100500 wei);
        //place event for creating new instance
    }
    
    function addCompany(string companyInfo) public payable {
        //equals 1 ether
        if(msg.value != 100500 wei)revert();
        owner.transfer(100500 wei);
        //place event for creating new instance
    }
    
    function createStudent(address student, address original) public {
        if(msg.sender != owner)
            return;
        studentOwnership[student] = original;
        //place event that his instance ready
    }
    
    function createCompany(address company, address original) public {
        if(msg.sender != owner)
            return;
        companyOwnership[company] = original;
        //place event that his instance ready
    }
    
    function allow(address company) public {
        if(studentOwnership[msg.sender] == 0)
            return;
        Student tmp = Student(studentOwnership[msg.sender]);
        tmp.allow(company);
    }
    
    function prohibit(address company) public {
        if(studentOwnership[msg.sender] == 0)
            return;
        Student tmp = Student(studentOwnership[msg.sender]);
        tmp.prohibit(company);
    }
    
    function addCertificate(string name, string picture) public {
        if(companyOwnership[msg.sender] == 0)
            return;
        Company tmp = Company(companyOwnership[msg.sender]);
        tmp.addCertificate(name, picture);
    }
    
    function giveCertificate(string name, address receiver) public{
        if(companyOwnership[msg.sender] == 0)
            return;
        Company tmp = Company(companyOwnership[msg.sender]);
        tmp.giveCertificate(name, receiver);
    }
    
    function changeStudentOwnership(address newOwner) public{
        if(studentOwnership[msg.sender] == 0)
            return;
        studentOwnership[msg.sender] = newOwner;
    }
    
    function changeCompanyOwnership(address newOwner) public{
        if(companyOwnership[msg.sender] == 0)
            return;
        companyOwnership[msg.sender] = newOwner;
    }
}