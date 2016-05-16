module Main exposing (..)

import App.Model as Model exposing (Model, Msg(..))
import App.Update exposing (init, update)
import App.View exposing (view)

import Html.App exposing (program)
import Authentication.Update exposing (handleAuthResult)
import Ports

main : Program Never
main =
    program
    { init = init
    , update = update
    , subscriptions = subscriptions
    , view = view
    }

subscriptions : Model -> Sub Model.Msg
subscriptions model =
  Ports.auth0authResult (handleAuthResult >> Authentication)
