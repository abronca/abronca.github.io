module Main exposing (main)

import Browser exposing (application)
import Browser.Navigation as Nav
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
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
    = HomeRoute
    | AboutRoute
    | PortfolioRoute
    | ContactRoute
    | NotFoundRoute


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    let
        route =
            parseUrl url
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
            ( { model | route = parseUrl url }
            , Cmd.none
            )


parseUrl : Url.Url -> Route
parseUrl url =
    let
        hashUrl =
            { url | path = url.fragment |> Maybe.withDefault "" }
    in
    case parse routeParser hashUrl of
        Just route ->
            route

        Nothing ->
            NotFoundRoute


routeParser : Parser (Route -> a) a
routeParser =
    oneOf
        [ map HomeRoute top
        , map AboutRoute (s "about")
        , map PortfolioRoute (s "portfolio")
        , map ContactRoute (s "contact")
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
            , Font.size 30
            , Font.color lightGray
            , Background.color darkGray
            ]
            (pageWrapper model)
        ]
    }


pageWrapper : Model -> Element Msg
pageWrapper model =
    column
        [ centerX, width (fill |> maximum 600), paddingXY 30 0 ]
        [ header, currentPage model ]


header : Element Msg
header =
    column
        [ Font.size 34
        , Font.bold
        , Font.color green
        , paddingXY 0 30
        , centerX
        ]
        [ el [ centerX ] (text "🐊")
        , el [ centerX ] (text "alexander bronca")
        ]


currentPage : Model -> Element Msg
currentPage model =
    case model.route of
        HomeRoute ->
            homePage

        AboutRoute ->
            aboutPage model |> withBackButton

        PortfolioRoute ->
            portfolioPage |> withBackButton

        ContactRoute ->
            contactPage |> withBackButton

        NotFoundRoute ->
            text "route not found"


homePage : Element Msg
homePage =
    column
        [ centerX ]
        [ menuLink [ centerX ] { url = "#about", label = text "about" }
        , menuLink [ centerX ] { url = "#portfolio", label = text "portfolio" }
        , menuLink [ centerX ] { url = "#contact", label = text "contact" }
        , menuLink [ centerX ]
            { url = "https://a-b.sh/dist/resume.pdf"
            , label = text "resume"
            }
        ]


aboutPage : Model -> Element Msg
aboutPage model =
    column
        [ alignLeft, spacing 6 ]
        [ question [ text "What do you do?" ]
        , answer
            [ text "I write code in NYC. I'm proficient in "
            , highlightedText "JavaScript"
            , text ", "
            , highlightedText "Ruby"
            , text ", and "
            , highlightedText "SQL"
            , text ". I'm comfortable using "
            , highlightedText "Rails"
            , text ", "
            , highlightedText "React"
            , text ", and "
            , highlightedText "Redux"
            , text ". I currently teach at App Academy NYC."
            ]
        , question [ text "Do you have any hobbies?" ]
        , answer
            [ text "Some of my favorite video games are "
            , highlightedText "EarthBound"
            , text ", "
            , highlightedText "Fez"
            , text ", and "
            , highlightedText "Portal"
            , text ". I also play guitar and occasionally write music."
            ]
        ]


portfolioPage : Element Msg
portfolioPage =
    column
        [ centerX, spacing 6 ]
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


portfolioItem : PortfolioItemOptions -> Element Msg
portfolioItem options =
    column
        [ centerX ]
        [ paragraph [ Font.center ] [ highlightedText options.title ]
        , row [ centerX ]
            [ menuLink [] { url = options.liveLink, label = text "live" }
            , text "|"
            , menuLink [] { url = options.gitHubLink, label = text "github" }
            ]
        , paragraph [ padding 10, Font.center, Font.italic ] [ text ("(" ++ options.description ++ ")") ]
        ]


contactPage : Element Msg
contactPage =
    column
        [ centerX ]
        [ menuLink [ centerX ]
            { url = "mailto:alexander.bronca@gmail.com"
            , label = text "alexander.bronca@gmail.com"
            }
        , menuLink [ centerX ]
            { url = "https://github.com/albronca"
            , label = text "github"
            }
        , menuLink [ centerX ]
            { url = "https://www.linkedin.com/in/albronca"
            , label = text "linkedin"
            }
        ]


menuLink : List (Attribute Msg) -> { url : String, label : Element Msg } -> Element Msg
menuLink attributes =
    link ([ Font.color blue, Font.center ] ++ attributes)


highlightedText : String -> Element Msg
highlightedText =
    text >> el [ Font.color yellow ]


withBackButton : Element Msg -> Element Msg
withBackButton page =
    column
        [ centerX ]
        [ page
        , menuLink [ centerX, padding 30 ] { url = "/", label = text "←" }
        ]


question : List (Element Msg) -> Element Msg
question =
    aboutItem "Q:"


answer : List (Element Msg) -> Element Msg
answer =
    aboutItem "A:"


aboutItem : String -> List (Element Msg) -> Element Msg
aboutItem bullet =
    (::) (el [ Font.bold, Font.color green, alignLeft ] (text bullet))
        >> paragraph []



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
