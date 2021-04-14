module Minefield exposing (..)
import Types exposing(..)
import Mine exposing (..)

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

init_battleField : List number
init_battleField = 
    [0,1,2]

