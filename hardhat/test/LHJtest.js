const { expect } = require("chai");
const { ethers } = require("hardhat");

describe ("LHJtest", function () {

  // 合约
  let contract ;
  // 初始地址
  const initialAddress = "0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266";

  before (async function () {
    const LHJtest = await ethers.getContractFactory("LHJ");
    contract = await LHJtest.deploy(initialAddress);
  });

  it ("name", async function () {
    let name = await contract.name();
    console.log(name);
    expect(name).to.equal("LHJ");
  });

  it ("symbol", async function () {
    let symbol = await contract.symbol();
    console.log(symbol);
    expect(symbol).to.equal("HONG");
  });

  it ("mint", async function () {
    await contract.mint(initialAddress, ethers.parseEther("1"));

    let balance = await contract.balanceOf(initialAddress);
    console.log(ethers.formatEther(balance));
    expect(balance).to.equal(ethers.parseEther("1"));
   });

  it ("transfer", async function () {
      let otherAddress = "0x70997970C51812dc3A010C7d01b50e0d17dc79C8";
      await contract.transfer(otherAddress, ethers.parseEther("1"));
      let balance = await contract.balanceOf(otherAddress);
      expect(balance).to.equal(ethers.parseEther("1"));
   });
});