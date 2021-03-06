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
import UniSwapGraph.InputObject
import UniSwapGraph.Interface
import UniSwapGraph.Object
import UniSwapGraph.Scalar
import UniSwapGraph.ScalarCodecs
import UniSwapGraph.Union


id : SelectionSet UniSwapGraph.ScalarCodecs.Id UniSwapGraph.Object.PairHourData
id =
    Object.selectionForField "ScalarCodecs.Id" "id" [] (UniSwapGraph.ScalarCodecs.codecs |> UniSwapGraph.Scalar.unwrapCodecs |> .codecId |> .decoder)


hourStartUnix : SelectionSet Int UniSwapGraph.Object.PairHourData
hourStartUnix =
    Object.selectionForField "Int" "hourStartUnix" [] Decode.int


pair :
    SelectionSet decodesTo UniSwapGraph.Object.Pair
    -> SelectionSet decodesTo UniSwapGraph.Object.PairHourData
pair object_ =
    Object.selectionForCompositeField "pair" [] object_ identity


reserve0 : SelectionSet UniSwapGraph.ScalarCodecs.BigDecimal UniSwapGraph.Object.PairHourData
reserve0 =
    Object.selectionForField "ScalarCodecs.BigDecimal" "reserve0" [] (UniSwapGraph.ScalarCodecs.codecs |> UniSwapGraph.Scalar.unwrapCodecs |> .codecBigDecimal |> .decoder)


reserve1 : SelectionSet UniSwapGraph.ScalarCodecs.BigDecimal UniSwapGraph.Object.PairHourData
reserve1 =
    Object.selectionForField "ScalarCodecs.BigDecimal" "reserve1" [] (UniSwapGraph.ScalarCodecs.codecs |> UniSwapGraph.Scalar.unwrapCodecs |> .codecBigDecimal |> .decoder)


reserveUSD : SelectionSet UniSwapGraph.ScalarCodecs.BigDecimal UniSwapGraph.Object.PairHourData
reserveUSD =
    Object.selectionForField "ScalarCodecs.BigDecimal" "reserveUSD" [] (UniSwapGraph.ScalarCodecs.codecs |> UniSwapGraph.Scalar.unwrapCodecs |> .codecBigDecimal |> .decoder)


hourlyVolumeToken0 : SelectionSet UniSwapGraph.ScalarCodecs.BigDecimal UniSwapGraph.Object.PairHourData
hourlyVolumeToken0 =
    Object.selectionForField "ScalarCodecs.BigDecimal" "hourlyVolumeToken0" [] (UniSwapGraph.ScalarCodecs.codecs |> UniSwapGraph.Scalar.unwrapCodecs |> .codecBigDecimal |> .decoder)


hourlyVolumeToken1 : SelectionSet UniSwapGraph.ScalarCodecs.BigDecimal UniSwapGraph.Object.PairHourData
hourlyVolumeToken1 =
    Object.selectionForField "ScalarCodecs.BigDecimal" "hourlyVolumeToken1" [] (UniSwapGraph.ScalarCodecs.codecs |> UniSwapGraph.Scalar.unwrapCodecs |> .codecBigDecimal |> .decoder)


hourlyVolumeUSD : SelectionSet UniSwapGraph.ScalarCodecs.BigDecimal UniSwapGraph.Object.PairHourData
hourlyVolumeUSD =
    Object.selectionForField "ScalarCodecs.BigDecimal" "hourlyVolumeUSD" [] (UniSwapGraph.ScalarCodecs.codecs |> UniSwapGraph.Scalar.unwrapCodecs |> .codecBigDecimal |> .decoder)


hourlyTxns : SelectionSet UniSwapGraph.ScalarCodecs.BigInt UniSwapGraph.Object.PairHourData
hourlyTxns =
    Object.selectionForField "ScalarCodecs.BigInt" "hourlyTxns" [] (UniSwapGraph.ScalarCodecs.codecs |> UniSwapGraph.Scalar.unwrapCodecs |> .codecBigInt |> .decoder)
