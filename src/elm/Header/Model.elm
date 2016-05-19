module Header.Model exposing (Model, init)

import Header.Msg exposing (Msg)

type alias Model =
  { title : String
  , name : String
  }

init : String -> String -> (Model, Cmd Msg)
init title name =
  ( Model title name
  , Cmd.none
  )
