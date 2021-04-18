module Types exposing (..)

type Msg
    = MinesGenerated (List ( Int, Int )) | SelectArea Int
type alias Model =
    {battle_field :List Case, mines : List (Int,Int)}
    
type alias Case =
    {   
        y : Int,
        x : Int,
        value : Int,
        isMine: Bool,
        visibility: Bool
    }