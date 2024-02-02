import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";

const ALCHEMY_API_KEY_POLYGON = "owggvblItcaezrbG_fiS7_t59JePYc9T";
const POLYGONSCAN_API_KEY = "DA1VWFE6FH8ZNAJ99Q2JQ8YRW5WHK9HW55";
const WALLET_PRIVATE_KEY =
  "";

const config: HardhatUserConfig = {
  solidity: "0.8.20",
  etherscan: {
    apiKey: POLYGONSCAN_API_KEY,
  },
  defaultNetwork: "polygon_mumbai",
  networks: {
    polygon_mumbai: {
      url: `https://polygon-mumbai.g.alchemy.com/v2/${ALCHEMY_API_KEY_POLYGON}`,
      accounts: [WALLET_PRIVATE_KEY as string],
    },
  },
};

export default config;
