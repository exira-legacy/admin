module Authentication.Update exposing (update)

import Authentication.Model exposing (Model)
import Authentication.Msg exposing (Msg(..))
import Authentication.Services exposing (Services)

import Authentication.Auth0 exposing (AuthenticationState(..))

update : Services -> Msg -> Model -> (Model, Cmd Msg)
update services msg model =
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
      (model, services.onShowLock model.options)

    Logout ->
      ({ model | state = LoggedOut }, services.onLogout ())

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
