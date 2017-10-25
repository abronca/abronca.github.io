module Msg exposing (..)

import Navigation exposing (Location)
import Window exposing (Size)


type Msg
    = UrlChange Location
    | WindowResize Size
