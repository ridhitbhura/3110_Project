type t
(** List of popups; list of buttons; list of players; list of property
    cards. Use command.mli to check for user input; and update state as *)

val image : t -> string

val x_coord : t -> int

val y_coord : t -> int

val width : t -> int

val height : t -> int

val window_title : t -> string

val popups : t -> Subscreen.t list

val buttons : t -> Button.t list

(* val check_start_clicked : t -> bool *)

val get_home_screen_from_json : Yojson.Basic.t -> t