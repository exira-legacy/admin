module Authentication.Auth0 exposing
  ( AuthenticationState(..)
  , AuthenticationError
  , AuthenticationResult
  , RawAuthenticationResult
  , Options
  , LoggedInUser
  , UserProfile
  , Token
  , mapResult
  )

type alias Token = String

type alias UserProfile =
  { user_id : String
  , name : String
  , nickname : String
  , picture : String
  , email : String
  , email_verified : Bool
  }

type alias LoggedInUser = { token: Token, profile: UserProfile }

type AuthenticationState = LoggedOut | LoggedIn LoggedInUser

-- TODO: It seems Auth0 sometimes only returns a description
type alias AuthenticationError =
  { name : String
  , code : String
  , description : String
  , statusCode : Int
  }

type alias RawAuthenticationResult = { err : Maybe AuthenticationError, ok : Maybe LoggedInUser }
type alias AuthenticationResult = Result AuthenticationError LoggedInUser

type alias Options =
   { responseType : String
   , rememberLastLogin : Maybe Bool
   , closable : Maybe Bool
   , popup : Maybe Bool
   , sso : Maybe Bool
   , callbackURL : Maybe String
   , authParams: Maybe { scope: String }
   }

mapResult : RawAuthenticationResult -> AuthenticationResult
mapResult result =
    case (result.err, result.ok) of
        (Just msg, _) ->
            Err msg

        (Nothing, Nothing) ->
            Err { name = "unknown", code = "unknown", statusCode = 500, description = "No information was received from the authentication provider" }

        (Nothing, Just user) ->
            Ok user
