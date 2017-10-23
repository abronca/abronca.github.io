module Model exposing (..)


type alias Model =
    { route : Route }


type Route
    = Home
    | About
    | Portfolio
    | Contact


model : Model
model =
    { route = Home }
