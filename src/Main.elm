module Main exposing (..)

import Model exposing (Model, initialModel)
import Msg exposing (Msg(..))
import Navigation exposing (..)
import Routing exposing (parseLocation)
import Update exposing (update)
import View exposing (view)


main : Program Never Model Msg
main =
    program UrlChange
        { init = init
        , view = view
        , update = update
        , subscriptions = always Sub.none
        }


init : Location -> ( Model, Cmd Msg )
init location =
    let
        route =
            parseLocation location
    in
        ( initialModel route, Cmd.none )
