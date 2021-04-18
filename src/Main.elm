module Main exposing (..)

import Browser
import Html exposing (Html, div, h1, img, text)
import Html.Attributes exposing (src)
import Types exposing (..)
import Minefield exposing(..)

init : ( Model, Cmd Msg )
init =
    ( {battle_field = init_battleField, mines = []}, mine_field)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MinesGenerated arg0 ->
            ({model | mines = arg0, battle_field = (setBattlefield model.battle_field arg0)}, Cmd.none)
        SelectArea argY ->
                (model, Cmd.none)



view : Model -> Html Msg
view model =
    div []
        [ img [ src "/logo.svg" ] []
        , h1 [] [ text "Your Elm App is working!" ]
        , text "Implémentez le démineur !"
        ]


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = always init
        , update = update
        , subscriptions = always Sub.none
        }
