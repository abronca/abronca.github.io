module View.PortfolioPage exposing (portfolioPage)

import Element exposing (..)
import Element.Attributes exposing (..)
import Msg exposing (Msg)
import Styles exposing (Styles(..))


portfolioPage : Element Styles variation Msg
portfolioPage =
    column Menu
        [ center ]
        [ portfolioItem
            { link = "https://github.com/albronca/sloth"
            , title = "sloth"
            , description = "(a rails/react/redux slack clone)"
            }
        , portfolioItem
            { link = "https://github.com/albronca/snake"
            , title = "snake"
            , description = "(using oo principles and a little jquery)"
            }
        , portfolioItem
            { link = "https://github.com/albronca/chessrb"
            , title = "chess"
            , description = "(a cli game written in ruby)"
            }
        ]


type alias PortfolioItemOptions =
    { link : String
    , title : String
    , description : String
    }


portfolioItem : PortfolioItemOptions -> Element Styles variation Msg
portfolioItem options =
    column PortfolioItem
        [ center ]
        [ link options.link (el MenuLink [] (text options.title))
        , text options.description
        ]
