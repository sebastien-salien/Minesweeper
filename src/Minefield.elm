module Minefield exposing (..)
import Types exposing(..)
import Mine exposing (..)
import Case exposing (..)

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
 
init_battleField : List Case
init_battleField = 
        createCaseList options.height options.width


setBattlefield : List Case -> List (Int,Int) -> List Case
setBattlefield battle_field mines =
        case mines of
                [] -> battle_field
                (y,x)::tl ->
                        setBattlefield (updateBattleField battle_field y x) tl


updateBattleField : List Case -> Int -> Int -> List Case
updateBattleField battle_field y x =
        case battle_field of
                [] -> battle_field
                hd_b::tl_b ->
                        if x== hd_b.x && y == hd_b.y then
                                {hd_b | isMine = True } :: tl_b
                        else
                                hd_b :: updateBattleField tl_b x y