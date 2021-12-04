val img_path : string -> string
(**[img_path image] is the complete image path to any image.*)

val draw_img : string -> int -> int -> unit
(**[draw_img img x_coord y_cooord] draws the images at the given
   position.*)

val draw_button : Button.t -> unit
(**[draw_button b] draws the button on to the screen.*)

val draw_buttons : Button.t list -> unit
(**[draw_buttons buttons] draws the buttons on to the screen.*)

val draw_popup : Popup.t -> unit
(**[draw_popup p] draws the popup on to the screen.*)

val draw_popups : Popup.t list -> unit
(**[draw_popup p] draws the popups on to the screen.*)

val initialize_window : string -> int -> int -> unit
(**[initialize_window window_title width height] initializes an empty
   window with the given window title and dimensions.*)

val draw_home_screen : Home_screen.t -> unit
(**[draw_home_screen hs] draws all components of the home screen on to
   the window.*)
