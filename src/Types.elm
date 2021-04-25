module Types exposing (..)

type Msg
    = MinesGenerated (List ( Int, Int )) | OpenCase Int Int | SetFlag Int Int| DefaultReset | CustomReset | Default 
        | IncrementWidth | DecrementWidth | IncrementHeight | DecrementHeight | IncrementMinMines | DecrementMinMines | IncrementMaxMines | DecrementMaxMines

type alias Options =
    { width : Int
    , height : Int
    , minMines : Int
    , maxMines : Int
    }
type alias Model =
    {battle_field :List Case, mines : List (Int,Int), cptFlag : Int, canPlay : Bool, options : Options, customOptions : Options}
    
type alias Case =
    {   
        y : Int,
        x : Int,
        value : Int,
        flagRaised : Bool,
        isMine: Bool,
        visibility: Bool
    }