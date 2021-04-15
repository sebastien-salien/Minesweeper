module Case exposing (..)
import Browser.Events exposing (..)
import Types exposing (..)
import Html exposing (datalist)
import Dict exposing (size)


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

createCaseList: Int -> List (List Case)
createCaseList y =
    if (y == 0) then
        []
    else
    (createCaseList (y-1)) ++ [(createCaseListHelpers (y-1) 0 10)]

createCaseListHelpers: Int -> Int -> Int -> List Case
createCaseListHelpers y x maxValue =
    if (x == 10) then
        []
    else
        [(createCase y x)] ++ (createCaseListHelpers y (x+1) maxValue)