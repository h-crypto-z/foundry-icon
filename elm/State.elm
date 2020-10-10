port module State exposing (init, update, subscriptions)

import Array exposing (Array)
import Browser
import Browser.Events
import Browser.Navigation
import Config
import Dict exposing (Dict)
import Eth
import Eth.Decode
import Eth.Net
import Eth.Sentry.Event as EventSentry exposing (EventSentry)
import Eth.Sentry.Tx as TxSentry
import Eth.Sentry.Wallet as WalletSentry
import Eth.Types exposing (Address, TxHash)
import Eth.Utils
import Helpers.Element as EH exposing (DisplayProfile(..))
import Helpers.Time as TimeHelpers
import Json.Decode
import Json.Encode
import List.Extra
import Maybe.Extra
import MaybeDebugLog exposing (maybeDebugLog)
import Random
import Task
import Time
import TokenValue exposing (TokenValue)
import Types exposing (..)
import Url exposing (Url)

init : Flags -> Url -> Browser.Navigation.Key -> ( Model, Cmd Msg )
init flags url key =
  ( { currentTime = flags.nowInMillis
    , currentBucket = (getCurrentBucketId flags.nowInMillis)
    }
  , Cmd.none
  )


update : Msg -> Model -> ( Model, Cmd Msg )
update _ model =
  ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none


port walletSentryPort : (Json.Decode.Value -> msg) -> Sub msg


port connectToWeb3 : () -> Cmd msg


port txOut : Json.Decode.Value -> Cmd msg


port txIn : (Json.Decode.Value -> msg) -> Sub msg
