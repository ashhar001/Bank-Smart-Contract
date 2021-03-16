pragma solidity ^0.4.17;

contract Bank{

    mapping (address=>uint) private balances;
    mapping (address => bool ) account;
    
    uint public countAccount;

    address public owner;

    modifier restricted(){
        require(msg.sender == owner);
        _;
    }

    function Bank() public{
        owner = msg.sender;
    }

    function enroll() public payable returns (uint){
        
        address user = msg.sender;
        require(!account[user]);
        account[user] = true;
        
        countAccount++;
    
        return user.balance;
    }

    function deposit() public payable returns(uint){
        
        address user = msg.sender;

        require(account[user]);
        require(msg.value > 0);

        balances[user] += msg.value;

        return balances[user];
    }

    function withdraw(uint Wamount) public payable returns(uint remainingBal){
        address user = msg.sender;
        
        
        require(account[user]);
        require(Wamount <= balances[user]);

        balances[user] -= Wamount;

        user.transfer(Wamount);

        return balances[user];
    }

    function transfer(uint amount, address recipient) payable public{

        address user = msg.sender;
        require(account[user]);

        require(amount <= balances[user]);
        
        balances[user] -= amount;

        recipient.transfer(amount);
    }

    function getBalance() public view returns(uint){

        return balances[msg.sender];
    }
    
    function getDetails() public view restricted returns(uint, uint, address){
        
        return(
                this.balance,
                countAccount,
                owner
            );
    }
}