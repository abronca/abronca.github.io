module Main exposing (main)

import Browser exposing (application)
import Browser.Navigation as Nav
import Element exposing (..)
import Element.Background as Background
import Element.Font as Font
import FontAwesome exposing (envelope, gitHub, icon, linkedIn)
import Html
import Palette
import Url
import Url.Parser exposing (Parser, map, oneOf, parse, s, top)



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
    | ProjectsRoute


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
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
        , map ProjectsRoute <| s "projects"
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
        [ layout
            [ Font.family
                [ Font.typeface "Inconsolata"
                , Font.sansSerif
                ]
            , Font.size (scaled 2)
            , Font.color Palette.white
            , Background.color Palette.black
            ]
            (mainLayout model)
        ]
    }


mainLayout : Model -> Element Msg
mainLayout model =
    column [ padding 32, width <| maximum 600 <| fill, centerX ]
        [ header
        , nav model
        , currentPage model
        ]


header : Element Msg
header =
    el
        [ Font.size (scaled 4)
        , Font.color Palette.green
        , centerX
        ]
    <|
        text "alexander bronca"


currentPage : Model -> Element Msg
currentPage model =
    case model.route of
        AboutRoute ->
            aboutPage

        ProjectsRoute ->
            projectsPage


nav : Model -> Element Msg
nav model =
    row [ paddingXY 0 32, Font.color Palette.blue, Font.size (scaled 1), width fill, spaceEvenly ]
        [ navItem
            { selected = model.route == AboutRoute
            , url = "#about"
            , label = text "about"
            }
        , navItem
            { selected = model.route == ProjectsRoute
            , url = "#projects"
            , label = text "projects"
            }
        , navItem
            { selected = False
            , url = "https://albronca.github.io/dist/alexander_bronca_resume_jan_2018.pdf"
            , label = text "resume"
            }
        ]


type alias NavItemOptions =
    { selected : Bool
    , url : String
    , label : Element Msg
    }


navItem : NavItemOptions -> Element Msg
navItem { selected, url, label } =
    let
        attrs =
            if selected then
                [ Font.bold, Font.underline ]

            else
                []
    in
    link attrs { url = url, label = label }


aboutPage : Element Msg
aboutPage =
    column [ spacing 32 ]
        [ paragraph [ spacing 8 ]
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
        , column [ Font.color Palette.blue, spacing 16 ]
            [ contactItem
                { icon = icon envelope
                , url = "mailto:alexander.bronca@gmail.com"
                , label = text "alexander.bronca@gmail.com"
                }
            , contactItem
                { icon = icon gitHub
                , url = "https://github.com/albronca"
                , label = text "github"
                }
            , contactItem
                { icon = icon linkedIn
                , url = "https://linkedin.com/in/albronca"
                , label = text "linkedin"
                }
            ]
        ]


type alias ContactItemOptions =
    { icon : Html.Html Msg
    , url : String
    , label : Element Msg
    }


contactItem : ContactItemOptions -> Element Msg
contactItem { icon, url, label } =
    row [ spacing 8 ]
        [ el [] (html icon)
        , link [] { url = url, label = label }
        ]


projectsPage : Element Msg
projectsPage =
    column
        [ spacing 24, width fill ]
        [ project
            { title = "gagopa.club"
            , description = "responsive frontend for karaoke song search"
            , liveLink = "https://gagopa.club"
            , gitHubLink = "https://github.com/albronca/gagopa"
            }
        , project
            { title = "picross"
            , description = "grid-based puzzle game in elm"
            , liveLink = "https://albronca.github.io/picross"
            , gitHubLink = "https://github.com/albronca/picross"
            }
        , project
            { title = "lights out"
            , description = "classic puzzle game in elm"
            , liveLink = "https://albronca.github.io/lights-out"
            , gitHubLink = "https://github.com/albronca/lights-out"
            }
        , project
            { title = "space melons"
            , description = "svg animation in elm"
            , liveLink = "https://albronca.github.io/space-melons"
            , gitHubLink = "https://github.com/albronca/space-melons"
            }
        ]


type alias ProjectOptions =
    { liveLink : String
    , gitHubLink : String
    , title : String
    , description : String
    }


project : ProjectOptions -> Element Msg
project options =
    column [ spacing 8 ]
        [ highlightedText options.title
        , row [ Font.size (scaled 1) ]
            [ text "("
            , link [ Font.color Palette.blue ] { url = options.liveLink, label = text "live" }
            , text "|"
            , link [ Font.color Palette.blue ] { url = options.gitHubLink, label = text "github" }
            , text ")"
            ]
        , paragraph [ Font.italic ] [ text options.description ]
        ]


highlightedText : String -> Element Msg
highlightedText =
    text >> el [ Font.color Palette.yellow ]


scaled : Int -> Int
scaled =
    modular 16 1.25 >> floor
