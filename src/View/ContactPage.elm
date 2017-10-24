module View.ContactPage exposing (contactPage)

import Html exposing (..)
import Html.Attributes exposing (..)
import Msg exposing (Msg)
import View.Utils exposing (homeArrow)


contactPage : Html Msg
contactPage =
    nav [ class "menu" ]
        [ a [ href "mailto:alexander.bronca@gmail.com" ] [ text "email" ]
        , a [ href "https://github.com/albronca" ] [ text "github" ]
        , a [ href "https://www.linkedin.com/in/albronca/" ] [ text "linkedin" ]
        , a [ href "https://twitter.com/al_br_" ] [ text "twitter" ]
        , homeArrow
        ]
