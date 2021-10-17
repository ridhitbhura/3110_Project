open Graphics

let draw_title_description _ = 
  moveto 450 350;
  draw_string "Welcome to Prison Dash";
  moveto 450 200;
  draw_string "Press s to start the game"

let draw_home_screen _ =
  moveto 450 350;
  draw_string "Let's play"

(** [press_s_button key] is [()] when the user presses the key [key]. 
    If key pressed is not [key], the function loops, waiting for user to press some key.*)
let rec press_button key = 
  let status_key = (wait_next_event [Key_pressed]).key in
  if status_key = key then () else press_button key

(** [start_game _] is *)
let start_game _ = 
  (* open_graph is an empty window*)
  open_graph "";
  resize_window 1300 700;
  set_window_title "Prison Dash!";
  draw_title_description ();
  press_button 's' ; (*desired key is 's' to progress in gameplay*)
  clear_graph ();
  draw_home_screen ();
  wait_next_event [Key_pressed]

let x = start_game ()