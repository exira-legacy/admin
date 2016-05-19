module Header.Update exposing (update)

import Header.Model exposing (Model)
import Header.Msg exposing (Msg(..))

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    NoOp ->
      (model, Cmd.none)
