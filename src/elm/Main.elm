module Main exposing (..)

import Html.App exposing (program)

import App.Model as Model exposing (Model, Msg(Header))
import App.Update exposing (init, update)
import App.View exposing (view)

import Authentication.Update exposing (handleAuthResult)
import Authentication.Auth0 exposing (Options)
import Ports exposing (authResult)

import Header.Subscriptions as Header exposing (subscriptions)

main : Program Never
main =
    program
    { init = init auth0Options
    , update = \msg model -> Debug.log (toString msg) (update msg model)
    , subscriptions = subscriptions
    , view = view
    }

auth0Options : Options
auth0Options =
  { responseType = "token"
  -- , callbackURL = Nothing -- "http://localhost:3000"
  , rememberLastLogin = True
  , closable = False
  , popup = False
  , sso = True
  , authParams = { scope = "openid" }
  }

-- subscriptions : Model -> Sub Model.Msg
-- subscriptions model =
--   authResult (handleAuthResult >> Authentication)

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.batch
    [ Sub.map Header (Header.subscriptions model.header)
    ]
