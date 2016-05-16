module Authentication.Update exposing (init, update, handleAuthResult)

import Ports exposing (showLock, logout)
import Authentication.Model exposing (Model, Msg(..))
import Authentication.Auth0 exposing (Options, AuthenticationState(..), RawAuthenticationResult, mapResult)

init : Options -> Model
init options =
  { state = LoggedOut
  , lastError = Nothing
  , options = options
  , showLock = showLock
  , logout = logout
  }

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    AuthenticationResult result ->
      let
        (newState, error) =
          case result of
            Ok user -> (LoggedIn user, Nothing)
            Err err -> (model.state, Just err)
      in
        ({ model | state = newState, lastError = error }, Cmd.none)

    ShowLogin ->
      (model, model.showLock model.options)

    Logout ->
      ({ model | state = LoggedOut }, model.logout ())

handleAuthResult : RawAuthenticationResult -> Msg
handleAuthResult = mapResult >> AuthenticationResult

-- tryGetUserProfile : Model -> Maybe UserProfile
-- tryGetUserProfile model =
--     case model.state of
--         LoggedIn user -> Just user.profile
--         LoggedOut -> Nothing

-- isLoggedIn : Model -> Bool
-- isLoggedIn model =
--     case model.state of
--         LoggedIn _ -> True
--         LoggedOut -> False
