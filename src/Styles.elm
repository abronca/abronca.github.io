module Styles exposing (..)

import Color exposing (..)
import Style exposing (..)
import Style.Color as Color
import Style.Font as Font exposing (font, sansSerif)


type Styles
    = Main
    | Header
    | Menu
    | MenuLink
    | CurrentPage
    | About
    | AboutBullet
    | AboutItem
    | Constant
    | PortfolioItem


stylesheet : StyleSheet Styles variation
stylesheet =
    styleSheet
        [ style Main
            [ Font.typeface [ font "Inconsolata", sansSerif ]
            , Font.size 30
            , Color.text (rgb 188 188 188)
            , Color.background (rgb 38 38 38)
            ]
        , style Header
            [ Font.size 34
            , Font.bold
            , Color.text (rgb 181 189 104)
            ]
        , style Menu []
        , style MenuLink
            [ Color.text (rgb 129 162 178)
            , hover [ Font.bold ]
            , Font.center
            ]
        , style CurrentPage []
        , style About []
        , style AboutBullet
            [ Font.bold
            , Color.text (rgb 181 189 104)
            ]
        , style AboutItem []
        , style Constant
            [ Color.text (rgb 240 198 116)
            ]
        , style PortfolioItem []
        ]
