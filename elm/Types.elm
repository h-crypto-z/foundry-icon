module Types exposing (..)

import Array exposing (Array)
import Browser
import Browser.Navigation
import Dict exposing (Dict)
import Eth.Sentry.Event as EventSentry exposing (EventSentry)
import Eth.Sentry.Tx as TxSentry exposing (TxSentry)
import Eth.Sentry.Wallet as WalletSentry exposing (WalletSentry)
import Eth.Types exposing (Address, Hex, Tx, TxHash, TxReceipt)
import Eth.Utils
import Helpers.Element as EH
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
    { currentTime : Int }


type Msg 
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url
    | NoOp

