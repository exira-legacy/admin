module Header.Subscriptions exposing (subscriptions)

import Header.Model exposing (Model)
import Header.Msg exposing (Msg)

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none
