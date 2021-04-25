module Minefield exposing (..)
import Types exposing(..)
import Mine exposing (..)
import Case exposing (..)

mine_field : Options -> Cmd Msg
mine_field defaultO= Mine.generateRandomMines
        defaultO
        MinesGenerated
 
init_battleField : Options -> List Case
init_battleField options = 
        createCaseList options.height options.width

setBattlefield : List Case -> List (Int,Int) -> List Case
setBattlefield battle_field mines =
        case mines of
                [] -> battle_field
                (y,x)::tl ->
                        setBattlefield (initBattleFieldMines battle_field y x) tl


initBattleFieldMines : List Case -> Int -> Int -> List Case
initBattleFieldMines battle_field y x =
        case battle_field of
                [] -> battle_field
                hd_b::tl_b ->
                        if x == hd_b.x && y == hd_b.y then
                                {hd_b | value = hd_b.value, isMine = True} :: (initBattleFieldMines tl_b y x)
                        else
                                if 
                                        ((hd_b.x + 1) == x && hd_b.y == y) ||
                                        ((hd_b.x - 1) == x && hd_b.y == y) ||
                                        (hd_b.x == x && (hd_b.y + 1) == y) ||
                                        (hd_b.x == x && (hd_b.y - 1) == y) ||
                                        ((hd_b.x + 1) == x && (hd_b.y + 1) == y) ||
                                        ((hd_b.x + 1) == x && (hd_b.y - 1) == y) ||
                                        ((hd_b.x - 1) == x && (hd_b.y + 1) == y) ||
                                        ((hd_b.x - 1) == x && (hd_b.y - 1) == y)
                                        then
                                        {hd_b | value = hd_b.value + 1, isMine = hd_b.isMine } :: (initBattleFieldMines tl_b y x)
                                else
                                        hd_b :: (initBattleFieldMines tl_b y x)

