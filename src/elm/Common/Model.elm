module Common.Model exposing (Domain, emptyDomain)

type alias Domain =
  { id : Int
  , name : String
  }

emptyDomain : Domain
emptyDomain =
  { id = 0
  , name = ""
  }
