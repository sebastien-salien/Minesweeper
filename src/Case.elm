module Case exposing (Case, getValue, getcoordinate,isMine)
import Browser.Events exposing (Visibility)
type alias Case =
    {   
        y : Int,
        x : Int,
        value : Int,
        isMine: Bool,
        visibility: Bool
    }


getcoordinate :Case -> (Int, Int)
getcoordinate point =
    ( point.y, point.x )

getValue :Case -> Int
getValue point =
    point.value

isMine :Case -> Bool
isMine point =
    point.isMine