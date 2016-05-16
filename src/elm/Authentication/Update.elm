module Authentication.Update exposing (init, update, handleAuthResult)

import Authentication.Model exposing (Model, Msg(..))
import Authentication.Auth0 exposing (AuthenticationState(..), RawAuthenticationResult, mapResult, defaultOpts)
import Ports exposing (auth0showLock)

init : Model
init =
  { state = LoggedOut
  , lastError = Nothing
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
      let
        effect =
          auth0showLock defaultOpts
      in
        (model, effect)

    Logout ->
      ({ model | state = LoggedOut }, Cmd.none)

handleAuthResult : RawAuthenticationResult -> Msg
handleAuthResult = mapResult >> AuthenticationResult
