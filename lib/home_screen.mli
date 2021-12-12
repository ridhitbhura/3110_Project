open Maps

type t
(** The abstract type representing a home screen. *)

type button_map = Button.t SM.t
(**[button_map] is a type representing a map with keys that are button
   names and values that are buttons.*)

type subscreen_map = Subscreen.t SM.t
(**[subscreen_map] is a type representing a map with keys that are
   subscreen names and values that are subscreens.*)

val image : t -> string
(**[image hs] is the background image of the hs.*)

val x_coord : t -> int
(**[x_coord hs] is the x-coordinate of the background image of the hs.*)

val y_coord : t -> int
(**[y_coord hs] is the y-coordinate of the background image of the hs.*)

val width : t -> int
(**[width hs] is the window width of the game.*)

val height : t -> int
(**[height hs] is the window height of the game.*)

val window_title : t -> string
(**[window_title hs] is the window title of the game.*)

val buttons : t -> button_map
(**[buttons hs] are the buttons in the home screen.*)

val subscreens : t -> subscreen_map
(**[subscreens hs] are the subscreens in the home screen.*)

type response =
  | NoButtonClicked
  | NewHS of t * bool
  | ProceedToGS
      (**[response] are the types of response that can be made by
         [respond_to_click hs coords]. No button in the home screen can
         be clicked. Or a button may have been clicked that proceeds
         that game from home screen to game screen. Or a button may have
         been clicked that produces a new home screen.*)

val respond_to_click : t -> int * int -> response
(**[check_button_click_and_respond hs] determines which button was
   clicked and makes the appropriate response.*)

val get_home_screen_from_json : Yojson.Basic.t -> t
(**[get_home_screen_from_json js] is the home screen that [hs]
   represents.*)
