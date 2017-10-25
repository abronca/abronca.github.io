module Main exposing (..)

import Model exposing (Model, initialModel)
import Msg exposing (Msg(..))
import Navigation exposing (..)
import Routing exposing (parseLocation)
import Update exposing (update)
import Task
import View exposing (view)
import Window exposing (resizes)


main : Program Never Model Msg
main =
    program UrlChange
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> resizes WindowResize
        }


init : Location -> ( Model, Cmd Msg )
init location =
    let
        route =
            parseLocation location
    in
        ( initialModel route, Task.perform WindowResize Window.size )
