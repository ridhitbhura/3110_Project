(*NEW STUFF*)
type fee = {
  base : int;
  set : int;
  control_1 : int;
  control_2 : int;
  control_3 : int;
  control_4 : int;
  take_over : int;
}

type corner = {
  corner_name: string;
  board_order: int;
  x_coord: int;
  y_coord: int;
  width: int;
  height: int
}

type utility = {
  utility_name: string;
  board_order: int;
  x_coord: int;
  y_coord: int;
  width: int;
  height: int
}

type property = {
  property_name : string;
  set : string;
  image_name : string;
  upgrade_cost : int;
  purchase_cost : int;
  fee : fee;
  mortgage : int;
  board_order : int;
  x_coord : int;
  y_coord : int;
  width : int;
  height : int;
}

type gameboard = {
  x_coord : int;
  y_coord : int;
  image_name : string;
}

type player = {
  image_name : string;
  x_coord : int;
  y_coord : int;
}

type faction = {
  image_name : string;
  x_coord : int;
  y_coord : int;
  players : player list;
}

type factions = {
  stripes : faction;
  solids : faction;
}

type info_card = {
  image_name : string;
  x_coord : int;
  y_coord : int;
}

type info_cards = {
  property_info : info_card;
  weapon_info : info_card;
  food_info : info_card;
}

type button = {
  image_name : string;
  x_coord : int;
  y_coord : int;
}

type dice = {
  x_coord : int;
  y_coord : int;
  image_name : string;
}

type dices = {
  dice1 : dice;
  dice2 : dice;
}

type game_screen_background = {
  x_coord : int;
  y_coord : int;
  image_name : string;
}

type home_screen = {
  image_name : string;
  buttons : button list;
  x_coord : int;
  y_coord : int;
}
type order = int*(int*int)

type game_screen = {
  game_screen_background : game_screen_background;
  (* contains the image and the position of the monopoly board*)
  gameboard : gameboard;
  (* all the properties in the gameboard*)
  properties : property list;
  utilities: utility list;
  corners: corner list;
  (* assoc list where key is set name (color) and value is string list
     containing names of properties*)
  sets : (string * string list) list;
  (* names/image/position information for the player panel on the side*)
  factions : factions;
  info_cards : info_cards;
  buttons : button list;
  dice : dices;
  order_list: order list;
}

type game = {
  game_screen : game_screen;
  home_screen : home_screen;
}

(* [type property] represents an individual property or card*)
(* type property = { property_name: string; set: string; image_name:
   string; upgrade_cost: int; purchase_cost: int; tax: int; board_order:
   int; x_coord: int; y_coord: int; }

   (* type panel = { item_name: string; image_name_panel: string;
   x_coord_panel: int; y_coord_panel: int; } *) *)

(* [from_json j] is the gameboard that the json j represents*)
val from_json : Yojson.Basic.t -> game

(* (* [get_properties_in_set t s] is a list of property names that
   belong to the particular set s in gameboard t*) val
   get_properties_in_set : gameboard -> string -> string list

   val parse_json_for_gui : gameboard -> (string * int * int) list *
   (string * int * int) list *)

(*OLD VERSION - Uncomment and it works*)

(* type t

   type location = int

   type cost = int

   type property_name = string

   type corner_name = string

   type weapon_name = string

   type food_name = string

   exception UnknownProperty of property_name

   exception UnknownCorner of corner_name *)
