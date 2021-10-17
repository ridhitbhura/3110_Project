
type t 

type location = int 

type cost = int 

type property_name = string 

type corner_name = string 

type weapon_name = string 

type food_name = string

exception UnknownProperty of property_name

exception UnknownCorner of corner_name

