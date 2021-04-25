module Mine exposing (Mine, generateRandomMines)

import Random exposing (Generator)
import Set
import Types exposing (..)

type alias Mine =
    ( Int, Int )


randomMinesGeneratorList : Options -> Int -> Generator (List Mine)
randomMinesGeneratorList { width, height } len =
    Random.list len <|
        Random.pair
            (Random.int 0 (width-1))
            (Random.int 0 (height-1))

relaunch : Options -> List Mine -> Generator (List Mine)
relaunch ({ minMines } as options) l =
    if List.length l >= minMines && not (List.member ( 0, 0 ) l) then
        Random.constant l

    else
        randomMinesGenerator options

randomMinesGenerator : Options -> Generator (List Mine)
randomMinesGenerator ({ width, height, minMines, maxMines } as options) =
    Random.int minMines maxMines
        |> Random.andThen (randomMinesGeneratorList options)
        |> Random.map (Set.fromList >> Set.toList)
        |> Random.andThen (relaunch options)


generateRandomMines : Options -> (List Mine -> msg) -> Cmd msg
generateRandomMines options msg =
    Random.generate msg (randomMinesGenerator options)
