# Ethers

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
## Ethers.js
[Ethers 文档](https://docs.ethers.org/v6/getting-started/#starting-glossary)
```
npm install ethers
```

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
```
