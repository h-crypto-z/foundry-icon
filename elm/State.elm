port module State exposing (init, subscriptions, update)

import Array exposing (Array)
import Browser
import Browser.Events
import Browser.Navigation
import Config
import Contracts.BucketSale.Generated.BucketSale exposing (currentBucket)
import Dict exposing (Dict)
import Eth
import Eth.Decode
import Eth.Net
import Eth.Sentry.Event as EventSentry exposing (EventSentry)
import Eth.Sentry.Tx as TxSentry
import Eth.Sentry.Wallet as WalletSentry
import Eth.Types exposing (Address, TxHash)
import Eth.Utils
import Graphql.Http
import Graphql.Http.GraphqlError exposing (GraphqlError)
import Graphql.SelectionSet as SelectionSet
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
import UniSwapGraph.Object exposing (Bundle)
import UniSwapGraph.Query exposing (bundle)
import UniSwapGraph.Scalar as Scalar
import Url exposing (Url)


init : Flags -> Url -> Browser.Navigation.Key -> ( Model, Cmd Msg )
init flags url key =
    ( { currentTime = flags.nowInMillis
      , currentBucketId = getCurrentBucketId flags.nowInMillis
      , currentBucketTotalEntered = TokenValue.fromIntTokenValue 0
      , currentEthPriceUsd = 0.0
      , currentDaiPriceEth = 0.0
      , currentFryPriceEth = 0.0
      }
    , let
        getEthPrice =
            fetchEthPrice

        getDaiPrice =
            fetchDaiPrice

        getFryPrice =
            fetchFryPrice
      in
      Cmd.batch [ getEthPrice, getDaiPrice, getFryPrice ]
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick i ->
            let
                cmd =
                    fetchTotalValueEnteredCmd model.currentBucketId

                getEthPrice =
                    fetchEthPrice

                getDaiPrice =
                    fetchDaiPrice

                getFryPrice =
                    fetchFryPrice
            in
            ( { model
                | currentTime = Time.posixToMillis i
                , currentBucketId = getCurrentBucketId <| Time.posixToMillis i
              }
            , Cmd.batch [ cmd, getEthPrice, getDaiPrice, getFryPrice ]
            )

        FetchedEthPrice fetchResult ->
            case fetchResult of
                Err error ->
                    -- let
                    --     _ =
                    --         Debug.log "GraphQL error" ( fetchResult, error )
                    -- in
                    ( model, Cmd.none )

                Ok bundle1 ->
                    let
                        v =
                            case bundle1 of
                                Just val ->
                                    val

                                Nothing ->
                                    Value 0
                    in
                    ( { model | currentEthPriceUsd = v.ethPrice }
                    , Cmd.none
                    )

        FetchedDaiPrice fetchResult ->
            case fetchResult of
                Err error ->
                    -- let
                    --     _ =
                    --         Debug.log "GraphQL error" ( fetchResult, error )
                    -- in
                    ( model, Cmd.none )

                Ok value ->
                    let
                        v =
                            case value of
                                Just val ->
                                    val

                                Nothing ->
                                    Value 0
                    in
                    ( { model | currentDaiPriceEth = v.ethPrice }
                    , Cmd.none
                    )

        FetchedFryPrice fetchResult ->
            case fetchResult of
                Err error ->
                    -- let
                    --     _ =
                    --         Debug.log "GraphQL error" ( fetchResult, error )
                    -- in
                    ( model, Cmd.none )

                Ok value ->
                    let
                        v =
                            case value of
                                Just val ->
                                    val

                                Nothing ->
                                    Value 0
                    in
                    ( { model | currentFryPriceEth = v.ethPrice }
                    , Cmd.none
                    )

        LinkClicked i ->
            ( model, Cmd.none )

        UrlChanged i ->
            ( model, Cmd.none )

        Resize i j ->
            ( model, Cmd.none )

        BucketValueEnteredFetched bucketId fetchResult ->
            case fetchResult of
                Err httpErr ->
                    -- let
                    --     _ =
                    --         Debug.log "http error when fetching total bucket value entered" ( bucketId, fetchResult )
                    -- in
                    ( model, Cmd.none )

                Ok valueEntered ->
                    ( { model | currentBucketTotalEntered = valueEntered }, Cmd.none )

        NoOp ->
            ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Time.every 5000 Tick ]


port walletSentryPort : (Json.Decode.Value -> msg) -> Sub msg


port connectToWeb3 : () -> Cmd msg


port txOut : Json.Decode.Value -> Cmd msg


port txIn : (Json.Decode.Value -> msg) -> Sub msg
