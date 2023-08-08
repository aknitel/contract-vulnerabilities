# Ethereum Smart Contract Vulnerabilities Demonstration

This project demonstrates two vulnerabilities commonly found in Ethereum smart contracts: reentrancy attack and denial of service. The project utilizes the Hardhat framework for development, compilation, and deployment of smart contracts.

## Vulnerabilities

1. **Reentrancy Attack**: Demonstrates the reentrancy attack vulnerability, where a malicious contract can repeatedly call a function of another contract before the first call completes.

2. **Denial of Service**: Demonstrates the denial of service vulnerability, where a malicious contract can block the execution of functions in the target contract.

## Running Tasks

You can use npm commands to run various tasks that showcase vulnerabilities in the contracts.

### Reentrancy Attack

Run the task to demonstrate the reentrancy attack vulnerability using the vulnerable contract:

```shell
npm run reentrancy
```

### Safe from Reentrancy Attack

Run the task to demonstrate the safe contract protected from reentrancy attack:

```shell
npm run non-reentrancy
```

### Denial of Service

Run the task to demonstrate the denial of service vulnerability:

```shell
npm run dos
```

### Safe from Denial of Service

Run the task to demonstrate the safe contract protected from denial of service:

```shell
npm run non-dos
```

## Dependencies

To run this demonstration project, you need to have Node.js and npm installed. You can also install Hardhat globally:

```shell
npm install -g hardhat
```

### Installation and Setup

1. Clone this repository:

    ```shell
    git clone https://github.com/aknitel/contract-vulnerabilities.git
    ```

2. Navigate to the project directory:

    ```shell
    cd demo-solidity-hardhat
    ```

3. Install project dependencies:

    ```shell
    npm install
    ```

## Running the Demonstration

Start a local Ethereum blockchain using Hardhat:

```shell
npx hardhat node
```
Now you can use npm commands to run various tasks and showcase the vulnerabilities in the contracts.

### Notes

- This project is for educational purposes only and should not be used in real-world environments.
- Make sure you understand the risks and implications of using vulnerable contracts before demonstrating them.

### License

This project is licensed under the ISC License.
