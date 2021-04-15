module Minefield exposing (..)
import Types exposing(..)
import Mine exposing (..)
import Case exposing (..)
import Array exposing (Array)

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

init_battleField : List (List Case)
init_battleField = 
        [[(createCase 0 0)],[(createCase 0 0)]]