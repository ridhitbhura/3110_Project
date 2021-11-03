open Graphics
open Game
open Functionality
(*open Images*)

(** [window_dimensions] is [(width, height)] where width is the width of
    the window and height is the height of the window.*)
let window_dimensions = (1330, 700)

let dice_dim = (233, 275)
(* let title_pos = (450, 200) let titlescreen_dimensions = (1098, 392)
   let title_dimensions = (167, 63) let icon_dimensions = (35, 35) let
   subtitle_dimensions = (90, 44) let property_img_dimensions = (138,
   182) *)

(* let img_row1 = snd window_dimensions/8 let img_row2 = snd
   window_dimensions/8 + 200 let img_row3 = snd window_dimensions/8 +
   400

   let img_col1 = fst window_dimensions/2 let img_col2 = fst
   window_dimensions/2 + 150 let img_col3 = fst window_dimensions/2 +
   300

   let left_col_buffer = 10

   let third_window = 200 *)

(* let property_locations = [("barbell_50", img_col1, img_row1);
   ("dumbell_50", img_col2, img_row1); ("treadmill_50", img_col3,
   img_row1); ("chef_50", img_col1, img_row2); ("dining_table_50",
   img_col2, img_row2); ("instant_ramen_50", img_col3, img_row2);
   ("sink_50", img_col1, img_row3); ("toilet_50", img_col2, img_row3);
   ("shower_50", img_col3, img_row3)] *)

(* let player_info_locations = [("stripes_50", left_col_buffer, 4 * snd
   icon_dimensions + 4 * snd subtitle_dimensions + snd title_dimensions
   + 50 + third_window); ("gold_50", left_col_buffer, 4 * snd
   icon_dimensions + 3 * snd subtitle_dimensions + snd title_dimensions
   + 45 + third_window); ("coin_50", left_col_buffer, 3 * snd
   icon_dimensions + 3 * snd subtitle_dimensions + snd title_dimensions
   + 40 + third_window); ("lives_50", left_col_buffer, 3 * snd
   icon_dimensions + 2 * snd subtitle_dimensions + snd title_dimensions
   + 35 + third_window); ("heart_50", left_col_buffer, 2 * snd
   icon_dimensions + 2 * snd subtitle_dimensions + snd title_dimensions
   + 30 + third_window); ("solids_50", left_col_buffer-5, 2 * snd
   icon_dimensions + 2 * snd subtitle_dimensions + 25 + third_window);
   ("gold_50", left_col_buffer, 2 * snd icon_dimensions + snd
   subtitle_dimensions + 20 + third_window); ("coin_50",
   left_col_buffer, snd icon_dimensions + snd subtitle_dimensions + 15 +
   third_window); ("lives_50", left_col_buffer, snd icon_dimensions + 10
   + third_window); ("heart_50", left_col_buffer, 5 + third_window);] *)

let file = Yojson.Basic.from_file "data/ms1.json"

let game = Gameboard.from_json file

(* let rec print_gui_parts g = match g with | [] -> print_string "empty
   list" | (a,_,_) :: tail -> print_string a; print_gui_parts tail *)

(** [start_game _] is the function running all commands in a sequence*)
let start_game _ =
  (* open_graph is an empty window*)
  open_graph "";
  resize_window (fst window_dimensions) (snd window_dimensions);
  set_window_title "Prison Dash!";
  Gui.draw_home_screen game;
  Gui.press_button 's';
  (*desired key is 's' to progress in gameplay*)
  clear_graph ();
  Gui.draw_game_screen_background game;
  Gui.draw_gameboard game;
  Gui.draw_dice game;
  Gui.draw_buttons game;
  Gui.draw_factions game;
  Gui.draw_info_cards game;
  (* Gui.draw_dice_roll dice_dim game; *)
  wait_next_event [ Key_pressed ]

(* let gameboard = Gameboard.from_json (Yojson.Basic.from_file
   "data/ms1.json") in *)
(* let gui_parts = Gameboard.parse_json_for_gui game in
   Gui.draw_game_screen (fst gui_parts) (snd gui_parts); wait_next_event
   [Key_pressed] *)
let _ = start_game ()

(** stack overflow*)
(* let open_img _ = open_graph ""; *)
(*set_color white;*)
(* let images_t = Png.load_as_rgb24"images/barbell.png" [] in let
   images_of = Graphic_image.of_image images_t in let images_rgb =
   Graphic_image.image_of images_of in let smaller_img_rgb =
   Rgb24.resize None images_rgb 50 50 in let smaller_img_rgb =
   Rgb24.resize None images_t 50 50 in *)
(* let img = Png.load_as_rgb24 "images/barbell_50.png" [] in let g =
   Graphic_image.of_image img in Graphics.draw_image g 200 200; let _ =
   (wait_next_event [Key_pressed]).key in () *)
