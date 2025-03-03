# ethers

## Project setup
```
yarn install
```

### Compiles and hot-reloads for development
```
yarn serve
```

### Compiles and minifies for production
```
yarn build
```

### Lints and fixes files
```
yarn lint
```

### Customize configuration
See [Configuration Reference](https://cli.vuejs.org/config/).

```
npm install ethers
```

npm install @babel/plugin-transform-class-properties @babel/plugin-transform-private-methods @babel/plugin-transform-private-property-in-object --save-dev

babel.config.js

module.exports = {
presets: [
'@vue/cli-plugin-babel/preset'
],
plugins: [
['@babel/plugin-transform-class-properties', { loose: true }],
['@babel/plugin-transform-private-methods', { loose: true }],
['@babel/plugin-transform-private-property-in-object', { loose: true }]
]
}

eth = parseEther("1.0")
// 1000000000000000000n

// Convert user-provided strings in gwei to wei for max base fee
feePerGas = parseUnits("4.5", "gwei")
// 4500000000n

// Convert a value in wei to a string in ether to display in a UI
formatEther(eth)
// '1.0'

// Convert a value in wei to a string in gwei to display in a UI
formatUnits(feePerGas, "gwei")

