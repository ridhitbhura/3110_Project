open Graphics
open Gameboard
open Functionality
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
  let dice1 = game.game_screen.dice.dice1 in
  let x = dice1.x_coord in
  let y = dice1.y_coord in
  let img = dice1.image_name in
  draw_img img x y;

  let dice2 = game.game_screen.dice.dice2 in
  let x = dice2.x_coord in
  let y = dice2.y_coord in
  let img = dice2.image_name in
  draw_img img x y

let rec draw_buttons (buttons : button list) =
  match buttons with
  | [] -> ()
  | h :: t ->
      let x = h.x_coord in
      let y = h.y_coord in
      let img = h.image_name in
      draw_img img x y;
      draw_buttons t

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

let dimension_check mouse img_dim x y =
  if
    fst mouse > x - (fst img_dim / 2)
    && fst mouse < x + (fst img_dim / 2)
    && snd mouse > y - (snd img_dim / 2)
    && snd mouse > y - (snd img_dim / 2)
  then true
  else false

let rec is_dice_clicked img_dim game =
  let dice1_x = game.game_screen.dice.dice1.x_coord in
  let dice1_y = game.game_screen.dice.dice1.y_coord in
  let dice2_x = game.game_screen.dice.dice2.x_coord in
  let dice2_y = game.game_screen.dice.dice2.y_coord in
  if button_down () then
    if
      dimension_check (mouse_pos ()) img_dim dice1_x dice1_y
      || dimension_check (mouse_pos ()) img_dim dice2_x dice2_y
    then handle2 0
    else is_dice_clicked img_dim game
  else is_dice_clicked img_dim game

let draw_dice_roll img_dim game =
  (* let x = game.game_screen.dice.x_coord + 50 in let y =
     game.game_screen.dice.y_coord + 50 in *)
  let z = is_dice_clicked img_dim game in
  let img = string_of_int z in
  draw_string img

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

let draw_new_button b =
  match Button.image b with
  | None -> ()
  | Some img ->
      let x = Button.x_coord b in
      let y = Button.y_coord b in
      draw_img img x y

let rec draw_new_buttons lst =
  match lst with
  | [] -> ()
  | h :: t ->
      draw_new_button h;
      draw_new_buttons t

let draw_popup p =
  let img = Popup.image p in
  let x = Popup.x_coord p in
  let y = Popup.y_coord p in
  draw_img img x y;
  let buttons = Popup.buttons p in
  draw_new_buttons buttons

let draw_new_home_screen hs =
  let img = Home_screen.image hs in
  let x = Home_screen.x_coord hs in
  let y = Home_screen.y_coord hs in
  draw_img img x y;
  let buttons = Home_screen.buttons hs in
  draw_new_buttons buttons

let rec press_button key =
  let status_key = (wait_next_event [ Key_pressed ]).key in
  if status_key = key then () else press_button key