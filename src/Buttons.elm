module Buttons exposing (main, update)

import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)


main : Program () Int Message
main =
    Browser.sandbox { init = init, update = update, view = view }


type alias Model =
    Int


init : Model
init =
    0


type Message
    = Increment
    | Decrement
    | Reset
    | IncrementTen


update : Message -> Model -> Model
update msg model =
    case msg of
        Increment ->
            model + 1

        Decrement ->
            model - 1

        Reset ->
            init

        IncrementTen ->
            model + 10


view : Int -> Html Message
view model =
    div []
        [ button [ onClick Decrement ] [ text "-" ]
        , div [] [ text (String.fromInt model) ]
        , button [ onClick Increment ] [ text "+" ]
        , button [ onClick IncrementTen ] [ text "+10" ]
        , button [ onClick Reset ] [ text "Clear" ]
        ]
