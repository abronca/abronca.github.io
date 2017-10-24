module View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Msg exposing (Msg(..))
import Model exposing (Model, Route(..))
import View.AboutPage exposing (aboutPage)
import View.ContactPage exposing (contactPage)
import View.HomePage exposing (homePage)
import View.PortfolioPage exposing (portfolioPage)
import View.Utils exposing (homeArrow)


view : Model -> Html Msg
view model =
    div [ class "main" ]
        [ header
        , currentPage model
        ]


header : Html Msg
header =
    h1 [ class "header" ]
        [ div [] [ text "🐊" ]
        , div [] [ text "alexander bronca" ]
        ]


currentPage : Model -> Html Msg
currentPage model =
    case model.route of
        HomeRoute ->
            homePage

        AboutRoute ->
            aboutPage

        PortfolioRoute ->
            portfolioPage

        ContactRoute ->
            contactPage

        NotFoundRoute ->
            div []
                [ p [] [ text "404 - Page not found" ]
                , nav [ class "menu" ] [ homeArrow ]
                ]
