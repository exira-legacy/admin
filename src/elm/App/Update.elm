module App.Update exposing (update)

import App.Model exposing (Model)
import App.Msg exposing (Msg(..))

import Ports exposing (showLock, logout)

import Authentication.Update as Authentication exposing (update)
import Header.Update as Header exposing (update)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Authentication authMsg ->
      let
        authenticationServices =
          { onShowLock = showLock
          , onLogout = logout
          }

        (authenticationModel, cmd) = Authentication.update authenticationServices authMsg model.authentication
      in
        ({ model | authentication = authenticationModel }, cmd |> Cmd.map Authentication)

    Header headerMsg ->
      let
        (headerModel, cmd) = Header.update headerMsg model.header
      in
        ({ model | header = headerModel }, cmd |> Cmd.map Header)
