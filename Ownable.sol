
contract Ownable{
    
    address owner;

    modifier onlyOwner {
        require(msg.sender == owner, "You are not the owner");
        _;
    }

    constructor () {
        owner = msg.sender;
    }
}
