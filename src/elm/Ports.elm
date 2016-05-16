port module Ports exposing (..)

import Authentication.Auth0 exposing (Options, RawAuthenticationResult)

-- Auth0 Ports
port auth0showLock : Options -> Cmd msg
port auth0Logout : () -> Cmd msg
port auth0authResult : (RawAuthenticationResult -> msg) -> Sub msg
