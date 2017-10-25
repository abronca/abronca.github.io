module Styles exposing (..)

import Color exposing (..)
import Style exposing (..)
import Style.Color as Color
import Style.Font as Font exposing (font, sansSerif)


type Styles
    = None
    | Main
    | Header
    | MenuLink
    | AboutBullet
    | Constant
    | PortfolioItemDesc
    | SmallText


stylesheet : StyleSheet Styles variation
stylesheet =
    styleSheet
        [ style None []
        , style Main
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
        , style MenuLink
            [ Color.text (rgb 129 162 178)
            , hover [ Font.bold ]
            , Font.center
            ]
        , style AboutBullet
            [ Font.bold
            , Color.text (rgb 181 189 104)
            ]
        , style Constant
            [ Color.text (rgb 240 198 116)
            ]
        , style PortfolioItemDesc
            [ Font.center
            ]
        , style SmallText
            [ Font.size 20
            ]
        ]
