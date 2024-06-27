// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, Ownable {
    struct Store {
        string name;
        uint256 price;
    }
    
    struct UserCollection {
        uint256 id;
    }

    mapping(uint256 => Store) public redeemableCars;
    mapping(address => mapping(uint256 => uint256)) public CarsNftCollection;
    mapping(address => UserCollection[]) public userCollections;

    constructor() ERC20("Degen Token", "DEGEN") {
        redeemableCars[1] = Store("NFT: Bugatti Chiron", 8500);
        redeemableCars[2] = Store("NFT: Lamborghini Aventador", 2000);
        redeemableCars[3] = Store("NFT: Ferrari LaFerrari", 3000);
        redeemableCars[4] = Store("NFT: Rolls-Royce Phantom", 5000);
        redeemableCars[5] = Store("NFT: Aston Martin Valkyrie", 6000);
        redeemableCars[6] = Store("NFT: McLaren P1", 6000);
        redeemableCars[7] = Store("NFT: Koenigsegg Jesko", 7000);
        redeemableCars[8] = Store("NFT: Pagani Huayra", 8000);
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function decimals() public view virtual override returns (uint8) {
        return 1;
    }

    function burn( uint256 val) public {
        require(balanceOf(msg.sender) >= val, "You don't have enough Degen tokens to burn");
        _burn(msg.sender, val);
    }

    function transferToken(address sender, address _receiver, uint256 val) external {
        require(balanceOf(sender) >= val, "You don't have enough Degen tokens to transfer");
        approve(sender, val);
        _transfer(sender, _receiver, val);
    }

    function redeemToken(uint256 carId) external payable {
        require(redeemableCars[carId].price <= balanceOf(msg.sender), "Insufficient funds");
        require(balanceOf(msg.sender) >= redeemableCars[carId].price, "You don't have enough Degen tokens to redeem");
        _burn(msg.sender, redeemableCars[carId].price);
        CarsNftCollection[msg.sender][carId] += 1;
        userCollections[msg.sender].push(UserCollection(carId));
    }
   
    function showUserCollection(address user) public view returns (uint256[] memory) {
        uint256[] memory userCollection = new uint256[](8);

        for (uint256 i = 1; i <= 8; i++) {
            userCollection[i-1] = CarsNftCollection[user][i]; 
        }

        return userCollection;
    }

    // function showStore() public view returns (string[] memory) {
    //     string[] memory storeItems = new string[](8);

    //     for (uint256 i = 1; i <= 8; i++) {
    //         storeItems[i-1] = redeemableCars[i].name;
            
    //     }

    //     return storeItems;
    // }


    function showStore() external pure returns (string memory) {
        return "1. NFT: Bugatti Chiron\n2. NFT: Lamborghini Aventador\n3. NFT: Ferrari LaFerrari\n4. NFT: Rolls-Royce Phantom\n5. NFT: Aston Martin Valkyrie\n6. NFT: McLaren P1\n7. NFT: Koenigsegg Jesko\n8. NFT: Pagani Huayra";
    }
}
