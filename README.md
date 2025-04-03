## 本地安装 Ganache
### 下载地址
```
https://archive.trufflesuite.com/ganache/
```

### 文档
```
https://archive.trufflesuite.com/docs/ganache/
```
## 安裝openzeppelin
```bash
  npm install @openzeppelin/contracts
```
## 安裝openzeppelin升级
```bash
  npm install @openzeppelin/contracts-upgradeable @openzeppelin/contracts
```

# Truffle

[Truffle 文档](https://archive.trufflesuite.com/docs/truffle/)


## 安装
```bash
  npm install -g truffle
```

## 查看版本号
```bash
  truffle version
```

## 项目初始化
```bash
  truffle init
```
## 编译合约
```bash
  truffle compile
```

## 部署合约到开发环境
### 配置文件truffle-config.js中network配置
### migrations中的1_deploy_contracts.js前缀必须带数字
```bash
  truffle migrate --network development
```
### --f 2：指定从第 2 个迁移脚本开始。
### --to 2：只执行到第 2 个迁移脚本（如果有多个迁移文件，这样可以控制执行的脚本范围）。
```bash
  truffle migrate --f 1 --to 1 --network development
```

## 部署合约到主网环境
### 确保你已经安装了@truffle/hdwallet-provider和dotenv。如果没有安装，可以使用以下命令进行安装
```bash
 npm install @truffle/hdwallet-provider dotenv
```

```bash
  truffle migrate --network mainnet
```

## 安装测试依赖
### 依赖文档
https://juejin.cn/post/6997381389406437412
https://blog.csdn.net/black_cat7/article/details/145066594
```bash
  npm install --save-dev chai mocha
```

## 测试合约
```bash
  npm install --save-dev truffle chai
```


# Hardhat

## 文档
[Hardhat 文档](https://hardhat.org/docs)

## 安装 Hardhat
```bash
  npm install --save-dev hardhat
```

## 项目初始化
```bash
  npx hardhat init
```

## 编译合约
```bash
  npx hardhat compile
```

## 部署合约
```bash
  npx hardhat ignition deploy ./ignition/modules/Token.js --network development
```

# Ethers
```bash
    npm install ethers --save
```
# 代码风格检查
[solhint](https://www.npmjs.com/package/solhint)

```bash
  npm install -g solhint
```
## 查看版本
```bash
  solhint --version
```
## 初始化配置文件
```bash
    solhint --init
```
## 检查合约
```bash
    solhint contracts/**/*.sol

```

# Foundry
[Foundry 文档](https://learnblockchain.cn/docs/foundry/i18n/zh/index.html)

## 安装Foundry
# 克隆仓库
```
git clone https://github.com/foundry-rs/foundry.git
cd foundry
```
## 安装 Forge
```
cargo install --path ./crates/forge --profile release --force --locked
```
## 安装 Cast
```
cargo install --path ./crates/cast --profile release --force --locked
```
## 安装 Anvil
```
cargo install --path ./crates/anvil --profile release --force --locked
```
## 安装 Chisel
```
cargo install --path ./crates/chisel --profile release --force --locked
```

```bash
mkdir foundry
```
```
cd foundry
```
```
forge init --force --no-git
```
```
forge install transmissions11/solmate
forge install transmission11/solmate@v7
forge install OpenZeppelin/openzeppelin-contracts

forge update lib/solmate
forge remove solmate

forge remappings
```

## 安装soldeer [soldeer文档](https://soldeer.xyz/)
```
forge soldeer init
```

## 部署合约
```bash
  forge create --rpc-url http://localhost:8545 --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 src/Counter.sol:Counter --broadcast
```
### 使用 --constructor-args 标志将参数传递给构造函数

```
--constructor-args "ForgeUSD" "FUSD" 18 1000000000000000000000
```
### 克隆链上已验证的合约
```bash
  forge clone --etherscan-api-key XEUXBFXMB5G8KWRAKKX44MGJMMNSVTM6AT 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2 WETH9
```
### Gas 报告  foundry.toml
#### 为特定合约生成报告：
```
gas_reports = ["MyContract", "MyContractFactory"]
```
#### 为所有合约生成报告：
```
gas_reports = ["*"]
```

#### 要生成 Gas 报告，请运行 
```
forge test --gas-report
// 针对单个测试用例
forge test --match-test testFuzz_withdraw --gas-report
```

#### 忽略合约
```
gas_reports_ignore = ["Example"]
```

#### gas 函数快照
```
forge snapshot
// 指定一个文件输出
forge snapshot --snap <FILE_NAME>
// --asc gas升序 --desc gas降序
// --min <VALUE> gas最小 --max <VALUE> gas最大
```

#### 调试器 Debugger
```
    forge test --debug $FUNC
```

### Cast 概述

(Cast 是 Foundry 用于执行以太坊 RPC 调用的命令行工具。 你可以进行智能合约调用、发送交易或检索任何类型的链数据——所有这些都来自你的命令行！)
#### 使用 cast 来检索 DAI 代币的总供应量
```
cast call 0x6b175474e89094c44da98b954eedeac495271d0f "totalSupply()(uint256)" --rpc-url https://eth-mainnet.alchemyapi.io/v2/Lc7oIGYeL_QvInzI0Wiu_pOZZDEKBrdf
```

#### 解码 calldata
```
cast 4byte-decode 0x1F1F897F676d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003e7
```

### Anvil 概述
Anvil 是 Foundry 附带的本地测试网节点。 你可以使用它从前端测试你的合约或通过 RPC 进行交互。
```
#  Number of dev accounts to generate and configure. [default: 10]
anvil -a, --accounts <ACCOUNTS>

# The EVM hardfork to use. [default: latest]
anvil --hardfork <HARDFORK>

# Port number to listen on. [default: 8545]
anvil  -p, --port <PORT>
```

### Chisel 概述
Chisel 是随 Foundry 提供的高级 Solidity REPL。它可用于在本地或分叉网络上快速测试 Solidity 片段。
如何使用 Chisel
要使用 Chisel，只需键入 chisel。然后开始编写 Solidity 代码！Chisel 会对每次输入提供详细反馈。

Chisel 可在 Foundry 项目内外使用。如果二进制文件在 Foundry 项目根目录下执行，Chisel 将继承项目的配置选项。