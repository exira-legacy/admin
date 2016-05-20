module Authentication.View exposing (view)

import Authentication.Model exposing (Model)
import Authentication.Msg exposing (Msg(..))

import Html exposing (Html, div, a, text, p)
import Html.Events exposing (onClick)

import Authentication.Auth0 as Auth0 exposing (AuthenticationState(LoggedIn), UserProfile)

view : Model -> Html Msg
view model =
    case model.state of
      Auth0.LoggedIn userData ->
        loggedInView Logout userData.profile

      Auth0.LoggedOut ->
        loggedOutView ShowLogin

loggedInView : Msg -> UserProfile -> Html Msg
loggedInView logoutAction profile =
  --p [] [ text <| profile.name ++ " (" ++ profile.email ++ ")" ]
  div []
    [ a
        [ onClick logoutAction ]
        [ text "Logout" ]
    ]

loggedOutView : Msg -> Html Msg
loggedOutView loginAction  =
  div []
    [ a
        [ onClick loginAction ]
        [ text "Login" ]
    ]
