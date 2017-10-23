module Update exposing (update)

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
