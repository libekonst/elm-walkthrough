module TextFields exposing (..)

import Browser
import Html exposing (Attribute, Html, div, input, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }


type alias Model =
    { content : String }


init : Model
init =
    { content = "" }


type Msg
    = Change String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Change userInput ->
            { model | content = userInput }


reverseContent : Model -> String
reverseContent model =
    String.reverse model.content


countChars : Model -> String
countChars model =
    String.fromInt (String.length model.content)


view : Model -> Html Msg
view model =
    div []
        [ input [ placeholder "Text to reverse", value model.content, onInput Change ] []
        , div [] [ text (reverseContent model ++ " " ++ countChars model) ]
        ]
