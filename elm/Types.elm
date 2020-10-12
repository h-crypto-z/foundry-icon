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
import Http
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
    }


type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url
    | Tick Time.Posix
    | Resize Int Int
    | BucketValueEnteredFetched Int (Result Http.Error TokenValue)
    | NoOp


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


calcEffectivePricePerToken : TokenValue -> TokenValue
calcEffectivePricePerToken totalValueEntered =
    TokenValue.toFloatWithWarning totalValueEntered
        / (TokenValue.toFloatWithWarning <| Config.bucketSaleTokensPerBucket)
        |> TokenValue.fromFloatWithWarning


fetchTotalValueEnteredCmd : Int -> Cmd Msg
fetchTotalValueEnteredCmd id =
    BucketSaleWrappers.getTotalValueEnteredForBucket
        id
        (BucketValueEnteredFetched id)
