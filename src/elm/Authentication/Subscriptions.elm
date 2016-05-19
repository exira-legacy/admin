module Authentication.Subscriptions exposing (subscriptions)

import Authentication.Model exposing (Model)
import Authentication.Msg exposing (Msg(AuthenticationResult))

import Ports exposing (authResult)
import Authentication.Auth0 exposing (RawAuthenticationResult, mapResult)

subscriptions : Model -> Sub Msg
subscriptions model =
  authResult (handleAuthResult)

handleAuthResult : RawAuthenticationResult -> Msg
handleAuthResult = mapResult >> AuthenticationResult
