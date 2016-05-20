module App.Model exposing (Model, init)

import App.Msg exposing (Msg(..))

import Authentication.Model as Authentication exposing (Model, init)
import Header.Model as Header exposing (Model, init)

-- Temp
import Authentication.Auth0 exposing (LockOptions)

type alias Model =
  { authentication: Authentication.Model
  , header : Header.Model
  }

init : LockOptions -> (Model, Cmd Msg)
init authenticationOptions =
  let
    (authentication, authenticationFx) =
      Authentication.init authenticationOptions

    (header, headerFx) =
      Header.init "Home"
  in
    ( Model authentication header
    , Cmd.batch
      [ Cmd.map Authentication authenticationFx
      , Cmd.map Header headerFx
      ]
  )
