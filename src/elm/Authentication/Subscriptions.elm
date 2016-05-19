module Authentication.Subscriptions exposing (subscriptions)

import Authentication.Model exposing (Model)
import Authentication.Msg exposing (Msg)

-- import Authentication.Update exposing (handleAuthResult)
-- import Ports exposing (authResult)

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none
  --authResult (handleAuthResult >> Authentication)
