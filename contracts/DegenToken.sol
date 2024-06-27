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
        string name;
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

    function burn(address burner, uint256 val) public {
        require(balanceOf(burner) >= val, "You don't have enough Degen tokens to burn");
        _burn(burner, val);
    }

    function transferToken(address sender, address _receiver, uint256 val) external {
        require(balanceOf(sender) >= val, "You don't have enough Degen tokens to transfer");
        approve(sender, val);
        _transfer(sender, _receiver, val);
    }

    function redeemToken(address spender, uint256 carId) external payable {
        require(redeemableCars[carId].price <= balanceOf(spender), "Insufficient funds");
        require(balanceOf(spender) >= redeemableCars[carId].price, "You don't have enough Degen tokens to redeem");
        _burn(spender, redeemableCars[carId].price);
        CarsNftCollection[spender][carId] += 1;
        userCollections[spender].push(UserCollection(redeemableCars[carId].name, carId));
    }
   
    function showUserCollection(address user) public view returns (string[] memory) {
        uint256 collectionLength = userCollections[user].length;
        string[] memory userCollectionItems = new string[](collectionLength);
    
        for (uint256 i = 0; i < collectionLength; i++) {
            userCollectionItems[i] = userCollections[user][i].name;
        }
    
        return userCollectionItems;
    }

    // function showStore() public view returns (string[] memory) {
    //     string[] memory storeItems = new string[](8);

    //     for (uint256 i = 1; i <= 8; i++) {
    //         storeItems[i-1] = redeemableCars[i].name;
            
    //     }

    //     return storeItems;
    // }


    function showStore() public pure returns (string memory) {
        string memory storeItems = "1. NFT: Bugatti Chiron\n2. NFT: Lamborghini Aventador\n3. NFT: Ferrari LaFerrari\n4. NFT: Rolls-Royce Phantom\n5. NFT: Aston Martin Valkyrie\n6. NFT: McLaren P1\n7. NFT: Koenigsegg Jesko\n8. NFT: Pagani Huayra";
        return storeItems;
    }
}
