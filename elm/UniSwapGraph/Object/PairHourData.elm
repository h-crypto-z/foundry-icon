-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module UniSwapGraph.Object.PairHourData exposing (..)

import Graphql.Internal.Builder.Argument as Argument exposing (Argument)
import Graphql.Internal.Builder.Object as Object
import Graphql.Internal.Encode as Encode exposing (Value)
import Graphql.Operation exposing (RootMutation, RootQuery, RootSubscription)
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import Graphql.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode
import ScalarCodecs
import UniSwapGraph.InputObject
import UniSwapGraph.Interface
import UniSwapGraph.Object
import UniSwapGraph.Scalar
import UniSwapGraph.Union


id : SelectionSet ScalarCodecs.Id UniSwapGraph.Object.PairHourData
id =
    Object.selectionForField "ScalarCodecs.Id" "id" [] (ScalarCodecs.codecs |> UniSwapGraph.Scalar.unwrapCodecs |> .codecId |> .decoder)


hourStartUnix : SelectionSet Int UniSwapGraph.Object.PairHourData
hourStartUnix =
    Object.selectionForField "Int" "hourStartUnix" [] Decode.int


pair :
    SelectionSet decodesTo UniSwapGraph.Object.Pair
    -> SelectionSet decodesTo UniSwapGraph.Object.PairHourData
pair object_ =
    Object.selectionForCompositeField "pair" [] object_ identity


reserve0 : SelectionSet ScalarCodecs.BigDecimal UniSwapGraph.Object.PairHourData
reserve0 =
    Object.selectionForField "ScalarCodecs.BigDecimal" "reserve0" [] (ScalarCodecs.codecs |> UniSwapGraph.Scalar.unwrapCodecs |> .codecBigDecimal |> .decoder)


reserve1 : SelectionSet ScalarCodecs.BigDecimal UniSwapGraph.Object.PairHourData
reserve1 =
    Object.selectionForField "ScalarCodecs.BigDecimal" "reserve1" [] (ScalarCodecs.codecs |> UniSwapGraph.Scalar.unwrapCodecs |> .codecBigDecimal |> .decoder)


reserveUSD : SelectionSet ScalarCodecs.BigDecimal UniSwapGraph.Object.PairHourData
reserveUSD =
    Object.selectionForField "ScalarCodecs.BigDecimal" "reserveUSD" [] (ScalarCodecs.codecs |> UniSwapGraph.Scalar.unwrapCodecs |> .codecBigDecimal |> .decoder)


hourlyVolumeToken0 : SelectionSet ScalarCodecs.BigDecimal UniSwapGraph.Object.PairHourData
hourlyVolumeToken0 =
    Object.selectionForField "ScalarCodecs.BigDecimal" "hourlyVolumeToken0" [] (ScalarCodecs.codecs |> UniSwapGraph.Scalar.unwrapCodecs |> .codecBigDecimal |> .decoder)


hourlyVolumeToken1 : SelectionSet ScalarCodecs.BigDecimal UniSwapGraph.Object.PairHourData
hourlyVolumeToken1 =
    Object.selectionForField "ScalarCodecs.BigDecimal" "hourlyVolumeToken1" [] (ScalarCodecs.codecs |> UniSwapGraph.Scalar.unwrapCodecs |> .codecBigDecimal |> .decoder)


hourlyVolumeUSD : SelectionSet ScalarCodecs.BigDecimal UniSwapGraph.Object.PairHourData
hourlyVolumeUSD =
    Object.selectionForField "ScalarCodecs.BigDecimal" "hourlyVolumeUSD" [] (ScalarCodecs.codecs |> UniSwapGraph.Scalar.unwrapCodecs |> .codecBigDecimal |> .decoder)


hourlyTxns : SelectionSet ScalarCodecs.BigInt UniSwapGraph.Object.PairHourData
hourlyTxns =
    Object.selectionForField "ScalarCodecs.BigInt" "hourlyTxns" [] (ScalarCodecs.codecs |> UniSwapGraph.Scalar.unwrapCodecs |> .codecBigInt |> .decoder)
