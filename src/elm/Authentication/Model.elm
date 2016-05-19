module Authentication.Model exposing (Model, init)

import Authentication.Msg exposing (Msg)

import Authentication.Auth0 exposing (AuthenticationState(LoggedOut), AuthenticationError, Options)

type alias Model =
  { state : AuthenticationState
  , lastError : Maybe AuthenticationError
  , options : Options
  --, showLock : Options -> Cmd Msg
  --, logout : () -> Cmd Msg
  }

init : Options -> (Model, Cmd Msg)
init options =
  (
    { state = LoggedOut
    , lastError = Nothing
    , options = options
    --, showLock = showLock
    --, logout = logout
    }
  , Cmd.none
  )
