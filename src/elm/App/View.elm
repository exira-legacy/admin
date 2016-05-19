module App.View exposing (..)

import Html exposing (Html, div)
import Html.App as App exposing (map)

import App.Model as App exposing (Model, Msg(..))

import Authentication.Auth0 as Auth0 exposing (AuthenticationState(..))
import Authentication.Model as Authentication exposing (Msg(..))
import Authentication.View exposing (loggedInUser, loggedOutUser)

import Header.View as Header exposing (view)

view : App.Model -> Html App.Msg
view model =
  div []
    [ App.map Header (Header.view model.header) ]
  -- case model.auth.state of
  --   Auth0.LoggedIn userData ->
  --     loggedInUser (Authentication Authentication.Logout) userData.profile

  --   Auth0.LoggedOut ->
  --     loggedOutUser (Authentication Authentication.ShowLogin)
