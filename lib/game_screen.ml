open Yojson.Basic.Util

type t = {
  buttons : Button.t list;
  players : Player.t list;
  properties : Property.t list;
  food_stacks : Food_stack.t list;
  weapon_stacks : Weapon_stack.t list;
  action_spaces : Action_space.t list;
  pop_ups : Popup.t list;
  team_info : Popup.t list;
  info_cards : Popup.t;
  background_image : string;
  background_xcoord : int;
  background_ycoord : int;
  gameboard_image : string;
  gameboard_xcoord : int;
  gameboard_ycoord : int;
  dice : Die.t list;
}

let get_game_screen_from_json (json : Yojson.Basic.t) : t =
  let gs_json = json |> member "game_screen" in
  let btns =
    gs_json |> member "buttons" |> Button.get_buttons_from_json
  in
  let plyrs =
    gs_json |> member "players" |> Player.get_players_from_json
  in
  let props =
    gs_json |> member "properties" |> Property.get_properties_from_json
  in
  let ti =
    gs_json |> member "team_info" |> Popup.get_pop_ups_from_json
  in
  let bi =
    gs_json
    |> member "game_screen_background"
    |> member "image_name" |> to_string
  in
  let bi_x_coord =
    gs_json
    |> member "game_screen_background"
    |> member "x_coord" |> to_int
  in
  let bi_y_coord =
    gs_json
    |> member "game_screen_background"
    |> member "y_coord" |> to_int
  in
  let gi =
    gs_json |> member "gameboard" |> member "image_name" |> to_string
  in
  let gi_x_coord =
    gs_json |> member "gameboard" |> member "x_coord" |> to_int
  in
  let gi_y_coord =
    gs_json |> member "gameboard" |> member "y_coord" |> to_int
  in
  let ic =
    gs_json |> member "info_cards" |> Popup.get_pop_up_from_json
  in
  let pops =
    gs_json |> member "pop_ups" |> Popup.get_pop_ups_from_json
  in
  let foods =
    gs_json |> member "foods" |> member "food_types"
    |> Food.get_foods_from_json
  in
  let f_stacks =
    gs_json |> member "foods" |> member "food_stacks"
    |> Food_stack.get_food_stacks_from_json foods
  in
  let weapons =
    gs_json |> member "weapons" |> member "weapon_types"
    |> Weapon.get_weapons_from_json
  in
  let w_stacks =
    gs_json |> member "weapons" |> member "weapon_stacks"
    |> Weapon_stack.get_weapon_stacks_from_json weapons
  in
  let dice = gs_json |> member "dice" |> Die.get_dice_from_json in
  let actions =
    gs_json |> member "action_spaces"
    |> Action_space.get_action_spaces_from_json
  in

  {
    buttons = btns;
    players = plyrs;
    properties = props;
    pop_ups = pops;
    team_info = ti;
    background_image = bi;
    background_xcoord = bi_x_coord;
    background_ycoord = bi_y_coord;
    gameboard_image = gi;
    gameboard_xcoord = gi_x_coord;
    gameboard_ycoord = gi_y_coord;
    info_cards = ic;
    food_stacks = f_stacks;
    weapon_stacks = w_stacks;
    dice;
    action_spaces = actions;
  }