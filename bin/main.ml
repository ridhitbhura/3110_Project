open Graphics
open Game
(*open Images*)

(** [window_dimensions] is [(width, height)] where width is the width of
    the window and height is the height of the window.*)
let window_dimensions = (1330, 700)

let dice_dim = (233, 275)
(* let title_pos = (450, 200) let titlescreen_dimensions = (1098, 392)
   let title_dimensions = (167, 63) let icon_dimensions = (35, 35) let
   subtitle_dimensions = (90, 44) let property_img_dimensions = (138,
   182) *)

let file = Yojson.Basic.from_file "data/standard.json"

let hs = Home_screen.get_home_screen_from_json file

let gs = Game_screen.get_game_screen_from_json file

let start_game _ =
  (* open_graph is an empty window*)
  (* open_graph ""; resize_window (fst window_dimensions) (snd
     window_dimensions); set_window_title "Prison Dash!";
     Gui.draw_home_screen game; Gui.press_button 's'; *)
  (*desired key is 's' to progress in gameplay*)
  (* clear_graph (); Gui.draw_game_screen_background game;
     Gui.draw_gameboard game; Gui.draw_dice game; Gui.draw_buttons
     game.game_screen.buttons; Gui.draw_factions game;
     Gui.draw_info_cards game; Gui.draw_dice_roll dice_dim game; *)
  (* wait_next_event [ Key_pressed ] *)
  open_graph "";
  resize_window (fst window_dimensions) (snd window_dimensions);
  set_window_title "Prison Dash!";
  Gui.draw_home_screen hs;
  Command.press_button 's';
  Gui.draw_game_screen gs;
  Command.press_button 's'

(* let gameboard = Gameboard.from_json (Yojson.Basic.from_file
   "data/ms1.json") in *)
(* let gui_parts = Gameboard.parse_json_for_gui game in
   Gui.draw_game_screen (fst gui_parts) (snd gui_parts); wait_next_event
   [Key_pressed] *)
let _ = start_game ()
