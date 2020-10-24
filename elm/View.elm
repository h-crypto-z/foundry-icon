module View exposing (root)

import Browser
import Config
import Dict exposing (Dict)
import Dict.Extra
import Element exposing (Attribute, Element)
import Element.Background
import Element.Border
import Element.Events
import Element.Font
import Element.Input
import Element.Lazy
import ElementMarkdown
import Eth.Types exposing (Address, Hex, TxHash)
import Eth.Utils
import Helpers.Element as EH exposing (DisplayProfile(..), changeForMobile, responsiveVal)
import Helpers.Eth as EthHelpers
import Helpers.List as ListHelpers
import Helpers.Time as TimeHelpers
import Helpers.Tuple as TupleHelpers
import Html.Attributes
import Images
import Json.Decode
import List.Extra
import Maybe.Extra
import MaybeDebugLog exposing (maybeDebugLog)
import Theme exposing (defaultTheme)
import Time
import TokenValue exposing (TokenValue)
import Tuple3
import Types exposing (..)


root : Model -> Browser.Document Msg
root model =
    { title = "Dashboard - Foundry"
    , body =
        [ Element.layout
            [ Element.width Element.fill
            , Element.Background.color Theme.blue
            , Element.htmlAttribute <| Html.Attributes.style "height" "100vh"
            , Element.Font.family
                [ Element.Font.typeface "DM Sans"
                , Element.Font.sansSerif
                ]
            , Element.Font.color EH.white
            ]
          <|
            body model
        ]
    }


body : Model -> Element Msg
body model =
    Element.column
        [ Element.Background.color Theme.softRed
        , Element.width Element.fill
        , Element.Border.rounded 50
        ]
        [ Element.row
            [ Element.paddingEach { left = 15, top = 0, right = 0, bottom = 0 } ]
            [ Element.newTabLink []
                { url = Config.foundrySaleLink
                , label = textExtraLarge "BUY FRY"
                }
            , Element.column
                [ Element.padding 20 ]
                [ textSmall "BUCKET #"
                , textLarge <| String.fromInt model.currentBucketId
                ]
            , Element.column
                [ Element.padding 20 ]
                [ textSmall "TIME LEFT"
                , textLarge <| getBucketRemainingTimeText model.currentBucketId model.currentTime
                ]
            , Element.column
                []
                [ Element.row
                    []
                    [ Element.column
                        [ Element.padding 5 ]
                        [ textLarge "SALE"
                        , textLarge "UNISWAP"
                        ]
                    , Element.column
                        [ Element.padding 5
                        , Element.alignRight
                        ]
                        (columnItems
                            (TokenValue.toConciseString <|
                                calcEffectivePricePerToken
                                    (calcEffectivePricePerToken model.currentBucketTotalEntered
                                        (if model.currentDaiPriceEth == 0 then
                                            1

                                         else
                                            model.currentDaiPriceEth
                                        )
                                    )
                                    model.currentEthPriceUsd
                            )
                            (TokenValue.toConciseString <|
                                TokenValue.fromFloatWithWarning <|
                                    model.currentFryPriceEth
                                        * model.currentEthPriceUsd
                            )
                        )
                    , Element.column
                        []
                        [ textLarge "USD"
                        , textLarge "USD"
                        ]
                    ]
                ]
            ]
        ]


textExtraLarge : String -> Element Msg
textExtraLarge txt =
    Element.el
        [ Element.Font.size 32
        , Element.padding 5
        , Element.Font.bold
        ]
    <|
        Element.text txt


textLarge : String -> Element Msg
textLarge txt =
    Element.el
        [ Element.Font.size 16
        , Element.padding 5
        ]
    <|
        Element.text txt


textSmall : String -> Element Msg
textSmall txt =
    Element.el
        [ Element.Font.size 8
        , Element.padding 5
        ]
    <|
        Element.text txt


columnLeft : String -> String -> Int -> Element Msg
columnLeft str1 str2 padding =
    Element.column
        [ Element.padding padding ]
        [ textLarge str1
        , textLarge str2
        ]


columnItems : String -> String -> List (Element Msg)
columnItems str1 str2 =
    [ textLarge str1
    , textLarge str2
    ]
