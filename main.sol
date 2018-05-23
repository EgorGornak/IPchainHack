pragma solidity ^0.4.22;

contract Main{
    struct Company{
        uint INN;
        string [] links;
    }

    struct pair{
        address companyAdress;
        uint linkId;
    }

    struct Client{
        uint INN;
        mapping (address => bool) allowance;
        pair[] arr;
    }
    
    Client [] clients;
    Company [] companies;
    address owner;
    
    constructor() public{
        Client tmp;
        Company tmp2;
        clients.push(tmp);
        companies.push(tmp2);
        owner = msg.sender;
        
    }
    
    mapping(address => uint) clientsInd;
    mapping(address => uint) companiesInd;
    
    function allow(address company) public{
        uint companyInd = companiesInd[company];
        uint clientInd = clientsInd[msg.sender];
        if(companyInd == 0 || clientInd == 0)
            return;
        clients[clientInd].allowance[msg.sender] = true;
    }
    
    function prohibit(address company) public{
        uint companyInd = companiesInd[company];
        uint clientInd = clientsInd[msg.sender];
        if(companyInd == 0 || clientInd == 0)
            return;
        clients[clientInd].allowance[msg.sender] = false;
    }
    
    function createCompany(uint INN) public payable{
        if(msg.value != 1500000 wei)
            revert();
        if(companiesInd[msg.sender] != 0)
            revert();
        Company tmp;
        tmp.INN = INN;
        companiesInd[msg.sender] =companies.push(tmp); 
    }
    
    function createClient(uint INN) public payable{
        if(msg.value != 1500000 wei || clientsInd[msg.sender] != 0) revert();
        Client tmp;
        tmp.INN = INN;
        clientsInd[msg.sender] = clients.push(tmp);
    }
    

    function addCeritiface(string link) public{
        uint ind = companiesInd[msg.sender];
        if(ind == 0)
            revert();
        companies[ind].links.push(link);
    }
    
    function giveCertificate(address receiver, uint linkId) public{
        uint receiverInd = clientsInd[receiver];
        uint companyInd = companiesInd[msg.sender];
        if(receiverInd == 0 || companyInd == 0)
            revert();
        if(clients[receiverInd].allowance[msg.sender] == false)
        revert();
        pair tmp;
        tmp.companyAdress = msg.sender;
        tmp.linkId = linkId;
        clients[receiverInd].arr.push(tmp);
    }
}