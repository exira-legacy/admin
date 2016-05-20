module Authentication.Subscriptions exposing (subscriptions)

import Authentication.Model exposing (Model)
import Authentication.Msg exposing (Msg(AuthenticationResult, ShowLogin))

import Ports exposing (authResult, showLogin)
import Authentication.Auth0 exposing (RawAuthenticationResult, mapResult)

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.batch
    [ authResult handleAuthResult
    , showLogin handleLogin
    ]

handleAuthResult : RawAuthenticationResult -> Msg
handleAuthResult = mapResult >> AuthenticationResult

handleLogin : Bool -> Msg
handleLogin _ = ShowLogin
