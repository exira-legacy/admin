port module Ports exposing (..)

import Authentication.Auth0 exposing (LockOptions, RawAuthenticationResult)

-- Auth0 Ports
port showLock : LockOptions -> Cmd msg
port logout : () -> Cmd msg
port authResult : (RawAuthenticationResult -> msg) -> Sub msg
