module View exposing (view)

import Html exposing (Html)
import Element exposing (..)
import Element.Attributes exposing (..)
import Msg exposing (Msg)
import Model exposing (Model, Route(..))
import Styles exposing (Styles(..), stylesheet)
import View.AboutPage exposing (aboutPage)
import View.ContactPage exposing (contactPage)
import View.HomePage exposing (homePage)
import View.PortfolioPage exposing (portfolioPage)


view : Model -> Html Msg
view model =
    viewport stylesheet <|
        column Main
            [ height fill ]
            [ header
            , el CurrentPage
                [ maxWidth (px 600), center ]
                (currentPage model)
            ]


header : Element Styles variation Msg
header =
    column Header
        [ paddingXY 0 30, center ]
        [ text "🐊"
        , text "alexander bronca"
        ]


currentPage : Model -> Element Styles variation Msg
currentPage model =
    case model.route of
        HomeRoute ->
            homePage

        AboutRoute ->
            aboutPage |> withBackButton

        PortfolioRoute ->
            portfolioPage |> withBackButton

        ContactRoute ->
            contactPage |> withBackButton

        NotFoundRoute ->
            empty


withBackButton : Element Styles variation Msg -> Element Styles variation Msg
withBackButton page =
    column CurrentPage
        [ center ]
        [ page
        , link "#" (el MenuLink [ padding 30 ] (text "←"))
        ]
