const path = require('path');
const fs = require('fs');
const solc = require('solc');

const bankPath = path.resolve(__dirname, 'contract', 'Bank.sol');
const source = fs.readFileSync(bankPath,'utf8');

// console.log(solc.compile(source,1));

module.exports = solc.compile(source,1).contracts[':Bank'];