module View.AboutPage exposing (aboutPage)

import Html exposing (..)
import Html.Attributes exposing (..)
import Msg exposing (Msg)
import View.Utils exposing (question, answer, constant, homeArrow)


aboutPage : Html Msg
aboutPage =
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
