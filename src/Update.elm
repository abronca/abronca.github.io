module Update exposing (update)

import Element exposing (classifyDevice)
import Model exposing (Model)
import Msg exposing (Msg(..))
import Routing exposing (parseLocation)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UrlChange location ->
            let
                route =
                    parseLocation location
            in
                ( { model | route = route }, Cmd.none )

        WindowResize size ->
            let
                device =
                    classifyDevice size
            in
                ( { model | device = device }, Cmd.none )
