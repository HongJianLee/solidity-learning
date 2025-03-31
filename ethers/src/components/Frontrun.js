// 抢跑
import {ethers} from "ethers";

// 1. 创建provider
const provider = new ethers.WebSocketProvider("ws://127.0.0.1:8545");
await provider.getNetwork().then(res => console.log(`[${(new Date).toLocaleTimeString()}] 连接到 chain ID ${res.chainId}`));

// 2. 创建interface对象，用于解码交易详情。
const iface = new ethers.Interface([
    "function mint() external",
])

// 3. 创建钱包，用于发送抢跑交易
const privateKey = '0xafda4461a7ba8aa6091d4673fb017e3406bdfda02590eda6a2fb4df4fbfaf2c7'
const wallet = new ethers.Wallet(privateKey, provider)

// 动态获取Gas费用
const getAdjustedGasFees = async (tx) => {
    const feeData = await provider.getFeeData();
    const maxPriorityFeePerGas = feeData.maxPriorityFeePerGas * BigInt(12) / BigInt(10); // 增加20%
    const maxFeePerGas = feeData.maxFeePerGas * BigInt(12) / BigInt(10); // 增加20%
    console.log(`maxPriorityFeePerGas: ${maxPriorityFeePerGas}, maxFeePerGas: ${maxFeePerGas}`)
    return {
        maxPriorityFeePerGas: maxPriorityFeePerGas < maxFeePerGas ? maxPriorityFeePerGas : maxFeePerGas,
        maxFeePerGas,
    };
};

const main = async () => {
    // 4. 监听pending的mint交易，获取交易详情，然后解码。
    console.log("监听pending交易，获取txHash，并输出交易详情。")
    provider.on("pending", async (txHash) => {
        if (txHash) {
            // 获取tx详情
            let tx = await provider.getTransaction(txHash);
            if (tx) {
                // filter pendingTx.data
                if (tx.data.indexOf(iface.getFunction("mint").selector) !== -1 && tx.from !== wallet.address) {
                    // 打印txHash
                    console.log(`\n[${(new Date).toLocaleTimeString()}] 监听Pending交易: ${txHash} \r`);

                    // 打印解码的交易详情
                    let parsedTx = iface.parseTransaction(tx)
                    console.log("pending交易详情解码：")
                    console.log(parsedTx);
                    // Input data解码
                    console.log("raw transaction")
                    console.log(tx);
                    // 获取调整后的Gas费用
                    const { maxPriorityFeePerGas, maxFeePerGas } = await getAdjustedGasFees(tx);


                    // 构建抢跑tx
                    const txFrontrun = {
                        to: tx.to,
                        value: tx.value,
                        maxPriorityFeePerGas,
                        maxFeePerGas,
                        gasLimit: tx.gasLimit * BigInt(2),
                        data: tx.data
                    }
                    // 发送抢跑交易
                    var txResponse = await wallet.sendTransaction(txFrontrun)
                    console.log(`正在frontrun交易`)
                    await txResponse.wait()
                    console.log(`frontrun 交易成功`)
                }
            }
        }
    });

    // provider.on("error", async () => {
    //     console.log(`Unable to connect to ${ep.subdomain} retrying in 3s...`);
    //     setTimeout(init, 3000);
    // });
    //
    // provider.on("close", async (code) => {
    //     console.log(
    //         `Connection lost with code ${code}! Attempting reconnect in 3s...`
    //     );
    //     provider._websocket.terminate();
    //     setTimeout(init, 3000);
    // });
};

main()