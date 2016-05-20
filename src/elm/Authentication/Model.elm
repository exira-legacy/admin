module Authentication.Model exposing (Model, init, tryGetUserProfile)

import Authentication.Msg exposing (Msg)

import Authentication.Auth0 exposing
  ( AuthenticationState(LoggedIn, LoggedOut)
  , AuthenticationError
  , LockOptions
  , UserProfile
  )

type alias Model =
  { state : AuthenticationState
  , lastError : Maybe AuthenticationError
  , options : LockOptions
  }

init : LockOptions -> (Model, Cmd Msg)
init options =
  (
    { state = LoggedOut
    , lastError = Nothing
    , options = options
    }
  , Cmd.none
  )

tryGetUserProfile : Model -> Maybe UserProfile
tryGetUserProfile model =
    case model.state of
        LoggedIn user -> Just user.profile
        LoggedOut -> Nothing

isLoggedIn : Model -> Bool
isLoggedIn model =
    case model.state of
        LoggedIn _ -> True
        LoggedOut -> False
