module Types exposing (..)

type Msg
    = MinesGenerated (List ( Int, Int )) | OpenCase Int Int | SetFlag Int Int| Default
type alias Model =
    {battle_field :List Case, mines : List (Int,Int), cptFlag : Int}
    
type alias Case =
    {   
        y : Int,
        x : Int,
        value : Int,
        flagRaised : Bool,
        isMine: Bool,
        visibility: Bool
    }