(*NEW STUFF ADDED*)

type t

(* [type property] represents an individual property or card*)
type property = {
  property_name: string;
  set: string;
  image_name: string;
  upgrade_cost: int;
  purchase_cost: int;
  tax: int;
  board_order: int;
  x_coord: int;
  y_coord: int;
}

type panel = {
  item_name: string;
  image_name: string;
  x_coord: int;
  y_coord: int;
}

(* [from_json j] is the gameboard that the json j represents*)
val from_json: Yojson.Basic.t -> t

(* [get_properties_in_set t s] is a list of property names that belong to the particular set s in gameboard t*)
val get_properties_in_set: t -> string -> string list 



(*OLD VERSION - Uncomment and it works*)

 
(* type t 

type location = int 

type cost = int 

type property_name = string 

type corner_name = string 

type weapon_name = string 

type food_name = string

exception UnknownProperty of property_name

exception UnknownCorner of corner_name  *)





