module Main exposing (..)

import Browser
import Html exposing (Html, div, h1, img, text)
import Html.Attributes exposing (src)
import Types exposing (..)
import Minefield exposing(..)
import Html.Attributes exposing (style, class)
import Html.Events exposing (onClick)
import Html exposing (button)
import Html exposing (b)

init : ( Model, Cmd Msg )
init =
    ( {battle_field = init_battleField, mines = []}, mine_field)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MinesGenerated arg0 ->
            ({model | mines = arg0, battle_field = (setBattlefield model.battle_field arg0)}, Cmd.none)
        SelectArea argX argY ->
            ((viewUpdate model argX argY), Cmd.none)

view : Model -> Html Msg
view model =
    div []
        [ img [ src "/logo.svg" ] []
        , h1 [] [ text "Your Elm App is working!" ]
        , text "Implémentez le démineur !"
        ,div [ style "display" "grid", style "grid-template-columns" "repeat(10, 50px)" ]
            (viewDiv2 model 99 model.battle_field)
        ]


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = always init
        , update = update
        , subscriptions = always Sub.none
        }


-- viewDiv : Model -> Int -> List Case -> List (Html Msg)
-- viewDiv model n cases =
--     let
--         h = List.head cases
--         drop = List.drop n cases
--     in
    
--     if n == 0 
--         then 
--              [button[onClick(SelectArea h.x h.y),style "width" "50px", style "height" "50px"][]]
--         else 
--             viewDiv model (n-1) drop ++ [button[onClick(SelectArea h.x h.y),style "width" "50px", style "height" "50px"][]]
            

viewDiv2 :  Model -> Int -> List Case -> List (Html Msg)
viewDiv2 model n cases =
    case cases of
        [] -> []

        hd :: tm -> viewDiv2 model (n-1) tm ++ 
            [button [onClick(SelectArea hd.x hd.y), class "case"]
            [
            if hd.visibility == True then
                if hd.isMine then
                    text "💣"
                else
                text (String.fromInt (1))

                else
                text ""
            ]]


--onClick((SelectArea ht.x ht.y)),



-- viewCell : List Cell -> Cell -> Html Msg
-- viewCell cells cell =
--     button
--         [ onClick (Reveal cell.id), style "width" "50px", style "height" "50px" ]
--         [ if cell.revealed then
--             if cell.isMine then
--                 text "💣"

--             else
--                 text (String.fromInt (numberOfBombsAround cells cell.id))

--           else
--             text ""
--         ]

viewVisibility : List Case -> Int -> Int -> List Case
viewVisibility cases x y = 
    case cases of
        [] -> []

        th :: tm ->  if x== th.x && y == th.y then
                                ({ th | visibility = True } :: tm)
                    else 
                      th :: viewVisibility tm x y 


viewUpdate : Model ->  Int ->  Int -> Model
viewUpdate model x y =
    {model | battle_field = viewVisibility model.battle_field x y}