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
        pair[] arr;
        mapping (address => bool) allowance;
        uint INN;
    }
    
    Company [] companies;
    address owner;
    Client [] clients;
        Client tmp2;
        Company tmp1;
   
    constructor() public{
        owner = msg.sender;
    }
    
    function FIRST() public{
        clients.push(tmp2);
        companies.push(tmp1);
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
    
    function createCompany(uint INN) public{
        if(companiesInd[msg.sender] != 0)
            revert();
        tmp1.INN = INN;
        Company memory buffer = tmp1;
        companiesInd[msg.sender] =companies.push(buffer) - 1; 
    }
    
    function createClient(uint INN) public{
        if(clientsInd[msg.sender] != 0)
            revert();
        tmp2.INN = INN;
        Client memory buffer = tmp2;
        clientsInd[msg.sender] = clients.push(tmp2) -1 ;
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
