// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract MyContract {
    // public type used to set the visibility of the declared variable in the blockchain system
    string private name = "My String"; //string
    bool public boolean1 = true; // boolean
    uint public myUint = 4; //unsigned integer
    int public myInt = 1; //integer
    address public myAddress = 0x1AD5804aC9368657A0D3dD62adE9FddB725F8766; // My ETH address

    // functions
    // write function
    function setName (string memory _myString) public {
        name = _myString;
    }

    // read function
    function getName() public view returns (string memory) {
        return name;
    }

    function resetName () internal {
        name = "My String";
    }

    // visibility
    string name1 = "myString1"; // no visibility
    string private name2 = "myString2"; // private visibility so only accessible in the smart contract
    string internal name3 = "myString3"; // internal visibility so only accesible in the smart contract and can be inherited
    string public name4 = "myString4"; // public visibility so can be accessed inside outside and can be inherited

    // function calling
    int count = 1;
    function increment1 () public { // can be called inside outside the smart contract and by another function
        count = count + 1;
    }

    function increment2 () public { // can be called inside outside the smart contract and accessible to others smart contracts and others functions
        increment1();
    }

    function increment3() private { // can be called by another function but only in the smart contract
        count = count + 1;
    }

    function increment4 () public { // accessible inside outside the smart contract and can access to the private function called in the same smart contract than the current function
        increment3();
    }

    function increment5() external { // can be only called outside the current smart contract
        count = count + 1;
    }

    function increment6() internal { // can be only called in the current smart contract
        count = count + 1;
    }

    function increment7() public { // can call the function increment6
        increment6();
    }

    // modifiers
    function getName1() public view returns (string memory) { // view built-in modifier cannot modify the state of the blockchain but can read it - Ex values, variables ...
        return name;
    }

    function add(uint a, uint b) public pure returns (uint) { // pure built-in modifier cannot modify and cannot read the blockchain (values, variables, ...)
        return a + b;
    }

    function pay() public payable { // payable built-in modifier can modify and can read the blockchain so allowed to receive ether cryptocurrency when a transaction is
        uint256 balance = msg.value;
    }

    // custom modifiers
    modifier onlyOwner { // this modifier require that the caller of the function is the owner of the contract
        address owner = myAddress;
        require(msg.sender == owner, 'caller must be owner');
        _;
    }
    function setName(string memory _name) onlyOwner public {
        name = _name;
    }

    // constructors
    constructor(string memory _name) { // constructor is a function that runs once and only once when the contract is initialized on the blockchain, it can take functions, variables or other smart contracts as parameters, can be made payable, send ether and pratically all roles but can be called only once
        name = _name;
    }

    // Global variables
    constructor() {
        address contractAddress = address(this);
    }

    function pay() public payable {
        string payer = msg.sender; // msg = message/text
        address origin = tx.origin; // tx = transaction/blockchain
        uint amount = msg.value;
    }

    function getBlockInfo() public view returns (uint, uint, uint) {
        return(block.number, block.timestamp, block.chainid); // block = block informations during transactions in the blockchain
    }

    // operators
    // + for add
    // - for sub
    // * for mul
    // / for div
    // ** for exp
    // % for mod
    // ++ for increment
    // -- for decrement

    // Inequalities
    // == for eq
    // != for dif
    // > for gt
    // >= for gOrEq
    // <
    // <=

    // Logical Operators
    // && for and
    // || for or
    // ! for not

    // Conditionals
    function evenOrOdd(uint x) public pure returns (string memory) {
        if (x % 2 == 0)
        return "even";
            else return "odd";
        // another way
        return (x % 2 == 0)? "even" : "odd";
    }

    // Arrays
    uint[] public array = [1, 2, 3];// uint for numbers and arrays - [] to declare the type of variables inside an array
    uint[10] public array2;
    string[] public array3 = ["one", "two"];// array for strings and arrays
    address[] public array4 = [0x1AD5804aC9368657A0D3dD62adE9FddB725F8766, 0xaeFFaDaFf4Cb8cE96efCaaf5ccac6Ab5BEAE18];
    string[] public arrayOfString = ["one", "two"];// Arrays of strings and arraysuint[] public myNumbers = new uint[] (10);// declaring an empty array with the variable length of numbers
    
    function get(uint i) public view returns (uint/*or address or anything depending on the type of the stored values*/) {
        return array[i];
    }
    function length(string memory _array) internal view returns (uint) { 
        return array.length;
    }
    function push(uint i) public {
        array.push(i); // add i to the end of the array
    }
    function pop() public {
        array.pop(); // remove the last element of the array
    }
    function remove(uint i) public {
        delete array[i]; // remove an indexed value of the array
    }

    // Mappings
    mapping (uint => string) public names;
    mapping (uint => address) public addresses;
    mapping (address => uint) private balances;
    mapping (address => bool) public hasVoted;
    mapping (address => mapping (uint => bool)) public myMapping;

    function get(uint _id) public view returns (string memory) {
        return names[_id]; // return the value at index i in arraynames[]
    }
    function set(uint _index, string memory _value) public {
        names[_index] = _value;// Set a new value for an existing key. If key does not exist, it creates a new key/value pair.
    } 
    function remove(uint _index) public {
        delete names[_index];
    }

    // Structs
    struct User{
        string name;
        address addr;
        bool listCompleted;
    }
    // Array of users
    User[] public users;
    function add (string memory _name, address _addr, bool _listCompleted) public {
        users.push(User(_name, _addr, _listCompleted));
    }
    function get (uint _id) public view returns (string memory _name, address addr, bool listCompleted) {
        User storage u = users[_id];
        return (u.name, u.addr, u.listCompleted);
    }
    // Update completed
    function complete (uint _id) public {
        User storage u = users[_id]; 
        u.listCompleted = true;
    }

    // Events
    event MessageUpdated (
        address indexed _user,
        string message// events are just like functions but they only execute if they are called in the blockchain
    );// events are not called during transactions but they will be executed at the end of a transaction
    function updateMessage(address _user) public {  // a function that will be called when a message is sent to this contract
        users[_user].listCompleted = true; // set the listCompleted to true for the user address in the array users at the end of the transaction
        emit MessageUpdated(msg.sender, "Hey, I'm Updated");   // trigger an event and pass the value of the _message variable as parameter
    }

    // Ether
    uint public value1 = 1 wei;
    uint public value2 = 1;
    uint public value3 = 1 gwei;
    uint public value4 = 1000000000;
    uint public value5 = 1 ether;
    uint public value6 = 1000000000000000000;

    // payment functions
    receive() external payable { }
    fallback() external payable {
        count ++;
    }
    function checkBalance() public view returns (uint) {
        return address(this).balance;// This is not a good way to get the Ethereum address of this contract, use msg.sender instead
    }
    function transfer (address payable _to) public payable {
        (bool sent, ) = _to.call{value : msg.value}("");
        require(sent, "Transfer Failed !");
    }

    // Errors
    event ErrorEvent (string message);

    function ex1(uint _value) public {
        require (_value > 10, "value must be greater than 10"); // require to check if a condition is met or not. If met, the function will pursue its execution, else it will throw the error message and stop its execution.
        emit ErrorEvent("success");
    }
    function ex2(uint _value) public {
        if (_value < 10) {
            revert ("value must be greater than 10"); // revert to throw a error if the condition is not met
        }
        emit ErrorEvent("success");
    }
}

    // Inheritance
contract Ownable {
    address owner;
    constructor () {
        owner = msg.sender;
    }
    modifier onlyOwner() {
        require(msg.sender == owner, 'caller must be owner');
        _;
    }
}

contract MyInheritedContract is Ownable { // inheritance - this contract can be inherited by other contracts
    string public name = "Gregoire";

    function setName(string memory _name) public onlyOwner {
        name = _name;
    }
}

// Calling others contracts
contract MyCalledContract {
    string private secret;

    constructor (string memory _secret) external { // make the contract call another contract and pass its address as parameter for the other contract to use its functions
        secret = _secret; 
    }// this is how to call a contract, it will return the value of the variable in the current smart contract when calling the other one on the blockchain
    
    function getSecret() external view returns (string memory) { // read the variable secret from another contract with its address as parameter and make the current contract use those variables. It will call the getter function from that contract 
        return secret;
    }

    function setSecret(string memory _secret) external { // to change a variable of another contract, it must be changed in its contract and then be passed as parameter on this one. It will call the setter function from that contract 
        secret = _secret;        
    }
}

contract MyCallingContract {
    MyCalledContract public myCalledContract;

    constructor (MyCalledContract _myCalledContract) {
        myCalledContract = _myCalledContract; // use the contract from another smart contract as parameter and use those functions that are declared on this one for the current one 
    }// constructor is called when a new instance of the object is created with this smart contract in the blockchain. It will use the MyCalledContract address on the blockchain to create an instance, which will then be used by the current contracts and functions that are declared inside it
    function getSecret() external view returns (string memory) { // read a variable from another smart contract with its address as parameter. It will use the setter function of this one to get these variables 
        return myCalledContract.getSecret();        
    }
    function setSecret(string memory _secret) external {
        myCalledContract.setSecret(_secret);// use the contract from another smart contract as parameter and use those functions that are declared on this one for the current one
    }
}

// Interfaces
interface IERC20 {
    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    )
    external returns (bool success);
}

contract MyTransferContract {
    function deposit (address _tokenAddress, uint _amount) public {
        IERC20(_tokenAddress).transferFrom(msg.sender, address(this), _amount);
    }
}