module Header.Model exposing (Model, init)

import Header.Msg exposing (Msg)

type alias Model =
  { title : String
  }

init : String -> (Model, Cmd Msg)
init title =
  ( Model title
  , Cmd.none
  )
