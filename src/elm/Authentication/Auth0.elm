module Authentication.Auth0 exposing
  ( AuthenticationState(..)
  , AuthenticationError
  , AuthenticationResult
  , RawAuthenticationResult
  , defaultOpts
  , LoggedInUser
  , UserProfile
  , Token
  , Options
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
   , rememberLastLogin : Bool
   , closable : Bool
   , popup : Bool
   , sso : Bool
   , authParams: { scope: String }
   }

defaultOpts : Options
defaultOpts =
  { responseType = "token"
  , rememberLastLogin = True
  , closable = False
  , popup = False
  , sso = True
  , authParams = { scope = "openid" }
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
