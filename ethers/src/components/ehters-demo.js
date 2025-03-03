import {ethers} from "ethers";

const aAccount = "0xA5e458041D2D584123a2B55E2F8283a8b330cDB3";
const aAccountSecret = "0xabd43d861f85a8464aebb7db22043a978ce204f4bc0b2c1c34ebad846eb31ee9";
const bAccount = "0x7E918caEA9741df0650B408C26315416CDaeE3A5";
const contractAddress = "0x7C56a6d90B61C4510DfB0F277Aff512bF34424E9";

async function main() {
    // -------- 区块高度 ---------
    const provider = new ethers.JsonRpcProvider("HTTP://127.0.0.1:8545");
    const blockNumber = await provider.getBlockNumber();
    console.log(`Current block number: ${blockNumber}`);
    // -------- 区块高度 ---------

    // -------- Ethers.eth ---------
    // 0x0C1183d1A3c910Fa819333390ec73fDfE8b209F5 账户的余额
    let balance = await provider.getBalance(aAccount)
    console.log(`Ethers.eth balance: ${ethers.formatEther(balance)} ETH`);
    // 1 ETH = 1000000000000000000 wei
    let ethWei = ethers.parseEther("1");
    console.log(`1 ETH = ${ethWei} wei`);
    // 1 gwei = 1000000000 wei
    let gwei = ethers.parseUnits("1", "gwei");
    console.log(`1 gwei = ${gwei} wei`);
    // wei 转换为 ETH
    let weiEth = ethers.formatEther(ethWei);
    console.log(`${ethWei} wei = ${weiEth} ETH`);
    // wei 转换为 gwei
    let weiGwei = ethers.formatUnits(gwei, "gwei");
    console.log(`${gwei} wei = ${weiGwei} gwei`);
    // -------- Ethers.eth ---------

    // --------- 发送交易 ---------
    // let signer = new ethers.Wallet(aAccountSecret, provider);
    // let tx = await signer.sendTransaction({
    //     to: bAccount,
    //     value: ethers.parseEther("1.0")
    // });
    // let receipt = await tx.wait();
    // console.log(`Transaction ${tx.hash} mined. Block number: ${receipt.blockNumber}`);
    //
    // let signer2 = new ethers.Wallet(bAccountSecret, provider);
    // let tx2 = await signer2.sendTransaction({
    //     to: aAccount,
    //     value: ethers.parseEther("1.0")
    // })
    // let receipt2 = await tx2.wait();
    // console.log(`Transaction ${tx2.hash} mined. Block number: ${receipt2.blockNumber}`);
    // --------- 发送交易 ---------

    // --------- 智能合约 ---------
    const abi = [
        "event Transfer(address indexed from, address indexed to, uint256 value)",
        "function mint(address account, uint256 value)",
        "function name() public view returns (string)",
        "function symbol() public view returns (string)",
        "function decimals() public view returns (uint8)",
        "function totalSupply() public view returns (uint256)",
        "function balanceOf(address account) public view returns (uint256)",
        "function transfer(address to, uint256 amount) public returns (bool)",
        "function allowance(address owner, address spender) public view returns (uint256)",
        "function approve(address spender, uint256 amount) public returns (bool)",
        "function transferFrom(address from, address to, uint256 amount) public returns (bool)",
        "event Transfer(address indexed from, address indexed to, uint256 value)",
        "event Approval(address indexed owner, address indexed spender, uint256 value)"
    ];
    let signer = new ethers.Wallet(aAccountSecret, provider);

    // 获取当前 nonce
    const currentNonce = await provider.getTransactionCount(aAccount, "latest");
    console.log(`Current nonce: ${currentNonce}`);

    const contract = new ethers.Contract(contractAddress, abi, signer);
    console.log(`Contract name: ${await contract.name()}`);

    // 发送 mint 交易（指定 nonce）
    const txMint = await contract.mint(aAccount, ethers.parseEther("1.0"), {
        nonce: currentNonce
    });
    console.log(`Mint transaction hash: ${txMint.hash}`);
    await txMint.wait();
    console.log("Mint transaction confirmed");

    // --------- Listening to Events ---------
    const contract2 = new ethers.Contract(contractAddress, abi, provider);
    contract2.on("Transfer", (from, to, value, event) => {
        console.log(`Transfer1 event emitted: from ${from} to ${to} value ${value}`);
        // Optionally, stop listening
        event.removeListener();
    });

    // Same as above
    let filter = contract.filters.Transfer();
    contract2.on(filter, (from, to, value, event) => {
        console.log(`Transfer2 event emitted: from ${from} to ${to} value ${value}`);
        // Optionally, stop listening
        event.removeListener();
    })

    // Listen for any Transfer to "ethers.eth"
    let filter2 = contract2.filters.Transfer(aAccount)
    contract2.on(filter2, (from, to, value, event) => {
        // `to` will always be equal to the address of "bAccount"
        console.log(`Transfer3 event emitted: from ${from} to ${to} value ${value}`);
        // Optionally, stop listening
        event.removeListener();
    });

    // Listen for any event, whether it is present in the ABI
    // or not. Since unknown events can be picked up, the
    // parameters are not destructed.
    contract2.on("*", (event) => {
        // The `event.log` has the entire EventLog
        console.log(`Event emitted: ${event.event}`);
    });

    // --------- Listening to Events ---------

    // transfer
    // 发送 transfer 交易（指定 nonce + 1）
    let amount = ethers.parseUnits("1.0", 18);
    const txTransfer = await contract.transfer(bAccount, amount, {
        nonce: currentNonce + 1
    });
    console.log(`Transfer transaction hash: ${txTransfer.hash}`);
    await txTransfer.wait();
    console.log("Transfer transaction confirmed");

    // 检查余额
    const balanceOfA = await contract.balanceOf(aAccount);
    console.log(`A Account balance: ${ethers.formatEther(balanceOfA)}`);

    const balanceOfB = await contract.balanceOf(bAccount);
    console.log(`B Account balance: ${ethers.formatEther(balanceOfB)}`);

}

main()