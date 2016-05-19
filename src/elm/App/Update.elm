module App.Update exposing (init, update)

import App.Model exposing (Model, Msg(..))
import Authentication.Update as Authentication exposing (init, update)
import Authentication.Auth0 exposing (Options)

import Header.Model as Header exposing (init)
import Header.Update as Header exposing (update)

init : Options -> (Model, Cmd Msg)
init authenticationOptions =
  let
    -- (auth, authFx) =
    --   Authentication.init authenticationOptions

    (header, headerFx) =
      Header.init "Home" "David Cumps"
  in
    ( Model header
    , Cmd.batch
      [ Cmd.map Header headerFx
      ]
  )

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    -- Authentication authMsg ->
    --   let
    --     (authModel, cmd) = Authentication.update authMsg model.auth
    --   in
    --     ({ model | auth = authModel }, cmd |> Cmd.map Authentication)

    Header headerMsg ->
      let
        (headerModel, cmd) = Header.update headerMsg model.header
      in
        ({ model | header = headerModel }, cmd |> Cmd.map Header)
