const Create2Factory = artifacts.require("Create2Factory");
const MyContract = artifacts.require("MyContract");

module.exports = async function (deployer, network, accounts) {
    const deployerAddress = "0xA5e458041D2D584123a2B55E2F8283a8b330cDB3";

    await deployer.deploy(Create2Factory);
    const factory = await Create2Factory.deployed();

    // 目标合约的字节码 + 构造函数参数
    const encodedArgs = web3.eth.abi.encodeParameters(
        ['string'], // 构造函数参数类型
        ['Hello, Blockchain!'] // 构造函数参数值
    ).slice(2); // 去掉 "0x"
    console.log("构造函数参数编码:", encodedArgs);

    const initCode = `${MyContract.bytecode}${encodedArgs}`;

    // 计算 initCodeHash
    const initCodeHash = web3.utils.keccak256(initCode);
    console.log("initCodeHash:", initCodeHash)

    // 创建 salt（盐值）
    const salt = web3.utils.keccak256("A");
    console.log("salt:", salt);

    // 计算合约地址
    const predictedAddress = await factory.computeAddress(salt, initCodeHash);
    console.log("预计合约地址:", predictedAddress);

    // 使用 CREATE2 部署合约
    await factory.deploy(initCode, salt, { from: deployerAddress });

    console.log("实际部署的合约地址:", predictedAddress);

    // 验证合约已部署
    const deployedCode = await web3.eth.getCode(predictedAddress);
    if (deployedCode === '0x') {
        console.error("❌ 部署失败，请检查 initCode 和 salt");
    } else {
        console.log("✅ 合约部署成功！");
    }
};
