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