module View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Msg exposing (Msg(..))
import Model exposing (Model, Route(..))


view : Model -> Html Msg
view model =
    div [ class "main" ]
        [ header
        , page model
        ]


header : Html Msg
header =
    h1 [ class "header" ]
        [ div [] [ text "🐊" ]
        , div [] [ text "alexander bronca" ]
        ]


page : Model -> Html Msg
page model =
    case model.route of
        HomeRoute ->
            home

        AboutRoute ->
            about

        PortfolioRoute ->
            portfolio

        ContactRoute ->
            contact

        NotFoundRoute ->
            div []
                [ p [] [ text "404 - Page not found" ]
                , nav [ class "menu" ] [ homeArrow ]
                ]


home : Html Msg
home =
    nav [ class "menu" ]
        [ a [ href "#about" ] [ text "about" ]
        , a [ href "#portfolio" ] [ text "portfolio" ]
        , a [ href "#contact" ] [ text "contact" ]
        ]


about : Html Msg
about =
    div []
        [ div [ class "dialogue" ]
            [ question [ text "What do you do?" ]
            , answer
                [ text "I write code in NYC. I'm proficient in "
                , constant "JavaScript"
                , text ", "
                , constant "Ruby"
                , text ", and "
                , constant "SQL"
                , text ". I'm comfortable using "
                , constant "Rails"
                , text ", "
                , constant "React"
                , text ", and "
                , constant "Redux"
                , text ". I currently teach at App Academy NYC."
                ]
            , question [ text "Do you have any hobbies?" ]
            , answer
                [ text "Some of my favorite video games are "
                , constant "EarthBound"
                , text ", "
                , constant "Fez"
                , text ", and "
                , constant "Portal"
                , text ". I also play guitar and occasionally write music."
                ]
            ]
        , nav [ class "menu" ] [ homeArrow ]
        ]


portfolio : Html Msg
portfolio =
    nav [ class "menu" ]
        [ p [ class "portfolio-item" ]
            [ a [ href "https://github.com/albronca/sloth" ] [ text "sloth" ]
            , text "(a rails/react/redux slack clone)"
            ]
        , p [ class "portfolio-item" ]
            [ a [ href "https://github.com/albronca/snake" ] [ text "snake" ]
            , text "(using oo principles and a little jquery)"
            ]
        , p [ class "portfolio-item" ]
            [ a [ href "https://github.com/albronca/chessrb" ] [ text "chess" ]
            , text "(a cli game written in ruby)"
            ]
        , homeArrow
        ]


contact : Html Msg
contact =
    nav [ class "menu" ]
        [ a [ href "mailto:alexander.bronca@gmail.com" ] [ text "email" ]
        , a [ href "https://github.com/albronca" ] [ text "github" ]
        , a [ href "https://www.linkedin.com/in/albronca/" ] [ text "linkedin" ]
        , a [ href "https://twitter.com/al_br_" ] [ text "twitter" ]
        , homeArrow
        ]


homeArrow : Html Msg
homeArrow =
    a [ href "#" ] [ text "←" ]


question : List (Html Msg) -> Html Msg
question children =
    p [ class "question" ] children


answer : List (Html Msg) -> Html Msg
answer children =
    p [ class "answer" ] children


constant : String -> Html Msg
constant text_ =
    span [ class "constant" ] [ text text_ ]
