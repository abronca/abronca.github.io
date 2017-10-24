module View.HomePage exposing (homePage)

import Html exposing (..)
import Html.Attributes exposing (..)
import Msg exposing (Msg)


homePage : Html Msg
homePage =
    nav [ class "menu" ]
        [ a [ href "#about" ] [ text "about" ]
        , a [ href "#portfolio" ] [ text "portfolio" ]
        , a [ href "#contact" ] [ text "contact" ]
        ]
