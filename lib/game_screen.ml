open Yojson.Basic.Util
open Maps

type button_map = Button.t SM.t

type subscreen_map = Subscreen.t SM.t

type player_map = Player.t IM.t

type property_map = Property.t IM.t

type food_stack_map = Food_stack.t IM.t

type weapon_stack_map = Weapon_stack.t IM.t

type action_space_map = Action_space.t IM.t

type t = {
  buttons : button_map;
  players : player_map;
  properties : property_map;
  food_stacks : food_stack_map;
  weapon_stacks : weapon_stack_map;
  action_spaces : action_space_map;
  pop_ups : subscreen_map;
  team_info : subscreen_map;
  info_cards : Subscreen.t;
  background_image : string;
  background_xcoord : int;
  background_ycoord : int;
  gameboard_image : string;
  gameboard_xcoord : int;
  gameboard_ycoord : int;
  dice : Die.t list;
  order_list: (int * (int*int)) list
}

(* Returns the order list or the board_location to (x, y) coords. *)
let get_order_list_from_json el = 
  (el |> member "order" |> to_int, 
    (el |> member "x_coord" |> to_int, 
    el |> member "y_coord" |> to_int)
  )

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
    gs_json |> member "team_info" |> Subscreen.get_subscreens_from_json
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
  let _, ic =
    gs_json |> member "info_cards" |> Subscreen.get_subscreen_from_json
  in
  let pops =
    gs_json |> member "subscreens" |> Subscreen.get_subscreens_from_json
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
  let or_lst = gs_json |> member "board_order_coords" |> to_list 
      |> List.map get_order_list_from_json in 
  {
    buttons = SM.of_lst btns SM.empty;
    players = IM.of_lst plyrs IM.empty;
    properties = IM.of_lst props IM.empty;
    pop_ups = SM.of_lst pops SM.empty;
    team_info = Subscreen.activates (SM.of_lst ti SM.empty);
    background_image = bi;
    background_xcoord = bi_x_coord;
    background_ycoord = bi_y_coord;
    gameboard_image = gi;
    gameboard_xcoord = gi_x_coord;
    gameboard_ycoord = gi_y_coord;
    info_cards = Subscreen.activate ic;
    food_stacks = IM.of_lst f_stacks IM.empty;
    weapon_stacks = IM.of_lst w_stacks IM.empty;
    dice;
    action_spaces = IM.of_lst actions IM.empty;
    order_list = or_lst;
  }

let buttons gs = gs.buttons

let players gs = gs.players

let properties gs = gs.properties

let food_stacks gs = gs.food_stacks

let weapon_stacks gs = gs.weapon_stacks

let action_spaces gs = gs.action_spaces

let pop_ups gs = gs.pop_ups

let team_info gs = gs.team_info

let info_cards gs = gs.info_cards

let background_image gs = gs.background_image

let background_xcoord gs = gs.background_xcoord

let background_ycoord gs = gs.background_ycoord

let gameboard_image gs = gs.gameboard_image

let gameboard_xcoord gs = gs.gameboard_xcoord

let gameboard_ycoord gs = gs.gameboard_ycoord

let dice gs = gs.dice

let rec find_player_number plyrs_to_chars plyr =
  match plyrs_to_chars with
  | [] -> None
  | (p, c) :: t ->
      if Player.character plyr = c then Some p
      else find_player_number t plyr

(*there's some complicated stuff going on here. to put it simply, all
  players module are either given a player number or they were not
  selected, meaning they are deactivated.*)
let initialize gs plyrs_to_chars =
  let initialized_players =
    IM.mapi
      (fun _ p ->
        match find_player_number plyrs_to_chars p with
        | None -> Player.deactivate p
        | Some num -> Player.update_player_number p num)
      gs.players
  in
  { gs with players = initialized_players }

type response =
  | EndGame
  | NewGS of t

(*currently only gets dice buttons*)
let get_dice_buttons gs = List.map (fun d -> Die.button d) gs.dice

let check_dice_button_clicked buttons (x, y) =
  List.find_opt (fun b -> Button.is_clicked b (x, y)) buttons


let update_board_loc pl dice_val = 
  let loc_old = Player.location pl in 
  (loc_old + dice_val) mod 40

let get_xy_for_board_loc loc gs = match List.assoc_opt loc gs.order_list with 
  | None -> failwith "board order and respective coords dont exist"
  | Some v -> v

let respond_to_dice_click gs pl_num =
  begin match gs.dice with
  | [ h; t ] ->
      let first_roll = Die.roll_die h in
      let new_first_die = Die.new_image h first_roll in
      let second_roll = Die.roll_die t in
      let new_second_die = Die.new_image t second_roll in
      let dice_val = first_roll + second_roll in 
      begin match IM.find_opt pl_num gs.players with 
      | None -> failwith "doesnt have current player"
      | Some v -> 
        let new_board_loc = update_board_loc v dice_val in 
        let (new_x, new_y) = get_xy_for_board_loc new_board_loc gs in
        let v_new = Player.move_board new_board_loc v |> Player.move_coord (new_x + Constants.player_offset) (new_y + Constants.player_offset) in 
        let pl_map = IM.add pl_num v_new gs.players in
      NewGS { gs with dice = [ new_first_die; new_second_die ]; players=pl_map} end
      (* NewGS { gs with dice = [ new_first_die; new_second_die ]} *)
  | _ -> failwith "precondition violation" end

(* respond_to_dice_click gs 1 is moving player 1 for now. Yet to implement multi player movement  *)
let respond_to_click gs (x, y) =
  let buttons = get_dice_buttons gs in
  let clicked_button = check_dice_button_clicked buttons (x, y) in
  match clicked_button with
  | None -> NewGS gs
  | Some _ -> respond_to_dice_click gs 1
