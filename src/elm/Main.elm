module Main exposing (..)

import Html.App exposing (program)

import App.Model exposing (init)
import App.Update exposing (update)
import App.View exposing (view)
import App.Subscriptions exposing (subscriptions)

import Authentication.Auth0 exposing (LockOptions)

main : Program Never
main =
    program
    { init = init auth0Options
    , update = \msg model -> Debug.log (toString msg) (update msg model)
    , subscriptions = subscriptions
    , view = view
    }

auth0Options : LockOptions
auth0Options =
  { responseType = "token"
  -- , callbackURL = Nothing -- "http://localhost:3000"
  , rememberLastLogin = True
  , closable = False
  , popup = False
  , sso = True
  , authParams = { scope = "openid" }
  }
