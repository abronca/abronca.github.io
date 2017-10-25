module Model exposing (..)

import Element exposing (Device, classifyDevice)


type alias Model =
    { route : Route
    , device : Device
    }


type Route
    = HomeRoute
    | AboutRoute
    | PortfolioRoute
    | ContactRoute
    | NotFoundRoute


initialModel : Route -> Model
initialModel route =
    { route = route
    , device = classifyDevice { width = 0, height = 0 }
    }
