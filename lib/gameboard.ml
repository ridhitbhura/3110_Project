open Yojson.Basic.Util

type fee = {
  normal : int;
  set : int;
  control_1 : int;
  control_2 : int;
  control_3 : int;
  control_4 : int;
  take_over : int;
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
  x_coord_gameboard : int;
  y_coord_gameboard : int;
  board_image : string;
}

type player = {
  player_stats : string;
  x_coord_stat : int;
  y_coord_stat : int;
}

type faction = {
  background_image : string;
  x_coord_background : int;
  y_coord_background : int;
  players : player list;
}

type factions = {
  stripes : faction;
  solids : faction;
}

(* type info_card = |Property |Weapon |Food

   type info_cards = { info_card_image: string;

   } *)

type t = {
  (* contains the image and the position of the monopoly board*)
  gameboard : gameboard;
  (* all the properties in the gameboard*)
  properties : property list;
  (* assoc list where key is set name (color) and value is string list
     containing names of properties*)
  sets : (string * string list) list;
  (* names/image/position information for the player panel on the side*)
  factions : faction; (* info_cards: info_card list *)
}

(** [get_property_from_json json] parses a single property json to give
    a property type*)
let get_property_from_json (json : Yojson.Basic.t) : property =
  {
    property_name = json |> member "property_name" |> to_string;
    set = json |> member "set" |> to_string;
    image_name = json |> member "image_name" |> to_string;
    upgrade_cost = json |> member "upgrade_cost" |> to_int;
    purchase_cost = json |> member "purchase_cost" |> to_int;
    tax = json |> member "tax" |> to_int;
    board_order = json |> member "board_order" |> to_int;
    x_coord = json |> member "x_coord" |> to_int;
    y_coord = json |> member "y_coord" |> to_int;
  }

(** [get_properties_from_json json] parses all the properties from the
    json*)
let get_properties_from_json (json : Yojson.Basic.t) : property list =
  json |> member "properties" |> to_list
  |> List.map get_property_from_json

let get_set_list_from_json (json : Yojson.Basic.t) :
    string * string list =
  ( json |> member "set_name" |> to_string,
    json |> member "set_properties" |> to_list |> List.map to_string )

let get_sets_from_json (json : Yojson.Basic.t) :
    (string * string list) list =
  json |> member "sets" |> to_list |> List.map get_set_list_from_json

(** [get_panel_item_from_json json] parses a single panel item json to
    give a panel type*)
let get_panel_item_from_json (json : Yojson.Basic.t) : panel =
  {
    item_name = json |> member "item_name" |> to_string;
    image_name_panel = json |> member "image_name" |> to_string;
    x_coord_panel = json |> member "x_coord" |> to_int;
    y_coord_panel = json |> member "y_coord" |> to_int;
  }

(** [get_panel_from_json json] parses all the properties from the json*)
let get_panel_from_json (json : Yojson.Basic.t) : panel list =
  json |> member "player_panel" |> to_list
  |> List.map get_panel_item_from_json

let from_json (json : Yojson.Basic.t) =
  {
    properties = get_properties_from_json json;
    sets = get_sets_from_json json;
    panel = get_panel_from_json json;
  }

let rec get_properties_gui_info lst =
  match lst with
  | [] -> []
  | h :: t ->
      (h.image_name, h.x_coord, h.y_coord) :: get_properties_gui_info t

let rec get_panel_gui_info lst =
  match lst with
  | [] -> []
  | h :: t ->
      (h.image_name_panel, h.x_coord_panel, h.y_coord_panel)
      :: get_panel_gui_info t

let parse_json_for_gui (g : t) :
    (string * int * int) list * (string * int * int) list =
  (get_properties_gui_info g.properties, get_panel_gui_info g.panel)

let get_properties_in_set t (set : string) : string list =
  List.assoc set t.sets

(*OLD VERSION - Uncomment and it works*)

(* type property_name = string

   type weapon_name = string

   type food_name = string

   type corner_name = string

   type cost = int

   type location = int

   type board_order = int

   exception UnknownProperty of property_name

   exception UnknownCorner of corner_name

   type set = { set_name: string; property_set : property_name list }

   type property = { property_name: property_name; set_name: set;
   upgrade_cost: int ; purchase_cost: int; tax: int; board_order:
   board_order; (* owner: Player.get_name input; *) (* image: Image *) }

   type weapon = { name: weapon_name; damage: int; descrption: string;
   (* image: Image *) }

   type weapon_stack = { weapons_left: weapon list; board_order :
   board_order;

   } type food = { hp_gain : int ; description : string; (* image: Image
   *) }

   type food_stack = { food_left : food list; board_order : board_order

   }

   type corner = { corner_name : string; board_order : board_order; }

   type t = { properties : property list; weapon_stack: weapon_stack;
   food_stack : food_stack; corners: corner list; } *)
