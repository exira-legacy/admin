module Authentication.Model exposing (Model, Msg(..))

import Authentication.Auth0 exposing (AuthenticationResult, AuthenticationState, AuthenticationError)

type Msg
  = ShowLogin
  | AuthenticationResult AuthenticationResult
  | Logout

type alias Model =
  { state : AuthenticationState
  , lastError : Maybe AuthenticationError
  }
