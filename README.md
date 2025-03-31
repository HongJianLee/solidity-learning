## 本地安装ganache
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
forge install OpenZeppelin/openzeppelin-contracts
```
## 部署合约
```bash
forge create --rpc-url http://localhost:8545 --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 src/Counter.sol:Counter --broadcast
```
