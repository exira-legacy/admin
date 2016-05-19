module Header.View exposing (view)

import Header.Model exposing (Model)
import Header.Msg exposing (Msg(..))

import Html exposing (Html, h2, p, text, div)

view : Model -> Html Msg
view model =
  div []
    [ h2 [] [ text model.title ]
    , p [] [ text model.name ]
    ]
