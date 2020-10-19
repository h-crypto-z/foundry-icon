module Types exposing (..)

import Array exposing (Array)
import BigInt exposing (BigInt)
import Browser
import Browser.Navigation
import Config
import Contracts.BucketSale.Generated.BucketSale exposing (currentBucket)
import Contracts.BucketSale.Wrappers as BucketSaleWrappers
import Dict exposing (Dict)
import Eth.Sentry.Event as EventSentry exposing (EventSentry)
import Eth.Sentry.Tx as TxSentry exposing (TxSentry)
import Eth.Sentry.Wallet as WalletSentry exposing (WalletSentry)
import Eth.Types exposing (Address, Hex, Tx, TxHash, TxReceipt)
import Eth.Utils
import Helpers.Element as EH
import Helpers.Time as TimeHelpers
import Html.Attributes exposing (required)
import Http
import Json.Decode exposing (Decoder, field, float, int, map3)
import Json.Encode
import List.Extra
import Time
import TokenValue exposing (TokenValue)
import Url exposing (Url)


type alias Flags =
    { basePath : String
    , networkId : Int
    , width : Int
    , height : Int
    , nowInMillis : Int
    }


type alias Model =
    { currentTime : Int
    , currentBucketId : Int
    , currentBucketTotalEntered : TokenValue
    , currentEthPriceUsd : Float
    , currentDaiPriceEth : Float
    , currentFryPriceEth : Float
    }


type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url
    | Tick Time.Posix
    | Resize Int Int
    | BucketValueEnteredFetched Int (Result Http.Error TokenValue)
      --| DataReceived (Result Http.Error GraphQlInfo)
    | NoOp


type alias GraphQlInfo =
    { ethPrice : Float
    , daiPrice : Float
    , fryPrice : Float
    }



-- {
--   "data": {
--     "bundle": {
--       "ethPrice": "371.589792074740403253429188923292"
--     },
--     "token": {
--       "derivedETH": "0.00001778586954269887951194800608117371"
--     },
--     "tokens": [
--       {
--         "derivedETH": "0.002708888895018976277243627345705594"
--       }
--     ]
--   }
-- }


graphJson : Decoder GraphQlInfo
graphJson =
    map3 GraphQlInfo
        -- eth
        (field "data" (field "bundle" (field "ethPrice" float)))
        -- dai
        (field "data" (field "token" (field "derivedEth" float)))
        -- fry
        (field "data" (field "tokens" (field "derivedEth" float)))


getCurrentBucketId : Int -> Int
getCurrentBucketId now =
    (TimeHelpers.sub (Time.millisToPosix now) (Time.millisToPosix Config.saleStarted)
        |> TimeHelpers.posixToSeconds
    )
        // (Config.bucketSaleBucketInterval
                |> TimeHelpers.posixToSeconds
           )


getBucketRemainingTimeText : Int -> Int -> String
getBucketRemainingTimeText bucketId now =
    TimeHelpers.toHumanReadableString
        (TimeHelpers.sub
            (getBucketEndTime bucketId)
            (Time.millisToPosix now)
        )


getBucketStartTime : Int -> Time.Posix
getBucketStartTime bucketId =
    Time.millisToPosix
        (Config.saleStarted + (bucketId * Time.posixToMillis Config.bucketSaleBucketInterval))


getBucketEndTime : Int -> Time.Posix
getBucketEndTime bucketId =
    TimeHelpers.add
        (getBucketStartTime bucketId)
        Config.bucketSaleBucketInterval


calcEffectivePricePerToken : TokenValue -> Float -> TokenValue
calcEffectivePricePerToken totalValueEntered daiEthValue =
    TokenValue.toFloatWithWarning totalValueEntered
        * daiEthValue
        / (TokenValue.toFloatWithWarning <| Config.bucketSaleTokensPerBucket)
        |> TokenValue.fromFloatWithWarning


fetchTotalValueEnteredCmd : Int -> Cmd Msg
fetchTotalValueEnteredCmd id =
    BucketSaleWrappers.getTotalValueEnteredForBucket
        id
        (BucketValueEnteredFetched id)



-- fetchUniswapGraphInfo : Cmd Msg
-- fetchUniswapGraphInfo =
--     Http.request
--         { method = "POST"
--         , url = Config.uniswapGraphQL
--         , body = Http.stringBody "application/json" "{bundle (id: 1){ethPrice},tokens(where: {name: \"Dai Stablecoin\"}){derivedETH}  ,token(id: \"0x6c972b70c533e2e045f333ee28b9ffb8d717be69\"){derivedETH}}"
--         , expect = Http.expectJson DataReceived graphJson
--         , headers = [ Http.header "Access-Control-Allow-Origin" "*" ]
--         , timeout = Nothing
--         , tracker = Nothing
--         }
