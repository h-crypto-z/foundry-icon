module Config exposing (..)

import BigInt exposing (BigInt)
import Eth.Types exposing (Address)
import Eth.Utils
import Time
import TokenValue exposing (TokenValue)


bucketSaleBucketInterval : Time.Posix
bucketSaleBucketInterval =
    Time.millisToPosix <| 1000 * 60 * 60 * 7


bucketSaleTokensPerBucket : TokenValue
bucketSaleTokensPerBucket =
    TokenValue.fromIntTokenValue 30000


saleStarted : Int
saleStarted =
    1592568000000


httpProviderUrl : String
httpProviderUrl =
    mainnetHttpProviderUrl


mainnetHttpProviderUrl : String
mainnetHttpProviderUrl =
    "https://23eb406fad764a70987ba5e619459917.eth.rpc.rivet.cloud/"


ganacheHttpProviderUrl : String
ganacheHttpProviderUrl =
    "http://localhost:8545"


daiContractAddress : Address
daiContractAddress =
    Eth.Utils.unsafeToAddress "0x6B175474E89094C44Da98b954EedeAC495271d0F"


etherscanBaseUrl : String
etherscanBaseUrl =
    "https://etherscan.io/address/"


teamToastMultiSigAddress : Address
teamToastMultiSigAddress =
    Eth.Utils.unsafeToAddress "0xE5dDe1cc679184fc420E6f92e0Bd8C81E41D25e1"


treasuryForwarderAddress : Address
treasuryForwarderAddress =
    Eth.Utils.unsafeToAddress "0x93fE7D1d24bE7CB33329800ba2166f4D28Eaa553"


fryTokenAddress : Address
fryTokenAddress =
    Eth.Utils.unsafeToAddress "0x6c972b70c533E2E045F333Ee28b9fFb8D717bE69"


bucketSaleAddress : Address
bucketSaleAddress =
    Eth.Utils.unsafeToAddress "0x30076fF7436aE82207b9c03AbdF7CB056310A95A"


uniswapPoolLink : String
uniswapPoolLink =
    "https://uniswap.info/token/0x6c972b70c533e2e045f333ee28b9ffb8d717be69"


uniswapTradeLink : String
uniswapTradeLink =
    "https://app.uniswap.org/#/swap?outputCurrency=0x6c972b70c533e2e045f333ee28b9ffb8d717be69&inputCurrency=ETH"


foundrySaleLink : String
foundrySaleLink =
    "https://sale.foundrydao.com"


uniswapGraphQL : String
uniswapGraphQL =
    "https://cors-anywhere.herokuapp.com/https://api.thegraph.com/subgraphs/name/uniswap/uniswap-v2"



--"https://api.thegraph.com/subgraphs/name/uniswap/uniswap-v2/"
