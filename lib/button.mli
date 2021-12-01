type t
(**The abstract type representing a button.*)

type dimen = {
  x_range : int * int;
  y_range : int * int;
}
(** The [x_range] and [y_range] dictate the boundaries of the button.*)

val is_clicked : t -> bool
(**[is_clicked button] is whether the button was clicked.*)

val click : t -> t
(**[click button] changes the status of the button to clicked.*)

val unclick : t -> t
(**[unclick button] changes the status of the button to unclicked.*)

val is_dimmed : t -> bool
(**[is_dimmed button] is whether if the button is dimmed, or if it is
   operating.*)

val dim : t -> t
(**[dim button] deactivates [button] making it unclickable.*)

val undim : t -> t
(**[undim button] reactvates [button] making it clickable.*)

val dimension : t -> dimen
(**[dimension button] gives the dimensions of the button with respect to
   the game screen.*)

val image : t -> string
(**[image button] is the name of the button image.*)

val dimmed_image : t -> string option
(**[dimmed_image button] is the [Some name] if a dimmed button image
   exists, otherwise it is [None]*)

val get_button_from_json : Yojson.Basic.t -> t

val get_buttons_from_json : Yojson.Basic.t -> string -> t list

type init = {
  x_coord : int;
  y_coord : int;
  width : int;
  height : int;
  image : string;
  dimmed_image : string option;
}

val make : init -> t
(**[make i] creates an active unclicked button based on the given
   initializer.*)
