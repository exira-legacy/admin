module Header.View exposing (view)

import Header.Model exposing (Model)
import Header.Msg exposing (Msg(..))

import Authentication.Auth0 exposing (UserProfile)
import Html exposing (Html, h2, p, text, div)

view : Maybe UserProfile -> Model -> Html Msg
view profile model =
  let
    name =
      case profile of
        Just p -> p.name
        Nothing -> "Anonymous"
  in
    div []
      [ h2 [] [ text model.title ]
      , p [] [ text name ]
      ]
