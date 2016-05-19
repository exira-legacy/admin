module App.Msg exposing (Msg(..))

import Authentication.Msg as Authentication exposing (Msg)
import Header.Msg as Header exposing (Msg)

type Msg
  = Authentication Authentication.Msg
  | Header Header.Msg
