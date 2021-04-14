module Case exposing (getValue, getcoordinate,isMine)
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