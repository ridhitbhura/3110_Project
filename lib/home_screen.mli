type t
(** List of popups; list of buttons; list of players; list of property
    cards. Use command.mli to check for user input; and update state as *)

type response =
  | NoButtonClicked
  | Response of t * bool
  | ProceedToGS

val image : t -> string

val x_coord : t -> int

val y_coord : t -> int

val width : t -> int

val height : t -> int

val window_title : t -> string

val popups : t -> Subscreen.t list

val buttons : t -> Button.t list

val check_button_clicked : t -> int * int -> Button.t option

val change_popups : t -> Subscreen.t list -> t

val replace_buttons : t -> Button.t list -> t

val check_button_click_and_respond : t -> int * int -> response
(**[check_button_click_and_respond hs] determines which button was
   clicked and makes the appropriate response.*)

val response_to_start_button : t -> t

(* val response_to_two_players_button : t -> t

   val response_to_four_players_button : t -> t

   val response_to_six_player_button : t -> t *)

val get_home_screen_from_json : Yojson.Basic.t -> t
