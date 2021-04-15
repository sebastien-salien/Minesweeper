module Minefield exposing (..)
import Types exposing(..)
import Mine exposing (..)
import Case exposing (..)
import Array exposing (Array)
import Array2D exposing(Array2D)

options : Options
options = { 
        width = 10,
        height = 10,
        minMines = 5,
        maxMines = 10,
        initialX = 0,
        initialY = 0
        }

mine_field : Cmd Msg
mine_field = Mine.generateRandomMines
        options
        MinesGenerated
 
init_battleField : Array2D Case
init_battleField = 
        Array2D.fromList (createCaseList 10)