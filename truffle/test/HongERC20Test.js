const HongERC20 = artifacts.require("HongERC20");

describe('HongERC20', () => {
    let hongERC20;
    const owner = "0x281AD57EdC50dD7d63C369FB18721FDA211D3C71";
    const user = "0x913CA48477A66F9ced3DdF4B931E758cBb11D85B";
    before(async () => {
        hongERC20 = await HongERC20.new(owner);
    })

    it('name and symbol', async () => {
        let name = await hongERC20.name();
        let symbol = await hongERC20.symbol();
        expect(name).to.equal("Hong-ERC20");
        expect(symbol).to.equal("HONG");
    })

    it('pause and unpause', async () => {
        await hongERC20.pause({from: owner});
        expect(await hongERC20.paused()).to.be.true;
        await hongERC20.unpause({from: owner});
        expect(await hongERC20.paused()).to.be.false;
    })

    it('mint', async () => {
        await hongERC20.mint(user, 1000, {from: owner});
        let balance = await hongERC20.balanceOf(user);
        expect(balance.toString()).to.equal('1000');
    })

    it('transfer', async () => {
        await hongERC20.mint(owner, 1000, {from: owner});
        await hongERC20.transfer(user, 1000, {from: owner});
        let balance = await hongERC20.balanceOf(user);
        expect(balance.toString()).to.equal('2000');
    })

   it('approve and transferFrom', async () => {
       await hongERC20.mint(owner, 1000, {from: owner});
       await hongERC20.approve(user, 1000, {from: owner});
       await hongERC20.transferFrom(owner, user, 1000, {from: user});
       let balance = await hongERC20.balanceOf(user);
       expect(balance.toString()).to.equal('3000');
    })

    it('burn', async () => {
        await hongERC20.mint(owner, 1000, {from: owner});
        await hongERC20.burn(1000, {from: owner});
        let balance = await hongERC20.balanceOf(owner);
        expect(balance.toString()).to.equal('0');
    })

});

