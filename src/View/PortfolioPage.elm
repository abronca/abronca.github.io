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
            { title = "sloth"
            , description = "slack clone in rails/react/redux"
            , liveLink = "https://sloth.chat"
            , gitHubLink = "https://github.com/albronca/sloth"
            }
        , portfolioItem
            { title = "space melons"
            , description = "svg and randomness in elm"
            , liveLink = "https://a-b.sh/space-melons"
            , gitHubLink = "https://github.com/albronca/space-melons"
            }
        ]


type alias PortfolioItemOptions =
    { liveLink : String
    , gitHubLink : String
    , title : String
    , description : String
    }


portfolioItem : PortfolioItemOptions -> Element Styles variation Msg
portfolioItem options =
    column None
        [ center ]
        [ paragraph Constant [] [ text options.title ]
        , row None
            []
            [ link options.liveLink (el MenuLink [] (text "live"))
            , el None [] (text "|")
            , link options.gitHubLink (el MenuLink [] (text "github"))
            ]
        , paragraph PortfolioItemDesc [ padding 10 ] [ text ("(" ++ options.description ++ ")") ]
        ]
