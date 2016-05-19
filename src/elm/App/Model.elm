module App.Model exposing (Model, Msg(..))

import Authentication.Model as Authentication exposing (Model)

import Header.Model as Header exposing (Model)
import Header.Msg as Header exposing (Msg)

type Msg
  -- = Authentication Authentication.Msg
  = Header Header.Msg

type alias Model =
  { header : Header.Model
  }
