module Array2D exposing (..)

import Array exposing (Array)
import ArrayHelpers as Helpers

type alias Array2D a =
    { data : Array (Array a)
    , columns : Int
    }

empty : Array2D a
empty =
    { data = Array.empty
    , columns = 0
    }


fromArray : Array (Array a) -> Array2D a
fromArray array =
    let
        ( initialColumns, normalizedData ) =
            Helpers.getMinColumnsAndTruncateRows array
    in
        { data = normalizedData
        , columns = initialColumns
        }

fromList : List (List a) -> Array2D a
fromList list =
    list
        |> List.map Array.fromList
        |> Array.fromList
        |> fromArray

initialize : Int -> Int -> (Int -> Int -> a) -> Array2D a
initialize numRows numColumns f =
    let
        initialRows =
            Array.initialize
                numRows
                (\row ->
                    (Array.initialize
                        numColumns
                        (\col -> f row col)
                    )
                )
    in
        { data = initialRows
        , columns = numColumns
        }

repeat : Int -> Int -> a -> Array2D a
repeat numRows numColumns e =
    let
        row =
            Array.repeat numColumns e
    in
        { data = Array.repeat numRows row
        , columns = numColumns
        }

rows : Array2D a -> Int
rows array2d =
    Array.length array2d.data

columns : Array2D a -> Int
columns array2d =
    array2d.columns

isEmpty : Array2D a -> Bool
isEmpty array2d =
    Array.isEmpty array2d.data

get : Int -> Int -> Array2D a -> Maybe a
get row col array2d =
    Array.get row array2d.data |> Maybe.andThen (Array.get col)

set : Int -> Int -> a -> Array2D a -> Array2D a
set row col newValue array2d =
    Array.get row array2d.data
        |> Maybe.map (\rowAry -> { array2d | data = (Array.set row (Array.set col newValue rowAry) array2d.data) })
        |> Maybe.withDefault array2d