module Home.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Home.Model as HomeModel exposing (..)
import Game.Model as GameModel exposing (..)
import Types exposing (..)


view : HomeModel.Model -> Html Msg
view model =
    div
        [ id "home_index"
        , class "view-container"
        ]
        [ headerView
        , currentGames model
        , footerView
        ]


headerView : Html Msg
headerView =
    header
        []
        [ logo
        , h1
            []
            [ text "Ahoy Matey, "
            , br [] []
            , text "welcome to Phoenix Battleship!"
            ]
        , p []
            [ text "The "
            , a [ href "https://en.wikipedia.org/wiki/Battleship_(game)", target "_blank" ]
                [ text "Good Old game" ]
            , text ", built with "
            , a [ href "http://elixir-lang.org/", target "_blank" ]
                [ text "Elixir" ]
            , text ", "
            , a [ href "http://www.phoenixframework.org/", target "_blank" ]
                [ text "Phoenix" ]
            , text " and "
            , a [ href "http://elm-lang.org/", target "_blank" ]
                [ text "Elm" ]
            ]
        , button
            []
            [ text "Start new battle, arr!" ]
        ]


currentGames : HomeModel.Model -> Html Msg
currentGames model =
    if List.length model.games == 0 then
        section
            []
            [ text "No games" ]
    else
        section
            []
            [ h2
                []
                [ text "Current games" ]
            , model.games
                |> List.map gameView
                |> ul
                    [ attribute "class" "current-games" ]
            ]


gameView : GameModel.Model -> Html Msg
gameView game =
    let
        gameInfo =
            case game.defender of
                Nothing ->
                    (a
                        [ class "button small" ]
                        [ text "join" ]
                    )

                Just defender ->
                    lastTurnView game
    in
        li
            []
            [ text (Maybe.withDefault "" game.id)
            , gameInfo
            ]


lastTurnView : GameModel.Model -> Html Msg
lastTurnView game =
    case List.head game.turns of
        Nothing ->
            text ""

        Just turn ->
            ul
                [ class "stats-list" ]
                []


footerView : Html Msg
footerView =
    footer []
        [ p []
            [ text "crafted with ♥ by "
            , a [ href "http://codeloveandboards.com/", target "_blank" ]
                [ text "@bigardone" ]
            ]
        , p []
            [ a [ href "https://github.com/bigardone/phoenix-battleship", target "_blank" ]
                [ i [ attribute "className" "fa fa-github" ]
                    []
                , text " source code"
                ]
            ]
        ]


logo : Html Msg
logo =
    img
        [ class "logo"
        , src "data:image/png;base64,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"
        ]
        []
