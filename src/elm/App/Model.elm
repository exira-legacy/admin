module App.Model exposing (Model, Msg(..))

import Authentication.Model as Authentication exposing (Model)

type Msg
  = Authentication Authentication.Msg

type alias Model =
  { auth : Authentication.Model
  }
