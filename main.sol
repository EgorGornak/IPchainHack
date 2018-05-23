pragma solidity ^0.4.22;

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
    string public studentInfo;
    
    constructor(string _info, address owner) public{
        studentOwner = owner;
        studentInfo = _info;
    }
    
    mapping (address => bool) allowance;
    
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