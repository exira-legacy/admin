module Authentication.Services exposing (Services)

import Authentication.Msg exposing (Msg)

import Authentication.Auth0 exposing (LockOptions)

type alias Services =
  { onShowLock : LockOptions -> Cmd Msg
  , onLogout : () -> Cmd Msg
  }
