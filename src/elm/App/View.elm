module App.View exposing (..)

import App.Model exposing (Model)
import App.Msg exposing (Msg(..))

import Header.View as Header exposing (view)
import Authentication.View as Authentication exposing (view)

import Html exposing (Html, div)
import Html.App as App exposing (map)

view : Model -> Html Msg
view model =
  div []
    [ App.map Header (Header.view model.header)
    , App.map Authentication (Authentication.view model.authentication)
    ]
