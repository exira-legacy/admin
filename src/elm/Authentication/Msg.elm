module Authentication.Msg exposing (Msg(..))

import Authentication.Auth0 exposing (AuthenticationResult)

type Msg
  = ShowLogin
  | AuthenticationResult AuthenticationResult
  | Logout
