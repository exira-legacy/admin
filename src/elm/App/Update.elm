module App.Update exposing
  ( init
  , update
  )

import Authentication.Update as Authentication exposing (init, update)

import App.Model exposing (Model, Msg(..))

init : (Model, Cmd Msg)
init =
  ( Model Authentication.init
  , Cmd.none
  )

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Authentication msg ->
      let
        (newAuth, commands) = Authentication.update msg model.auth
      in
        ({ model | auth = newAuth }, commands |> Cmd.map Authentication)
