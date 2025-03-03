const HongERC20 = artifacts.require("HongERC20");

describe('HongERC20', () => {
    let hongERC20;
    const owner = "0xA5e458041D2D584123a2B55E2F8283a8b330cDB3";
    const user = "0x7E918caEA9741df0650B408C26315416CDaeE3A5";
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

