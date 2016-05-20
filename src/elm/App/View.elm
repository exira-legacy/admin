module App.View exposing (..)

import App.Model exposing (Model)
import App.Msg as App exposing (Msg(..))

import Header.View as Header exposing (view)
import Authentication.Model as Authentication exposing (tryGetUserProfile)
import Authentication.View as Authentication exposing (view)

import Html exposing (Html, div)
import Html.App as App exposing (map)

view : Model -> Html Msg
view model =
  let
    profile = tryGetUserProfile model.authentication
  in
    div []
      [ App.map Header (Header.view profile model.header)
      , App.map Authentication (Authentication.view model.authentication) ]
