open Yojson.Basic.Util

type fee = {
  base : int;
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

type buttons = {
  trade_button : button;
  end_turn_button : button;
  exit_game_button : button;
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
  start_button : button;
  credits_button : button;
  x_coord : int;
  y_coord : int;
}

type game_screen = {
  game_screen_background : game_screen_background;
  (* contains the image and the position of the monopoly board*)
  gameboard : gameboard;
  (* all the properties in the gameboard*)
  properties : property list;
  (* assoc list where key is set name (color) and value is string list
     containing names of properties*)
  sets : (string * string list) list;
  (* names/image/position information for the player panel on the side*)
  factions : factions;
  info_cards : info_cards;
  buttons : buttons;
  dice : dices;
}

type game = {
  game_screen : game_screen;
  home_screen : home_screen;
}

let get_fee_from_json (json : Yojson.Basic.t) : fee =
  {
    base = json |> member "base" |> to_int;
    set = json |> member "set" |> to_int;
    control_1 = json |> member "control_1" |> to_int;
    control_2 = json |> member "control_2" |> to_int;
    control_3 = json |> member "control_3" |> to_int;
    control_4 = json |> member "control_4" |> to_int;
    take_over = json |> member "take_over" |> to_int;
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
    fee = json |> member "fee" |> get_fee_from_json;
    x_coord = json |> member "x_coord" |> to_int;
    y_coord = json |> member "y_coord" |> to_int;
    board_order = json |> member "board_order" |> to_int;
    mortgage = json |> member "mortgage" |> to_int;
    width = json |> member "width" |> to_int;
    height = json |> member "height" |> to_int;
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

let get_game_screen_background_from_json (json : Yojson.Basic.t) :
    game_screen_background =
  {
    x_coord =
      json
      |> member "game_screen_background"
      |> member "x_coord" |> to_int;
    y_coord =
      json
      |> member "game_screen_background"
      |> member "y_coord" |> to_int;
    image_name =
      json
      |> member "game_screen_background"
      |> member "image_name" |> to_string;
  }

let get_gameboard_from_json (json : Yojson.Basic.t) : gameboard =
  {
    x_coord = json |> member "gameboard" |> member "x_coord" |> to_int;
    y_coord = json |> member "gameboard" |> member "y_coord" |> to_int;
    image_name =
      json |> member "gameboard" |> member "image_name" |> to_string;
  }

let get_player_from_json (json : Yojson.Basic.t) : player =
  {
    image_name = json |> member "image_name" |> to_string;
    x_coord = json |> member "x_coord" |> to_int;
    y_coord = json |> member "y_coord" |> to_int;
  }

let get_faction_from_json (json : Yojson.Basic.t) : faction =
  {
    image_name = json |> member "image_name" |> to_string;
    x_coord = json |> member "x_coord" |> to_int;
    y_coord = json |> member "y_coord" |> to_int;
    players =
      json |> member "players" |> to_list
      |> List.map get_player_from_json;
  }

let get_factions_from_json (json : Yojson.Basic.t) : factions =
  {
    stripes =
      json |> member "factions" |> member "stripes"
      |> get_faction_from_json;
    solids =
      json |> member "factions" |> member "solids"
      |> get_faction_from_json;
  }

let get_info_card_from_json (json : Yojson.Basic.t) : info_card =
  {
    image_name = json |> member "image_name" |> to_string;
    x_coord = json |> member "x_coord" |> to_int;
    y_coord = json |> member "y_coord" |> to_int;
  }

let get_info_cards_from_json (json : Yojson.Basic.t) : info_cards =
  {
    property_info =
      json |> member "info_cards" |> member "property_info"
      |> get_info_card_from_json;
    weapon_info =
      json |> member "info_cards" |> member "weapon_info"
      |> get_info_card_from_json;
    food_info =
      json |> member "info_cards" |> member "food_info"
      |> get_info_card_from_json;
  }

let get_button_from_json (json : Yojson.Basic.t) : button =
  {
    image_name = json |> member "image_name" |> to_string;
    x_coord = json |> member "x_coord" |> to_int;
    y_coord = json |> member "y_coord" |> to_int;
  }

let get_buttons_from_json (json : Yojson.Basic.t) : buttons =
  {
    trade_button =
      json |> member "buttons" |> member "trade_button"
      |> get_button_from_json;
    end_turn_button =
      json |> member "buttons"
      |> member "end_turn_button"
      |> get_button_from_json;
    exit_game_button =
      json |> member "buttons"
      |> member "exit_game_button"
      |> get_button_from_json;
  }

let get_dice_from_json (json : Yojson.Basic.t) : dice =
  {
    image_name = json |> member "image_name" |> to_string;
    x_coord = json |> member "x_coord" |> to_int;
    y_coord = json |> member "y_coord" |> to_int;
  }

let get_dices_from_json (json : Yojson.Basic.t) : dices =
  {
    dice1 =
      json |> member "dice" |> member "dice_1" |> get_dice_from_json;
    dice2 =
      json |> member "dice" |> member "dice_2" |> get_dice_from_json;
  }

let get_game_screen_from_json (json : Yojson.Basic.t) : game_screen =
  {
    game_screen_background = get_game_screen_background_from_json json;
    gameboard = get_gameboard_from_json json;
    properties = get_properties_from_json json;
    sets = get_sets_from_json json;
    factions = get_factions_from_json json;
    info_cards = get_info_cards_from_json json;
    buttons = get_buttons_from_json json;
    dice = get_dices_from_json json;
  }

let get_home_screen_from_json (json : Yojson.Basic.t) : home_screen =
  {
    image_name =
      json |> member "home_screen" |> member "image_name" |> to_string;
    x_coord = json |> member "home_screen" |> member "x_coord" |> to_int;
    y_coord = json |> member "home_screen" |> member "y_coord" |> to_int;
    start_button =
      json |> member "home_screen" |> member "start_button"
      |> get_button_from_json;
    credits_button =
      json |> member "home_screen" |> member "credits_button"
      |> get_button_from_json;
  }

let from_json (json : Yojson.Basic.t) : game =
  {
    game_screen = get_game_screen_from_json json;
    home_screen = get_home_screen_from_json json;
  }