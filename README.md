# truffle-hardhat-demo

## 本地安装ganache
### 下载地址
```
https://archive.trufflesuite.com/ganache/
```

### 文档
```
https://archive.trufflesuite.com/docs/ganache/
```


# truffle-demo

https://archive.trufflesuite.com/docs/truffle/

安装
npm install -g truffle

查看版本号
truffle version

初始化
truffle init

编译
truffle compile

migrations中的2_deploy_contracts.js前缀必须带数字ß

部署合约到开发环境Ganache
truffle migrate --network development

测试
npm install --save-dev truffle chai

npm install -g chai

npm install --save-dev chai mocha
https://juejin.cn/post/6997381389406437412
https://blog.csdn.net/black_cat7/article/details/145066594

# Hardhat Demo

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

## 安裝openzeppelin
```bash
  npm install @openzeppelin/contracts
```
## 安裝openzeppelin升级
```bash
    npm install @openzeppelin/contracts-upgradeable @openzeppelin/contracts
```

## 编译合约
```bash
  npx hardhat compile
```

## 部署合约
```bash
  npx hardhat ignition deploy ./ignition/modules/Token.js --network development
```