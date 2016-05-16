module App.Update exposing (init, update)

import App.Model exposing (Model, Msg(..))
import Authentication.Update as Authentication exposing (init, update)
import Authentication.Auth0 exposing (Options)

init : Options -> (Model, Cmd Msg)
init authenticationOptions =
  ( Model (Authentication.init authenticationOptions)
  , Cmd.none
  )

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Authentication authMsg ->
      let
        (authModel, cmd) = Authentication.update authMsg model.auth
      in
        ({ model | auth = authModel }, cmd |> Cmd.map Authentication)
