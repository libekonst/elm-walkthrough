module Forms exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)


main =
    Browser.sandbox { init = init, view = view, update = update }


type alias Model =
    { name : String, password : String, verifyPassword : String }


init : Model
init =
    Model "" "" ""


type Msg
    = Name String
    | Password String
    | VerifyPassword String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Name name ->
            { model | name = name }

        Password pass ->
            { model | password = pass }

        VerifyPassword vrfpswd ->
            { model | verifyPassword = vrfpswd }


view : Model -> Html Msg
view model =
    div []
        [ loginInput "text" "User name" model.name Name
        , loginInput "password" "Password" model.password Password
        , loginInput "password" "Re-enter password" model.verifyPassword VerifyPassword
        , passwordValidator (validate model.password model.verifyPassword)
        ]


loginInput : String -> String -> String -> (String -> msg) -> Html msg
loginInput t p v toMsg =
    input [ type_ t, placeholder p, value v, onInput toMsg ] []


passwordValidator : Validity -> Html msg
passwordValidator validity =
    case validity of
        Empty ->
            div [] []

        Valid reason ->
            div [ style "color" "green" ] [ text (String.concat [ "✓ ", reason ]) ]

        Invalid reason ->
            div [ style "color" "red" ] [ text (String.concat [ "✕ ", reason ]) ]


isStrongPassword : String -> Bool
isStrongPassword password =
    password |> String.trim |> allTestsPass [ isNotEmpty, isLongerThan 8, hasLower, hasUpper, hasDigits ]


hasDigits : String -> Bool
hasDigits word =
    String.any Char.isDigit word


isNotEmpty : String -> Bool
isNotEmpty word =
    not (String.isEmpty word)


isLongerThan : Int -> String -> Bool
isLongerThan chars word =
    String.length word > chars


hasUpper : String -> Bool
hasUpper word =
    String.any Char.isUpper word


hasLower : String -> Bool
hasLower word =
    String.any Char.isLower word


allTestsPass : List (String -> Bool) -> String -> Bool
allTestsPass predicates word =
    List.all (testOk word) predicates


testOk : String -> (String -> Bool) -> Bool
testOk word f =
    f word == True


type Validity
    = Valid String
    | Empty
    | Invalid String


validate : String -> String -> Validity
validate pass passAgain =
    if String.isEmpty pass then
        Empty

    else if not (isStrongPassword pass) then
        Invalid
            "Password should be at least 8 chars long and contain upper, lower and digit characters"

    else if String.isEmpty passAgain then
        Empty

    else if pass == passAgain then
        Valid "Success"

    else
        Invalid "Passwords don't match"
