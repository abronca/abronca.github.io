module View.PortfolioPage exposing (portfolioPage)

import Html exposing (..)
import Html.Attributes exposing (..)
import Msg exposing (Msg)
import View.Utils exposing (homeArrow)


portfolioPage : Html Msg
portfolioPage =
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
