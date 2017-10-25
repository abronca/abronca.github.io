module View.ContactPage exposing (contactPage)

import Element exposing (..)
import Element.Attributes exposing (..)
import Msg exposing (Msg)
import Styles exposing (Styles(..))


contactPage : Element Styles variation Msg
contactPage =
    column Menu
        [ center ]
        [ link "mailto:alexander.bronca@gmail.com" (el MenuLink [] (text "email"))
        , link "https://github.com/albronca" (el MenuLink [] (text "github"))
        , link "https://www.linkedin.com/in/albronca" (el MenuLink [] (text "linkedin"))
        , link "https://twitter.com/al_br_" (el MenuLink [] (text "twitter"))
        ]
