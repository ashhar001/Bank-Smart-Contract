const HDWalletProvider = require('truffle-hdwallet-provider');
const Web3 = require('web3');

const { interface , bytecode } = require('./compile');

const provider = new HDWalletProvider(
    'floor wedding mobile input wire lounge lend matter camp mouse volcano onion',
    'https://rinkeby.infura.io/v3/a1565f504a8145c3ac11b038fb92698c'
);

const web3 = new Web3(provider);

const deploy = async () => {

    const accounts = await web3.eth.getAccounts();

    console.log('Attempting to deploy from account', accounts[0]);

    const result = await new web3.eth.Contract(JSON.parse(interface))  //interface here is ABI
        .deploy({ data: bytecode})
        // .deploy({ data: '0x' + bytecode, arguments: ['Hi there!'] })
        .send({ gas: '1000000' , from: accounts[0] });

    console.log(interface);
    console.log('Contract Deployed to', result.options.address);
};

deploy();