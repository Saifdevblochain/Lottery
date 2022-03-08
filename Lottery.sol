    //SPDX-License-Identifier: UNLICENSED
    pragma solidity >=0.5.0 < 0.9.0;
    contract Lottery{
    address public manager;
    address payable[] public players;
    constructor(){
        manager=msg.sender;
    }
    function alreadyentered() public view returns(bool){
        for (uint i=0; i< players.length;i++){
            if(players[i]==msg.sender)
                return true;
        }
        return false;
    }
    function enter() public payable{
        require (msg.sender!=manager,"You cannot enter");
        require (alreadyentered() == false,"You Already Entered");
        require (msg.value>=1 ether,"Min amount is 1 Eth");

    }
    function random() public view returns(uint){
       return uint(sha256(abi.encodePacked(block.difficulty,block.number,players)));
    }

    function pickwinner()public payable {
        require (msg.sender==manager,"You are not manager");
        uint x= random()%players.length;
        address contractaddress= address(this);
        players[x].transfer(contractaddress.balance);
        players=new address payable[](0);

    }


    }
