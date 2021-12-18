require("@nomiclabs/hardhat-waffle");

/**
 * @type import('hardhat/config').HardhatUserConfig
 */

 module.exports = {
  solidity: '0.8.0',
  networks: {
    rinkeby: {
      url: 'https://eth-rinkeby.alchemyapi.io/v2/oKlMtPZI8d9w6bp2J8IHomOaJwKlPFlv',
      accounts: ['c117a16d1beefede50b8465738c0292454c97b8713d64a83257d49494b1a07ad'],
    },
  },
};
