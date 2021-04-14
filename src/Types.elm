module Types exposing (..)

type Msg
    = MinesGenerated (List ( Int, Int ))

type alias Case =
    {   
        y : Int,
        x : Int,
        value : Int,
        isMine: Bool,
        visibility: Bool
    }