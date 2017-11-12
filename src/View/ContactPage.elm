module View.ContactPage exposing (contactPage)

import Element exposing (..)
import Element.Attributes exposing (..)
import Msg exposing (Msg)
import Styles exposing (Styles(..))


contactPage : Element Styles variation Msg
contactPage =
    column None
        [ center ]
        [ link "mailto:alexander.bronca@gmail.com" (el MenuLink [] (text "alexander.bronca@gmail.com"))
        , link "https://github.com/albronca" (el MenuLink [] (text "github"))
        , link "https://www.linkedin.com/in/albronca" (el MenuLink [] (text "linkedin"))
        ]
