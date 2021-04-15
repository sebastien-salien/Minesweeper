module Case exposing (..)
import Browser.Events exposing (..)
import Types exposing (..)


getcoordinate :Case -> (Int, Int)
getcoordinate point =
    ( point.y, point.x )

getValue :Case -> Int
getValue point =
    point.value

isMine :Case -> Bool
isMine point =
    point.isMine

createCase : Int -> Int -> Case
createCase y x =
    {
        x=x,
        y=y,
        value = 0,
        isMine = False,
        visibility = False
    }
