module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


main : Program Never Model Msg
main =
    beginnerProgram
        { model = model
        , view = view
        , update = update
        }



-- MODEL


type alias Model =
    { route : Route }


type Route
    = Home
    | About
    | Portfolio
    | Contact


model : Model
model =
    { route = Home }



-- VIEW


view : Model -> Html Msg
view model =
    div [ class "main" ]
        [ header
        , page model.route
        ]


header : Html Msg
header =
    h1 [ class "header" ]
        [ div [] [ text "🐊" ]
        , div [] [ text "alexander bronca" ]
        ]


page : Route -> Html Msg
page route =
    case route of
        Home ->
            home

        About ->
            about

        Portfolio ->
            portfolio

        Contact ->
            contact


home : Html Msg
home =
    nav [ class "menu" ]
        [ a [ href "#", onClick (GoTo About) ] [ text "about" ]
        , a [ href "#", onClick (GoTo Portfolio) ] [ text "portfolio" ]
        , a [ href "#", onClick (GoTo Contact) ] [ text "contact" ]
        ]


about : Html Msg
about =
    div []
        [ div [ class "dialogue" ]
            [ question [ text "What do you do?" ]
            , answer
                [ text "I write code in NYC. I'm proficient in "
                , span [ class "constant" ] [ text "JavaScript" ]
                , text ", "
                , span [ class "constant" ] [ text "Ruby" ]
                , text ", and "
                , span [ class "constant" ] [ text "SQL" ]
                , text ". I'm also comfortable with "
                , span [ class "constant" ] [ text "Rails" ]
                , text ", "
                , span [ class "constant" ] [ text "React" ]
                , text ", and "
                , span [ class "constant" ] [ text "Redux" ]
                , text ". I currently teach at App Academy NYC."
                ]
            , question [ text "Do you have any hobbies?" ]
            , answer
                [ text "Some of my favorite video games are "
                , span [ class "constant" ] [ text "EarthBound" ]
                , text ", "
                , span [ class "constant" ] [ text "Fez" ]
                , text ", and "
                , span [ class "constant" ] [ text "Portal" ]
                , text ". I also play guitar and occasionally write music."
                ]
            ]
        , nav [ class "menu" ] [ homeArrow ]
        ]


question : List (Html Msg) -> Html Msg
question children =
    p [ class "question" ] children


answer : List (Html Msg) -> Html Msg
answer children =
    p [ class "answer" ] children


portfolio : Html Msg
portfolio =
    nav [ class "menu" ]
        [ p [ class "portfolio-item" ]
            [ a [ href "https://github.com/albronca/sloth" ] [ text "sloth" ]
            , text "(a rails/react/redux slack clone)"
            ]
        , p [ class "portfolio-item" ]
            [ a [ href "https://github.com/albronca/snake" ] [ text "snake" ]
            , text "(using oo principles and a little jquery"
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
    a [ href "#", onClick (GoTo Home) ] [ text "←" ]



-- UPDATE


type Msg
    = GoTo Route


update : Msg -> Model -> Model
update msg model =
    case msg of
        GoTo route ->
            { model | route = route }
