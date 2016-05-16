module App.View exposing (..)

import Html exposing (Html)

import App.Model as App exposing (Model, Msg(..))

import Authentication.Auth0 as Auth0 exposing (AuthenticationState(..))
import Authentication.Model as Authentication exposing (Msg(..))
import Authentication.View exposing (loggedInUser, loggedOutUser)

view : App.Model -> Html App.Msg
view model =
  case model.auth.state of
    Auth0.LoggedIn userData ->
      loggedInUser (Authentication Authentication.Logout) userData.profile

    Auth0.LoggedOut ->
      loggedOutUser (Authentication Authentication.ShowLogin)
