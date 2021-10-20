(* open Yojson.Basic.Util

type property = {
  property_name: string;
  set: string;
  image_name: string;
  upgrade_cost: int;
  purchase_cost: int;
  tax: int;
  board_order: int;
}

type t = {
  (* all the properties in the gameboard*)
  properties: property list; 
  (* assoc list where key is set name (color) and value is string list containing names of properties*)
  sets: (string * string list) list
}

(** [get_property_from_json json] parses a single property json to give a property type*)
let get_property_from_json (json:Yojson.Basic.t): property = {
  property_name = json |> member "property_name" |> to_string;
  set = json |> member "set_name" |> to_string;
  image_name = json |> member "image_name" |> to_string;
  upgrade_cost = json |> member "upgrade_cost" |> to_int;
  purchase_cost = json |> member "purchase_cost" |> to_int;
  tax = json |> member "tax" |> to_int;
  board_order = json |> member "board_order" |> to_int;
}

(** [get_properties_from_json json] parses all the properties from the json*)
let get_properties_from_json (json:Yojson.Basic.t): property list =
  json |> member "properties" |> to_list |> List.map get_property_from_json

let get_set_list_from_json (json:Yojson.Basic.t): string * string list = (
  json |> member "set_name" |> to_string, 
  json |> member "set_properties" |> to_list |> List.map to_string
)
let get_sets_from_json (json:Yojson.Basic.t): (string * string list) list = 
  json |> member "sets" |> to_list |> List.map get_set_list_from_json

let from_json (json:Yojson.Basic.t) = {
  properties = get_properties_from_json json;
  sets = get_sets_from_json json;
}

let get_properties_in_set t (set: string) : string list = List.assoc set t.sets *)





(*OLD VERSION - Uncomment and it works*)


type property_name = string 

type weapon_name = string 

type food_name = string 

type corner_name = string 

type cost = int 

type location = int 

type board_order = int

exception UnknownProperty of property_name

exception UnknownCorner of corner_name 

type set = {
  set_name: string;
  property_set : property_name list  
}

type property = {
  property_name: property_name; 
  set_name: set;
  upgrade_cost: int ; 
  purchase_cost: int; 
  tax: int; 
  board_order: board_order;
  (* owner: Player.get_name input; *)
  (* image: Image *)
}


type weapon = { 
  name: weapon_name;
  damage: int; 
  descrption: string; 
  (* image: Image *)
}

type weapon_stack = { 
  weapons_left: weapon list;
  board_order : board_order;
  
}
type food = { 
  hp_gain : int ;
  description : string; 
  (* image: Image *)
}

type food_stack = { 
  food_left : food list;
  board_order : board_order

}

type corner = {
  corner_name : string; 
  board_order :  board_order;
} 

type t = {
  properties : property list; 
  weapon_stack: weapon_stack;
  food_stack : food_stack; 
  corners: corner list; 
}

