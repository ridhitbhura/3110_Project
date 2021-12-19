val img_path : string -> string
(**[img_path image] is the complete image path to any image.*)

val draw_img : string -> int -> int -> unit
(**[draw_img img x_coord y_cooord] draws the images at the given
   position.*)

val initialize_window : Home_screen.t -> unit
(**[initialize_window hs] initializes an empty window with the given
   window title and dimensions.*)

val draw_home_screen : Home_screen.t -> unit
(**[draw_home_screen hs] draws components of the home screen on to the
   window. Subscreens that are deactivated are not drawn.*)

val draw_game_screen : Game_screen.t -> unit
(**[draw_game_screen gs] draws components of the game screen on to the
   window. Subscreens that are deactivated are not drawn.*)

val press_button : char -> unit
(**[press_button c] waits until c has been entered on to the keyboard
   before proceeding.*)

val mouse_click : unit -> int * int
(**[mouse_click u] if a user clicks their mouse returns the x and y
   position of their click.*)
