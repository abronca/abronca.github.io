module Model exposing (..)


type alias Model =
    { route : Route }


type Route
    = HomeRoute
    | AboutRoute
    | PortfolioRoute
    | ContactRoute
    | NotFoundRoute


initialModel : Route -> Model
initialModel route =
    { route = route }
