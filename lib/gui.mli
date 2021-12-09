val img_path : string -> string
(**[img_path image] is the complete image path to any image.*)

val draw_img : string -> int -> int -> unit
(**[draw_img img x_coord y_cooord] draws the images at the given
   position.*)

val draw_button : Button.t -> unit
(**[draw_button b] draws the button on to the screen.*)

val draw_buttons : Button.t list -> unit
(**[draw_buttons buttons] draws the buttons on to the screen.*)

val draw_subscreen : Subscreen.t -> unit
(**[draw_subscreen s] draws the subscreen on to the screen if the
   subscreen is active.*)

val draw_subscreens : Subscreen.t list -> unit
(**[draw_subscreens p] draws the active subscreens on to the screen.*)

val draw_dynamic_image : Dynamic_image.t -> unit

val draw_dynamic_images : Dynamic_image.t list -> unit

val initialize_window : Home_screen.t -> unit
(**[initialize_window hs] initializes an empty window with the given
   window title and dimensions.*)

val draw_home_screen : Home_screen.t -> unit
(**[draw_home_screen hs] draws all components of the home screen on to
   the window.*)

val draw_die : Die.t -> unit

val draw_dice : Die.t list -> unit

val draw_game_screen : Game_screen.t -> unit
