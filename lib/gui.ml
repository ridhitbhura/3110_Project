open Graphics
open Gameboard
(* let titlescreen_dimensions = (1098, 392)

   let property_img_dimensions = (138, 182) *)

(* let img_path img_name = "images/" ^ img_name ^ ".png" *)

let img_path img_name = "images/" ^ img_name

(*draw_img draws each individual image *)
let draw_img img_name x_coord y_coord =
  let path = img_path img_name in
  let img = Png.load_as_rgb24 path [] in
  let g = Graphic_image.of_image img in
  Graphics.draw_image g x_coord y_coord

(*draw_img draws each individual image *)
(* let draw_img img_name x_coord y_coord img_w img_h centered = let path
   = img_path img_name in let img = Png.load_as_rgb24 path [] in let g =
   Graphic_image.of_image img in if centered then Graphics.draw_image g
   (x_coord-(img_w/2)) (y_coord-(img_h/2)) else Graphics.draw_image g
   (x_coord) (y_coord) *)

let draw_home_screen game =
  let x = game.home_screen.x_coord in
  let y = game.home_screen.y_coord in
  let img = game.home_screen.image_name in
  draw_img img x y

let draw_game_screen_background game =
  let x = game.game_screen.game_screen_background.x_coord in
  let y = game.game_screen.game_screen_background.y_coord in
  let img = game.game_screen.game_screen_background.image_name in
  draw_img img x y

let draw_gameboard game =
  let x = game.game_screen.gameboard.x_coord in
  let y = game.game_screen.gameboard.y_coord in
  let img = game.game_screen.gameboard.image_name in
  draw_img img x y

let draw_dice game =
  let x = game.game_screen.dice.x_coord in
  let y = game.game_screen.dice.y_coord in
  let img = game.game_screen.dice.image_name in
  draw_img img x y

let draw_buttons game =
  let trade_button = game.game_screen.buttons.trade_button in
  let x = trade_button.x_coord in
  let y = trade_button.y_coord in
  let img = trade_button.image_name in
  draw_img img x y;

  let sell_button = game.game_screen.buttons.sell_button in
  let x = sell_button.x_coord in
  let y = sell_button.y_coord in
  let img = sell_button.image_name in
  draw_img img x y;

  let mortgage_button = game.game_screen.buttons.mortgage_button in
  let x = mortgage_button.x_coord in
  let y = mortgage_button.y_coord in
  let img = mortgage_button.image_name in
  draw_img img x y;

  let build_button = game.game_screen.buttons.build_button in
  let x = build_button.x_coord in
  let y = build_button.y_coord in
  let img = build_button.image_name in
  draw_img img x y

let rec draw_players (players : player list) =
  match players with
  | [] -> ()
  | h :: t ->
      let x = h.x_coord in
      let y = h.y_coord in
      let img = h.image_name in
      draw_img img x y;
      draw_players t

let draw_factions game =
  let stripes = game.game_screen.factions.stripes in
  let x = stripes.x_coord in
  let y = stripes.y_coord in
  let img = stripes.image_name in
  draw_img img x y;

  let stripes = game.game_screen.factions.stripes in
  draw_players stripes.players;

  let solids = game.game_screen.factions.solids in
  let x = solids.x_coord in
  let y = solids.y_coord in
  let img = solids.image_name in
  draw_img img x y;

  let solids = game.game_screen.factions.solids in
  draw_players solids.players

let draw_info_cards game =
  let property_info = game.game_screen.info_cards.property_info in
  let x = property_info.x_coord in
  let y = property_info.y_coord in
  let img = property_info.image_name in
  draw_img img x y;

  let weapon_info = game.game_screen.info_cards.weapon_info in
  let x = weapon_info.x_coord in
  let y = weapon_info.y_coord in
  let img = weapon_info.image_name in
  draw_img img x y;

  let food_info = game.game_screen.info_cards.food_info in
  let x = food_info.x_coord in
  let y = food_info.y_coord in
  let img = food_info.image_name in
  draw_img img x y

(* let dimension_check mouse img_dim x y = if fst mouse > x - (fst
   img_dim / 2) && fst mouse < x + (fst img_dim / 2) && snd mouse > y -
   (snd img_dim / 2) && snd mouse > y - (snd img_dim / 2) then true else
   false

   let rec is_dice_clicked img_dim game = let x =
   game.game_screen.dice.x_coord in let y =
   game.game_screen.dice.x_coord in if button_down () then if
   dimension_check (mouse_pos ()) img_dim x y then Functionality.handle2
   0 else is_dice_clicked img_dim game else is_dice_clicked img_dim game

   let draw_dice_roll img_dim game = let x =
   game.game_screen.dice.x_coord + 50 in let y =
   game.game_screen.dice.y_coord + 50 in let z = is_dice_clicked img_dim
   game in let img = string_of_int z ^ ".png" in draw_img img x y *)

(* let draw_home_screen x_coord y_coord = draw_img "titlescreen.png"
   x_coord y_coord (fst titlescreen_dimensions) (snd
   titlescreen_dimensions) true *)

(* let rec draw_properties property_locations = match property_locations
   with | [] -> () | (name, x_coord, y_coord) :: t -> (* print_string
   name; print_newline (); print_int x_coord; print_newline ();
   print_int y_coord; print_newline (); *) draw_img name x_coord y_coord
   (fst property_img_dimensions) (snd property_img_dimensions) false;
   draw_properties t

   let draw_game_screen property_locations player_info_locations =
   draw_properties property_locations; draw_properties
   player_info_locations *)

(* draw_img "barbell_50" x_coord y_coord (fst property_img_dimensions)
   (snd property_img_dimensions) *)

(** [press_s_button key] is [()] when the user presses the key [key]. If
    key pressed is not [key], the function loops, waiting for user to
    press some key.*)
let rec press_button key =
  let status_key = (wait_next_event [ Key_pressed ]).key in
  if status_key = key then () else press_button key