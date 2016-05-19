module Authentication.View exposing (view)

import Authentication.Model exposing (Model)
import Authentication.Msg exposing (Msg(..))

import Html exposing (Html, div, button, text, p)
import Html.Events exposing (onClick)

import Authentication.Auth0 as Auth0 exposing (AuthenticationState(LoggedIn), UserProfile)

view : Model -> List (Html Msg) -> Html Msg
view model content =
    case model.state of
      Auth0.LoggedIn userData ->
        loggedInView Logout userData.profile content

      Auth0.LoggedOut ->
        loggedOutView ShowLogin


loggedInView : Msg -> UserProfile -> List (Html Msg) -> Html Msg
loggedInView logoutAction profile content =
  div []
    [ p [] [ text <| profile.name ++ " (" ++ profile.email ++ ")" ]
    , button
        [ onClick logoutAction ]
        [ text "Logout" ]
    , div [] content
    ]

loggedOutView : Msg -> Html Msg
loggedOutView loginAction  =
  div []
    [ text "Log in to see information about you: "
    , button
        [ onClick loginAction ]
        [ text "Login" ]
    ]
