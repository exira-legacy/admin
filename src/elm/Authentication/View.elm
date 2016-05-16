module Authentication.View exposing (loggedInUser, loggedOutUser)

import Html exposing (Html, div, button, text, img, ul, li)
import Html.Attributes exposing (src, style)
import Html.Events exposing (onClick)

import App.Model exposing (Msg(..))
import Authentication.Auth0 exposing (UserProfile)

loggedOutUser : Msg -> Html Msg
loggedOutUser loginAction =
  div []
    [ text "Log in to see information about you"
    , button
        [ onClick loginAction ]
        [ text "Login" ]
    ]

loggedInUser : Msg -> UserProfile -> Html Msg
loggedInUser logoutAction profile =
  div []
    [ div []
        [ img [ src profile.picture ] []
        , div [ style [ ("margin-left", "1em"), ("margin-right", "1em") ] ] [ text profile.name ]
        , button
            [ onClick logoutAction ]
            [ text "Logout" ]
        ]
    , ul []
        [ li [] [ text <| "Name: " ++ profile.name ]
        , li [] [ text <| "Email: " ++ profile.email ]
        ]
    ]
