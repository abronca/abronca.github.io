module Msg exposing (..)

import Model exposing (Route)
import Navigation exposing (Location)


type Msg
    = UrlChange Location
