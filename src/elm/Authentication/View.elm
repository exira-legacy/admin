module Authentication.View exposing (view)

import Authentication.Model exposing (Model)
import Authentication.Msg exposing (Msg(..))

import Html exposing (Html, div, button, text, img, ul, li)
import Html.Attributes exposing (src, style)
import Html.Events exposing (onClick)

import Authentication.Auth0 as Auth0 exposing (AuthenticationState(LoggedIn), UserProfile)

view : Model -> Html Msg
view model =
  div []
    [ div [] [ text "Auth" ]
    ]
--   case model.auth.state of
--     Auth0.LoggedIn userData ->
--       loggedInView Logout userData.profile

--     Auth0.LoggedOut ->
--       loggedOutView ShowLogin

-- loggedInView : Msg -> UserProfile -> Html Msg
-- loggedInView logoutAction profile =
--   div []
--     [ div []
--         [ img [ src profile.picture ] []
--         , div [ style [ ("margin-left", "1em"), ("margin-right", "1em") ] ] [ text profile.name ]
--         , button
--             [ onClick logoutAction ]
--             [ text "Logout" ]
--         ]
--     , ul []
--         [ li [] [ text <| "Name: " ++ profile.name ]
--         , li [] [ text <| "Email: " ++ profile.email ]
--         ]
--     ]

-- loggedOutView : Msg -> Html Msg
-- loggedOutView loginAction  =
--   div []
--     [ text "Log in to see information about you: "
--     , button
--         [ onClick loginAction ]
--         [ text "Login" ]
--     ]
