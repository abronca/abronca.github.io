module Main exposing (main)

import Browser exposing (application)
import Browser.Navigation as Nav
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import FontAwesome.Attributes as Icon
import FontAwesome.Brands as Icon
import FontAwesome.Solid as Icon
import FontAwesome.Styles as Icon
import Html
import Task
import Url
import Url.Parser exposing ((</>), Parser, fragment, map, oneOf, parse, s, top)



-- MAIN


main : Program () Model Msg
main =
    application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        }



-- MODEL


type alias Model =
    { key : Nav.Key
    , route : Route
    }


type Route
    = AboutRoute
    | PortfolioRoute
    | ContactRoute


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    let
        route =
            parseUrl url |> Maybe.withDefault AboutRoute
    in
    ( Model key route, Cmd.none )



-- UPDATE


type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        UrlChanged url ->
            case parseUrl url of
                Just route ->
                    ( { model | route = route }, Cmd.none )

                Nothing ->
                    ( model, Cmd.none )


parseUrl : Url.Url -> Maybe Route
parseUrl url =
    let
        hashUrl =
            { url | path = url.fragment |> Maybe.withDefault "" }
    in
    parse routeParser hashUrl


routeParser : Parser (Route -> a) a
routeParser =
    oneOf
        [ map AboutRoute top
        , map AboutRoute <| s "about"
        , map PortfolioRoute <| s "portfolio"
        , map ContactRoute <| s "contact"
        ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- VIEW


view : Model -> Browser.Document Msg
view model =
    { title = "a-b.sh"
    , body =
        [ Html.node "style" [] [ Icon.css ]
        , layout
            [ Font.family
                [ Font.typeface "Inconsolata"
                , Font.sansSerif
                ]
            , Font.size 30
            , Font.color lightGray
            , Background.color darkGray
            ]
            (pageWrapper model)
        ]
    }


pageWrapper : Model -> Element Msg
pageWrapper model =
    row
        [ centerX, width <| maximum 700 <| fill, height fill ]
        [ el [ width <| fillPortion 1 ] none
        , column [ height fill, width <| fillPortion 6 ]
            [ header
            , el [ onLeft <| nav model, paddingXY 30 0 ] <| currentPage model
            ]
        ]


header : Element Msg
header =
    el
        [ Font.size 40
        , Font.bold
        , Font.color green
        , padding 30
        , alignLeft
        ]
    <|
        text "alexander bronca"


currentPage : Model -> Element Msg
currentPage model =
    case model.route of
        AboutRoute ->
            aboutPage

        PortfolioRoute ->
            portfolioPage

        ContactRoute ->
            contactPage


nav : Model -> Element Msg
nav model =
    column
        [ alignTop, alignLeft, spacing 16 ]
        [ menuLink ([ alignRight ] ++ currentPageLink model.route AboutRoute)
            { url = "#about", label = text "about" }
        , menuLink ([ alignRight ] ++ currentPageLink model.route PortfolioRoute)
            { url = "#portfolio", label = text "portfolio" }
        , menuLink ([ alignRight ] ++ currentPageLink model.route ContactRoute)
            { url = "#contact", label = text "contact" }
        , menuLink [ alignRight ]
            { url = "https://albronca.github.io/dist/alexander_bronca_resume_jan_2018.pdf"
            , label = text "resume"
            }
        ]


currentPageLink : Route -> Route -> List (Attribute Msg)
currentPageLink currentRoute linkRoute =
    if currentRoute == linkRoute then
        [ Font.bold ]

    else
        []


aboutPage : Element Msg
aboutPage =
    textColumn
        [ spacing 20 ]
        [ paragraph [ Font.alignLeft ]
            [ text "I'm a software developer based in Brooklyn, NY. "
            , text "My primary languages are "
            , highlightedText "Elm"
            , text ", "
            , highlightedText "JavaScript"
            , text ", "
            , highlightedText "Ruby"
            , text ", and "
            , highlightedText "SQL"
            , text ". "
            , text "I've worked with "
            , highlightedText "Flow"
            , text ", "
            , highlightedText "TypeScript"
            , text ", "
            , highlightedText "Rails"
            , text ", "
            , highlightedText "React"
            , text ", and "
            , highlightedText "Redux"
            , text ". "
            , text "In my free time I enjoy playing games, singing karaoke, and studying Japanese."
            ]
        ]


portfolioPage : Element Msg
portfolioPage =
    column
        [ centerX, spacing 15 ]
        [ portfolioItem
            { title = "gagopa.club"
            , description = "responsive frontend for karaoke song search"
            , liveLink = "https://gagopa.club"
            , gitHubLink = "https://github.com/albronca/gagopa"
            }
        , portfolioItem
            { title = "picross"
            , description = "grid-based puzzle game in elm"
            , liveLink = "https://albronca.github.io/picross"
            , gitHubLink = "https://github.com/albronca/picross"
            }
        , portfolioItem
            { title = "lights out"
            , description = "classic puzzle game in elm"
            , liveLink = "https://albronca.github.io/lights-out"
            , gitHubLink = "https://github.com/albronca/lights-out"
            }
        , portfolioItem
            { title = "space melons"
            , description = "svg animation in elm"
            , liveLink = "https://albronca.github.io/space-melons"
            , gitHubLink = "https://github.com/albronca/space-melons"
            }
        ]


type alias PortfolioItemOptions =
    { liveLink : String
    , gitHubLink : String
    , title : String
    , description : String
    }


portfolioItem : PortfolioItemOptions -> Element Msg
portfolioItem options =
    column [ spacing 5 ]
        [ row [ spacing 5 ]
            [ highlightedText options.title
            , text " ("
            , menuLink [] { url = options.liveLink, label = text "live" }
            , text "|"
            , menuLink [] { url = options.gitHubLink, label = text "github" }
            , text ")"
            ]
        , el [ Font.italic, Font.size 20, paddingXY 10 0 ] <| text options.description
        ]


contactPage : Element Msg
contactPage =
    column
        [ spacing 20 ]
        [ menuLink []
            { url = "mailto:alexander.bronca@gmail.com"
            , label =
                row [ spacing 10 ]
                    [ el [] <| html <| Icon.envelopeSquare []
                    , text "alexander.bronca@gmail.com"
                    ]
            }
        , menuLink []
            { url = "https://github.com/albronca"
            , label =
                row [ spacing 10 ]
                    [ el [] <| html <| Icon.github []
                    , text "github"
                    ]
            }
        , menuLink []
            { url = "https://www.linkedin.com/in/albronca"
            , label =
                row [ spacing 10 ]
                    [ el [] <| html <| Icon.linkedin []
                    , text "linkedin"
                    ]
            }
        ]


menuLink : List (Attribute Msg) -> { url : String, label : Element Msg } -> Element Msg
menuLink attributes =
    link ([ Font.color blue, Font.center ] ++ attributes)


highlightedText : String -> Element Msg
highlightedText =
    text >> el [ Font.color yellow ]



-- COLORS


blue : Color
blue =
    rgb255 129 162 178


darkGray : Color
darkGray =
    rgb255 38 38 38


green : Color
green =
    rgb255 181 189 104


lightGray : Color
lightGray =
    rgb255 188 188 188


yellow : Color
yellow =
    rgb255 240 198 116
