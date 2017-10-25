module View.AboutPage exposing (aboutPage)

import Element exposing (..)
import Element.Attributes exposing (..)
import Msg exposing (Msg)
import Styles exposing (Styles(..))


aboutPage : Element Styles variation Msg
aboutPage =
    column About
        [ alignLeft, spacing 5 ]
        [ question [ text "What do you do?" ]
        , answer
            [ text "I write code in NYC. I'm proficient in "
            , constant "JavaScript"
            , text ", "
            , constant "Ruby"
            , text ", and "
            , constant "SQL"
            , text ". I'm comfortable using "
            , constant "Rails"
            , text ", "
            , constant "React"
            , text ", and "
            , constant "Redux"
            , text ". I currently teach at App Academy NYC."
            ]
        , question [ text "Do you have any hobbies?" ]
        , answer
            [ text "Some of my favorite video games are "
            , constant "EarthBound"
            , text ", "
            , constant "Fez"
            , text ", and "
            , constant "Portal"
            , text ". I also play guitar and occasionally write music."
            ]
        ]


question : List (Element Styles variation Msg) -> Element Styles variation Msg
question =
    aboutItem "Q:"


answer : List (Element Styles variation Msg) -> Element Styles variation Msg
answer =
    aboutItem "A:"


aboutItem : String -> List (Element Styles variation Msg) -> Element Styles variation Msg
aboutItem bullet =
    (::) (el AboutBullet [ alignLeft, paddingRight 12 ] (text bullet)) >> paragraph AboutItem []


constant : String -> Element Styles variation Msg
constant =
    text >> el Constant []
