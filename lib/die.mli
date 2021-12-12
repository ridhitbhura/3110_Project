type t
(**The abstract type representing a die.*)

val roll_die : t -> int
(** [roll_die d] is the result of rolling a six-sided die. *)

val image : t -> string
(** [image d] is image of a dice. *)

val new_image : t -> int -> t
(**[new_image die i] is the die with a die image that has [i] dots.
   Requires: [i] is between 1 and 6 inclusive.*)

val button : t -> Button.t
(**[button d] is the button that corresponds to this die.*)

val x_coord : t -> int
(**[x_coord d] gives the x_coord of the die*)

val y_coord : t -> int
(**[y_coord d] gives the y_coord of the die*)

val get_die_from_json : Yojson.Basic.t -> t
(**[die_from_json j] is the die that [j] represents.*)

val get_dice_from_json : Yojson.Basic.t -> t list
(**[dice_from_json j] are the dice that [j] represents.*)