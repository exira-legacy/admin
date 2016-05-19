module Authentication.Update exposing (update)

--import Ports exposing (showLock, logout)
import Authentication.Model exposing (Model)
import Authentication.Msg exposing (Msg(..))

--import Authentication.Auth0 exposing (Options, AuthenticationState(..), RawAuthenticationResult, mapResult)
import Authentication.Auth0 exposing (AuthenticationState(..))

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
      --(model, model.showLock model.options)
      (model, Cmd.none)

    Logout ->
      --({ model | state = LoggedOut }, model.logout ())
      ({ model | state = LoggedOut }, Cmd.none)

-- handleAuthResult : RawAuthenticationResult -> Msg
-- handleAuthResult = mapResult >> AuthenticationResult

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
