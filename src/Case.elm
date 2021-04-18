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

createCase : Int -> Int -> Bool -> Case
createCase y x mine=
    {
        x = x,
        y = y,
        value = 0,
        isMine = mine,
        visibility = False
    }

createCaseList: Int -> Int ->List Case
createCaseList maxY maxX =
    if (maxY == 0) then
        []
    else
    (createCaseList (maxY-1) maxX) ++ (createCaseListHelpers (maxY-1) 0 maxX)

createCaseListHelpers: Int -> Int -> Int -> List Case
createCaseListHelpers y x maxValue =
    if (x == maxValue) then
        []
    else
        [(createCase y x False)] ++ (createCaseListHelpers y (x+1) maxValue)