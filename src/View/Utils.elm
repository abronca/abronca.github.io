module View.Utils exposing (homeArrow, question, answer, constant)

import Html exposing (..)
import Html.Attributes exposing (..)
import Msg exposing (Msg)


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
