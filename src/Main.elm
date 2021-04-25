module Main exposing (..)

import Browser
import Html exposing (Html, div, h1,h2, span, text)
import Html.Attributes exposing (src)
import Types exposing (..)
import Minefield exposing(..)
import Html.Attributes exposing (style, class, attribute)
import Html.Events exposing (onClick,on)
import Html exposing (button)
import Html exposing (b)
import List.Extra
import Html exposing (Attribute)
import Html.Events.Extra.Mouse as Mouse
import Case exposing (..)
import Types exposing (Msg(..))
init : ( Model, Cmd Msg )
init =
    let
        defaultOption : Options
        defaultOption = { 
                width = 10,
                height = 10,
                minMines = 10,
                maxMines = 10
            }
    in
    
    ( {battle_field = init_battleField defaultOption
        , mines = []
        , cptFlag =0
        , canPlay = True
        , options = defaultOption
        , customOptions = defaultOption
        }, mine_field defaultOption)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =    
    case msg of
        MinesGenerated arg0 ->
            ({model | mines = arg0, battle_field = (setBattlefield model.battle_field arg0), cptFlag = (List.length arg0)}, Cmd.none)
        OpenCase argX argY ->
            ((viewUpdateVisibility model argX argY), Cmd.none)
        SetFlag argX argY ->
            ((viewUpdateFlag model argX argY), Cmd.none)
        DefaultReset -> 
            ( {battle_field = init_battleField model.customOptions, mines = [], cptFlag =0, canPlay = True, options = model.customOptions, customOptions = model.customOptions}, mine_field model.customOptions)
        CustomReset -> 
            ( {battle_field = init_battleField model.customOptions, mines = [], cptFlag =0, canPlay = True, options = model.customOptions, customOptions = model.customOptions}, mine_field model.customOptions)
        IncrementWidth ->
            let
                updateCustomOptions: Options
                updateCustomOptions = { width = model.customOptions.width +1, height = model.customOptions.height, minMines = model.customOptions.minMines, maxMines = model.customOptions.maxMines}
            in
            ({model | customOptions = updateCustomOptions}, Cmd.none)
        DecrementWidth ->
            let
                updateCustomOptions: Options
                updateCustomOptions = { width = if (model.customOptions.width > 0)  then model.customOptions.width - 1 else 0, height = model.customOptions.height, minMines = model.customOptions.minMines, maxMines = model.customOptions.maxMines}
            in
            ({model | customOptions = updateCustomOptions}, Cmd.none)
        IncrementHeight ->
            let
                updateCustomOptions: Options
                updateCustomOptions = { width = model.customOptions.width, height = model.customOptions.height + 1, minMines = model.customOptions.minMines, maxMines = model.customOptions.maxMines}
            in
            ({model | customOptions = updateCustomOptions}, Cmd.none)
        DecrementHeight ->
            let
                updateCustomOptions: Options
                updateCustomOptions = { width = model.customOptions.width, height = if (model.customOptions.height - 1 > 0) then model.customOptions.height - 1 else 0, minMines = model.customOptions.minMines, maxMines = model.customOptions.maxMines}
            in
            ({model | customOptions = updateCustomOptions}, Cmd.none)
        IncrementMinMines ->
            let
                updateCustomOptions: Options
                updateCustomOptions = { width = model.customOptions.width , height = model.customOptions.height, minMines = if (model.customOptions.minMines <= model.customOptions.maxMines) then model.customOptions.minMines + 1 else model.customOptions.minMines, maxMines = model.customOptions.maxMines}
            in
            ({model | customOptions = updateCustomOptions}, Cmd.none)
        DecrementMinMines ->
            let
                updateCustomOptions: Options
                updateCustomOptions = { width = model.customOptions.width , height = model.customOptions.height, minMines = if (model.customOptions.minMines > 0) then model.customOptions.minMines - 1 else 0, maxMines = model.customOptions.maxMines}
            in
            ({model | customOptions = updateCustomOptions}, Cmd.none)
        IncrementMaxMines ->
            let
                updateCustomOptions: Options
                updateCustomOptions = { width = model.customOptions.width , height = model.customOptions.height, minMines = model.customOptions.maxMines, maxMines = if (model.customOptions.maxMines < model.customOptions.width * model.customOptions.height) then model.customOptions.height +1 else model.customOptions.maxMines}
            in
            ({model | customOptions = updateCustomOptions}, Cmd.none)
        DecrementMaxMines ->
            let
                updateCustomOptions: Options
                updateCustomOptions = { width = model.customOptions.width , height = model.customOptions.height, minMines = model.customOptions.minMines, maxMines = if (model.customOptions.maxMines - 1 > model.customOptions.minMines) then model.customOptions.maxMines - 1 else model.customOptions.maxMines}
            in
            ({model | customOptions = updateCustomOptions}, Cmd.none)
        Default ->
            (model, Cmd.none)

view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Minesweeper" ]
        , h2 [] [text (if (model.canPlay) then "" else "You lost !")]
        , span [] [text ("flag available : " ++ (String.fromInt model.cptFlag))]
        , button [Mouse.onClick (\event -> DefaultReset ), class "reset" ] [ text "reset" ]
        , div [ class "battle_field", style "grid-template-columns" ("repeat(" ++ String.fromInt model.options.width ++", 50px)")]
            (viewDiv2 model 99 model.battle_field)
        , h2 [] [text "Custom Reset"]
        , div [class "set_custom_options"] [
          span [] [text "Custom Height :  "]
        , div [class "custom_options"]
            [ button [ onClick DecrementHeight ] [ text "-" ]
            , div [class "custom_value"] [ text (String.fromInt model.customOptions.height) ]
            , button [ onClick IncrementHeight ] [ text "+" ]] ]
        , div [class "set_custom_options"] [
          span [] [text "Custom Width :  "]
        , div [class "custom_options"]
            [ button [ onClick DecrementWidth ] [ text "-" ]
            , div [class "custom_value"] [ text (String.fromInt model.customOptions.width) ]
            , button [ onClick IncrementWidth ] [ text "+" ]] ]
        , div [class "set_custom_options"] [
          span [] [text "Custom MinMines :  "]
        , div [class "custom_options"]
            [ button [ onClick DecrementMinMines ] [ text "-" ]
            , div [class "custom_value"] [ text (String.fromInt model.customOptions.minMines) ]
            , button [ onClick IncrementMinMines ] [ text "+" ]] ]
        , div [class "set_custom_options"] [
          span [] [text "Custom MaxMines :  "]
        , div [class "custom_options"]
            [ button [ onClick DecrementMaxMines ] [ text "-" ]
            , div [class "custom_value"] [ text (String.fromInt model.customOptions.maxMines) ]
            , button [ onClick IncrementMaxMines ] [ text "+" ]] ]
        , button [Mouse.onClick (\event -> CustomReset ), class "custom_reset" ] [ text "Apply Custom Reset" ]
        ]


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = always init
        , update = update
        , subscriptions = always Sub.none
        }


viewDiv2 :  Model -> Int -> List Case -> List (Html Msg)
viewDiv2 model n cases =
    case cases of
        [] -> []
        hd :: tm -> 
            List.append [button [Mouse.onContextMenu (\event -> cutomClick event hd),Mouse.onClick (\event -> cutomClick event hd) , 
            setCaseStyle hd          
            , attribute "y" (String.fromInt hd.y), attribute "x" (String.fromInt hd.x)]
            [
            if hd.visibility == True then
                    if hd.isMine then
                        text "💣"
                    else
                        text (
                            if hd.value /= 0 then
                                String.fromInt (hd.value)
                            else
                                ""
                            )
                else
                    if hd.flagRaised == True then
                        text "🚩"
                    else
                        text ""
            ]] (viewDiv2 model (n-1) tm )

cutomClick : Mouse.Event -> Case -> Msg
cutomClick mouseEvent hd =
    case mouseEvent.button of
        Mouse.MainButton ->
            (OpenCase hd.x hd.y)
        Mouse.SecondButton ->
            (SetFlag hd.x hd.y)
        _ ->
            Default

setCaseStyle : Case -> Attribute Msg
setCaseStyle case_ =
    class ("case "
    ++ if case_.visibility && case_.isMine == False then
        if case_.value == 0 then "empty " else ""
        ++ if case_.value == 1 then "res-1 " else ""
        ++ if case_.value == 2 then "res-2 " else ""
        ++ if case_.value == 3 then "res-3 " else ""
        ++ if case_.value == 4 then "res-4 " else ""
        ++ if case_.value == 5 then "res-5 " else ""
        ++ if case_.value == 6 then "res-6 " else ""
        ++ if case_.value == 7 then "res-7 " else ""
        ++ if case_.value == 8 then "res-8 " else ""
    else ""
    )

viewUpdateVisibility_ : List Case -> Int -> Int -> List Case
viewUpdateVisibility_ cases x y = 
  let case_ = List.Extra.find (isCase x y) cases in
  case case_ of
    Nothing -> cases
    Just myCase ->
      if myCase.visibility then
        cases
      else
        let
            newBord : List Case
            newBord = (List.Extra.updateIf (isCaseWithoutFlag x y) (\c -> { c | visibility = True } ) cases)
        in
        if myCase.value > 0 || myCase.isMine then
            newBord
        else 
            List.foldl 
            (\(x_, y_) acc -> viewUpdateVisibility_ acc x_ y_)
            newBord
            [ (x, y - 1)
            , (x, y + 1)
            , (x + 1, y)
            , (x - 1, y)
            , (x - 1, y + 1)
            , (x - 1, y - 1)
            , (x + 1, y + 1)
            , (x + 1, y - 1)
            ]

viewUpdateFlag_ : List Case -> Int -> Int -> List Case
viewUpdateFlag_ cases x y =
    List.Extra.updateIf (isCase x y) (\c -> { c | flagRaised = (c.flagRaised == False) }) cases

viewUpdateCptFlag_ :  List Case -> Int-> Int-> Int -> Int
viewUpdateCptFlag_ battle_field x y cptFlag =
    case battle_field of
        [] -> cptFlag
        hd::tl ->
            if (isCase x y hd) then
                if (hd.flagRaised) then
                    cptFlag + 1
                else
                    cptFlag - 1
            else
                viewUpdateCptFlag_ tl x y cptFlag

viewUpdateVisibility : Model ->  Int ->  Int -> Model
viewUpdateVisibility model x y =
    if model.canPlay then
        {model | battle_field = viewUpdateVisibility_ model.battle_field x y, canPlay = isCaseContainsMine model.battle_field x y}
    else
        model

viewUpdateFlag : Model ->  Int ->  Int -> Model
viewUpdateFlag model x y =
    if (model.cptFlag == 0 ) then 
        model
    else
        {model | battle_field = viewUpdateFlag_ model.battle_field x y, cptFlag = viewUpdateCptFlag_ model.battle_field x y model.cptFlag}

