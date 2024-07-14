# Project Title: Degen Token

A Smart Contract for Degen Token (custom ERC 20 Token) deployed on Fuji Network. It has Features like mint, burn , transfer token, Redeem token for NFTs, check token Balance.

## Description

The Contract DegenTokens.sol has custom Token Degen Token with Symbol "DEGEN". Along with the token, the contract also has a market place of Car NFTs collection along with their price. Which can be acquired by any user by redeeming their token.

* Car nft Marketplace along with their price:

```shell
    1. NFT: Bugatti Chiron, price: 8500
    2. NFT: Lamborghini Aventador, price: 2000
    3. NFT: Ferrari LaFerrari, price: 3000
    4. NFT: Rolls-Royce Phantom, price: 5000
    5. NFT: Aston Martin Valkyrie, price: 6000
    6. NFT: McLaren P1, price: 6000
    7. NFT: Koenigsegg Jesko, price: 7000
    8. NFT: Pagani Huayra, price: 8000
```

* functions available to interact with contract:
    * mint() function: Only owner of the contract can mint the function to any address.

    ```shell
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
    ```

    * burn() function: any user can burn their token using this function, if their token balance > amount to be burnt

    ```shell
    function burn( uint256 val) public {
        require(balanceOf(msg.sender) >= val, "You don't have enough Degen tokens to burn");
        _burn(msg.sender, val);
    }
    ```

    * transferToken() function: It allows user to transfer their token to another user/address on the chain, can be done by any user on the network. The function automatically approves sender the amount of val to be transfered. 

    ```shell
    function transferToken(address sender, address _receiver, uint256 val) external {
        require(balanceOf(sender) >= val, "You don't have enough Degen tokens to transfer");
        approve(sender, val);
        _transfer(sender, _receiver, val);
    }
    ```

    * redeemToken() function: It allows user to redeem their tokens for any nft from the marketplace. it takes one parameter that the index of nft msg.sender wants to buy and check if token balance is enough. If so, that nft is added to the user's collection and can be viewed by calling showUserCollection() function.

    ```shell
    function redeemToken(uint256 carId) external payable {
        require(redeemableCars[carId].price <= balanceOf(msg.sender), "Insufficient funds");
        require(balanceOf(msg.sender) >= redeemableCars[carId].price, "You don't have enough Degen tokens to redeem");
        _burn(msg.sender, redeemableCars[carId].price);
        CarsNftCollection[msg.sender][carId] += 1;
        userCollections[msg.sender].push(UserCollection(carId));
    }
    ```

    * showUserCollection() function takes only one parameter that is the address and return an array demonstrating the nfs bought and their quantity by that address.

    ```shell
    function showUserCollection(address user) public view returns (uint256[] memory) {
        uint256[] memory userCollection = new uint256[](8);

        for (uint256 i = 1; i <= 8; i++) {
            userCollection[i-1] = CarsNftCollection[user][i]; 
        }

        return userCollection;
    }

    ```

### Installing

* User can fork this repository and the clone it to there local system. 
* User is required to install Node.js prior before executing the program.


### Executing program

1. After cloning the Repository, open first terminal and enter the commands: 

```shell
npm i
```
```shell
npm install @openzeppelin/contracts
```
```shell
npm install dotenv
```
```shell
npm install --save-dev hardhat
```

2. create a ".env " file in root directory and write the following in this:
```shell
WALLET_PRIVATE_KEY= your_metamask_private_key
```
Note: replace your_metamask_private_key with the private key of the metamask account which is on fuji network.

3. Now open second terminal and enter the following commands to start the hardhat node::

```shell
npx hardhat node
```

4. Finally in the third terminal, deploy the contract on fuji Network, using the following command:

```shell
npx hardhat run scripts/deploy.js --network fuji
```
This will deploy the contract on fuji successfully.

6. To run it on remix IDE install the following dependency:

```shell
npm install -g @remix-project/remixd
```

7. now type the following command:

```shell
remixd -s "shared folder path" -u https://remix.ethereum.org/
```
Note: replace the shared folder path with the root path of the project.

## Help

* To Understand the Hardhat commands on can use this command in terminal:
```
npx hardhat help
```
* To understand about avalance go the the docs section by visiting: https://docs.avax.network/


## Authors

* Name: Vibhansh Alok
* MetacrafterID: RuffledZest (vibhanshalok@gmail.com)
* Loom Video Link 2nd Attempt (Code walkthrough and Explaination): https://www.loom.com/share/39a4a9dee2c74e079f9ab17336907c40
* Loom Video Link 1st Attempt (demonstration): https://www.loom.com/share/51bd233693874ddfa20884efb1bb4d84
* Contract Address: 0xEF8c17796c3E761E29A2202852c234F4AFed96c1

## License

This project is licensed under the MIT License - see the LICENSE.md file for details.