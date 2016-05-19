module App.Subscriptions exposing (subscriptions)

import App.Model exposing (Model)
import App.Msg exposing (Msg(..))

import Header.Subscriptions as Header exposing (subscriptions)
import Authentication.Subscriptions as Authentication exposing (subscriptions)

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.batch
    [ Sub.map Authentication (Authentication.subscriptions model.authentication)
    , Sub.map Header (Header.subscriptions model.header)
    ]
