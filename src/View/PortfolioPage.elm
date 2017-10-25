module View.PortfolioPage exposing (portfolioPage)

import Element exposing (..)
import Element.Attributes exposing (..)
import Msg exposing (Msg)
import Styles exposing (Styles(..))


portfolioPage : Element Styles variation Msg
portfolioPage =
    column None
        [ center, spacing 6 ]
        [ portfolioItem
            { link = "https://github.com/albronca/sloth"
            , title = "sloth"
            , description = "(a rails/react/redux slack clone)"
            }
        , portfolioItem
            { link = "https://a-b.sh/space-melons"
            , title = "space melons"
            , description = "fun with svg and randomness in elm"
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
    column None
        [ center ]
        [ link options.link (el MenuLink [] (text options.title))
        , paragraph PortfolioItemDesc [] [ text options.description ]
        ]
