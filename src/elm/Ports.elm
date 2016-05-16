port module Ports exposing (..)

import Authentication.Auth0 exposing (Options, RawAuthenticationResult)

-- Auth0 Ports
port showLock : Options -> Cmd msg
port logout : () -> Cmd msg
port authResult : (RawAuthenticationResult -> msg) -> Sub msg
